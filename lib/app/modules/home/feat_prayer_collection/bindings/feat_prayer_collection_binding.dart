import 'package:get/get.dart';

import '../controllers/feat_prayer_collection_controller.dart';

class FeatPrayerCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeatPrayerCollectionController>(
      () => FeatPrayerCollectionController(),
    );
  }
}
