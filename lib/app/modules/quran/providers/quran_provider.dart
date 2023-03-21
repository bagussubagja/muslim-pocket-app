// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/surah_quran_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import '../../../data/models/ayat_of_the_day_model.dart';

class QuranProvider extends GetConnect {
  var urlDir = ConstantURL();

  Future<AyatOfTheDayModel?> getAyatOfTheDay() async {
    var client = http.Client();
    var uri = Uri.parse(urlDir.ayatOfTheDayEndpoint);
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;
        return ayatOfTheDayModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return AyatOfTheDayModel();
  }

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
