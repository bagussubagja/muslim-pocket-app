import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  const HelpCenterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelpCenterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HelpCenterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
