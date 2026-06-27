import 'package:ai_doc_scanner/core/services/image_filter_service.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/filter_event.dart';
import 'package:ai_doc_scanner/features/scanner/presentation/bloc/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageFilterBloc extends Bloc<ImageFilterEvent, ImageFilterState> {
  final ImageFilterService filterService;
  ImageFilterBloc({required this.filterService}) : super(ImageFilterInitial()) {
    on<ApplyFilter>((event, emit) async {
      emit(ImageFilterProcessing());
      // Simulate filter application

      try {
        final filteredImagePath = await filterService.applyFilter(
          event.imagePath,
          event.filter,
        );
        emit(ImageFilterApplied(filteredImagePath: filteredImagePath));
      } catch (e) {
        emit(ImageFilterError(e.toString()));
      }
    });
  }
}
