import 'package:ai_doc_scanner/features/scanner/data/datasources/scanner_services.dart';

import '../entities/document.dart';
import '../repositories/document_repository.dart';
import '../../../../core/services/categorization_service.dart';

// OCR runs directly (no Isolate.run) because the heavy text recognition happens
// on the native side via ML Kit, so it does not block the Dart UI thread.
// Running it in a background isolate would also break ML Kit's platform channel
// access and force the whole use case (including the database connection) to be
// sent across isolates, which is not allowed.

class ScanDocumentUseCase {
  final ScannerService scannerService;
  final DocumentRepository repository;
  final CategorizationService categorizationService;

  ScanDocumentUseCase({
    required this.scannerService,
    required this.repository,
    required this.categorizationService,
  });

  Future<void> call() async {
    // Launch the native scanner. The result carries both the captured JPEG
    // pages (for OCR) and a single generated PDF for the whole document.
    final result = await scannerService.scan();
    if (result == null) return;

    final images = result.images ?? const [];
    final pdf = result.pdf;
    if (images.isEmpty || pdf == null) return;

    // Run OCR over every page and combine the recognized text.
    final buffer = StringBuffer();
    for (final imagePath in images) {
      final pageText = await scannerService.extractText(imagePath);
      if (pageText.isNotEmpty) buffer.writeln(pageText);
    }
    final ocrText = buffer.toString().trim();

    // Auto-categorize based on extracted keywords
    final category = categorizationService.categorize(ocrText);

    // Persist one document per scan session: the first page is the thumbnail,
    // the PDF is the full document.
    final document = Document(
      title: 'Document ${DateTime.now().millisecondsSinceEpoch}',
      category: category,
      ocrText: ocrText,
      imagePath: images.first,
      pdfPath: pdf.uri,
      createdAt: DateTime.now(),
    );
    await repository.saveDocument(document);
  }
}
