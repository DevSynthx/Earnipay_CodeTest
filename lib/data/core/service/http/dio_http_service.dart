import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:unsplash/data/core/interceptors/cache_interceptor.dart';
import 'package:unsplash/data/core/service/http/http_service.dart';
import 'package:unsplash/data/core/service/storage/storage_service.dart';
import 'package:unsplash/data/util/error/error_handler.dart';
import 'package:unsplash/data/util/url/app_url.dart';
import 'package:unsplash/domain/model/cache/config.dart';

class DioHttpService implements HttpService {
  final StorageService storageService;
  late final Dio dio;

  DioHttpService(
    this.storageService, {
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);

    dio.interceptors.addAll([
      PrettyDioLogger(),
      RetryInterceptor(
        dio: dio,
        logPrint: print, // specify log function (optional)
        retries: 2, // retry count (optional)
        retryDelays: const [
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
        ],
      ),
      if (enableCaching) ...[CacheInterceptor(storageService)]
    ]);
  }

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => URL.base;
  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
    'Authorization': "Client-ID CK5_SZXnwCO7ORvuSV9E8UvYRi9Crl9soXY2t9Hwtgo"
  };

  @override
  Future<dynamic> get(String path, RequestMethod method,
      {Map<String, dynamic>? queryParams, bool forceRefresh = false}) async {
    var params = queryParams ?? {};
    dio.options.extra[Configs.dioCacheForceRefreshKey] = forceRefresh;
    try {
      var response = await dio.get(
        path,
        queryParameters: params,
      );
      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
