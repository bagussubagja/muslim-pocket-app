// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../../data/models/single_hadits_model.dart';
import '../../../../../../utils/constants/constant_url.dart';

class SearchHaditsProvider extends GetConnect {
  var url = ConstantURL();

  Future<SingleHaditsModel?> getSingleHadits(
      String narator, int numOfHadits) async {
    var client = http.Client();
    var uri = Uri.parse(url.singleHaditsUrlEndpoint(narator, numOfHadits));
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;
        return singleHaditsModelFromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return SingleHaditsModel();
  }
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
