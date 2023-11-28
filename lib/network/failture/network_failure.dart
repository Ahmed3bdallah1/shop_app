class NetworkFailure implements Exception {
  final String message;
  final int? code;
  final StackTrace? stackTrace;

  NetworkFailure(this.message, [this.code, this.stackTrace]);
}