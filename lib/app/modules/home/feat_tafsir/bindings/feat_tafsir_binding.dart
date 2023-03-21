import 'package:get/get.dart';

import '../controllers/feat_tafsir_controller.dart';

class FeatTafsirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatTafsirController>(
      () => FeatTafsirController(),
    );
  }
}
