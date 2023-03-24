import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:muslim_pocket_app/app/authentication/authentication.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';

class SettingController extends GetxController {
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

  var hasInternet = false
      .obs; // to checking if internet status is on or off when app launch for first time
  var isInternetActive = false
      .obs; // to check if internet status is on or off when app already launched
  late StreamSubscription subscription;

  checkInternetConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isInternetActive.value =
            await InternetConnectionChecker().hasConnection;
        if (isInternetActive.value) {
          hasInternet.value = true;
        } else {
          hasInternet.value = false;
        }
      });

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
  void onInit() async {
    await checkInternetConnectivity();
    super.onInit();
    getCurrentThemeValue();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
