// To parse this JSON data, do
//
//     final quranModel = quranModelFromJson(jsonString);

import 'dart:convert';

List<SurahQuranListModel> quranModelFromJson(String str) =>
    List<SurahQuranListModel>.from(
        json.decode(str).map((x) => SurahQuranListModel.fromJson(x)));

String quranModelToJson(List<SurahQuranListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurahQuranListModel {
  SurahQuranListModel({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  });

  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  factory SurahQuranListModel.fromJson(Map<String, dynamic> json) =>
      SurahQuranListModel(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}
