class HttpException implements Exception {
  String _message;

  HttpException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
