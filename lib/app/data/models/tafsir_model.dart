// To parse this JSON data, do
//
//     final tafsirModel = tafsirModelFromJson(jsonString);

import 'dart:convert';

TafsirModel? tafsirModelFromJson(String str) =>
    TafsirModel.fromJson(json.decode(str));

String tafsirModelToJson(TafsirModel? data) => json.encode(data!.toJson());

class TafsirModel {
  TafsirModel({
    this.status,
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
    this.tafsir,
    this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  bool? status;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  List<Tafsir?>? tafsir;
  SuratSelanjutnya? suratSelanjutnya;
  bool? suratSebelumnya;

  factory TafsirModel.fromJson(Map<String, dynamic> json) => TafsirModel(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
        tafsir: json["tafsir"] == null
            ? []
            : List<Tafsir?>.from(
                json["tafsir"]!.map((x) => Tafsir.fromJson(x))),
        suratSelanjutnya: SuratSelanjutnya.fromJson(json["surat_selanjutnya"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
        "tafsir": tafsir == null
            ? []
            : List<dynamic>.from(tafsir!.map((x) => x!.toJson())),
        "surat_selanjutnya": suratSelanjutnya!.toJson(),
        "surat_sebelumnya": suratSebelumnya,
      };
}

class SuratSelanjutnya {
  SuratSelanjutnya({
    this.id,
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  });

  int? id;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  factory SuratSelanjutnya.fromJson(Map<String, dynamic> json) =>
      SuratSelanjutnya(
        id: json["id"],
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
        "id": id,
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

class Tafsir {
  Tafsir({
    this.id,
    this.surah,
    this.ayat,
    this.tafsir,
  });

  int? id;
  int? surah;
  int? ayat;
  String? tafsir;

  factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        id: json["id"],
        surah: json["surah"],
        ayat: json["ayat"],
        tafsir: json["tafsir"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surah": surah,
        "ayat": ayat,
        "tafsir": tafsir,
      };
}
