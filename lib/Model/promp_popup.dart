// To parse this JSON data, do
//
//     final promoPopup = promoPopupFromMap(jsonString);

import 'dart:convert';

PromoPopup promoPopupFromMap(String str) => PromoPopup.fromMap(json.decode(str));

String promoPopupToMap(PromoPopup data) => json.encode(data.toMap());

class PromoPopup {
  PromoPopup({
    required this.code,
    required this.error,
    this.message,
    this.data,
  });

  int code;
  bool error;
  String? message;
  Data? data;

  factory PromoPopup.fromMap(Map<String, dynamic> json) => PromoPopup(
    code: json["code"],
    error: json["error"],
    message: json["message"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "error": error,
    "message": message,
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    this.id,
    this.image,
    this.startDate,
    this.endDate,
    this.days,
    this.status,
    this.appVisibility,
    this.webVisibility,
  });

  int? id;
  String? image;
  String? startDate;
  String? endDate;
  dynamic days;
  int? status;
  int? appVisibility;
  int? webVisibility;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    image: json["image"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    days: json["days"],
    status: json["status"],
    appVisibility: json["app_visibility"],
    webVisibility: json["web_visibility"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "image": image,
    "start_date": startDate,
    "end_date": endDate,
    "days": days,
    "status": status,
    "app_visibility": appVisibility,
    "web_visibility": webVisibility,
  };
}
