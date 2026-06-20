// When your app scans a document and extracts text, it needs to automatically classify what kind of document it is.
// You'll build a keyword-matching engine that detects patterns in the OCR text.

class CategorizationService {
  String categorize(String text) {
    final lower = text.toLowerCase();
    if (_containsAny(lower, ['total', 'subtotal', 'tax', 'payment'])) {
      return 'Receipt';
    } else if (_containsAny(lower, ['invoice', 'due date', 'bill to'])) {
      return 'Invoice';
    } else if (_containsAny(lower, [
      'name',
      'date of birth',
      'nationality',
      'passport',
    ])) {
      return 'ID Card';
    } else if (_containsAny(lower, [
      'university',
      'grade',
      'semester',
      'student',
    ])) {
      return 'Academic';
    }
    return 'General';
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((k) => text.contains(k));
  }
}
