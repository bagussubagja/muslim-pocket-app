import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:muslim_pocket_app/app/data/models/prayer_time_model.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_directory.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:muslim_pocket_app/app/modules/home/providers/home_provider.dart';
import 'package:html/parser.dart';
import '../../../data/models/surah_quran_list_model.dart';

class HomeController extends GetxController {
  /*
  Dependency
   */
  final homeProvider = Get.put(HomeProvider());

  /*
  Variables
   */
  var urlClass = ConstantURL();
  var dirClass = ConstantDirectory();
  var hijriyah = Hijriyah.now();

  /*
  Date Service
   */

  /*
  Location Service
   */

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // TODO: Tambahkan ke translation
      return Future.error('Akses Lokasi Tidak diizinkan');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Akses Lokasi ditolak!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Akses lokasi dilarang, tidak bisa meneruskan proses permintaan pengguna');
    }
    return await Geolocator.getCurrentPosition();
  }

  var lat = "".obs;
  var long = "".obs;

  var locationEndpoint = "".obs;

  /*
  Prayer Time
   */
  final List<String> prayerScheduleName = [
    'Shubuh',
    'Dzuhur',
    'Ashar',
    'Maghrib',
    'Isya',
  ];
  var prayerTime = PrayerTimeModel().obs;
  var prayerTimeList = [].obs;
  var shubuh = "".obs;
  var dzuhur = "".obs;
  var ashar = "".obs;
  var maghrib = "".obs;
  var isya = "".obs;
  var isLoading = true.obs;

  void showContent() {
    isLoading.value = false;
  }

  String convertTo24HourFormat(String timeString) {
    List<String> parts = timeString.split(' ');
    List<String> timeParts = parts[0].split(':');

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    if (parts[1] == 'pm' && hours != 12) {
      hours += 12;
    } else if (parts[1] == 'am' && hours == 12) {
      hours = 0;
    }

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    return '$formattedHours:$formattedMinutes';
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? "";

    return parsedString;
  }

  loadPrayerTime() async {
    prayerTime(await homeProvider.getPrayerTime());
    if (prayerTime.value.items != null) {
      shubuh.value = convertTo24HourFormat(prayerTime.value.items![0].fajr!);
      dzuhur.value = convertTo24HourFormat(prayerTime.value.items![0].dhuhr!);
      ashar.value = convertTo24HourFormat(prayerTime.value.items![0].asr!);
      maghrib.value =
          convertTo24HourFormat(prayerTime.value.items![0].maghrib!);
      isya.value = convertTo24HourFormat(prayerTime.value.items![0].isha!);
    }
    print('subuh : ${shubuh.value}');
    prayerTimeList.add(shubuh.value);
    prayerTimeList.add(dzuhur.value);
    prayerTimeList.add(ashar.value);
    prayerTimeList.add(maghrib.value);
    prayerTimeList.add(isya.value);
  }

  /*
  Category Feature
   */

  final List<Icon> featureCategoryIcon = const [
    Icon(
      FlutterIslamicIcons.lantern,
      color: Colors.white,
      size: 40,
    ),
    Icon(
      FlutterIslamicIcons.prayingPerson,
      color: Colors.white,
      size: 40,
    ),
    Icon(
      FlutterIslamicIcons.quran,
      color: Colors.white,
      size: 40,
    ),
    Icon(
      FlutterIslamicIcons.locationMosque,
      color: Colors.white,
      size: 40,
    ),
  ];

  final List<String> featureCategoryLabel = [
    'hadist'.tr,
    'kumpulan_doa'.tr,
    'tafsir'.tr,
    'masjid_terdekat'.tr
  ];

  /*
  Others
   */

  @override
  void onInit() {
    getCurrentLocation().then((value) {
      lat.value = '${value.latitude}';
      long.value = '${value.longitude}';
    });
    locationEndpoint.value =
        urlClass.nearbyMosqueEndpoint(lat.value, long.value);
    loadPrayerTime();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 3), showContent);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
