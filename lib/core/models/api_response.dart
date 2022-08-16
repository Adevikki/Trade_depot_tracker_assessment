class ApiResponse<T> {
  final bool successful;
  final T? data;
  final String message;

  ApiResponse({
    required this.successful,
     this.data,
    required this.message,
  });
}
