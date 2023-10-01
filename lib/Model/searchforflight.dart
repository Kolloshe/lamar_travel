// To parse required this JSON data, do
//
//     final searchforflight = searchforflightFromJson(jsonString);

import 'dart:convert';

Searchforflight searchforflightFromJson(String str) =>
    Searchforflight.fromJson(json.decode(str));

String searchforflightToJson(Searchforflight data) =>
    json.encode(data.toJson());

class Searchforflight {
  Searchforflight({
    required this.status,
    required this.data,
    required this.flights,
  });

  Status status;
  Data data;
  List<FlightList> flights;

  factory Searchforflight.fromJson(Map<String, dynamic> json) =>
      Searchforflight(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
        flights: json["flights"].runtimeType.toString() != 'String'
            ? List<FlightList>.from(
                json["flights"].map((x) => FlightList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
        "flights": List<dynamic>.from(flights.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    required this.flights,
  });

  List<FlightList> flights;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        flights: json["flights"].runtimeType.toString() != 'String'
            ? List<FlightList>.from(
                json["flights"].map((x) => FlightList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "flights": List<dynamic>.from(flights.map((x) => x.toJson())),
      };
}

class FlightList {
  FlightList({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory FlightList.fromJson(Map<String, dynamic> json) => FlightList(
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
