import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/quran_model.dart';

class DetailQuranProvider extends GetConnect {
  Future<QuranModel?> getQuranSurahData({required int numberSurah}) async {
    final quranSurahData =
        await rootBundle.loadString('assets/quran/$numberSurah.json');
    return quranModelFromJson(quranSurahData);
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
