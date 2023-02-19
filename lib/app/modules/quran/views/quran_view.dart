import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  const QuranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuranView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'QuranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
