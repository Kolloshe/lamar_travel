// To parse required this JSON data, do
//
//     final changeTransfer = changeTransferFromJson(jsonString);

import 'dart:convert';

ChangeTransfer changeTransferFromJson(String str) => ChangeTransfer.fromJson(json.decode(str));

String changeTransferToJson(ChangeTransfer data) => json.encode(data.toJson());

class ChangeTransfer {
    ChangeTransfer({
        required this.code,
        required this.error,
        required this.message,
        required this.data,
    });

    int code;
    bool error;
    String message;
    Data data;

    factory ChangeTransfer.fromJson(Map<String, dynamic> json) => ChangeTransfer(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data:  Data.fromJson(json["data"]),
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
        required this.dataIn,
        required this.out,
    });

    List<In> dataIn;
    List<In> out;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataIn: List<In>.from(json["in"].map((x) => In.fromJson(x))),
        out: List<In>.from(json["out"].map((x) => In.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "in": List<dynamic>.from(dataIn.map((x) => x.toJson())),
        "out": List<dynamic>.from(out.map((x) => x.toJson())),
    };
}

class In {
    In({
        required this.id,
        required this.currency,
        required this.totalAmount,
        required this.serviceTypeName,
        required this.name,
        required this.images,
        required this.priceDifference,
    });

    String id;
    String currency;
    int totalAmount;
    String serviceTypeName;
    String name;
    String images;
    int priceDifference;

    factory In.fromJson(Map<String, dynamic> json) => In(
        id: json["_id"],
        currency: json["currency"],
        totalAmount: json["total_amount"],
        serviceTypeName: json["service_type_name"],
        name: json["name"],
        images: json["images"],
        priceDifference: json["price_difference"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "currency": currency,
        "total_amount": totalAmount,
        "service_type_name": serviceTypeName,
        "name": name,
        "images": images,
        "price_difference": priceDifference,
    };
}
