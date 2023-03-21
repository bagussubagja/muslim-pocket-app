// To parse this JSON data, do
//
//     final detailHaditsModel = detailHaditsModelFromJson(jsonString);

import 'dart:convert';

DetailHaditsModel? detailHaditsModelFromJson(String str) =>
    DetailHaditsModel.fromJson(json.decode(str));

String detailHaditsModelToJson(DetailHaditsModel? data) =>
    json.encode(data!.toJson());

class DetailHaditsModel {
  DetailHaditsModel({
    this.items,
  });

  List<Item?>? items;

  factory DetailHaditsModel.fromJson(Map<String, dynamic> json) =>
      DetailHaditsModel(
        items: json["items"] == null
            ? []
            : List<Item?>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x!.toJson())),
      };
}

class Item {
  Item({
    this.number,
    this.arab,
    this.id,
  });

  int? number;
  String? arab;
  String? id;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        number: json["number"],
        arab: json["arab"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "arab": arab,
        "id": id,
      };
}
