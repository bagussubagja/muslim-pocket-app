import 'package:get/get.dart';

import '../controllers/detail_feat_tafsir_controller.dart';

class DetailFeatTafsirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailFeatTafsirController>(
      () => DetailFeatTafsirController(),
    );
  }
}
