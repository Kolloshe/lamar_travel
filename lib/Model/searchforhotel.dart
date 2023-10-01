// To parse required this JSON data, do
//
//     final searchforhotel = searchforhotelFromJson(jsonString);

import 'dart:convert';

Searchforhotel searchforhotelFromJson(String str) =>
    Searchforhotel.fromJson(json.decode(str));

String searchforhotelToJson(Searchforhotel data) => json.encode(data.toJson());

class Searchforhotel {
  Searchforhotel({
    required this.status,
    required this.data,
    required this.hotels,
  });

  Status status;
  Data data;
  List<HotelList> hotels;

  factory Searchforhotel.fromJson(Map<String, dynamic> json) => Searchforhotel(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
        hotels: List<HotelList>.from(
            json["hotels"].map((x) => HotelList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
        "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.hotels,
  });

  List<HotelList> hotels;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        hotels: List<HotelList>.from(
            json["hotels"].map((x) => HotelList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
      };
}

class HotelList {
  HotelList({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory HotelList.fromJson(Map<String, dynamic> json) => HotelList(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Status {
  Status({
    required this.code,
    required this.message,
    required this.error,
  });

  int code;
  String message;
  bool error;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "error": error,
      };
}
