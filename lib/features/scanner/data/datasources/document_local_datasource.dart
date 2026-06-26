import 'package:ai_doc_scanner/core/database/app_database.dart';
import 'package:ai_doc_scanner/features/scanner/domain/entities/document.dart';
import 'package:drift/drift.dart';

class DocumentLocalDatasource {
  final AppDatabase db;
  DocumentLocalDatasource(this.db);


  Future<void> saveDocument(Document document) async {
    await db
        .into(db.scannedDocuments)
        .insert(
          ScannedDocumentsCompanion.insert(
            title: document.title,
            category: document.category,
            ocrText: document.ocrText,
            imagePath: document.imagePath,
            createdAt: DateTime.now(),
          ),
        );
  }

  Future<List<Document>> getAllDocuments() async {
    final rows = await db.select(db.scannedDocuments).get();
    return rows.map(_rowToDocument).toList();
  }

  Future<List<Document>> searchDocuments(String query) async {
    final rows = await db
        .customSelect(
          'SELECT s.* FROM scanned_documents s JOIN documents_fts fts ON s.id = fts.rowid WHERE documents_fts MATCH ?',
          variables: [Variable.withString(query)],
          readsFrom: {db.scannedDocuments},
        )
        .get();

    return rows.map((row) {
      final scannedDocument = ScannedDocument(
        id: row.read<int>('id'),
        title: row.read<String>('title'),
        category: row.read<String>('category'),
        ocrText: row.read<String>('ocr_text'),
        imagePath: row.read<String>('image_path'),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          row.read<int>('created_at'),
        ),
      );
      return _rowToDocument(scannedDocument);
    }).toList();
  }

  Future<void> deleteDocument(int id) async {
    await (db.delete(db.scannedDocuments)..where((t) => t.id.equals(id))).go();
  }

  Future<List<Document>> getDocumentsByCategory(String category) async {
    final rows = await (db.select(
      db.scannedDocuments,
    )..where((t) => t.category.equals(category))).get();

    return rows.map(_rowToDocument).toList();
  }

  Document _rowToDocument(ScannedDocument row) => Document(
    id: row.id,
    title: row.title,
    category: row.category,
    ocrText: row.ocrText,
    imagePath: row.imagePath,
    createdAt: row.createdAt,
  );
}
