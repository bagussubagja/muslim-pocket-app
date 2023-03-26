import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/data/models/kajian_video_collection_model.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_url.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';

class KajianVideoCollectionController extends GetxController {
  final localStoragePath = Get.put(LocalStoragePath());
  final url = Get.put(ConstantURL());
  var isLightMode = true.obs;
  final box = GetStorage();

  getCurrentThemeValue() {
    isLightMode.value = box.read(localStoragePath.themePath);
    return isLightMode.value;
  }

  Stream<List<KajianVideoCollectionModel>> readKajianVideoCollectionData(
          String email) =>
      FirebaseFirestore.instance.collection('kajian $email').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => KajianVideoCollectionModel.fromJson(doc.data()))
              .toList());
}
