import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/help_center_controller.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  HelpCenterView({Key? key}) : super(key: key);
  final controller = Get.put(HelpCenterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pusat_bantuan'.tr),
        backgroundColor: greenPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            children: [
              LottieBuilder.asset(
                'assets/lotties/help_center.json',
              ),
              Text(
                'greeting'.tr,
                style: regularStyle,
                textAlign: TextAlign.center,
              ),
              Text(
                'is_bug_found'.tr,
                style: regularStyle.copyWith(
                  color: greyColor,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () async {
                  final Uri _emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: controller.url.devEmail,
                    queryParameters: {
                      'subject': 'salam_full'.tr,
                      'body': 'help_template'.tr
                    },
                  );
                  await launch(_emailLaunchUri.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenPrimaryColor,
                  elevation: 0,
                ),
                child: Text(
                  'send_bug_report'.tr,
                  style: regularStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
