import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/domain/repository/photo_repository.dart';

// final photoDetailsProvider =
//     FutureProvider.family<PhotosbyId, String>((ref, id) async {
//   return ref.watch(photoManagerProvider).photoDetails(id);
// });

final photoDetailsProvider =
    FutureProvider.family<PhotosbyId, String>((ref, id) async {
  return ref.watch(photoRepositoryProvider).photoDetails(id);
});
