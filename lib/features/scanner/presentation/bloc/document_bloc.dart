import 'package:ai_doc_scanner/features/scanner/domain/usecases/delete_document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/usecases/get_all_document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/usecases/scan_document_use_case.dart';
import 'package:ai_doc_scanner/features/scanner/domain/usecases/search_document.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_event.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetAllDocument getAllDocuments;
  final SearchDocument searchDocuments;
  final DeleteDocument deleteDocument;
  final ScanDocumentUseCase scanDocument;

  DocumentBloc(
    this.getAllDocuments,
    this.searchDocuments,
    this.deleteDocument,
    this.scanDocument,
  ) : super(DocumentInitial()) {
    on<LoadDocuments>((event, emit) async {
      emit(DocumentLoading());
      try {
        final documents = await getAllDocuments();
        emit(DocumentLoaded(documents));
      } catch (e) {
        emit(DocumentListError(e.toString()));
      }
    });

    on<SearchDocuments>((event, emit) async {
      emit(DocumentLoading());
      try {
        final documents = event.query!.isEmpty
            ? await getAllDocuments()
            : await searchDocuments(event.query!);
        emit(DocumentLoaded(documents));
      } catch (e) {
        emit(DocumentListError(e.toString()));
      }
    });

    on<FilterByCategory>((event, emit) async {
      emit(DocumentLoading());
      try {
        final documents = await getAllDocuments();
        final filteredDocuments = event.category == null
            ? documents
            : documents.where((doc) => doc.category == event.category).toList();
        emit(DocumentLoaded(filteredDocuments));
      } catch (e) {
        emit(DocumentListError(e.toString()));
      }
    });

    on<DeleteDocumentEvent>((event, emit) async {
      await deleteDocument(event.documentId);
      add(LoadDocuments());
    });

    on<ScanDocumentEvent>((event, emit) async {
      await scanDocument();
      add(LoadDocuments());
    });
  }
}
