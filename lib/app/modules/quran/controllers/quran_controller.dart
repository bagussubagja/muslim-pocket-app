import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/modules/quran/providers/quran_provider.dart';
import 'package:muslim_pocket_app/app/data/models/surah_quran_list_model.dart';

class QuranController extends GetxController {
  //TODO: Implement QuranController

  final quranProvider = Get.put(QuranProvider());

  var quranSurahList = <SurahQuranListModel?>[].obs;
  loadQuranSurahList() async{
    quranSurahList(await quranProvider.getQuranSurahList());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadQuranSurahList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
