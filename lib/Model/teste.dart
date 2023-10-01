// To parse required this JSON data, do
//
//     final teste = testeFromJson(jsonString);

import 'dart:convert';

Teste testeFromJson(String str) => Teste.fromJson(json.decode(str));

String testeToJson(Teste data) => json.encode(data.toJson());

class Teste {
    Teste({
        required this.status,
        required this.payload,
        required this.message,
        required this.completedAt,
        required this.code,
    });

    bool status;
    List<List<Payload>> payload;
    String message;
    DateTime completedAt;
    int code;

    factory Teste.fromJson(Map<String, dynamic> json) => Teste(
        status: json["status"],
        payload: List<List<Payload>>.from(json["payload"].map((x) => List<Payload>.from(x.map((x) => Payload.fromJson(x))))),
        message: json["message"],
        completedAt: DateTime.parse(json["completed_at"]),
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "payload": List<dynamic>.from(payload.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "message": message,
        "completed_at": completedAt.toIso8601String(),
        "code": code,
    };
}

class Payload {
    Payload({
        required  this.id,
        required this.cityName,
        required this.destinationName,
        required this.iso3,
        required this.countryName,
        required this.cityCode,
        required this.airportCode,
        required this.hotelCounts,
    });

    int id;
    String cityName;
    String destinationName;
    String iso3;
    String countryName;
    String cityCode;
    String airportCode;
    String hotelCounts;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        cityName: json["city_name"],
        destinationName: json["destination_name"],
        iso3: json["iso3"],
        countryName: json["country_name"],
        cityCode: json["city_code"],
        airportCode: json["airport_code"],
        hotelCounts: json["hotel_counts"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
        "destination_name": destinationName,
        "iso3": iso3,
        "country_name": countryName,
        "city_code": cityCode,
        "airport_code": airportCode,
        "hotel_counts": hotelCounts,
    };
}
