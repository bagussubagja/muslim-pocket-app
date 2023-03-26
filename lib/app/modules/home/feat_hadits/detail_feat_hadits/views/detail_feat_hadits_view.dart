import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/constant_theme.dart';
import '../controllers/detail_feat_hadits_controller.dart';

class DetailFeatHaditsView extends GetView<DetailFeatHaditsController> {
  DetailFeatHaditsView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(DetailFeatHaditsController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            title: Text("${'hadist'.tr} ${controller.dataParams[2]}"),
            centerTitle: true,
            backgroundColor: greenPrimaryColor,
            elevation: 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.SEARCH_HADITS,
                  arguments: controller.dataParams[0]);
            },
            backgroundColor: greenPrimaryColor,
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              controller: controller.scrollController,
              children: [
                _itemList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _itemList() {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        if (index < controller.pageLength()) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: Get.width,
            decoration: BoxDecoration(
              color: greenDarkerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  'Hadits ke-${controller.detailHadits.value.items?[index]?.number}',
                  style: regularStyle.copyWith(color: Colors.white),
                ),
                Text(
                  '${controller.detailHadits.value.items?[index]?.arab}',
                  style: regularStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${controller.detailHadits.value.items?[index]?.id}',
                  style: regularStyle.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return loadingWidget(greenPrimaryColor);
        }
      },
      separatorBuilder: (index, context) {
        return marginWidget(2.h, 0);
      },
      itemCount: controller.pageLength() + 1,
    );
  }
}
