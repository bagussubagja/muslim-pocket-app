import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/yufid_search_engine_controller.dart';

class YufidSearchEngineView extends GetView<YufidSearchEngineController> {
  const YufidSearchEngineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YufidSearchEngineView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'YufidSearchEngineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
