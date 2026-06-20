import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';

abstract class DocumentRepository {
  Future<void> saveDocument(Document document);
  Future<List<Document>> getAllDocuments();
  Future<List<Document>> searchDocuments(String query);
  Future<void> deleteDocument(int id);
  Future<List<Document>> getDocumentsByCategory(String category);
}
