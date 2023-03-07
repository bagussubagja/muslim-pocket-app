import 'package:get/get.dart';

class KajianController extends GetxController {
  //TODO: Implement KajianController

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

  final List<String> channelId = [];

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
