import 'package:get/get.dart';

import '../controllers/kajian_video_collection_controller.dart';

class KajianVideoCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KajianVideoCollectionController>(
      () => KajianVideoCollectionController(),
    );
  }
}
