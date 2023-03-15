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
    return Obx(() => Scaffold(
          body: SafeArea(
            child: Padding(
              padding: defaultPaddingScreen,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _headerSection(),
                  !controller.isLogged.value
                      ? _avatarSection()
                      : _loginWidget(),
                  !controller.isLogged.value
                      ? _userDataSection()
                      : const SizedBox.shrink(),
                  _settingOptions(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _headerSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'pengaturan'.tr,
            style: boldStyle,
          ),
          IconButton(
            onPressed: () {
              controller.changeThemeState();
              controller.getCurrentThemeValue();
            },
            icon: controller.isLightMode.value == true
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
          )
        ],
      );

  Widget _loginWidget() => Container(
        width: 100.w,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: greenDarkerColor,
            borderRadius: BorderRadius.circular(1.5.h)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Belum login?',
                  style: mediumStyle.copyWith(color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.changeLogInStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenPrimaryColor,
                    elevation: 0,
                  ),
                  child: Text("Login Sekarang!"),
                )
              ],
            ),
            Container(
              height: 20.h,
              width: 15.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/illustrations/login_banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
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

  Widget _settingOptions() => ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, _) => const Divider(),
      itemBuilder: (context, index) => InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(2.h),
            child: Container(
              width: Get.width,
              margin: index == 0 ? EdgeInsets.only(top: 4.h) : null,
              padding: const EdgeInsets.all(15),
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
          ),
      itemCount: controller.settingLabelOptions.length);
}
