import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/modules/home/views/home_view.dart';
import 'package:muslim_pocket_app/app/modules/kajian/views/kajian_view.dart';
import 'package:muslim_pocket_app/app/modules/quran/views/quran_view.dart';
import 'package:muslim_pocket_app/app/modules/setting/views/setting_view.dart';
import 'package:muslim_pocket_app/app/modules/yufid_search_engine/views/yufid_search_engine_view.dart';

class MainPageController extends GetxController {

  final index = 0.obs;

  final List<Widget> bodyScreenList = [
    HomeView(),
    QuranView(),
    YufidSearchEngineView(),
    KajianView(),
    SettingView(),
  ];

  void changeIndex (int newIndex){
    index.value = newIndex;
    update();
  }
}
