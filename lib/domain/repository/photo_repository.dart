import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/data/core/service/http/http_service_provider.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/domain/repository/http_photo_repository.dart';

final photoRepositoryProvider = Provider<PhotosRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider);
    return HttpPhotoRepository(httpService);
  },
);

abstract class PhotosRepository {
  Future<List<Photos>> getPhotos(int page);
  Future<PhotosbyId> photoDetails(String id);
}
