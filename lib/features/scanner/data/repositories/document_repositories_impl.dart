import 'package:ai_doc_scanner/features/scanner/data/datasources/document_local_datasource.dart';
import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/repositories/document_repository.dart';

class DocumentRepositoriesImpl implements DocumentRepository {
  final DocumentLocalDatasource localDatasource;

  DocumentRepositoriesImpl(this.localDatasource);

  @override
  Future<void> deleteDocument(int id) => localDatasource.deleteDocument(id);

  @override
  Future<List<Document>> getAllDocuments() => localDatasource.getAllDocuments();

  @override
  Future<List<Document>> getDocumentsByCategory(String category) =>
   localDatasource.getDocumentsByCategory(category);

  @override
  Future<void> saveDocument(Document document) => localDatasource.saveDocument(document);

  @override
  Future<List<Document>> searchDocuments(String query) => localDatasource.searchDocuments(query);
}