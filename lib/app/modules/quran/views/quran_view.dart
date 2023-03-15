import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/constant_theme.dart';
import '../../../widgets/margin_widget.dart';
import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  QuranView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: defaultPaddingScreen,
            child: ListView(
              children: [
                _titleSection(),
                controller.isAyatOfTheDayFeatureEnable() == null ||
                        controller.isAyatOfTheDayFeatureEnable() == false
                    ? _ayatOfTheDaySection()
                    : _bannerAyatofTheDay(),
                _surahQuranList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleSection() => Text(
        "quran".tr,
        style: boldStyle,
      );

  Widget _bannerAyatofTheDay() => Container(
        margin: EdgeInsets.all(1.h),
        padding: EdgeInsets.all(1.75.h),
        width: 100.w,
        decoration: BoxDecoration(
          color: greenPrimaryColor,
          borderRadius: BorderRadius.circular(1.5.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ayat_of_the_day'.tr,
              style: mediumStyle.copyWith(color: Colors.white),
            ),
            Text(
              'text_banner_ayat_of_the_day'.tr,
              style: regularStyle.copyWith(color: Colors.white),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.isAyatOfTheDayFeatureEnable();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenDarkerColor,
                  elevation: 0,
                ),
                child: Text(
                  'get_ayat_of_the_day'.tr,
                  style: regularStyle.copyWith(color: Colors.white),
                ))
          ],
        ),
      );

  Widget _ayatOfTheDaySection() {
    return Obx(
      () {
        return Container(
          width: Get.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ayat_of_the_day'.tr,
                    style: boldStyle.copyWith(color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.loadAyatOfTheDayData();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: greyColor,
                    ),
                  )
                ],
              ),
              Text(
                '"${controller.ayatOfTheDayData.value.acak?.id?.teks!.replaceAll("\n", "")}"',
                style: regularStyle.copyWith(
                  color: Colors.grey,
                ),
              ),
              marginWidget(1.h, 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.ayatOfTheDayData.value.surat?.nama}',
                    style: regularStyle.copyWith(color: greyColor),
                  ),
                  Text(
                    'Ayat ${controller.ayatOfTheDayData.value.acak?.id?.ayat}/${controller.ayatOfTheDayData.value.surat?.ayat}',
                    style: regularStyle.copyWith(color: greyColor),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _surahQuranList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'daftar_surah'.tr,
            style: boldStyle,
          ),
          marginWidget(2.h, 0),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print(controller.quranSurahList[index]!.nomor);
                  Get.toNamed(Routes.DETAIL_QURAN, arguments: [
                    controller.quranSurahList[index]!.namaLatin,
                    controller.quranSurahList[index]!.nomor,
                  ]);
                },
                child: Obx(() => Container(
                      padding: const EdgeInsets.all(20),
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: greenDarkerColor,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/quran-surah-background.jpg',
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.15,
                          filterQuality: FilterQuality.low,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: regularStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                  Text(
                                    ' - ${controller.quranSurahList[index]!.namaLatin}',
                                    style: regularStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '${controller.quranSurahList[index]!.arti} - ${controller.quranSurahList[index]!.jumlahAyat} Ayat',
                                style: regularStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              )
                            ],
                          ),
                          Text(
                            controller.quranSurahList[index]!.nama!,
                            style: regularStyle.copyWith(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                    )),
              );
            },
            separatorBuilder: (context, index) {
              return marginWidget(2.h, 0);
            },
            itemCount: controller.quranSurahList.length,
          )
        ],
      );
}
