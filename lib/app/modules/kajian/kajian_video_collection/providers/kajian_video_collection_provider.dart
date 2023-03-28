import 'package:get/get.dart';

class KajianVideoCollectionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
