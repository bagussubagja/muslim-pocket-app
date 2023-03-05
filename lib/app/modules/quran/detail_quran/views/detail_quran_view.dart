// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:muslim_pocket_app/app/utils/constant_theme.dart';
import 'package:sizer/sizer.dart';

import '../controllers/detail_quran_controller.dart';

class DetailQuranView extends GetView<DetailQuranController> {
  DetailQuranView({Key? key}) : super(key: key);

  final controller = Get.put(DetailQuranController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenPrimaryColor,
        title: Text(controller.dataParams[0]),
        centerTitle: true,
        elevation: 0,
        actions: [
          _playAudioSurah(context),
          _infoSurah(context),
        ],
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() => SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.quranData.value.ayat?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: greenDarkerColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  controller.quranData.value.ayat![index]!.ar!,
                                  style: regularStyle.copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(
                                width: 85.w,
                                child: Text(
                                  "${controller.quranData.value.ayat![index]!.nomor!} - ${controller.quranData.value.ayat![index]!.idn!}",
                                  style: regularStyle.copyWith(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ))
          ],
        ),
      );

  Widget _playAudioSurah(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await controller.audioPlayer
            .play(controller.quranData.value.audio!);
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await controller.audioPlayer.stop();
                              Get.back();
                            },
                            icon: const Icon(Icons.stop),
                          ),
                          Text(
                            'Stop',
                            style: regularStyle,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await controller.audioPlayer.resume();
                            },
                            icon: const Icon(Icons.play_arrow),
                          ),
                          Text(
                            'Play',
                            style: regularStyle,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await controller.audioPlayer.pause();
                            },
                            icon: const Icon(Icons.pause),
                          ),
                          Text(
                            'Pause',
                            style: regularStyle,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              );
            });
      },
      icon: const Icon(
        Icons.play_circle,
      ),
    );
  }

  Widget _infoSurah(BuildContext context) {
    return IconButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(controller.dataParams[0]),
              content: Text(controller.quranData.value.deskripsi!
                  .replaceAll("<i>", "")
                  .replaceAll("</i>", "")),
            );
          },
        );
      },
      icon: const Icon(
        Icons.info_outline_rounded,
      ),
    );
  }
}
