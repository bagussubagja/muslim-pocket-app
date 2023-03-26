import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/kajian_video_collection_model.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/content_not_found.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:restart_app/restart_app.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.KAJIAN_VIDEO_COLLECTION);
          },
          backgroundColor: greenPrimaryColor,
          child: const Icon(
            Icons.save_rounded,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: defaultPaddingScreen,
            child: ListView(
              children: [
                _headerSection(),
                _islamicChannelSection(),
                controller.hasInternet.value || controller.kajianVideo.isBlank!
                    ? _listVideoSection()
                    : contentNotFound()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'kajian_islami'.tr,
            style: boldStyle,
          ),
          !controller.isKajianVideoDataExist()
              ? IconButton(
                  onPressed: () {
                    if (controller.hasInternet.value) {
                      Restart.restartApp();
                    } else {
                      Get.snackbar(
                          'pesan'.tr, 'Aktifkan Data Seluler Terlebih Dahulu');
                    }
                  },
                  icon: const Icon(Icons.refresh),
                )
              : const SizedBox.shrink()
        ],
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
            onLongPress: () {
              try {
                final data = KajianVideoCollectionModel(
                    title: controller
                        .kajianVideo.value.items?[index].snippet?.title,
                    description: controller
                        .kajianVideo.value.items?[index].snippet?.description,
                    idVideo:
                        controller.kajianVideo.value.items?[index].id?.videoId,
                    thumbnail: controller.kajianVideo.value.items?[index]
                        .snippet?.thumbnails?.medium?.url,
                    publishTime: controller
                        .kajianVideo.value.items?[index].snippet?.publishTime
                        .toString());
                controller.saveKajianVideo(
                    data, FirebaseAuth.instance.currentUser?.email ?? '');
                Get.snackbar('pesan'.tr,
                    "Berhasil Menambahkan Video Kajian ke koleksi!");
              } catch (e) {
                Get.snackbar('pesan'.tr, e.toString());
              }
            },
            borderRadius: BorderRadius.circular(12),
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
