// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/data/models/kajian_model.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';

class KajianProvider extends GetConnect {
  final url = Get.put(ConstantURL());

  Future<KajianModel?> getIslamicVideo(
      {required String channelId,
      required String key,
      required int result}) async {
    var client = http.Client();
    var uri = Uri.parse(url.youtubeAPIEndpoint(channelId, key, result));
    try {
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        var json = response.body;
        return kajianModelFromJson(json);
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
    return KajianModel();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
