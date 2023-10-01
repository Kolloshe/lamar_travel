// To parse this JSON data, do
//
//     final privetJetCategoryModel = privetJetCategoryModelFromMap(jsonString);

import 'dart:convert';

PrivetJetCategoryModel privetJetCategoryModelFromMap(String str) =>
    PrivetJetCategoryModel.fromMap(json.decode(str));

String privetJetCategoryModelToMap(PrivetJetCategoryModel data) => json.encode(data.toMap());

class PrivetJetCategoryModel {
  PrivetJetCategoryModel({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<Categories> data;

  factory PrivetJetCategoryModel.fromMap(Map<String, dynamic> json) => PrivetJetCategoryModel(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: List<Categories>.from(json["data"].map((x) => Categories.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Categories {
  Categories({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
