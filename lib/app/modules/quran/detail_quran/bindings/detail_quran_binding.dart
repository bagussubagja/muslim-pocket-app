import 'package:get/get.dart';

import '../controllers/detail_quran_controller.dart';

class DetailQuranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailQuranController>(
      () => DetailQuranController(),
    );
  }
}
