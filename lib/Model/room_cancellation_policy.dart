// To parse this JSON data, do
//
//     final roomCancellationPolicy = roomCancellationPolicyFromMap(jsonString);

import 'dart:convert';

RoomCancellationPolicy roomCancellationPolicyFromMap(String str) =>
    RoomCancellationPolicy.fromMap(json.decode(str));

String roomCancellationPolicyToMap(RoomCancellationPolicy data) => json.encode(data.toMap());

class RoomCancellationPolicy {
  RoomCancellationPolicy({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<Content> data;

  factory RoomCancellationPolicy.fromMap(Map<String, dynamic> json) => RoomCancellationPolicy(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: List<Content>.from(json["data"].map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Content {
  Content({
    required this.currency,
    required this.amount,
    required this.fromDate,
  });

  String currency;
  num amount;
  String fromDate;

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        currency: json["currency"],
        amount: json["amount"],
        fromDate: json["from_date"],
      );

  Map<String, dynamic> toMap() => {
        "currency": currency,
        "amount": amount,
        "from_date": fromDate,
      };
}
