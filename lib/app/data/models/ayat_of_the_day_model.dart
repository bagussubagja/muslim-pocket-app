// To parse this JSON data, do
//
//     final ayatOfTheDayModel = ayatOfTheDayModelFromJson(jsonString);

import 'dart:convert';

AyatOfTheDayModel? ayatOfTheDayModelFromJson(String str) =>
    AyatOfTheDayModel.fromJson(json.decode(str));

String ayatOfTheDayModelToJson(AyatOfTheDayModel? data) =>
    json.encode(data!.toJson());

class AyatOfTheDayModel {
  AyatOfTheDayModel({
    this.status,
    this.query,
    this.acak,
    this.surat,
  });

  String? status;
  Query? query;
  Acak? acak;
  Surat? surat;

  factory AyatOfTheDayModel.fromJson(Map<String, dynamic> json) =>
      AyatOfTheDayModel(
        status: json["status"],
        query: Query.fromJson(json["query"]),
        acak: Acak.fromJson(json["acak"]),
        surat: Surat.fromJson(json["surat"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "query": query!.toJson(),
        "acak": acak!.toJson(),
        "surat": surat!.toJson(),
      };
}

class Acak {
  Acak({
    this.id,
    this.ar,
  });

  Ar? id;
  Ar? ar;

  factory Acak.fromJson(Map<String, dynamic> json) => Acak(
        id: Ar.fromJson(json["id"]),
        ar: Ar.fromJson(json["ar"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id!.toJson(),
        "ar": ar!.toJson(),
      };
}

class Ar {
  Ar({
    this.id,
    this.surat,
    this.ayat,
    this.teks,
  });

  String? id;
  String? surat;
  String? ayat;
  String? teks;

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
        id: json["id"],
        surat: json["surat"],
        ayat: json["ayat"],
        teks: json["teks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surat": surat,
        "ayat": ayat,
        "teks": teks,
      };
}

class Query {
  Query({
    this.format,
  });

  String? format;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "format": format,
      };
}

class Surat {
  Surat({
    this.nomor,
    this.nama,
    this.asma,
    this.name,
    this.start,
    this.ayat,
    this.type,
    this.urut,
    this.rukuk,
    this.arti,
    this.keterangan,
  });

  String? nomor;
  String? nama;
  String? asma;
  String? name;
  String? start;
  String? ayat;
  String? type;
  String? urut;
  String? rukuk;
  String? arti;
  String? keterangan;

  factory Surat.fromJson(Map<String, dynamic> json) => Surat(
        nomor: json["nomor"],
        nama: json["nama"],
        asma: json["asma"],
        name: json["name"],
        start: json["start"],
        ayat: json["ayat"],
        type: json["type"],
        urut: json["urut"],
        rukuk: json["rukuk"],
        arti: json["arti"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "asma": asma,
        "name": name,
        "start": start,
        "ayat": ayat,
        "type": type,
        "urut": urut,
        "rukuk": rukuk,
        "arti": arti,
        "keterangan": keterangan,
      };
}
