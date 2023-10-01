// To parse required this JSON data, do
//
//     final searchTransferIfRemoveForH = searchTransferIfRemoveForHFromJson(jsonString);

import 'dart:convert';

SearchTransferIfRemoveForH searchTransferIfRemoveForHFromJson(String str) =>
    SearchTransferIfRemoveForH.fromJson(json.decode(str));

String searchTransferIfRemoveForHToJson(SearchTransferIfRemoveForH data) =>
    json.encode(data.toJson());

class SearchTransferIfRemoveForH {
  SearchTransferIfRemoveForH({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  Data data;

  factory SearchTransferIfRemoveForH.fromJson(Map<String, dynamic> json) =>
      SearchTransferIfRemoveForH(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.type,
    required this.currentPage,
    required this.totalPages,
    required this.totalResults,
    required this.resultPerPage,
    required this.nextPage,
    required this.basePath,
    required this.airports,
    required this.hotels,
  });

  String type;
  int currentPage;
  int totalPages;
  int totalResults;
  int resultPerPage;
  String? nextPage;
  String? basePath;
  List<SearchTransferAirport>? airports;
  List<SearchTransferHotel>? hotels;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        resultPerPage: json["result_per_page"],
        nextPage: json["next_page"],
        basePath: json["base_path"],
        airports: json["airports"] != null
            ? List<SearchTransferAirport>.from(
                json["airports"].map((x) => SearchTransferAirport.fromJson(x)))
            : null,
        hotels: json["hotels"] != null
            ? List<SearchTransferHotel>.from(
                json["hotels"].map((x) => SearchTransferHotel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "current_page": currentPage,
        "total_pages": totalPages,
        "total_results": totalResults,
        "result_per_page": resultPerPage,
        "next_page": nextPage,
        "base_path": basePath,
        "airports": List<dynamic>.from(airports!.map((x) => x.toJson())),
        "hotels": List<dynamic>.from(hotels!.map((x) => x.toJson())),
      };
}

class SearchTransferAirport {
  SearchTransferAirport({
    required this.code,
    required this.name,
    required this.countryCode,
    required this.cityName,
  });

  String code;
  String name;
  String countryCode;
  String cityName;

  factory SearchTransferAirport.fromJson(Map<String, dynamic> json) => SearchTransferAirport(
        code: json["code"],
        name: json["name"],
        countryCode: json["country_code"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "country_code": countryCode,
        "city_name": cityName,
      };
}

class SearchTransferHotel {
  SearchTransferHotel({
    required this.id,
    required this.hotelId,
    required this.hotelCode,
    required this.name,
    required this.destinationCode,
    required this.destinationName,
    required this.latitude,
    required this.longitude,
  });

  int id;
  String hotelId;
  String hotelCode;
  String name;
  String destinationCode;
  String destinationName;
  String latitude;
  String longitude;

  factory SearchTransferHotel.fromJson(Map<String, dynamic> json) => SearchTransferHotel(
        id: json["id"],
        hotelId: json["hotelId"].toString(),
        hotelCode: json["hotelCode"],
        name: json["name"],
        destinationCode: json["destinationCode"],
        destinationName: json["destinationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hotelId": hotelId,
        "hotelCode": hotelCode,
        "name": name,
        "destinationCode": destinationCode,
        "destinationName": destinationName,
        "latitude": latitude,
        "longitude": longitude,
      };
}
