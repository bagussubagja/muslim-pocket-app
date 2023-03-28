import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:muslim_pocket_app/app/data/models/kajian_model.dart';
import 'package:muslim_pocket_app/app/data/models/kajian_video_collection_model.dart';
import 'package:muslim_pocket_app/app/modules/kajian/providers/kajian_provider.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_id_key.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';

import '../../../authentication/authentication.dart';

class KajianController extends GetxController {
  final key = Get.put(ConstantIdKey());
  final url = Get.put(ConstantURL());
  final provider = Get.put(KajianProvider());
  final box = GetStorage();
  final localStoragePath = Get.put(LocalStoragePath());
  var isLightMode = true.obs;
  var hasInternet = false.obs;

   final googleAuthProvider = Get.put(GoogleAuthentication());

  getCurrentThemeValue() {
    isLightMode.value = box.read(localStoragePath.themePath);
    return isLightMode.value;
  }

  final List<String> channelLogos = [
    'assets/logo/channel-logos/hsi-abdullahroy.jpg',
    'assets/logo/channel-logos/jejak-shahabat.jpg',
    'assets/logo/channel-logos/khalid-basalamah.jpg',
    'assets/logo/channel-logos/mutiara-sunnah-bandung.jpg',
    'assets/logo/channel-logos/nuzul-dzikri.jpg',
    'assets/logo/channel-logos/raehanul-baharaen.jpg',
    'assets/logo/channel-logos/rifqan-tv.jpg',
    'assets/logo/channel-logos/rodjatv.png',
    'assets/logo/channel-logos/rumaysho.jpg',
    'assets/logo/channel-logos/shahih-fiqh.jpeg',
    'assets/logo/channel-logos/syafiq-basalamah.jpg',
    'assets/logo/channel-logos/tarbiyah-sunnah.jpg',
  ];

  final List<String> channelName = [
    'HSI Abdullahroy',
    'Jejak Shahabat',
    'Khalid Basalamah',
    'Mutiara Sunnah Bandung',
    'Muhammad Nuzul Dzikri',
    'Raehanul Baharaen',
    'Rifqan TV',
    'Rodja TV',
    'Rumaysho',
    'Shahih Fiqh',
    'Syafiq Riza Basalamah',
    'Tarbiyah Sunnah',
  ];

  List<String> channelIds = [
    "UCpxXfrttfXNsUXCDvc3MQkQ",
    "UCbwm_qjlB3wQ_M140F38IVQ",
    "UCJHC3VbFsp7kJ2NxPGltwiw",
    "UCfNwrkkJPEJRvGIwPdSsDbA",
    "UCZHbLWGrq43F0-5Ef37CpWQ",
    "UCFmTr7NBAX556zo76DXxfsg",
    "UCkrLd1cy4AUOp1pAdu1Ru7Q",
    "UCP-tWGFUAmVWFz4XyHDz07A",
    "UC42PJ3sXqYJwSMPtiWCTfew",
    "UClCl3I9DfH4HUty22wPF9eg",
    "UC3_QdDQnRVRDJzq56JTO_Zw",
    "UCM73P3XvOfj0HjC97KKYW5g",
  ];

  var kajianVideo = KajianModel().obs;

  loadKajianVideo(
      {required String channelId,
      required String key,
      required int result}) async {
    kajianVideo(await provider.getIslamicVideo(
        channelId: channelId, key: key, result: result));
  }

  isKajianVideoDataExist() {
    if (kajianVideo.value.items?.isNotEmpty == true) {
      return true;
    } else {
      return false;
    }
  }

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

  // kajian video collection
  Future saveKajianVideo(KajianVideoCollectionModel model, String email) async {
    final data = FirebaseFirestore.instance.collection('kajian $email');

    final json = model.toJson();
    await data.add(json);
  }

  @override
  void onInit() async {
    await checkInternetConnectivity();
    loadKajianVideo(
      channelId: key.shahihFiqhChannelId,
      key: key.youtubeAPIKey,
      result: 50,
    );
    super.onInit();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }
}
