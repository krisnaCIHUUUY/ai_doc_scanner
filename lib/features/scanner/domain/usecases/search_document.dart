import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/repositories/document_repository.dart';

class SearchDocument {
  final DocumentRepository repository;
  SearchDocument(this.repository);

  Future<List<Document>> call(String query) => repository.searchDocuments(query);
}