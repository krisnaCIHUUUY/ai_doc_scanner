import 'package:ai_doc_scanner/features/scanner/domain/repositories/document_repository.dart';

class DeleteDocument {
  final DocumentRepository repository;
  DeleteDocument(this.repository); 

  Future<void> call(int id) => repository.deleteDocument(id);
}