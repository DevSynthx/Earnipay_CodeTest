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
    ) {
      page++;
      log("Page number $page");
      try {
        return ref.watch(photoRepositoryProvider).getPhotos(page);
      } catch (e) {
        throw e.toString();
      }
    },
  )..init();
});
