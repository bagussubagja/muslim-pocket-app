import 'package:get/get.dart';

import '../controllers/detail_feat_hadits_controller.dart';

class DetailFeatHaditsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailFeatHaditsController>(
      () => DetailFeatHaditsController(),
    );
  }
}
