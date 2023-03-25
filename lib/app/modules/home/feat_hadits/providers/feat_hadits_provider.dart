import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import '../../../../data/models/hadits_narators_model.dart';

class FeatHaditsProvider extends GetConnect {
  final url = ConstantURL();

  Future<List<HaditsNaratorsModel?>?> getNaratorsData() async {
    var client = http.Client();
    var uri = Uri.parse(url.haditsEndpoint);
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;

        return haditsNaratorsModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
