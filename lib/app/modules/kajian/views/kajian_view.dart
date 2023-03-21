import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/constant_theme.dart';
import '../controllers/kajian_controller.dart';

class KajianView extends GetView<KajianController> {
  KajianView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(KajianController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: defaultPaddingScreen,
            child: ListView(
              children: [
                _headerSection(),
                _islamicChannelSection(),
                _listVideoSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerSection() => Text(
        'kajian_islami'.tr,
        style: boldStyle,
      );

  Widget _islamicChannelSection() => Container(
        margin: const EdgeInsets.all(12),
        height: 7.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                controller.loadKajianVideo(
                  channelId: controller.channelIds[index],
                  key: controller.key.youtubeAPIKey,
                  result: 50,
                );
              },
              child: Container(
                width: 7.h,
                decoration: BoxDecoration(
                  color: greenPrimaryColor,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: AssetImage(
                      controller.channelLogos[index],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return marginWidget(0, 2.h);
          },
          itemCount: controller.channelLogos.length,
        ),
      );

  Widget _listVideoSection() => ListView.separated(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.DETAIL_KAJIAN, arguments: [
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
