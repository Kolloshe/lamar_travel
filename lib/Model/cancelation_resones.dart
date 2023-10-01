//     final cancellationReasons = cancellationReasonsFromJson(jsonString);

import 'dart:convert';

CancellationReasons cancellationReasonsFromJson(String str) =>
    CancellationReasons.fromJson(json.decode(str));

String cancellationReasonsToJson(CancellationReasons data) => json.encode(data.toJson());

class CancellationReasons {
  CancellationReasons({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<String> data;

  factory CancellationReasons.fromJson(Map<String, dynamic> json) => CancellationReasons(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
