import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/custom_textfield.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../data/models/quran_model.dart';
import '../providers/detail_quran_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../utils/function/string_function.dart';

class DetailQuranController extends GetxController {
  var dataParams = Get.arguments;

  /*
  dataParams[0] = Surah Alquran (Name)
  dataParams[1] = Surah Alquran (Number)
   */

  var quranData = QuranModel().obs;
  var detailQuranProvider = Get.put(DetailQuranProvider());
  final audioPlayer = Get.put(AudioPlayer());
  var stringFunction = Get.put(StringFunction());
  final itemController = ItemScrollController();
  final ayatIndexController = TextEditingController();
  int beginOfAyatNumber = 1;
  var endOfAyatNumber = 2.obs;

  loadQuranData({required int numberSurah}) async {
    quranData(
        await detailQuranProvider.getQuranSurahData(numberSurah: numberSurah));
    endOfAyatNumber.value = quranData.value.jumlahAyat ?? 2;
  }

  void scrollToAyat(int index) => itemController.scrollTo(
        index: index - 1,
        duration: const Duration(milliseconds: 500),
      );

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
                    print('a');
                  } catch (e) {
                    Get.snackbar('pesan'.tr,
                        'Kamu tidak bisa mencari ayat dengan karakter alpabet!');
                    ayatIndexController.clear();
                    print('b');
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
    loadQuranData(numberSurah: dataParams[1]);
    super.onInit();
  }

  @override
  void onClose() {
    ayatIndexController.dispose();
    super.onClose();
  }
}
