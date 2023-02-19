import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kajian_controller.dart';

class KajianView extends GetView<KajianController> {
  const KajianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KajianView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KajianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
