import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_tafsir/detail_feat_tafsir/providers/detail_feat_tafsir_provider.dart';

import '../../../../../data/models/tafsir_model.dart';

class DetailFeatTafsirController extends GetxController {
  final provider = Get.put(DetailFeatTafsirProvider());
  var tafsirData = TafsirModel().obs;
  var dataParams = Get.arguments;

  loadTafsirData(int surah) async {
    tafsirData(await provider.getTafsirData(surah: surah));
  }

  @override
  void onInit() {
    super.onInit();
    loadTafsirData(int.parse(dataParams));
  }

}
