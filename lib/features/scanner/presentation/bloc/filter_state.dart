abstract class ImageFilterState {}

class ImageFilterInitial extends ImageFilterState {}

class ImageFilterProcessing extends ImageFilterState {}

class ImageFilterApplied extends ImageFilterState {
  final String filteredImagePath;

  ImageFilterApplied({required this.filteredImagePath});
}

class ImageFilterError extends ImageFilterState {
  final String message;

  ImageFilterError(this.message);
}
