import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_quran_controller.dart';

class DetailQuranView extends GetView<DetailQuranController> {
  const DetailQuranView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailQuranView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailQuranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
