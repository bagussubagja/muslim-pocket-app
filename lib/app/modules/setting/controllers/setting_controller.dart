import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/authentication/authentication.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

  final googleAuthProvider = Get.put(GoogleAuthentication());
  var userName = FirebaseAuth.instance.currentUser?.displayName;
  var displayPicture = FirebaseAuth.instance.currentUser?.photoURL;
  var emailUser = FirebaseAuth.instance.currentUser?.email;
  var url = ConstantURL();
  var box = GetStorage();
  var localStoragePath = Get.put(LocalStoragePath());
  var isLightMode = true.obs;
  var isLogged = true.obs;

  List<String> settingLabelOptions = [
    'tentang_kami'.tr,
    'pusat_bantuan'.tr,
    'log_out'.tr,
  ];

  changeThemeState() {
    Get.changeTheme(
      Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
    );
    box.remove(localStoragePath.themePath);
    box.write(localStoragePath.themePath, Get.isDarkMode);
  }

  getCurrentThemeValue() {
    isLightMode.value = box.read(localStoragePath.themePath);
    return isLightMode.value;
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentThemeValue();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
