import 'package:ai_doc_scanner/core/services/image_filter_service.dart';

abstract class ImageFilterEvent {}

class ApplyFilter extends ImageFilterEvent {
  final String imagePath;
  final ImageFilter filter;

  ApplyFilter({required this.imagePath, required this.filter});
}
