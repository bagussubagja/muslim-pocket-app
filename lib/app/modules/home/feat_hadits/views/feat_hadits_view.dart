import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/constants/constant_theme.dart';
import '../controllers/feat_hadits_controller.dart';

class FeatHaditsView extends GetView<FeatHaditsController> {
  FeatHaditsView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(FeatHaditsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('hadist'.tr),
          elevation: 0,
          backgroundColor: greenPrimaryColor,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: defaultPaddingScreen,
            child: controller.isLoading.value == true
                ? loadingWidget(greenPrimaryColor)
                : ListView(
                    children: [
                      _itemList(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _itemList() {
    return Obx(
      () {
        return ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_FEAT_HADITS,
                      arguments: [controller.naratorsList[index]!.slug!, 1]);
                },
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: greenDarkerColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        controller.naratorsList[index]!.name!,
                        style: regularStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Total Hadist : ${controller.naratorsList[index]!.total}',
                        style: regularStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return marginWidget(2.h, 0);
            },
            itemCount: controller.naratorsList.value.length);
      },
    );
  }
}
