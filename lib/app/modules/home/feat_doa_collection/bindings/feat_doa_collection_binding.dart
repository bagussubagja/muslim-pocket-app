import 'package:get/get.dart';

import '../controllers/feat_doa_collection_controller.dart';

class FeatDoaCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatDoaCollectionController>(
      () => FeatDoaCollectionController(),
    );
  }
}
