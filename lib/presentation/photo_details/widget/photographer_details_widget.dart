import 'package:flutter/material.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/presentation/util/helper/app_spacer.dart';

class PhotographerDetails extends StatelessWidget {
  final PhotosbyId details;
  const PhotographerDetails({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${details.user!.firstName.toString()} ${details.user!.lastName.toString()}",
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
        ),
        const Space(2),
        Text(
          "Photographer",
          style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        const Space(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${details.likes}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Space(4),
                Text(
                  "Likes",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${details.downloads}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Space(4),
                Text(
                  "Downloads",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${details.user?.totalPhotos.toString()}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Space(4),
                Text(
                  "Photos",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${details.views}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Space(4),
                Text(
                  "Views",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
