class Exceptions implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorResponse;

  Exceptions({
    required this.message,
    this.statusCode,
    this.errorResponse,
  });

  @override
  String toString() {
    return 'Exception $message with status code $statusCode)';
  }
}
