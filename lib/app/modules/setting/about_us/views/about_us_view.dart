import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tentang_kami'.tr),
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
                'assets/lotties/about_us.json',
              ),
              marginWidget(1.75.h, 0),
              Text(
                'salam_full'.tr,
                style: regularStyle,
                textAlign: TextAlign.center,
              ),
              marginWidget(1.75.h, 0),
              Text(
                'app_desc'.tr,
                style: regularStyle.copyWith(color: greyColor),
                textAlign: TextAlign.center,
              ),
              marginWidget(1.75.h, 0),
              Text(
                'app_author'.tr,
                style: regularStyle.copyWith(
                  fontSize: 10.sp,
                  color: greyColor,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
