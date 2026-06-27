// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ScannedDocumentsTable extends ScannedDocuments
    with TableInfo<$ScannedDocumentsTable, ScannedDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScannedDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ocrTextMeta = const VerificationMeta(
    'ocrText',
  );
  @override
  late final GeneratedColumn<String> ocrText = GeneratedColumn<String>(
    'ocr_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    ocrText,
    imagePath,
    pdfPath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scanned_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScannedDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('ocr_text')) {
      context.handle(
        _ocrTextMeta,
        ocrText.isAcceptableOrUnknown(data['ocr_text']!, _ocrTextMeta),
      );
    } else if (isInserting) {
      context.missing(_ocrTextMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScannedDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScannedDocument(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      ocrText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_text'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ScannedDocumentsTable createAlias(String alias) {
    return $ScannedDocumentsTable(attachedDatabase, alias);
  }
}

class ScannedDocument extends DataClass implements Insertable<ScannedDocument> {
  final int id;
  final String title;
  final String category;
  final String ocrText;
  final String imagePath;
  final String pdfPath;
  final DateTime createdAt;
  const ScannedDocument({
    required this.id,
    required this.title,
    required this.category,
    required this.ocrText,
    required this.imagePath,
    required this.pdfPath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['ocr_text'] = Variable<String>(ocrText);
    map['image_path'] = Variable<String>(imagePath);
    map['pdf_path'] = Variable<String>(pdfPath);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScannedDocumentsCompanion toCompanion(bool nullToAbsent) {
    return ScannedDocumentsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      ocrText: Value(ocrText),
      imagePath: Value(imagePath),
      pdfPath: Value(pdfPath),
      createdAt: Value(createdAt),
    );
  }

  factory ScannedDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScannedDocument(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      ocrText: serializer.fromJson<String>(json['ocrText']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      pdfPath: serializer.fromJson<String>(json['pdfPath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'ocrText': serializer.toJson<String>(ocrText),
      'imagePath': serializer.toJson<String>(imagePath),
      'pdfPath': serializer.toJson<String>(pdfPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScannedDocument copyWith({
    int? id,
    String? title,
    String? category,
    String? ocrText,
    String? imagePath,
    String? pdfPath,
    DateTime? createdAt,
  }) => ScannedDocument(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    ocrText: ocrText ?? this.ocrText,
    imagePath: imagePath ?? this.imagePath,
    pdfPath: pdfPath ?? this.pdfPath,
    createdAt: createdAt ?? this.createdAt,
  );
  ScannedDocument copyWithCompanion(ScannedDocumentsCompanion data) {
    return ScannedDocument(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      ocrText: data.ocrText.present ? data.ocrText.value : this.ocrText,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScannedDocument(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('ocrText: $ocrText, ')
          ..write('imagePath: $imagePath, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, category, ocrText, imagePath, pdfPath, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScannedDocument &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.ocrText == this.ocrText &&
          other.imagePath == this.imagePath &&
          other.pdfPath == this.pdfPath &&
          other.createdAt == this.createdAt);
}

class ScannedDocumentsCompanion extends UpdateCompanion<ScannedDocument> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> ocrText;
  final Value<String> imagePath;
  final Value<String> pdfPath;
  final Value<DateTime> createdAt;
  const ScannedDocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.ocrText = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.pdfPath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScannedDocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String category,
    required String ocrText,
    required String imagePath,
    this.pdfPath = const Value.absent(),
    required DateTime createdAt,
  }) : title = Value(title),
       category = Value(category),
       ocrText = Value(ocrText),
       imagePath = Value(imagePath),
       createdAt = Value(createdAt);
  static Insertable<ScannedDocument> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? ocrText,
    Expression<String>? imagePath,
    Expression<String>? pdfPath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (ocrText != null) 'ocr_text': ocrText,
      if (imagePath != null) 'image_path': imagePath,
      if (pdfPath != null) 'pdf_path': pdfPath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScannedDocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? category,
    Value<String>? ocrText,
    Value<String>? imagePath,
    Value<String>? pdfPath,
    Value<DateTime>? createdAt,
  }) {
    return ScannedDocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      ocrText: ocrText ?? this.ocrText,
      imagePath: imagePath ?? this.imagePath,
      pdfPath: pdfPath ?? this.pdfPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (ocrText.present) {
      map['ocr_text'] = Variable<String>(ocrText.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScannedDocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('ocrText: $ocrText, ')
          ..write('imagePath: $imagePath, ')
          ..write('pdfPath: $pdfPath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScannedDocumentsTable scannedDocuments = $ScannedDocumentsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scannedDocuments];
}

typedef $$ScannedDocumentsTableCreateCompanionBuilder =
    ScannedDocumentsCompanion Function({
      Value<int> id,
      required String title,
      required String category,
      required String ocrText,
      required String imagePath,
      Value<String> pdfPath,
      required DateTime createdAt,
    });
typedef $$ScannedDocumentsTableUpdateCompanionBuilder =
    ScannedDocumentsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> category,
      Value<String> ocrText,
      Value<String> imagePath,
      Value<String> pdfPath,
      Value<DateTime> createdAt,
    });

class $$ScannedDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $ScannedDocumentsTable> {
  $$ScannedDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScannedDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScannedDocumentsTable> {
  $$ScannedDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrText => $composableBuilder(
    column: $table.ocrText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScannedDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScannedDocumentsTable> {
  $$ScannedDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get ocrText =>
      $composableBuilder(column: $table.ocrText, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ScannedDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScannedDocumentsTable,
          ScannedDocument,
          $$ScannedDocumentsTableFilterComposer,
          $$ScannedDocumentsTableOrderingComposer,
          $$ScannedDocumentsTableAnnotationComposer,
          $$ScannedDocumentsTableCreateCompanionBuilder,
          $$ScannedDocumentsTableUpdateCompanionBuilder,
          (
            ScannedDocument,
            BaseReferences<
              _$AppDatabase,
              $ScannedDocumentsTable,
              ScannedDocument
            >,
          ),
          ScannedDocument,
          PrefetchHooks Function()
        > {
  $$ScannedDocumentsTableTableManager(
    _$AppDatabase db,
    $ScannedDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScannedDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScannedDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScannedDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> ocrText = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<String> pdfPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScannedDocumentsCompanion(
                id: id,
                title: title,
                category: category,
                ocrText: ocrText,
                imagePath: imagePath,
                pdfPath: pdfPath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String category,
                required String ocrText,
                required String imagePath,
                Value<String> pdfPath = const Value.absent(),
                required DateTime createdAt,
              }) => ScannedDocumentsCompanion.insert(
                id: id,
                title: title,
                category: category,
                ocrText: ocrText,
                imagePath: imagePath,
                pdfPath: pdfPath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScannedDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScannedDocumentsTable,
      ScannedDocument,
      $$ScannedDocumentsTableFilterComposer,
      $$ScannedDocumentsTableOrderingComposer,
      $$ScannedDocumentsTableAnnotationComposer,
      $$ScannedDocumentsTableCreateCompanionBuilder,
      $$ScannedDocumentsTableUpdateCompanionBuilder,
      (
        ScannedDocument,
        BaseReferences<_$AppDatabase, $ScannedDocumentsTable, ScannedDocument>,
      ),
      ScannedDocument,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScannedDocumentsTableTableManager get scannedDocuments =>
      $$ScannedDocumentsTableTableManager(_db, _db.scannedDocuments);
}
