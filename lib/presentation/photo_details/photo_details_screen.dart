import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:unsplash/domain/model/photos_by_id.dart';
import 'package:unsplash/presentation/photo_details/details-provider/photo_details_provider.dart';
import 'package:unsplash/presentation/photo_details/widget/photographer_details_widget.dart';
import 'package:unsplash/presentation/util/components/alert_dialog/alert_screen_util.dart';
import 'package:unsplash/presentation/util/components/image_handler.dart';
import 'package:unsplash/presentation/util/helper/app_spacer.dart';

class PhotoDetailsScreen extends HookConsumerWidget {
  final String id;
  const PhotoDetailsScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenW = MediaQuery.of(context).size.width;
    final details = ref.watch(photoDetailsProvider(id));

    ref.listen<AsyncValue<PhotosbyId>>(photoDetailsProvider(id), (_, value) {
      if (value is AsyncError) {
        ScreenAlertView.showErrorDialog(
            context: context, errorText: value.error.toString());
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Space(5),
            const BackButton(),
            details.when(
                data: (data) {
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            const Space(10),
                            ProfileImageHandler(
                              imageUrl: data.user?.profileImage.medium,
                              blurHash: data.blurHash,
                              height: 100,
                              width: 100,
                              radius: 45,
                            ),
                            const Space(20),
                            PhotographerDetails(details: data),
                            const Space(50),
                            ImagePreview(
                                height: 150,
                                width: screenW,
                                radius: 5,
                                imageUrl: data.urls?.regular.toString(),
                                blurHash: data.blurHash),
                            const Space(20),
                            Text(
                              "${data.description}",
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const Space(50),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Related Collections",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Space(20),
                            SizedBox(
                              height: 200,
                              child: AlignedGridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                itemCount: data.tagsPreview?.length,
                                itemBuilder: (context, index) {
                                  final preview = data.tagsPreview![index];
                                  return ImagePreview(
                                      height: 100,
                                      imageUrl: preview
                                          .source?.coverPhoto.urls.regular,
                                      blurHash:
                                          preview.source?.coverPhoto.blurHash);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                error: (e, s) =>
                    const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()))
          ],
        ),
      )),
    );
  }
}
