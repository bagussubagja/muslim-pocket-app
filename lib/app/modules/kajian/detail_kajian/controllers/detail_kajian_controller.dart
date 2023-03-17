import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/modules/kajian/detail_kajian/providers/detail_kajian_provider.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_id_key.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../data/models/kajian_model.dart';

class DetailKajianController extends GetxController {
  /*
  dataParams[0] = Title
  dataParams[1] = Description
  dataParams[2] = Video ID
  dataParams[3] = Publish Time
   */
  var dataParams = Get.arguments;
  final provider = Get.put(DetailKajianProvider());
  final constKey = Get.put(ConstantIdKey());
  final url = Get.put(ConstantURL());
  final localStoragePath = Get.put(LocalStoragePath());
  late YoutubePlayerController ytController;
  var kajianVideo = KajianModel().obs;
  final box = GetStorage();
  var isLightMode = true.obs;

  getCurrentThemeValue() {
    isLightMode.value = box.read(localStoragePath.themePath);
    return isLightMode.value;
  }

  loadKajianVideo(
      {required String channelId,
      required String key,
      required int result}) async {
    kajianVideo(await provider.getIslamicVideo(
        channelId: channelId, key: key, result: result));
  }

  @override
  void onInit() {
    ytController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(
            'https://www.youtube.com/watch?v=${dataParams[2]}')!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ));
    super.onInit();
  }

  @override
  void onReady() {
    loadKajianVideo(
      channelId: constKey.shahihFiqhChannelId,
      key: constKey.youtubeAPIKey,
      result: 5,
    );
    super.onReady();
  }

  @override
  void onClose() {
    ytController.dispose();
    super.onClose();
  }
}
