import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/constants/constant_theme.dart';
import '../controllers/kajian_controller.dart';

class KajianView extends GetView<KajianController> {
  KajianView({Key? key}) : super(key: key);
  final controller = Get.put(KajianController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            children: [
              _headerSection(),
              _islamicChannelSection(),
              _listVideoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection() => Text(
        'kajian_islami'.tr,
        style: boldStyle,
      );

  Widget _islamicChannelSection() => Container(
        margin: const EdgeInsets.all(12),
        height: 7.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              width: 7.h,
              decoration: BoxDecoration(
                color: greenPrimaryColor,
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage(
                    controller.channelLogos[index],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return marginWidget(0, 2.h);
          },
          itemCount: controller.channelLogos.length,
        ),
      );

  Widget _listVideoSection() => ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: greyLightColor, borderRadius: BorderRadius.circular(12)),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 25.h,
                width: Get.width,
                child: Image.asset(
                  'assets/images/prayer-bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Title',
                style: mediumStyle,
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return marginWidget(2.h, 0);
      },
      itemCount: 10);
}
