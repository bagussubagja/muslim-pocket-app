import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YufidSearchEngineController extends GetxController {

  late WebViewController webViewController;

  final persentage = 0.obs;
  var isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void progressUpdate(int progress){
    persentage.value++;
    if(progress == 100){
      isLoaded.value = true;
      update();
    }
  }
}
