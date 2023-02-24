import 'package:flutter/material.dart';
import 'package:muslim_pocket_app/app/utils/locale.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    Sizer(builder: (context, orientation, deviceType){
      return GetMaterialApp(
        title: "Application",
        translations: LocaleLanguage(),
        locale: Locale('id', 'ID'),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    })
  );
}
