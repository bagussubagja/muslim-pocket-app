import 'package:get/get.dart';

import '../controllers/feat_hadits_controller.dart';

class FeatHaditsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatHaditsController>(
      () => FeatHaditsController(),
    );
  }
}
