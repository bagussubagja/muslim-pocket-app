// To parse this JSON data, do
//
//     final haditsNaratorsModel = haditsNaratorsModelFromJson(jsonString);

import 'dart:convert';

List<HaditsNaratorsModel?>? haditsNaratorsModelFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<HaditsNaratorsModel?>.from(
            json.decode(str)!.map((x) => HaditsNaratorsModel.fromJson(x)));

String haditsNaratorsModelToJson(List<HaditsNaratorsModel?>? data) =>
    json.encode(
        data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class HaditsNaratorsModel {
  HaditsNaratorsModel({
    this.name,
    this.slug,
    this.total,
  });

  String? name;
  String? slug;
  int? total;

  factory HaditsNaratorsModel.fromJson(Map<String, dynamic> json) =>
      HaditsNaratorsModel(
        name: json["name"],
        slug: json["slug"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "total": total,
      };
}
