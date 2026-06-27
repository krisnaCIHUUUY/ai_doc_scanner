import 'dart:io';
import 'dart:isolate';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

enum ImageFilter { original, grayscale, highContrast }

class ImageFilterService {
  Future<String> applyFilter(String imagePath, ImageFilter filter) async {
    if (filter == ImageFilter.original) return imagePath;
    return await Isolate.run(() => _processFilter(imagePath, filter));
  }

  // Static method so it can run inside an isolate (no instance state needed)
  static Future<String> _processFilter(
    String imagePath,
    ImageFilter filter,
  ) async {
    final bytes = await File(imagePath).readAsBytes();
    var image = img.decodeImage(bytes)!;

    if (filter == ImageFilter.grayscale) {
      // Convert each pixel to its luminance value
      image = img.grayscale(image);
    } else if (filter == ImageFilter.highContrast) {
      // First convert to grayscale
      image = img.grayscale(image);
      // Otsu threshold to find optimal black/white split point
      final histogram = List<int>.filled(256, 0);
      for (final pixel in image) {
        histogram[pixel.r.toInt()]++;
      }
      final total = image.width * image.height;
      double sum = 0;
      for (int i = 0; i < 256; i++) {
        sum += i * histogram[i];
      }
      double sumB = 0;
      int wB = 0;
      double maxVar = 0;
      int threshold = 0;
      for (int t = 0; t < 256; t++) {
        wB += histogram[t];
        if (wB == 0) continue;
        final wF = total - wB;
        if (wF == 0) break;
        sumB += t * histogram[t];
        final mB = sumB / wB;
        final mF = (sum - sumB) / wF;
        final varBetween = wB * wF * (mB - mF) * (mB - mF);
        if (varBetween > maxVar) {
          maxVar = varBetween;
          threshold = t;
        }
      }
      // Apply threshold: each pixel becomes pure black or pure white
      for (final pixel in image) {
        final v = pixel.r.toInt() > threshold ? 255 : 0;
        pixel.r = v;
        pixel.g = v;
        pixel.b = v;
      }
    }

    // Save filtered image to a new file alongside the original
    final dir = await getApplicationDocumentsDirectory();
    final outPath =
        '${dir.path}/filtered_${filter.name}_${DateTime.now().millisecondsSinceEpoch}.jpg';
    await File(outPath).writeAsBytes(img.encodeJpg(image));
    return outPath;
  }
}
