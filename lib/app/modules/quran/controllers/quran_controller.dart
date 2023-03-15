import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/modules/quran/providers/quran_provider.dart';
import 'package:muslim_pocket_app/app/data/models/surah_quran_list_model.dart';
import '../../../data/models/ayat_of_the_day_model.dart';

class QuranController extends GetxController {
  //TODO: Implement QuranController

  final quranProvider = Get.put(QuranProvider());

  var quranSurahList = <SurahQuranListModel?>[].obs;
  var ayatOfTheDayData = AyatOfTheDayModel().obs;
  var isAyatOfTheDayEnable = false.obs;

  loadQuranSurahList() async {
    quranSurahList(await quranProvider.getQuranSurahList());
  }

  loadAyatOfTheDayData() async {
    ayatOfTheDayData(await quranProvider.getAyatOfTheDay());
  }

  isAyatOfTheDayFeatureEnable() {
    if (ayatOfTheDayData.value.status.toString() == '200') {
      isAyatOfTheDayEnable.value = true;
    } else {
      isAyatOfTheDayEnable.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadQuranSurahList();
    loadAyatOfTheDayData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
