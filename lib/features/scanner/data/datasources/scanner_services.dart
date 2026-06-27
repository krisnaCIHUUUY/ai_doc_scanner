import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// Now you will create the ScannerService class in the Data layer. 
// This service wraps ML Kit's document scanner and text recognizer into two clean methods your use case can call.

class ScannerService {
  // Launch the native document scanner UI and return the full result.
  // We request BOTH formats: the JPEG images are needed for OCR, while the PDF
  // is the document we persist/export.
  Future<DocumentScanningResult?> scan() async {
    final options = DocumentScannerOptions(
      pageLimit: 5,
      mode: ScannerMode.full,
      isGalleryImport: true,
      documentFormats: {DocumentFormat.jpeg, DocumentFormat.pdf},
    );

    final scanner = DocumentScanner(options: options);

    try {
      return await scanner.scanDocument();
    } catch (e) {
      return null;
    } finally {
      scanner.close();
    }
  }

  // Extract text from a scanned image using on-device OCR
  Future<String> extractText(String imagePath) async {
    final textRecognizer = TextRecognizer();
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognized = await textRecognizer.processImage(inputImage);
      return recognized.blocks.map((b) => b.text).join('\n');
    } finally {
      textRecognizer.close();
    }
  }
}
