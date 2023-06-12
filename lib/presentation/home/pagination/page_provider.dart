import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/domain/repository/photo_repository.dart';
import 'package:unsplash/presentation/home/pagination/pagination-state/pagination_state.dart';
import 'package:unsplash/presentation/home/pagination/pagination_notifier.dart';

final itemsProvider =
    StateNotifierProvider<PaginationNotifier<Photos>, PaginationState<Photos>>(
        (ref) {
  int page = 0;
  return PaginationNotifier(
    itemsPerBatch: 20,
    fetchNextItems: (
      item,
    ) async {
      page++;
      log("Page number $page");
      try {
        return await ref.read(photoRepositoryProvider).getPhotos(page);
      } catch (e) {
        // if there is an error fetching photos for the first time, set the page
        // number to one
        page--;
        throw e.toString();
      }
    },
  )..init();
});
