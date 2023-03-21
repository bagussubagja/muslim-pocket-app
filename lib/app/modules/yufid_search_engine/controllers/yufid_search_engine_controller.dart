import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YufidSearchEngineController extends GetxController {

  late WebViewController webViewController;

  final persentage = 0.obs;
  var isLoaded = false.obs;

  void progressUpdate(int progress){
    persentage.value++;
    if(progress == 100){
      isLoaded.value = true;
      update();
    }
  }
}
