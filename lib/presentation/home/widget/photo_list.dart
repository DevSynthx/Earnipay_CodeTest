import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/presentation/home/pagination/page_provider.dart';
import 'package:unsplash/presentation/home/widget/photo_list_builder.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final state = ref.watch(itemsProvider);
      return state.when(
        data: (items) {
          return items.isEmpty
              ? SliverToBoxAdapter(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.read(itemsProvider.notifier).fetchFirstBatch();
                        },
                        icon: const Icon(Icons.replay),
                      ),
                      const Chip(
                        label: Text("No photos Found!"),
                      ),
                    ],
                  ),
                )
              : PhotoListBuilder(
                  photos: items,
                );
        },
        loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator())),
        error: (e, stk) => SliverToBoxAdapter(
          child: Center(
            child: Column(
              children: const [
                Icon(Icons.info),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        onGoingLoading: (photos) {
          return PhotoListBuilder(
            photos: photos,
          );
        },
        onGoingError: (photos, e, stk) {
          return PhotoListBuilder(
            photos: photos,
          );
        },
      );
    });
  }
}
