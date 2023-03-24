import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/constants/constant_theme.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            color: greenPrimaryColor,
            backgroundColor: greenLightColor.withOpacity(0.35),
            buttonBackgroundColor: greenPrimaryColor.withOpacity(0.7),
            animationDuration: const Duration(milliseconds: 400),
            items: [
              Icon(
                controller.index.value == 0 ? Icons.home : Icons.home_outlined,
                color: greyLightColor,
              ),
              Icon(
                controller.index.value == 1 ? Icons.book : Icons.book_outlined,
                color: greyLightColor,
              ),
              Icon(
                controller.index.value == 2
                    ? Icons.search_rounded
                    : Icons.search_sharp,
                color: greyLightColor,
              ),
              Icon(
                controller.index.value == 3
                    ? Icons.monitor
                    : Icons.monitor_outlined,
                color: greyLightColor,
              ),
              Icon(
                controller.index.value == 4
                    ? Icons.settings
                    : Icons.settings_outlined,
                color: greyLightColor,
              ),
            ],
            onTap: (index) {
              controller.changeIndex(index);
            },
          ),
          body: controller.bodyScreenList[controller.index.value],
        ));
  }
}
