// To parse this JSON data, do
//
//     final singleHaditsModel = singleHaditsModelFromJson(jsonString);

import 'dart:convert';

SingleHaditsModel singleHaditsModelFromJson(String str) => SingleHaditsModel.fromJson(json.decode(str));

String singleHaditsModelToJson(SingleHaditsModel data) => json.encode(data.toJson());

class SingleHaditsModel {
    SingleHaditsModel({
        this.name,
        this.slug,
        this.number,
        this.arab,
        this.id,
    });

    String? name;
    String? slug;
    int? number;
    String? arab;
    String? id;

    factory SingleHaditsModel.fromJson(Map<String, dynamic> json) => SingleHaditsModel(
        name: json["name"],
        slug: json["slug"],
        number: json["number"],
        arab: json["arab"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "slug": slug,
        "number": number,
        "arab": arab,
        "id": id,
    };
}
