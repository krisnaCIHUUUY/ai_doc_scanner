
import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';

abstract class DocumentState {}

final class DocumentInitial extends DocumentState {}

final class DocumentLoading extends DocumentState {}

final class DocumentLoaded extends DocumentState {
  final List<Document> documents;

  DocumentLoaded(this.documents);
}

final class DocumentListError extends DocumentState {
  final String message;

  DocumentListError(this.message);
}
