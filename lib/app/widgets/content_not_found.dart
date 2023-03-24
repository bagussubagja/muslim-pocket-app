import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muslim_pocket_app/app/utils/constants/constant_theme.dart';

Widget contentNotFound() => Column(
      children: [
        LottieBuilder.asset(
          'assets/lotties/content-not-found.json',
        ),
        Text(
          'Konten Sedang Tidak Tersedia atau Ada kendala dengan layanan. Coba lagi dalam beberapa waktu!',
          style: regularStyle,
          textAlign: TextAlign.center,
        )
      ],
    );
