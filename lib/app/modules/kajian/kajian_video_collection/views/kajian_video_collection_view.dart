import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/routes/app_pages.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';
import 'package:muslim_pocket_app/app/widgets/content_not_found.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/kajian_video_collection_model.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/margin_widget.dart';
import '../controllers/kajian_video_collection_controller.dart';

class KajianVideoCollectionView
    extends GetView<KajianVideoCollectionController> {
  KajianVideoCollectionView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(KajianVideoCollectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenPrimaryColor,
        elevation: 0,
        title: const Text('Koleksi Video Kajian'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: controller.readKajianVideoCollectionData(
              FirebaseAuth.instance.currentUser?.email ?? ''),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;
              if (data?.isEmpty == true) {
                return Align(
                  alignment: Alignment.center,
                  child: contentNotFound(),
                );
              } else {
                return _listVideoSection(data);
              }
            } else {
              return loadingWidget(greenPrimaryColor);
            }
          }),
    );
  }

  Widget _listVideoSection(List<KajianVideoCollectionModel>? model) =>
      ListView.separated(
        itemCount: model?.length ?? 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(
                Routes.DETAIL_KAJIAN,
                arguments: [
                  model?[index].title,
                  model?[index].description,
                  model?[index].idVideo,
                  model?[index].publishTime,
                ],
              );
            },
            onLongPress: () async {
              try {
                var email = FirebaseAuth.instance.currentUser?.email;
                var collection =
                    FirebaseFirestore.instance.collection('kajian $email');
                var snapshots = await collection.get();
                var doc = snapshots.docs;
                collection.doc(doc[index].id).delete();
                Get.snackbar('pesan'.tr, "Video berhasil dihapus!");
              } catch (e) {
                Get.snackbar(
                    'pesan'.tr, "Terjadi error ketika menghapus video!");
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: controller.getCurrentThemeValue()
                      ? greyLightColor
                      : Colors.black12,
                  borderRadius: BorderRadius.circular(12)),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    errorWidget: (context, url, error) {
                      return Placeholder(
                        child: Text(error),
                      );
                    },
                    imageUrl: model?[index].thumbnail ?? '',
                    placeholder: (context, url) {
                      return loadingWidget(greenPrimaryColor);
                    },
                    filterQuality: FilterQuality.medium,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 25.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    model?[index].title ?? '',
                    style: mediumStyle.copyWith(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return marginWidget(2.h, 0);
        },
      );
}
