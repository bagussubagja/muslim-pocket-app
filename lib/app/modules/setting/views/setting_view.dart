import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_layout.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
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
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return Obx(() {
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      _headerSection(),
                      _avatarSection(snapshot),
                      _userDataSection(snapshot),
                      _settingOptions(snapshot: snapshot),
                    ],
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      _headerSection(),
                      _loginWidget(context: context),
                    ],
                  );
                }
              });
            },
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

  Widget _loginWidget({required BuildContext context}) => Container(
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
                  onPressed: controller.hasInternet.value
                      ? () async {
                          controller.googleAuthProvider.signInWithGoogle();
                        }
                      : () {
                          Get.snackbar('pesan'.tr, 'Aktifkan Data Seluler Terlebih Dahulu!');
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenPrimaryColor,
                    elevation: 0,
                  ),
                  child: const Text("Login Sekarang!"),
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

  Widget _avatarSection(AsyncSnapshot<User?> snapshot) => Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Align(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: snapshot.data?.photoURL ?? controller.url.emptyAvatar,
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

  Widget _userDataSection(AsyncSnapshot<User?> snapshot) => Column(
        children: [
          Text(
            snapshot.data?.displayName ?? '',
            style: regularStyle,
          ),
          Text(
            snapshot.data?.email ?? '',
            style: regularStyle.copyWith(color: greyColor),
          )
        ],
      );

  Widget _settingOptions({required AsyncSnapshot<User?> snapshot}) =>
      ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, _) => const Divider(),
          itemCount: controller.settingLabelOptions.length,
          itemBuilder: (context, index) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            } else {
              return InkWell(
                onTap: () async {
                  if (index == 0) {
                    Get.toNamed(Routes.ABOUT_US);
                  } else if (index == 1) {
                    Get.toNamed(Routes.HELP_CENTER);
                  } else if (index == 2) {
                    controller.googleAuthProvider.logout();
                    Get.snackbar("pesan".tr, "logout_success".tr);
                  }
                },
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
              );
            }
          });
}
