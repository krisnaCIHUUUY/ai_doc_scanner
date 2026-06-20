class Document {
  final int? id;
  final String title;
  final String category;
  final String ocrText;
  final String imagePath;
  final DateTime createdAt;

  Document({
    this.id,
    required this.title,
    required this.category,
    required this.ocrText,
    required this.imagePath,
    required this.createdAt,
  });
}