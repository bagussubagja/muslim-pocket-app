import 'package:get/get.dart';

import '../../../../data/models/quran_model.dart';
import '../providers/detail_quran_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:html/parser.dart';

class DetailQuranController extends GetxController {
  var dataParams = Get.arguments;

  /*
  dataParams[0] = Surah Alquran (Name)
  dataParams[1] = Surah Alquran (Number)
   */

  var quranData = QuranModel().obs;
  var detailQuranProvider = Get.put(DetailQuranProvider());
  final audioPlayer = Get.put(AudioPlayer());

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? "";

    return parsedString;
  }

  loadQuranData({required int numberSurah}) async {
    quranData(
        await detailQuranProvider.getQuranSurahData(numberSurah: numberSurah));
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuranData(numberSurah: dataParams[1]);
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
