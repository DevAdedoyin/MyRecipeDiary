class HttpException implements Exception {
  final String message;
  // final int statusCode;

  HttpException(this.message,);

  @override
  String toString() {
    return message;
  }
}