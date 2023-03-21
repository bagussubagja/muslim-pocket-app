import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muslim_pocket_app/app/modules/home/controllers/home_controller.dart';
import 'package:muslim_pocket_app/app/translations/translations.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/utils/storage/local_storage_path.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('location_not_allowed'.tr);
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('location_permission_denied'.tr);
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('cant_proccess_user_request_location_forbidden'.tr);
  }
  return await Geolocator.getCurrentPosition();
}

Future<String> getSubDistrictLocation(double latitude, double longitude) async {
  List<Placemark> placemark =
      await placemarkFromCoordinates(latitude, longitude);
  return placemark[0].locality!.split(" ")[1];
}

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
  } else {
    debugPrint(
        'True = lightMode, False = darkMode => (${box.read(localStoragePath.themePath)})');
  }
  await getCurrentLocation().then((value) {
    box.write(localStoragePath.latitudePath, value.latitude);
    box.write(localStoragePath.longitudePath, value.longitude);
  });
  await getSubDistrictLocation(box.read(localStoragePath.latitudePath),
          box.read(localStoragePath.longitudePath))
      .then(
    (value) => box.write(localStoragePath.subDistrictPath, value),
  );
  debugPrint(box.read(localStoragePath.subDistrictPath));
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          theme: box.read(localStoragePath.themePath)
              ? ThemeData.light()
              : ThemeData.dark(),
          darkTheme: ThemeData.dark(),
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
