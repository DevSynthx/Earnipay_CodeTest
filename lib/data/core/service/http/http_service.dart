/// Http Service Interface
abstract class HttpService {
  /// Http base url
  String get baseUrl;

  /// Http headers
  Map<String, String> get headers;

  /// Http get request
  Future<dynamic> get(
    String path,
    RequestMethod method, {
    Map<String, dynamic>? queryParams,
    bool forceRefresh = false,
  });
}

enum RequestMethod { post, get }
