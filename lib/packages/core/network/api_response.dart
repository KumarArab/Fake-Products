class ApiResponse<T> {
  final T data;
  final int statusCode;
  final String message;

  ApiResponse({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  @override
  String toString() {
    return 'ApiResponse(statusCode: $statusCode, message: $message, data: $data)';
  }
}

