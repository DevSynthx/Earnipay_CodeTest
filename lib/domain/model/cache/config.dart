import 'package:unsplash/data/util/url/app_url.dart';

class Configs {
  /// The max allowed age duration for the http cache
  static const Duration maxCacheAge = Duration(hours: 1);

  /// Key used in dio options to indicate whether
  /// cache should be force refreshed
  static const String dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';

  /// Base API URL of UNSPLASH API
  ///
  static const String apiBaseUrl = URL.base;
}
