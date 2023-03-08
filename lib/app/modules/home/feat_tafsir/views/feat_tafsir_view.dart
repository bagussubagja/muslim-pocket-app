import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feat_tafsir_controller.dart';

class FeatTafsirView extends GetView<FeatTafsirController> {
  const FeatTafsirView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeatTafsirView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeatTafsirView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
