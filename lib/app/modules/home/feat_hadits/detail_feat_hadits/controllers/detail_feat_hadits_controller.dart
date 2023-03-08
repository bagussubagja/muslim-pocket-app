import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/data/models/detail_hadits_model.dart';
import 'package:muslim_pocket_app/app/modules/home/feat_hadits/detail_feat_hadits/providers/detail_feat_hadits_provider.dart';

class DetailFeatHaditsController extends GetxController {
  final detailProvider = Get.put(DetailFeatHaditsProvider());
  var detailHadits = DetailHaditsModel().obs;
  var dataParams = Get.arguments;

  var page = 1;

  ScrollController scrollController = ScrollController();

  int pageLength() {
    if (detailHadits.value.items?.length != null) {
      return detailHadits.value.items!.length;
    } else {
      return 0;
    }
  }

  loadDetailHaditsData(String narator, int page) async {
    detailHadits(await detailProvider.getDetailHaditsData(narator, page));
  }

  @override
  void onInit() {
    super.onInit();
    loadDetailHaditsData(dataParams[0], page);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {
          debugPrint('Awal Page');
        } else {
          debugPrint('Load Data Baru');
          page++;
          loadDetailHaditsData(dataParams[0], page);
        }
        // loadDetailHaditsData(datas[0], 2);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
