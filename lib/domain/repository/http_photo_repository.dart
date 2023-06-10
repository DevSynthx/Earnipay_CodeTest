import 'package:unsplash/data/core/service/http/http_service.dart';
import 'package:unsplash/data/util/url/app_url.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/domain/repository/photo_repository.dart';

class HttpPhotoRepository implements PhotosRepository {
  final HttpService httpService;
  HttpPhotoRepository(this.httpService);
  @override
  Future<List<Photos>> getPhotos(int page) async {
    try {
      final response = await httpService.get(URL.photos, RequestMethod.get,
          forceRefresh: true, queryParams: {"pages": page, "per_page": 20});
      final res = List<Photos>.from(response.map((x) => Photos.fromJson(x)));
      return res;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<PhotosbyId> photoDetails(String id) async {
    try {
      final response = await httpService.get(
        forceRefresh: true,
        "${URL.photos}/$id",
        RequestMethod.get,
      );
      final res = PhotosbyId.fromJson(response);
      return res;
    } catch (e) {
      throw e.toString();
    }
  }
}
