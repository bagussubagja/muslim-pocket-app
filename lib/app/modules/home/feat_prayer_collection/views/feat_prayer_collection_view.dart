import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feat_prayer_collection_controller.dart';

class FeatPrayerCollectionView extends GetView<FeatPrayerCollectionController> {
  const FeatPrayerCollectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeatPrayerCollectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FeatPrayerCollectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
