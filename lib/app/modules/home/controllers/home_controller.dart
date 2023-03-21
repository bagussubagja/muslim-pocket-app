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
import 'package:muslim_pocket_app/app/utils/function/string_function.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';
import '../../../data/models/surah_quran_list_model.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  /*
  Dependency
   */
  final homeProvider = Get.put(HomeProvider());
  final stringFunction = Get.put(StringFunction());

  /*
  Variables
   */
  var urlClass = ConstantURL();
  var dirClass = ConstantDirectory();
  var hijriyah = Hijriyah.now();
  var localStoragePath = LocalStoragePath();
  final box = GetStorage();
  var isLightMode = true.obs;

  /*
  Location Service
   */

  // Future<Position> getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('location_not_allowed'.tr);
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('location_permission_denied'.tr);
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('cant_proccess_user_request_location_forbidden'.tr);
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

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

  loadPrayerTime(String subDistrict) async {
    prayerTime(await homeProvider.getPrayerTime(subDistrict.toLowerCase()));
    if (prayerTime.value.items != null) {
      shubuh.value = convertTo24HourFormat(prayerTime.value.items![0].fajr!);
      dzuhur.value = convertTo24HourFormat(prayerTime.value.items![0].dhuhr!);
      ashar.value = convertTo24HourFormat(prayerTime.value.items![0].asr!);
      maghrib.value =
          convertTo24HourFormat(prayerTime.value.items![0].maghrib!);
      isya.value = convertTo24HourFormat(prayerTime.value.items![0].isha!);
    }
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

  List<String> featureCategoryLabel = [
    'hadist'.tr,
    'kumpulan_doa'.tr,
    'tafsir'.tr,
    'masjid_terdekat'.tr
  ];

  /*
  Surah of the Day
   */

  var isSurahOfTheDayRequested = false.obs;

  requestSurahOfTheDay() {
    isSurahOfTheDayRequested.value = true;
    box.write(localStoragePath.surahOfTheDayPath, true);
  }

  var surahOfTheDayData = SurahQuranListModel().obs;

  loadSurahOfTheDay() async {
    surahOfTheDayData(await homeProvider.getSurahOfTheDay());
  }

  /*
  Islamic Website
   */

  final List<String> websiteLogo = [
    'assets/logo/website-logos/bimbingan-islam.png',
    'assets/logo/website-logos/khotbah-jumat.jpg',
    'assets/logo/website-logos/kisah-muslim.png',
    'assets/logo/website-logos/konsultasi-syariah.jpg',
    'assets/logo/website-logos/muslim-or-id.jpg',
    'assets/logo/website-logos/muslimah-or-id.png',
    'assets/logo/website-logos/rumaysho.jpg',
    'assets/logo/website-logos/yufid-edu.jpg',
    'assets/logo/website-logos/yufid-tv.png',
    'assets/logo/website-logos/yufidia.jpg',
  ];

  final List<String> websiteName = [
    'Bimbingan Islam',
    'Khotbah Jumat',
    'Kisah Muslim',
    'Konsultasi Syariah',
    'Muslim.or.id',
    'Muslimah.or.id',
    'Rumaysho',
    'Yufid Edu',
    'Yufid TV',
    'Yufidia',
  ];

  final List<String> websiteUrl = [
    'https://bimbinganislam.com/',
    "https://khotbahjumat.com/",
    "https://kisahmuslim.com/",
    "https://konsultasisyariah.com/",
    "https://muslim.or.id/",
    "https://muslimah.or.id/",
    "https://rumaysho.com/",
    "https://yufidedu.com/",
    "https://yufid.tv/",
    "https://yufidia.com/",
  ];

  /*
  Others
   */

  isPrayerScheduleDataExist() {
    return prayerTime.value.items == null;
  }

  isAddressDataExist() {
    return prayerTime.value.items != null;
  }

  isSurahOfTheDayDataExist() {
    return box.read(localStoragePath.surahOfTheDayPath) != null ||
        isSurahOfTheDayRequested.value == true;
  }

  isDataLoaded() {
    return isLoading.value;
  }

  getCurrentThemeValue() {
    isLightMode.value = box.read(localStoragePath.themePath);
    return isLightMode.value;
  }

  @override
  void onInit() {
    locationEndpoint.value = urlClass.nearbyMosqueEndpoint(
      box.read(localStoragePath.latitudePath).toString(),
      box.read(localStoragePath.longitudePath).toString(),
    );
    loadSurahOfTheDay();
    loadPrayerTime(box.read(localStoragePath.subDistrictPath));
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
