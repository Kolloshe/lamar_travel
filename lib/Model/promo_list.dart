// To parse this JSON data, do
//
//     final promoList = promoListFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

PromoList promoListFromMap(String str) => PromoList.fromMap(json.decode(str));

String promoListToMap(PromoList data) => json.encode(data.toMap());

class PromoList {
  PromoList({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<PromoDataList?> data;

  factory PromoList.fromMap(Map<String, dynamic> json) => PromoList(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: json.containsKey("data")
            ? List<PromoDataList>.from(json["data"].map((x) => PromoDataList.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x!.toMap())),
      };
}

class PromoDataList {
  PromoDataList(
      {required this.id,
      this.title,
      this.name,
      this.description,
      this.promoCode,
      this.image,
      this.smileImage});

  dynamic id;
  String? title;
  String? name;
  String? description;
  String? promoCode;
  String? image;
  String? smileImage;

  factory PromoDataList.fromMap(Map<String, dynamic> json) => PromoDataList(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        description: json["description"],
        promoCode: json["promo_code"] == null ? null : json["promo_code"],
        image: json["image"],
        smileImage: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "name": name,
        "description": description,
        "promo_code": promoCode == null ? null : promoCode,
        "image": image,
        "smile_image": smileImage
      };
}
