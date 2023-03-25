import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/translations/translations.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  var box = GetStorage();
  final localStoragePath = Get.put(LocalStoragePath());
  if (!box.hasData(localStoragePath.themePath)) {
    box.write(localStoragePath.themePath, true);
  }

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: box.read(localStoragePath.themePath)
              ? ThemeData.light()
              : ThemeData.dark(),
          color: greenPrimaryColor,
          translations: LocaleLanguage(),
          locale: const Locale('id', 'ID'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
