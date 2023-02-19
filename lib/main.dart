import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    Sizer(builder: (context, orientation, deviceType){
      return GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    })
  );
}
