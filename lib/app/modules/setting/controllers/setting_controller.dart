import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

  var url = ConstantURL();

  final List<String> settingLabelOptions = [
    'akun'.tr,
    'tentang_kami'.tr,
    'pusat_bantuan'.tr,
    'log_out'.tr,
  ];

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
}
