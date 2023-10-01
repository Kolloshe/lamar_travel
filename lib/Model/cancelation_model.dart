// To parse required this JSON data, do
//
//     final canceliation = canceliationFromJson(jsonString);

import 'dart:convert';

Canceliation canceliationFromJson(String str) => Canceliation.fromJson(json.decode(str));

String canceliationToJson(Canceliation data) => json.encode(data.toJson());

class Canceliation {
    Canceliation({
        required this.error,
        required this.data,
    });

    bool error;
    Data data;

    factory Canceliation.fromJson(Map<String, dynamic> json) => Canceliation(
        error: json["error"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.currency,
        required this.total,
    });

    String currency;
    double total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currency: json["currency"],
        total: json["total"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "total": total,
    };
}
