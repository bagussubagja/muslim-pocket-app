// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';

import '../../../../data/models/tafsir_model.dart';

class FeatTafsirProvider extends GetConnect {
  var url = ConstantURL();
  Future<TafsirModel?> getTafsirData({required int surah}) async {
    var client = http.Client();
    var uri = Uri.parse(url.tafsirEndpoint(surah));
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;
        return tafsirModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return TafsirModel();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
