import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/loading_widget.dart';
import '../controllers/detail_kajian_controller.dart';

class DetailKajianView extends GetView<DetailKajianController> {
  DetailKajianView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(DetailKajianController());

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller.ytController),
      builder: (context, player) => Obx(
        () => Scaffold(
          appBar: AppBar(
            backgroundColor: greenPrimaryColor,
            elevation: 0,
            title: Text('kajian_islami'.tr),
          ),
          body: Padding(
            padding: defaultPaddingScreen,
            child: ListView(
              shrinkWrap: true,
              children: [
                player,
                Text(
                  controller.dataParams[0],
                  style: mediumStyle.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                marginWidget(1.h, 0),
                Text(
                  controller.dataParams[1],
                  style: regularStyle.copyWith(
                    fontSize: 12.sp,
                    color: greyColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'publish_time'.tr,
                      style: regularStyle,
                    ),
                    Text(
                      controller.dataParams[3].toString().substring(0, 10),
                      style: regularStyle,
                    ),
                  ],
                ),
                marginWidget(2.h, 0),
                Text(
                  'more_videos'.tr,
                  style: mediumStyle,
                ),
                _listVideoSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listVideoSection() => ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.offAndToNamed(Routes.DETAIL_KAJIAN, arguments: [
                controller.kajianVideo.value.items?[index].snippet?.title,
                controller.kajianVideo.value.items?[index].snippet?.description,
                controller.kajianVideo.value.items?[index].id?.videoId,
                controller.kajianVideo.value.items?[index].snippet?.publishTime,
              ]);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: controller.getCurrentThemeValue()
                      ? greyLightColor
                      : Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    errorWidget: (context, url, error) {
                      return Placeholder(
                        child: Text(error),
                      );
                    },
                    imageUrl: controller.kajianVideo.value.items?[index].snippet
                            ?.thumbnails?.medium?.url ??
                        controller.url.contentNotFound,
                    placeholder: (context, url) {
                      return loadingWidget(greenPrimaryColor);
                    },
                    filterQuality: FilterQuality.medium,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    controller.kajianVideo.value.items?[index].snippet?.title ??
                        '',
                    style: mediumStyle.copyWith(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return marginWidget(2.h, 0);
        },
        itemCount: controller.kajianVideo.value.items?.length ?? 0,
      );
}
