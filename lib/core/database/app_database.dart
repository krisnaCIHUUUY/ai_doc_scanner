import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class ScannedDocuments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get ocrText => text()();
  TextColumn get imagePath => text()();
  DateTimeColumn get createdAt => dateTime()();
}

@DriftDatabase(tables: [ScannedDocuments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE VIRTUAL TABLE IF NOT EXISTS documents_fts USING fts5(title, ocr_text, content=scanned_documents, content_rowid=id)',
      );
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'app_database');
}
