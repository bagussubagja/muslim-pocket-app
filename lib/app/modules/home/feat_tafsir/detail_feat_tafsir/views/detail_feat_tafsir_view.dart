import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/detail_feat_tafsir_controller.dart';

class DetailFeatTafsirView extends GetView<DetailFeatTafsirController> {
  const DetailFeatTafsirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tafsir_alquran'.tr),
        centerTitle: true,
        backgroundColor: greenPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            children: [
              _bodyItemList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyItemList() {
    return Obx(
      () {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: controller.tafsirData.value.tafsir?.length ?? 0,
          separatorBuilder: (index, context) {
            return marginWidget(2.h, 0);
          },
          itemBuilder: (context, index) {
            return Container(
              width: Get.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: greenDarkerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${controller.tafsirData.value.namaLatin}',
                        style: regularStyle.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Ayat Ke-${controller.tafsirData.value.tafsir?[index]?.ayat}',
                        style: regularStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    "${controller.tafsirData.value.tafsir?[index]?.tafsir}",
                    style: regularStyle.copyWith(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
