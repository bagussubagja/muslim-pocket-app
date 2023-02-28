import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/constant_directory.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var urlClass = ConstantURL();
  var dirClass = ConstantDirectory();
  var hijriyah = Hijriyah.now();

  final List<String> prayerScheduleName = [
    'Shubuh',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya',
  ];

  final List<String> prayerScheduleTime = [
    '04.10',
    '12.00',
    '15.12',
    '18.09',
    '17.20',
  ];

  final List<Icon> featureCategoryIcon = const [
    Icon(
      FlutterIslamicIcons.lantern,
      color: Colors.white,
      size: 45,
    ),
    Icon(
      FlutterIslamicIcons.prayingPerson,
      color: Colors.white,
      size: 45,
    ),
    Icon(
      FlutterIslamicIcons.quran,
      color: Colors.white,
      size: 45,
    ),
    Icon(
      FlutterIslamicIcons.locationMosque,
      color: Colors.white,
      size: 45,
    ),
  ];

  final List<String> featureCategoryLabel = [
    'hadist'.tr,
    'kumpulan_doa'.tr,
    'tafsir'.tr,
    'masjid_terdekat'.tr
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
