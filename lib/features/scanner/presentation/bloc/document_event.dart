

abstract class DocumentEvent {}

class LoadDocuments extends DocumentEvent {}

class SearchDocuments extends DocumentEvent {
  final String? query;

  SearchDocuments(this.query);
}

class FilterByCategory extends DocumentEvent {
  final String? category;

  FilterByCategory(this.category);
}

class DeleteDocumentEvent extends DocumentEvent {
  final int documentId;

  DeleteDocumentEvent(this.documentId);
}

class ScanDocumentEvent extends DocumentEvent {}
