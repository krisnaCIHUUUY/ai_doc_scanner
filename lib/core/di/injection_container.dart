import 'package:ai_doc_scanner/core/services/image_filter_service.dart';
import 'package:ai_doc_scanner/features/scanner/data/datasources/scanner_services.dart';
import 'package:ai_doc_scanner/features/scanner/domain/usecases/get_all_document.dart';
import 'package:ai_doc_scanner/features/scanner/domain/usecases/search_document.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/document_bloc.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/filter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../database/app_database.dart';
import '../services/categorization_service.dart';
import '../../features/scanner/data/datasources/document_local_datasource.dart';
import '../../features/scanner/data/repositories/document_repositories_impl.dart';
import '../../features/scanner/domain/repositories/document_repository.dart';
import '../../features/scanner/domain/usecases/delete_document.dart';
import '../../features/scanner/domain/usecases/scan_document_use_case.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Services
  sl.registerLazySingleton<CategorizationService>(
    () => CategorizationService(),
  );

  sl.registerLazySingleton<ImageFilterService>(() => ImageFilterService());
  sl.registerLazySingleton<ScannerService>(() => ScannerService());

  // Data sources
  sl.registerLazySingleton<DocumentLocalDatasource>(
    () => DocumentLocalDatasource(sl<AppDatabase>()),
  );

  // Repositories
  sl.registerLazySingleton<DocumentRepository>(
    () => DocumentRepositoriesImpl(sl<DocumentLocalDatasource>()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllDocument(sl<DocumentRepository>()));
  sl.registerLazySingleton(() => SearchDocument(sl<DocumentRepository>()));
  sl.registerLazySingleton(() => DeleteDocument(sl<DocumentRepository>()));
  sl.registerLazySingleton(
    () => ScanDocumentUseCase(
      scannerService: sl<ScannerService>(),
      repository: sl<DocumentRepository>(),
      categorizationService: sl<CategorizationService>(),
    ),
  );

  sl.registerFactory(
    () => DocumentBloc(
      sl<GetAllDocument>(),
      sl<SearchDocument>(),
      sl<DeleteDocument>(),
      sl<ScanDocumentUseCase>(),
    ),
  );

  sl.registerFactory(
    () => ImageFilterBloc(filterService: sl<ImageFilterService>()),
  );
}
