import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/surah_quran_list_model.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_directory.dart';

class QuranProvider extends GetConnect {
  Future<List<SurahQuranListModel>> getQuranSurahList() async {
    final quranSurahListData =
        await rootBundle.loadString('assets/quran/quran-surah-list.json');
    final dataList = json.decode(quranSurahListData) as List<dynamic>;
    return dataList.map((e) => SurahQuranListModel.fromJson(e)).toList();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
