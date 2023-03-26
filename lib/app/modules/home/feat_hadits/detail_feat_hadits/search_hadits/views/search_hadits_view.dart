import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/custom_textfield.dart';

import '../controllers/search_hadits_controller.dart';

class SearchHaditsView extends GetView<SearchHaditsController> {
  SearchHaditsView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(SearchHaditsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: customTextField(
              controller: controller.haditsNumberController,
              hintText: 'Cari Nomor Hadits dari Perawi',
              maxLength: 4,
              function: () {
                controller.loadSingleHaditsData(
                    int.parse(controller.haditsNumberController.text));
                controller.haditsNumberController.clear();
              },
            ),
            centerTitle: true,
            backgroundColor: greenPrimaryColor,
          ),
          body: Padding(
            padding: defaultPaddingScreen,
            child: ListView(
              children: [
                Text(
                  'Perawi : ${controller.singleHaditsData.value.name ?? '-'}',
                  style: regularStyle,
                ),
                Text(
                  'Nomor Hadits : ${controller.singleHaditsData.value.number ?? '-'}',
                  style: regularStyle,
                ),
                Text(
                  'Narasi Hadits :\n ${controller.singleHaditsData.value.arab ?? '-'}',
                  style: regularStyle,
                ),
                Text(
                  'Artinya :\n ${controller.singleHaditsData.value.id ?? '-'}',
                  style: regularStyle,
                ),
              ],
            ),
          ),
        ));
  }
}
