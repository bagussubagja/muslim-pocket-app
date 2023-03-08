import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../../../data/models/prayer_time_model.dart';
import '../../../data/models/surah_quran_list_model.dart';

class HomeProvider extends GetConnect {
  Future<List<SurahQuranListModel?>?> getSurahOfTheDay() async {
    var client = http.Client();
    var uri = Uri.parse('https://equran.id/api/surat');
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;

        return quranModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<PrayerTimeModel?> getPrayerTime() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://muslimsalat.com/rancaekek.json?key=610f59dc2c2a1999fa6cec4ccd9415ed');
    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var json = response.body;
        print(json);
        return prayerTimeModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return PrayerTimeModel();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
