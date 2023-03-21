import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import '../../../data/models/prayer_time_model.dart';
import '../../../data/models/surah_quran_list_model.dart';

class HomeProvider extends GetConnect {
  Future<SurahQuranListModel> getSurahOfTheDay() async {
    final quranSurahListData =
        await rootBundle.loadString('assets/quran/quran-surah-list.json');
    final dataList = json.decode(quranSurahListData) as List<dynamic>;
    final randomIndex = Random().nextInt(dataList.length);
    return SurahQuranListModel.fromJson(dataList[randomIndex]);
  }

  Future<PrayerTimeModel?> getPrayerTime(String subDistrict) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://muslimsalat.com/$subDistrict.json?key=610f59dc2c2a1999fa6cec4ccd9415ed');
    try {
      var response = await client.get(uri);
      print(response.request);
      if (response.statusCode == 200) {
        var json = response.body;
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
