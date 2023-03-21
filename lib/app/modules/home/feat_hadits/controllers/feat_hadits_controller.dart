import 'dart:async';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/hadits_narators_model.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_hadits/providers/feat_hadits_provider.dart';

class FeatHaditsController extends GetxController {
  // Dependency
  final haditsProvider = Get.put(FeatHaditsProvider());
  var isLoading = true.obs;

  void showContent() {
    isLoading.value = false;
  }

  var naratorsList = <HaditsNaratorsModel?>[].obs;

  loadNaratorList() async {
    naratorsList(await haditsProvider.getNaratorsData());
  }

  @override
  void onInit() {
    loadNaratorList();
    super.onInit();
    Timer(const Duration(seconds: 1), showContent);
  }

}
