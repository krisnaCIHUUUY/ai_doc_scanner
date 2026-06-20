import 'dart:isolate';
import 'package:ai_doc_scanner/features/scanner/data/datasources/scanner_services.dart';

import '../entities/document.dart';
import '../repositories/document_repository.dart';
import '../../../../core/services/categorization_service.dart';

// why use isolate.run() for OCR processing?
// The TextRecognizer performs heavy native processing when recognizing text from an image.
// Wrapping the call in Isolate.run() ensures the post-processing (combining text blocks, string manipulation) does not block the main Dart thread while the recognizer works.

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
    // Launch the native scanner and get captured image paths
    final imagePaths = await scannerService.scan();
    if (imagePaths == null || imagePaths.isEmpty) return;

    // Process each scanned page
    for (final imagePath in imagePaths) {
      // Run OCR in a background isolate to keep UI responsive
      final ocrText = await Isolate.run(
        () => scannerService.extractText(imagePath),
      );

      // Auto-categorize based on extracted keywords
      final category = categorizationService.categorize(ocrText);

      // Build and persist the document entity
      final document = Document(
        title: 'Document ${DateTime.now().millisecondsSinceEpoch}',
        category: category,
        ocrText: ocrText,
        imagePath: imagePath,
        createdAt: DateTime.now(),
      );
      await repository.saveDocument(document);
    }
  }
}
