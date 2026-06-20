abstract class Failure {
  final String message;
  const Failure(this.message);
}

// Returned when the user dismisses the scanner without capturing
class ScannerCancelledFailure extends Failure {
  const ScannerCancelledFailure() : super('Scanner was cancelled by the user.');
}

// Returned when text recognition fails on a scanned image
class OcrFailure extends Failure {
  const OcrFailure(super.message);
}

// Returned when saving to the database fails
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}
