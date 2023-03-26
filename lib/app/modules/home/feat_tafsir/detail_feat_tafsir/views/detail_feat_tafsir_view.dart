import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizer/sizer.dart';

import '../controllers/detail_feat_tafsir_controller.dart';

class DetailFeatTafsirView extends GetView<DetailFeatTafsirController> {
  const DetailFeatTafsirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('tafsir_alquran'.tr),
          centerTitle: true,
          backgroundColor: greenPrimaryColor,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.scrollToAyatDialogue(context);
            },
            backgroundColor: greenPrimaryColor,
            child: const Icon(
              Icons.keyboard_double_arrow_down_rounded,
              color: Colors.white,
            )),
        body: SafeArea(
          child: Padding(
            padding: defaultPaddingScreen,
            child: controller.tafsirData.value.nama != null
                ? _bodyItemList()
                : loadingWidget(greenPrimaryColor),
          ),
        ),
      ),
    );
  }

  Widget _bodyItemList() {
    return ScrollablePositionedList.separated(
      shrinkWrap: true,
      itemScrollController: controller.itemController,
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
  }
}
