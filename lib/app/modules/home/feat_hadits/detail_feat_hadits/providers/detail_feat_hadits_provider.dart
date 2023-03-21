// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import '../../../../../data/models/detail_hadits_model.dart';

class DetailFeatHaditsProvider extends GetConnect {
  var url = ConstantURL();

  Future<DetailHaditsModel?> getDetailHaditsData(
      String narator, int page) async {
    var client = http.Client();
    var uri = Uri.parse(url.haditsUrlEndpoint(narator, page));
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;
        return detailHaditsModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return DetailHaditsModel();
  }

  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
