import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:muslim_pocket_app/app/modules/quran/providers/quran_provider.dart';
import 'package:muslim_pocket_app/app/data/models/surah_quran_list_model.dart';
import '../../../data/models/ayat_of_the_day_model.dart';

class QuranController extends GetxController {
  final quranProvider = Get.put(QuranProvider());

  var quranSurahList = <SurahQuranListModel?>[].obs;
  var ayatOfTheDayData = AyatOfTheDayModel().obs;
  var isAyatOfTheDayEnable = false.obs;

  loadQuranSurahList() async {
    quranSurahList(await quranProvider.getQuranSurahList());
  }

  loadAyatOfTheDayData() async {
    ayatOfTheDayData(await quranProvider.getAyatOfTheDay());
  }

  isAyatOfTheDayFeatureEnable() {
    if (ayatOfTheDayData.value.status.toString() == '200') {
      isAyatOfTheDayEnable.value = true;
    } else {
      isAyatOfTheDayEnable.value = false;
    }
  }

/*
  Internet Connectivity
  */

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

  @override
  void onInit() async {
    await checkInternetConnectivity();
    loadQuranSurahList();
    loadAyatOfTheDayData();
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
