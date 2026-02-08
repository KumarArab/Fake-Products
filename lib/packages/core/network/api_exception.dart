class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({
    required this.message,
    required this.statusCode,
  });

  bool get isNetworkError => statusCode == 0 || statusCode == 408;

  bool get isServerError => statusCode >= 500;

  bool get isClientError => statusCode >= 400 && statusCode < 500;

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

