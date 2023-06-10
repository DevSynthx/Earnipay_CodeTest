import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletons/skeletons.dart';
import 'package:unsplash/presentation/util/components/app_image.dart';

class ImageHandler extends StatelessWidget {
  final String? imageUrl;
  final String? blurHash;
  final double height;
  final double width;
  final double radius;
  const ImageHandler(
      {super.key,
      required this.imageUrl,
      required this.blurHash,
      this.height = 60,
      this.width = 60,
      this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl!.isEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.asset(
                AppImage.errorImage,
                fit: BoxFit.cover,
                scale: 3,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(
              imageUrl: imageUrl.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) => BlurHash(
                hash: blurHash.toString(),
                errorBuilder: (context, error, stackTrace) => SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      randomHeight: false,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: Image.asset(
                    AppImage.errorImage,
                    fit: BoxFit.cover,
                    scale: 3,
                  )),
            ),
          );
  }
}

class ProfileImageHandler extends HookConsumerWidget {
  final String? imageUrl;
  final String? blurHash;
  final double height;
  final double width;
  final double radius;
  const ProfileImageHandler(
      {super.key,
      required this.imageUrl,
      required this.blurHash,
      this.height = 60,
      this.width = 60,
      this.radius = 10});

  @override
  Widget build(BuildContext context, ref) {
    return (imageUrl == null || imageUrl!.isEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.asset(
                AppImage.errorImage,
                fit: BoxFit.cover,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              height: height,
              width: width,
              child: CachedNetworkImage(
                imageUrl: imageUrl.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) => BlurHash(
                  hash: blurHash.toString(),
                  errorBuilder: (context, error, stackTrace) => SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: 60,
                        height: 60,
                        randomHeight: false,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      AppImage.errorImage,
                      fit: BoxFit.fill,
                      scale: 3,
                    )),
              ),
            ),
          );
  }
}

class ImagePreview extends StatelessWidget {
  final String? imageUrl;
  final String? blurHash;
  final double height;
  final double width;
  final double radius;
  const ImagePreview(
      {super.key,
      required this.imageUrl,
      required this.blurHash,
      this.height = 30,
      this.width = 30,
      this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl!.isEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.asset(
                AppImage.errorImage,
                fit: BoxFit.contain,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              height: height,
              width: width,
              child: CachedNetworkImage(
                imageUrl: imageUrl.toString(),
                fit: BoxFit.cover,
                placeholder: (context, url) => BlurHash(
                  hash: blurHash.toString(),
                  errorBuilder: (context, error, stackTrace) => SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                        width: MediaQuery.of(context).size.width,
                        height: height,
                        randomHeight: false,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(25),
                    child: Image.asset(
                      AppImage.errorImage,
                      fit: BoxFit.contain,
                      scale: 3,
                    )),
              ),
            ),
          );
  }
}
