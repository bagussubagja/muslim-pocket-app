import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/feat_doa_collection/bindings/feat_doa_collection_binding.dart';
import '../modules/home/feat_doa_collection/views/feat_doa_collection_view.dart';
import '../modules/home/feat_hadits/bindings/feat_hadits_binding.dart';
import '../modules/home/feat_hadits/detail_feat_hadits/bindings/detail_feat_hadits_binding.dart';
import '../modules/home/feat_hadits/detail_feat_hadits/views/detail_feat_hadits_view.dart';
import '../modules/home/feat_hadits/views/feat_hadits_view.dart';
import '../modules/home/feat_tafsir/bindings/feat_tafsir_binding.dart';
import '../modules/home/feat_tafsir/detail_feat_tafsir/bindings/detail_feat_tafsir_binding.dart';
import '../modules/home/feat_tafsir/detail_feat_tafsir/views/detail_feat_tafsir_view.dart';
import '../modules/home/feat_tafsir/views/feat_tafsir_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kajian/bindings/kajian_binding.dart';
import '../modules/kajian/detail_kajian/bindings/detail_kajian_binding.dart';
import '../modules/kajian/detail_kajian/views/detail_kajian_view.dart';
import '../modules/kajian/views/kajian_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/quran/bindings/quran_binding.dart';
import '../modules/quran/detail_quran/bindings/detail_quran_binding.dart';
import '../modules/quran/detail_quran/views/detail_quran_view.dart';
import '../modules/quran/views/quran_view.dart';
import '../modules/setting/about_us/bindings/about_us_binding.dart';
import '../modules/setting/about_us/views/about_us_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/help_center/bindings/help_center_binding.dart';
import '../modules/setting/help_center/views/help_center_view.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/yufid_search_engine/bindings/yufid_search_engine_binding.dart';
import '../modules/yufid_search_engine/views/yufid_search_engine_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.FEAT_HADITS,
          page: () => FeatHaditsView(),
          binding: FeatHaditsBinding(),
          children: [
            GetPage(
              name: _Paths.DETAIL_FEAT_HADITS,
              page: () => DetailFeatHaditsView(),
              binding: DetailFeatHaditsBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.FEAT_TAFSIR,
          page: () => FeatTafsirView(),
          binding: FeatTafsirBinding(),
          children: [
            GetPage(
              name: _Paths.DETAIL_FEAT_TAFSIR,
              page: () => const DetailFeatTafsirView(),
              binding: DetailFeatTafsirBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.FEAT_DOA_COLLECTION,
          page: () => FeatDoaCollectionView(),
          binding: FeatDoaCollectionBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.QURAN,
      page: () => QuranView(),
      binding: QuranBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_QURAN,
          page: () => DetailQuranView(),
          binding: DetailQuranBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.KAJIAN,
      page: () => KajianView(),
      binding: KajianBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_KAJIAN,
          page: () => DetailKajianView(),
          binding: DetailKajianBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
      children: [
        GetPage(
          name: _Paths.ABOUT_US,
          page: () => const AboutUsView(),
          binding: AboutUsBinding(),
        ),
        GetPage(
          name: _Paths.HELP_CENTER,
          page: () => HelpCenterView(),
          binding: HelpCenterBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.YUFID_SEARCH_ENGINE,
      page: () => YufidSearchEngineView(),
      binding: YufidSearchEngineBinding(),
    ),
  ];
}
