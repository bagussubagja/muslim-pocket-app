import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/single_hadits_model.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_hadits/detail_feat_hadits/search_hadits/providers/search_hadits_provider.dart';

class SearchHaditsController extends GetxController {
  final haditsNumberController = TextEditingController();
  final provider = Get.put(SearchHaditsProvider());
  var singleHaditsData = SingleHaditsModel().obs;

  var dataParams = Get.arguments;

  loadSingleHaditsData(int numOfHadits) async {
    singleHaditsData(await provider.getSingleHadits(dataParams, numOfHadits));
  }

  @override
  void onClose() {
    haditsNumberController.dispose();
    super.onClose();
  }
}
