import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_tafsir/detail_feat_tafsir/providers/detail_feat_tafsir_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../data/models/tafsir_model.dart';
import '../../../../../utils/constants/constant_theme.dart';
import '../../../../../widgets/custom_textfield.dart';

class DetailFeatTafsirController extends GetxController {
  final provider = Get.put(DetailFeatTafsirProvider());
  var tafsirData = TafsirModel().obs;
  var dataParams = Get.arguments;

  final ayatIndexController = TextEditingController();
    final itemController = ItemScrollController();
  int beginOfAyatNumber = 1;

  var endOfAyatNumber = 2.obs;

    void scrollToAyat(int index) => itemController.scrollTo(
        index: index - 1,
        duration: const Duration(milliseconds: 500),
      );

  loadTafsirData(int surah) async {
    tafsirData(await provider.getTafsirData(surah: surah));
    endOfAyatNumber.value = tafsirData.value.jumlahAyat ?? 2;
  }

  Future<bool> scrollToAyatDialogue(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pergi Ke Ayat'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customTextField(
                    controller: ayatIndexController,
                    hintText:
                        'Masukkan Ayat dari $beginOfAyatNumber - ${endOfAyatNumber.value}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  try {
                    scrollToAyat(int.parse(ayatIndexController.text));
                    ayatIndexController.clear();
                    Get.back();
                  } catch (e) {
                    Get.snackbar('pesan'.tr,
                        'Kamu tidak bisa mencari ayat dengan karakter alpabet!');
                    ayatIndexController.clear();
                  }
                },
                child: Text(
                  'Cari Ayat',
                  style: regularStyle.copyWith(color: greenPrimaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Batal',
                  style: regularStyle.copyWith(color: greyColor),
                ),
              )
            ],
          ),
        )) ??
        false;
  }

  @override
  void onInit() {
    super.onInit();
    loadTafsirData(int.parse(dataParams));
  }
}
