import 'dart:convert';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:unsplash/data/core/service/connection/connection.dart';
import 'package:unsplash/domain/model/cache/cache_response.dart';
import 'package:unsplash/domain/model/cache/config.dart';
import 'package:unsplash/data/core/service/storage/storage_service.dart';

class CacheInterceptor implements Interceptor {
  /// Creates new instance of [CacheInterceptor]
  CacheInterceptor(this.storageService);

  /// Storage service used to store cache in local storage
  final StorageService storageService;

  /// Helper method to create a storage key from
  /// request/response information
  ///
  @visibleForTesting
  String createStorageKey(
    String method,
    String baseUrl,
    String path, [
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  ]) {
    var storageKey = '${method.toUpperCase()}:${baseUrl + path}/';
    if (queryParameters.isNotEmpty) {
      storageKey += '?';
      queryParameters.forEach((key, dynamic value) {
        storageKey += '$key=$value&';
      });
    }
    return storageKey;
  }

  /// Method that intercepts Dio error
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ❌ ❌ Dio Error! ${err.message}');
    log('❌ ❌ ❌ Url: ${err.requestOptions.uri}');
    log('❌ ❌ ❌ ${err.stackTrace}');
    log('❌ ❌ ❌ Response Errors: ${err.response?.data}');
    final storageKey = createStorageKey(
      err.requestOptions.method,
      err.requestOptions.baseUrl,
      err.requestOptions.path,
      err.requestOptions.queryParameters,
    );
    if (storageService.has(storageKey)) {
      final cachedResponse = _getCachedResponse(storageKey);
      if (cachedResponse != null) {
        log('📦 📦 📦 Retrieved response from cache');
        final response = cachedResponse.buildResponse(err.requestOptions);
        log('⬅️ ⬅️ ⬅️ Response');
        log(
          '''
          <---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'}'
          ' ${response.requestOptions.baseUrl}${response.requestOptions.path}''',
        );
        log('Query params: ${response.requestOptions.queryParameters}');
        log('-------------------------');
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }

  /// Method that intercepts Dio request
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (kDebugMode) {
      debugPrint("Headers");
      print(options.headers);
      options.headers.forEach((k, v) => debugPrint('$k: $v'));
      if (options.queryParameters != {}) {
        debugPrint("queryParameters:");
        options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
      }
      if (options.data != null) {
        debugPrint("Body: ${options.data}");
      }
      debugPrint(
          "--> END ${options.method != "" ? options.method.toUpperCase() : 'METHOD'}");
    }
    // Check if device has connection
    final res = await checkInternet();
    if (!res) {
      final storageKey = createStorageKey(
        options.method,
        options.baseUrl,
        options.path,
        options.queryParameters,
      );
      if (storageService.has(storageKey)) {
        final cachedResponse = _getCachedResponse(storageKey);
        if (cachedResponse != null) {
          log('📦 📦 📦 Retrieved response from cache on request ');
          final response = cachedResponse.buildResponse(options);
          log('⬅️ ⬅️ ⬅️ Response');
          // ignore: lines_longer_than_80_chars
          log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
          log('Query params: ${response.requestOptions.queryParameters}');
          log('-------------------------');
          return handler.resolve(response);
        }
      }
    } else if (options.extra[Configs.dioCacheForceRefreshKey] == true) {
      log('🌍 🌍 🌍 Retrieving request from network by force refresh');
      return handler.next(options);
    }

    return handler.next(options);
  }

  /// Method that intercepts Dio response
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final storageKey = createStorageKey(
      response.requestOptions.method,
      response.requestOptions.baseUrl,
      response.requestOptions.path,
      response.requestOptions.queryParameters,
    );
    if (kDebugMode) {
      debugPrint("Headers:");
      response.headers.forEach((k, v) => debugPrint('$k: $v'));
      debugPrint("Response: ${response.data}");
      debugPrint("<-- END HTTP");
    }

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      log('🌍 🌍 🌍 Retrieved response from network');
      log('⬅️ ⬅️ ⬅️ Response');
      // ignore: lines_longer_than_80_chars
      log('<---- ${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 ✅'} ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      log('Query params: ${response.requestOptions.queryParameters}');
      log('-------------------------');

      final cachedResponse = CachedResponse(
        data: response.data,
        headers: Headers.fromMap(response.headers.map),
        age: clock.now(),
        statusCode: response.statusCode!,
      );
      storageService.set(storageKey, cachedResponse.toJson());
    }
    return handler.next(response);
  }

  CachedResponse? _getCachedResponse(String storageKey) {
    final dynamic rawCachedResponse = storageService.get(storageKey);
    try {
      final cachedResponse = CachedResponse.fromJson(
        json.decode(json.encode(rawCachedResponse)) as Map<String, dynamic>,
      );
      if (cachedResponse.isValid) {
        return cachedResponse;
      } else {
        log('Cache is outdated, deleting it...');
        storageService.remove(storageKey);
        return null;
      }
    } catch (e) {
      log('Error retrieving response from cache');
      log('e: $e');
      return null;
    }
  }
}
