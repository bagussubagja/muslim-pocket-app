import 'package:get/get.dart';

import '../../../../data/models/quran_model.dart';
import '../providers/detail_quran_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../utils/function/string_function.dart';

class DetailQuranController extends GetxController {
  var dataParams = Get.arguments;

  /*
  dataParams[0] = Surah Alquran (Name)
  dataParams[1] = Surah Alquran (Number)
   */

  var quranData = QuranModel().obs;
  var detailQuranProvider = Get.put(DetailQuranProvider());
  final audioPlayer = Get.put(AudioPlayer());
  var stringFunction = Get.put(StringFunction());

  loadQuranData({required int numberSurah}) async {
    quranData(
        await detailQuranProvider.getQuranSurahData(numberSurah: numberSurah));
  }

  @override
  void onInit() {
    super.onInit();
    loadQuranData(numberSurah: dataParams[1]);
  }



}
