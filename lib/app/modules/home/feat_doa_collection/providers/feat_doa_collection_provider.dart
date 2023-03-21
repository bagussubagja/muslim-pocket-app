// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import '../../../../data/models/doa_model.dart';

class FeatDoaCollectionProvider extends GetConnect {
  var url = ConstantURL();
  Future<List<DoaModel?>?> getDoasData() async {
    var client = http.Client();
    var uri = Uri.parse(url.doaEndpoint);
    try {
      var respone = await client.get(uri);
      if (respone.statusCode == 200) {
        var json = respone.body;

        return doaModelFromJson(json);
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
