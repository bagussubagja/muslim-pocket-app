// To parse this JSON data, do
//
//     final kajianVideoCollectionModel = kajianVideoCollectionModelFromJson(jsonString);

import 'dart:convert';

KajianVideoCollectionModel kajianVideoCollectionModelFromJson(String str) => KajianVideoCollectionModel.fromJson(json.decode(str));

String kajianVideoCollectionModelToJson(KajianVideoCollectionModel data) => json.encode(data.toJson());

class KajianVideoCollectionModel {
    KajianVideoCollectionModel({
        this.title,
        this.thumbnail,
        this.description,
        this.idVideo,
        this.publishTime,
    });

    String? title;
    String? thumbnail;
    String? description;
    String? idVideo;
    String? publishTime;

    factory KajianVideoCollectionModel.fromJson(Map<String, dynamic> json) => KajianVideoCollectionModel(
        title: json["title"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        idVideo: json["id_video"],
        publishTime: json["publish_time"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "description": description,
        "id_video": idVideo,
        "publish_time": publishTime,
    };
}
