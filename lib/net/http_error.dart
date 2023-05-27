class HttpError implements Exception {
  HttpError(
    this.code,
    this.message, {
    this.error,
    this.httpCode,
  });

  String code;
  int? httpCode;
  String message;
  dynamic error;

  @override
  String toString() {
    return "HttpError [$code]: $message";
  }
}
