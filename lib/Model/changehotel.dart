// To parse required this JSON data, do
//
//     final changehotel = changehotelFromJson(jsonString);

import 'dart:convert';

Changehotel changehotelFromJson(String str) =>
    Changehotel.fromJson(json.decode(str));

String changehotelToJson(Changehotel data) => json.encode(data.toJson());

class Changehotel {
  Changehotel({
    required this.status,
    required this.response,
  });

  Status? status;
  List<ResponseHotel> response;

  factory Changehotel.fromJson(Map<String, dynamic> json) => Changehotel(
        status:json.containsKey("status")? Status.fromJson(json["status"]):null,
        response: List<ResponseHotel>.from(
            json["response"].map((x) => ResponseHotel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class ResponseHotel {
  ResponseHotel(
      {required this.id,
      required this.searchId,
      required this.hotelCode,
      required this.name,
      required this.starRating,
      required this.destinationCode,
      required this.destinationName,
      required this.checkInText,
      required this.checkOutText,
      required this.checkIn,
      required this.checkOut,
      required this.address,
      required this.currency,
      required this.rateFrom,
      required this.latitude,
      required this.longitude,
      required this.image,
      required this.imgAll,
      required this.rooms,
      required this.facilities,
      required this.selectedRoom});

  int id;
  String searchId;
  String hotelCode;
  String name;
  String starRating;
  String destinationCode;
  String destinationName;
  String checkInText;
  String checkOutText;
  DateTime checkIn;
  DateTime checkOut;
  String address;
  String currency;
  int rateFrom;
  String latitude;
  String longitude;
  String image;
  List<ImgAll> imgAll;
  List<List<Room>> rooms;
  List<dynamic> facilities;
  List<Room>? selectedRoom;

  factory ResponseHotel.fromJson(Map<String, dynamic> json) => ResponseHotel(
      id: json["id"],
      searchId: json["searchId"],
      hotelCode: json["hotelCode"],
      name: json["name"],
      starRating: json["starRating"],
      destinationCode: json["destinationCode"],
      destinationName: json["destinationName"],
      checkInText: json["checkInText"],
      checkOutText: json["checkOutText"],
      checkIn: DateTime.parse(json["checkIn"]),
      checkOut: DateTime.parse(json["checkOut"]),
      address: json["address"],
      currency: json["currency"],
      rateFrom: json["rateFrom"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      image: json["image"],
      imgAll: List<ImgAll>.from(json["img_all"].map((x) => ImgAll.fromJson(x))),
      rooms: List<List<Room>>.from(json["rooms"].map((x) => List<Room>.from(x.map((x) => Room.fromJson(x))))),
      facilities:  json.containsKey('facilities')? json["facilities"]:[],
      selectedRoom: json["selectedRoom"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "searchId": searchId,
        "hotelCode": hotelCode,
        "name": name,
        "starRating": starRating,
        "destinationCode": destinationCode,
        "destinationName": destinationName,
        "checkInText": checkInText,
        "checkOutText": checkOutText,
        "checkIn":
            "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
        "checkOut":
            "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
        "address": address,
        "currency": currency,
        "rateFrom": rateFrom,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "img_all": List<dynamic>.from(imgAll.map((x) => x.toJson())),
        "rooms": List<dynamic>.from(rooms.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "selectedRoom": List<dynamic>.from(selectedRoom!.map((x) =>  x.toJson())),
        "availability": true,
        //"language":"en"
        //List<dynamic>.from(facilities.map((x)=>x.toJson())),
      };
}

class Facility {
  String name;
  Facility({
    required this.name,
  });
  factory Facility.fromJson(Map<int, dynamic> json) => Facility(
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "src": name,
      };
}

class ImgAll {
  ImgAll({
    required this.src,
  });

  String src;

  factory ImgAll.fromJson(Map<String, dynamic> json) => ImgAll(
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
      };
}

class Room {
  Room({
    required this.name,
    required this.code,
    required this.allotment,
    required this.rateKey,
    required this.rateClass,
    required this.rateType,
    required this.boardCode,
    required this.boardName,
    required this.sellingCurrency,
    required this.amount,
    required this.amountChange,
    required this.type,
    required this.roomTypeText
  });

  String name;
  String code;
  int allotment;
  String rateKey;
  String rateClass;
  String rateType;
  String boardCode;
  String boardName;
  String sellingCurrency;
  int amount;
  int amountChange;
  String? roomTypeText;
  String type;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"],
        code: json["code"],
        allotment: json["allotment"],
        rateKey: json["rateKey"],
        rateClass: json["rateClass"],
        rateType: json["rateType"],
        boardCode: json["boardCode"],
        boardName: json["boardName"],
        sellingCurrency: json["SellingCurrency"],
        amount: json["amount"],
        amountChange: json["amountChange"],
        type: json["type"],
      roomTypeText: json.containsKey('roomTypeText') ? json['roomTypeText'] : null
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "allotment": allotment,
        "rateKey": rateKey,
        "rateClass": rateClass,
        "rateType": rateType,
        "boardCode": boardCode,
        "boardName": boardName,
        "SellingCurrency": sellingCurrency,
        "amount": amount,
        "amountChange": amountChange,
        "type": type,
    "roomTypeText":roomTypeText
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
