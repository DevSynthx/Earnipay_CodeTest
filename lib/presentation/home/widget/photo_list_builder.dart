import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/presentation/home/widget/photo_widget.dart';

class PhotoListBuilder extends StatefulWidget {
  const PhotoListBuilder({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final List<Photos> photos;

  @override
  State<PhotoListBuilder> createState() => _PhotoListBuilderState();
}

class _PhotoListBuilderState extends State<PhotoListBuilder> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: const [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            //QuiltedGridTile(1, 2),
          ],
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final photo = widget.photos[index];
            return PhotoWidget(photos: photo);
          },
          childCount: widget.photos.length,
        ),
      ),
    );
  }
}
