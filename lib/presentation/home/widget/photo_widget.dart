import 'package:flutter/material.dart';
import 'package:unsplash/domain/model/photos.dart';
import 'package:unsplash/presentation/photo_details/photo_details_screen.dart';
import 'package:unsplash/presentation/util/components/image_handler.dart';
import 'package:unsplash/presentation/util/helper/navigator.dart';

class PhotoWidget extends StatelessWidget {
  final Photos photos;
  const PhotoWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigate(PhotoDetailsScreen(id: photos.id)),
      child: ImageHandler(
        blurHash: photos.blurHash,
        imageUrl: photos.urls.regular,
      ),
    );
  }
}
