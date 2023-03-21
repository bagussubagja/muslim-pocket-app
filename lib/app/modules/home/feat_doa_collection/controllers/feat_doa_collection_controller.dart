import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/doa_model.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_doa_collection/providers/feat_doa_collection_provider.dart';

class FeatDoaCollectionController extends GetxController {
  final doaProvider = Get.put(FeatDoaCollectionProvider());

  var doasList = <DoaModel?>[].obs;
  var isLoading = false.obs;

  loadDoasData() async {
    isLoading.value = true;
    doasList(await doaProvider.getDoasData());
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    loadDoasData();
  }

}
