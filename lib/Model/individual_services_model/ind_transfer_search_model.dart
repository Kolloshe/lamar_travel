// To parse required this JSON data, do
//
//     final indTransferSearchModel = indTransferSearchModelFromMap(jsonString);

import 'dart:convert';

IndTransferSearchModel indTransferSearchModelFromMap(String str) =>
    IndTransferSearchModel.fromMap(json.decode(str));

String indTransferSearchModelToMap(IndTransferSearchModel data) => json.encode(data.toMap());

class IndTransferSearchModel {
  IndTransferSearchModel({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<IndTransferSearchResultData> data;

  factory IndTransferSearchModel.fromMap(Map<String, dynamic> json) => IndTransferSearchModel(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: List<IndTransferSearchResultData>.from(
            json["data"].map((x) => IndTransferSearchResultData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class IndTransferSearchResultData {
  IndTransferSearchResultData({
    required this.code,
    required this.countryCode,
    required this.label,
    required this.value,
    required this.type,
    required this.category,
    required this.country,
  });

  String code;
  String countryCode;
  String label;
  String value;
  String type;
  String category;
  String country;

  factory IndTransferSearchResultData.fromMap(Map<String, dynamic> json) =>
      IndTransferSearchResultData(
        code: json["code"].toString(),
        countryCode: json["country_code"].toString(),
        label: json["label"].toString(),
        value: json["value"].toString(),
        type: json["type"].toString(),
        category: json["category"].toString(),
        country: json["country"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "country_code": countryCode,
        "label": label,
        "value": value,
        "type": type,
        "category": category,
        "country": country,
      };
}
