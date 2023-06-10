import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/data/core/service/http/dio_http_service.dart';
import 'package:unsplash/data/core/service/http/http_service.dart';
import 'package:unsplash/data/core/service/storage/hive_service_provider.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  return DioHttpService(storageService);
});
