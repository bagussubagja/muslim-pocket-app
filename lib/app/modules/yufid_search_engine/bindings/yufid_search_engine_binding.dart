import 'package:get/get.dart';

import '../controllers/yufid_search_engine_controller.dart';

class YufidSearchEngineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YufidSearchEngineController>(
      () => YufidSearchEngineController(),
    );
  }
}
