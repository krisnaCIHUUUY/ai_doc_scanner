import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/repositories/document_repository.dart';

class GetAllDocument {
  final DocumentRepository repository;
  GetAllDocument(this.repository);

  Future<List<Document>> call() => repository.getAllDocuments();
}