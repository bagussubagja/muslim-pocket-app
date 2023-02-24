import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/kajian/bindings/kajian_binding.dart';
import '../modules/kajian/views/kajian_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/quran/bindings/quran_binding.dart';
import '../modules/quran/detail_quran/bindings/detail_quran_binding.dart';
import '../modules/quran/detail_quran/views/detail_quran_view.dart';
import '../modules/quran/views/quran_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
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
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.QURAN,
      page: () => const QuranView(),
      binding: QuranBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_QURAN,
          page: () => const DetailQuranView(),
          binding: DetailQuranBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.KAJIAN,
      page: () => const KajianView(),
      binding: KajianBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.YUFID_SEARCH_ENGINE,
      page: () => const YufidSearchEngineView(),
      binding: YufidSearchEngineBinding(),
    ),
  ];
}
