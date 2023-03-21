import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/loading_widget.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/feat_doa_collection_controller.dart';

class FeatDoaCollectionView extends GetView<FeatDoaCollectionController> {
  FeatDoaCollectionView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(FeatDoaCollectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kumpulan_doa'.tr),
        centerTitle: true,
        elevation: 0,
        backgroundColor: greenPrimaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            shrinkWrap: true,
            children: [
              _doaListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doaListView() {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return loadingWidget(greenPrimaryColor);
        } else {
          return ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: controller.doasList.length,
            separatorBuilder: (index, context) {
              return marginWidget(2.h, 0);
            },
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(10),
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: greenDarkerColor,
                ),
                child: Column(
                  children: [
                    Text(
                      controller.doasList[index]!.doa!,
                      style: regularStyle.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      controller.doasList[index]!.ayat!,
                      style: regularStyle.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      controller.doasList[index]!.latin!,
                      style: regularStyle.copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      controller.doasList[index]!.artinya!,
                      style: regularStyle.copyWith(
                        fontSize: 11.sp,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
