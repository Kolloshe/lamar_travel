// To parse this JSON data, do
//
//     final refreshPayUrLModel = refreshPayUrLModelFromMap(jsonString);

import 'dart:convert';

RefreshPayUrLModel refreshPayUrLModelFromMap(String str) =>
    RefreshPayUrLModel.fromMap(json.decode(str));

String refreshPayUrLModelToMap(RefreshPayUrLModel data) => json.encode(data.toMap());

class RefreshPayUrLModel {
  RefreshPayUrLModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory RefreshPayUrLModel.fromMap(Map<String, dynamic> json) => RefreshPayUrLModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.paymentUrl,
  });

  String paymentUrl;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        paymentUrl: json["payment_url"],
      );

  Map<String, dynamic> toMap() => {
        "payment_url": paymentUrl,
      };
}
