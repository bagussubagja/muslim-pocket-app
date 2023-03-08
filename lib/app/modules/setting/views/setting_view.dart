import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/margin_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  SettingView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: defaultPaddingScreen,
          child: ListView(
            shrinkWrap: true,
            children: [
              _headerSection(),
              _avatarSection(),
              _userDataSection(),
              _settingOptions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'pengaturan'.tr,
            style: boldStyle,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode))
        ],
      );

  Widget _avatarSection() => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Align(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: controller.url.emptyAvatar,
            imageBuilder: (context, imageProvider) => Container(
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
            errorWidget: (context, url, error) => Image.network(
              controller.url.contentNotFound,
            ),
          ),
        ),
      );

  Widget _userDataSection() => Column(
        children: [
          Text(
            'Bagus Subagja',
            style: regularStyle,
          ),
          Text(
            'bagussubagja99@gmail.com',
            style: regularStyle.copyWith(color: greyColor),
          )
        ],
      );

  Widget _settingOptions() => ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 2.h),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyLightColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.settingLabelOptions[index],
                  style: regularStyle,
                ),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
      itemCount: controller.settingLabelOptions.length);
}
