// To parse required this JSON data, do
//
//     final newChangeHotel = newChangeHotelFromJson(jsonString);

import 'dart:convert';

NewChangeHotel newChangeHotelFromJson(String str) => NewChangeHotel.fromJson(json.decode(str));

String newChangeHotelToJson(NewChangeHotel data) => json.encode(data.toJson());

class NewChangeHotel {
  NewChangeHotel({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  Data data;

  factory NewChangeHotel.fromJson(Map<String, dynamic> json) => NewChangeHotel(
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
    required this.count,
    required this.hotels,
  });

  int count;
  List<HotelNewChange> hotels;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    count: json["count"],
    hotels: List<HotelNewChange>.from(json["hotels"].map((x) => HotelNewChange.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
  };
}

class HotelNewChange {
  HotelNewChange({
    required this.id,
    required this.searchId,
    required this.hotelCode,
    required this.name,
    required this.description,
    required this.starRating,
    required this.destinationCode,
    required this.destinationName,
    required this.checkInText,
    required this.checkOutText,
    required this.checkIn,
    required this.checkOut,
    required this.checkin,
    required this.checkout,
    required this.address,
    required this.currency,
    required this.rateFrom,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.imgAll,
    required this.rooms,
    required this.facilities,
  });

  int id;
  String searchId;
  String hotelCode;
  String name;
  String description;
  String starRating;
  String destinationCode;
  String destinationName;
  String checkInText;
  String checkOutText;
  DateTime checkIn;
  DateTime checkOut;
  DateTime checkin;
  DateTime checkout;
  String address;
  String currency;
  int rateFrom;
  String latitude;
  String longitude;
  String image;
  List<ImgAll> imgAll;
  List<List<NewRoomChanHotel>> rooms;
  List<String> facilities;

  factory HotelNewChange.fromJson(Map<String, dynamic> json) => HotelNewChange(
    id: json["id"],
    searchId: json["searchId"],
    hotelCode: json["hotelCode"],
    name: json["name"],
    description: json["description"],
    starRating: json["starRating"],
    destinationCode: json["destinationCode"],
    destinationName: json["destinationName"],
    checkInText: json["checkInText"],
    checkOutText: json["checkOutText"],
    checkIn: DateTime.parse(json["checkIn"]),
    checkOut: DateTime.parse(json["checkOut"]),
    checkin: DateTime.parse(json["checkin"]),
    checkout: DateTime.parse(json["checkout"]),
    address: json["address"],
    currency: json["currency"],
    rateFrom: json["rateFrom"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    image: json["image"],
    imgAll: List<ImgAll>.from(json["img_all"].map((x) => ImgAll.fromJson(x))),
    rooms: List<List<NewRoomChanHotel>>.from(json["rooms"].map((x) => List<NewRoomChanHotel>.from(x.map((x) => NewRoomChanHotel.fromJson(x))))),
    facilities: List<String>.from(json["facilities"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "searchId": searchId,
    "hotelCode": hotelCode,
    "name": name,
    "description": description,
    "starRating": starRating,
    "destinationCode": destinationCode,
    "destinationName": destinationName,
    "checkInText": checkInText,
    "checkOutText": checkOutText,
    "checkIn": "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
    "checkOut": "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
    "checkin": "${checkin.year.toString().padLeft(4, '0')}-${checkin.month.toString().padLeft(2, '0')}-${checkin.day.toString().padLeft(2, '0')}",
    "checkout": "${checkout.year.toString().padLeft(4, '0')}-${checkout.month.toString().padLeft(2, '0')}-${checkout.day.toString().padLeft(2, '0')}",
    "address": address,
    "currency": currency,
    "rateFrom": rateFrom,
    "latitude": latitude,
    "longitude": longitude,
    "image": image,
    "img_all": List<dynamic>.from(imgAll.map((x) => x.toJson())),
    "rooms": List<dynamic>.from(rooms.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "facilities": List<dynamic>.from(facilities.map((x) => x)),
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

class NewRoomChanHotel {
  NewRoomChanHotel({
    required this.name,
    required this.code,
    required this.allotment,
    required this.rateKey,
    required this.rateClass,
    required this.rateType,
    required this.boardCode,
    required this.boardName,
    required this.sellingCurrency,
    required this.adults,
    required this.children,
    required this.net,
    required this.payableCurrency,
    required this.amount,
    required this.amountChange,
    required this.type,
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
  int adults;
  int children;
  String net;
  String payableCurrency;
  int amount;
  int amountChange;
  String type;

  factory NewRoomChanHotel.fromJson(Map<String, dynamic> json) => NewRoomChanHotel(
    name: json["name"],
    code: json["code"],
    allotment: json["allotment"],
    rateKey: json["rateKey"],
    rateClass: json["rateClass"],
    rateType: json["rateType"],
    boardCode: json["boardCode"],
    boardName: json["boardName"],
    sellingCurrency: json["SellingCurrency"],
    adults: json["adults"],
    children: json["children"],
    net: json["net"],
    payableCurrency: json["payableCurrency"],
    amount: json["amount"],
    amountChange: json["amountChange"],
    type: json["type"],
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
    "adults": adults,
    "children": children,
    "net": net,
    "payableCurrency": payableCurrency,
    "amount": amount,
    "amountChange": amountChange,
    "type": type,
  };
}
