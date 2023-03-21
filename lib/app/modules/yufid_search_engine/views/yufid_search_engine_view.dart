import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utils/constants/constant_theme.dart';
import '../controllers/yufid_search_engine_controller.dart';

class YufidSearchEngineView extends GetView<YufidSearchEngineController> {
  YufidSearchEngineView({Key? key}) : super(key: key);
  final yufidController = Get.put(YufidSearchEngineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.refresh_rounded),
            )
          ],
          elevation: 0,
          backgroundColor: greenPrimaryColor,
          title: Text(
            'yufid_search_engine'.tr,
            style: regularStyle.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: WebView(
          initialUrl: 'https://yufid.com/',
          onProgress: (progress) {
            yufidController.progressUpdate(progress);
          },
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            yufidController.webViewController = controller;
          },
        ));
  }
}
