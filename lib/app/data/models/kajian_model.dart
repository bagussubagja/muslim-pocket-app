// To parse this JSON data, do
//
//     final kajianModel = kajianModelFromJson(jsonString);

import 'dart:convert';

KajianModel kajianModelFromJson(String str) =>
    KajianModel.fromJson(json.decode(str));

String kajianModelToJson(KajianModel data) => json.encode(data.toJson());

class KajianModel {
  KajianModel({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.regionCode,
    this.items,
  });

  String? kind;
  String? etag;
  String? nextPageToken;
  String? regionCode;
  List<Item>? items;

  factory KajianModel.fromJson(Map<String, dynamic> json) => KajianModel(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        regionCode: json["regionCode"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "regionCode": regionCode,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.etag,
    this.id,
    this.snippet,
  });

  String? etag;
  Id? id;
  Snippet? snippet;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        etag: json["etag"],
        id: json["id"] == null ? null : Id.fromJson(json["id"]),
        snippet:
            json["snippet"] == null ? null : Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "etag": etag,
        "id": id?.toJson(),
        "snippet": snippet?.toJson(),
      };
}

class Id {
  Id({
    this.videoId,
  });

  String? videoId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
      };
}

class Snippet {
  Snippet({
    this.publishedAt,
    this.title,
    this.description,
    this.thumbnails,
    this.publishTime,
  });

  DateTime? publishedAt;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  DateTime? publishTime;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        title: json["title"],
        description: json["description"],
        thumbnails: json["thumbnails"] == null
            ? null
            : Thumbnails.fromJson(json["thumbnails"]),
        publishTime: json["publishTime"] == null
            ? null
            : DateTime.parse(json["publishTime"]),
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt?.toIso8601String(),
        "title": title,
        "description": description,
        "thumbnails": thumbnails?.toJson(),
        "publishTime": publishTime?.toIso8601String(),
      };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
  });

  Default? thumbnailsDefault;
  Default? medium;
  Default? high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault:
            json["default"] == null ? null : Default.fromJson(json["default"]),
        medium:
            json["medium"] == null ? null : Default.fromJson(json["medium"]),
        high: json["high"] == null ? null : Default.fromJson(json["high"]),
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault?.toJson(),
        "medium": medium?.toJson(),
        "high": high?.toJson(),
      };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  String? url;
  int? width;
  int? height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
