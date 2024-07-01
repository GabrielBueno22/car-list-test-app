abstract class HttpService {
  Future<Map<String, dynamic>?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  Future post(
    String path, {
    Map<String, dynamic>? body,
  });
}
