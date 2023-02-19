import 'package:get/get.dart';

import '../controllers/kajian_controller.dart';

class KajianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KajianController>(
      () => KajianController(),
    );
  }
}
