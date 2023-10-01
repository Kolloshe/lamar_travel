// To parse this JSON data, do
//
//     final cancelBookingModel = cancelBookingModelFromMap(jsonString);

import 'dart:convert';

CancelBookingModel cancelBookingModelFromMap(String str) => CancelBookingModel.fromMap(json.decode(str));

String cancelBookingModelToMap(CancelBookingModel data) => json.encode(data.toMap());

class CancelBookingModel {
  CancelBookingModel({
   required this.code,
   required this.error,
   required this.message,
   required this.data,
  });

  int code;
  bool error;
  String message;
  Data? data;

  factory CancelBookingModel.fromMap(Map<String, dynamic> json) => CancelBookingModel(
    code: json["code"],
    error: json["error"],
    message: json["message"],
    data: json.containsKey('data')?  Data.fromMap(json["data"]):null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "error": error,
    "message": message,
    "data": data?.toMap(),
  };
}

class Data {
  Data({
   required this.bookingRef,
   required this.supportEmail,
  });

  String bookingRef;
  String supportEmail;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    bookingRef: json["bookingRef"],
    supportEmail: json["support_email"],
  );

  Map<String, dynamic> toMap() => {
    "bookingRef": bookingRef,
    "support_email": supportEmail,
  };
}
