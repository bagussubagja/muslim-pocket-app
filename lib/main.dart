import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/translations/translations.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          translations: LocaleLanguage(),
          locale: Locale('id', 'ID'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
