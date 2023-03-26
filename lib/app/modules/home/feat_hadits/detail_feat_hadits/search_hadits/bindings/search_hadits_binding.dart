import 'package:get/get.dart';

import '../controllers/search_hadits_controller.dart';

class SearchHaditsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchHaditsController>(
      () => SearchHaditsController(),
    );
  }
}
