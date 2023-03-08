import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/constant_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: defaultPaddingScreen,
              child: controller.isLoading.value == true
                  ? loadingWidget(greenPrimaryColor)
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _userInformation(),
                        _dateNowSection(context),
                        _prayerTimeSchedule(),
                        _featuresCategory(),
                        // _surahOfTheDay(),
                        _islamicWebsite(),
                      ],
                    )),
        ),
      );
    });
  }

  Widget _userInformation() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'salam'.tr},',
                style: regularStyle,
              ),
              Text(
                'Bagus Subagja',
                style: regularStyle.copyWith(fontWeight: FontWeight.w800),
              )
            ],
          ),
          CachedNetworkImage(
            placeholder: (context, url) {
              return const CircularProgressIndicator();
            },
            useOldImageOnUrlChange: false,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            imageUrl: controller.urlClass.emptyAvatar,
          )
        ],
      );

  Widget _dateNowSection(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 2.h),
        padding: const EdgeInsets.all(20),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage('${controller.dirClass.assetImage}prayer-bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              greenPrimaryColor,
              greenLightColor,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.hijriyah.toFormat('dd MMMM yyyy'),
              style: regularStyle.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            marginWidget(2.h, 0),
            DigitalClock(
              is24HourTimeFormat: true,
              hourMinuteDigitTextStyle: boldStyle.copyWith(
                fontSize: 28.sp,
                color: Colors.white,
              ),
              secondDigitTextStyle: boldStyle.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
              ),
              colon: Text(
                ":",
                style: boldStyle.copyWith(
                  fontSize: 28.sp,
                  color: Colors.white,
                ),
              ),
            ),
            marginWidget(2.h, 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                marginWidget(0, 2.w),
                Flexible(
                  child: Text(
                    "${controller.prayerTime.value.title}",
                    style: regularStyle.copyWith(color: Colors.white),
                    overflow: TextOverflow.visible,
                  ),
                )
              ],
            )
          ],
        ),
      );

  Widget _prayerTimeSchedule() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 2.h),
            width: Get.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                controller.prayerScheduleName.length,
                (index) => Container(
                  height: 8.5.h,
                  width: 8.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: greenDarkerColor,
                    image: DecorationImage(
                      image: AssetImage(
                          '${controller.dirClass.assetImage}prayer-schedule.jpg'),
                      opacity: 0.35,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.prayerScheduleName[index],
                        style: regularStyle.copyWith(
                            color: Colors.white, fontSize: 11.sp),
                      ),
                      Text(
                        controller.prayerTimeList[index] ?? "...",
                        style: regularStyle.copyWith(
                            color: Colors.white, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );

  Widget _featuresCategory() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          marginWidget(2.h, 0),
          Text(
            '${'kategori'.tr}',
            style: boldStyle,
          ),
          marginWidget(2.h, 0),
          SizedBox(
            width: Get.width,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: List.generate(
                controller.featureCategoryLabel.length,
                (index) => InkWell(
                  onTap: () async {
                    if (index == 0) {
                      Get.toNamed(Routes.FEAT_HADITS);
                    } else if (index == 1) {
                      Get.toNamed(Routes.FEAT_PRAYER_COLLECTION);
                    } else if (index == 2) {
                      Get.toNamed(Routes.FEAT_TAFSIR);
                    } else if (index == 3) {
                      if (await canLaunch(controller.locationEndpoint.value)) {
                        await launch(controller.locationEndpoint.value,
                            forceWebView: false);
                      }
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        width: 8.h,
                        height: 8.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: greenPrimaryColor.withOpacity(0.9),
                        ),
                        child: controller.featureCategoryIcon[index],
                      ),
                      Text(
                        controller.featureCategoryLabel[index]
                            .replaceAll(" ", "\n"),
                        style: regularStyle.copyWith(fontSize: 12.sp),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );

  // Widget _surahOfTheDay() => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'surah_of_the_day'.tr,
  //           style: boldStyle,
  //         ),
  //         ListView.builder(
  //             itemCount: controller.surahofTheDayData.length,
  //             shrinkWrap: true,
  //             primary: false,
  //             itemBuilder: (context, index) {
  //               return Container(
  //                 width: 100.w,
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: greyLightColor,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "${controller.quranSurahList[0]?.namaLatin}",
  //                           style: regularStyle.copyWith(
  //                             fontWeight: FontWeight.w800,
  //                           ),
  //                         ),
  //                         Text(
  //                           "${controller.quranSurahList[0]?.nama}",
  //                           style: regularStyle.copyWith(
  //                             fontWeight: FontWeight.w800,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     Text(
  //                         "${controller.parseHtmlString(controller.quranSurahList[0]!.deskripsi.substring(0, 100))}...")
  //                   ],
  //                 ),
  //               );
  //             })
  //       ],
  //     );

  Widget _islamicWebsite() => Container();
}
