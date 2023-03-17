import 'package:get/get.dart';

import '../controllers/detail_kajian_controller.dart';

class DetailKajianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailKajianController>(
      () => DetailKajianController(),
    );
  }
}
