import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/feat_tafsir_controller.dart';

class FeatTafsirView extends GetView<FeatTafsirController> {
  FeatTafsirView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(FeatTafsirController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tafsir'.tr),
        centerTitle: true,
        backgroundColor: greenPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            children: [
              Text(
                'Silahkan Pilih Tafsir dari surah Al-Quran dibawah :',
                style: regularStyle,
                textAlign: TextAlign.center,
              ),
              marginWidget(2.h, 0),
              SizedBox(
                width: Get.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: 12,
                  children:
                      List.generate(controller.quranSurahList.length, (index) {
                    return InkWell(
                      onTap: () {
                        final noSurah =
                            controller.quranSurahList[index].numericOnly();
                        Get.toNamed(Routes.DETAIL_FEAT_TAFSIR,
                            arguments: noSurah);
                      },
                      child: Container(
                        height: 15.h,
                        width: 15.h,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: greenDarkerColor,
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/quran-surah-background.jpg'),
                            opacity: 0.35,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.quranSurahList[index],
                              style: regularStyle.copyWith(
                                color: Colors.white,
                                fontSize: 11.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
