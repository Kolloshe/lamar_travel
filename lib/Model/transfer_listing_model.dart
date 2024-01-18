// To parse required this JSON data, do
//
//     final transferListing = transferListingFromJson(jsonString);

import 'dart:convert';

TransferListing transferListingFromJson(String str) => TransferListing.fromJson(json.decode(str));

String transferListingToJson(TransferListing data) => json.encode(data.toJson());

class TransferListing {
    TransferListing({
        required this.code,
        required this.error,
        required this.message,
        required this.data,
    });

    int code;
    bool error;
    String message;
    List<Datum> data;

    factory TransferListing.fromJson(Map<String, dynamic> json) => TransferListing(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.transferId,
        required this.searchCode,
        required this.serviceTypeCode,
        required this.serviceTypeName,
        required this.productTypeName,
        required this.vehicleTypeName,
        required this.generalInfoList,
        required this.waitingTimeInfoList,
        required this.image,
        required this.totalAmount,
        required this.currency,
    });

    String transferId;
    int searchCode;
    String serviceTypeCode;
    String serviceTypeName;
    String productTypeName;
    String vehicleTypeName;
    List<String> generalInfoList;
    List<WaitingTimeInfoList> waitingTimeInfoList;
    String image;
    int totalAmount;
    String currency;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        transferId: json["transfer_id"],
        searchCode: json["search_code"],
        serviceTypeCode: json["service_type_code"],
        serviceTypeName: json["service_type_name"],
        productTypeName: json["product_type_name"],
        vehicleTypeName: json["vehicle_type_name"],
        generalInfoList: List<String>.from(json["general_info_list"].map((x) => x)),
        waitingTimeInfoList: List<WaitingTimeInfoList>.from(json["waiting_time_info_list"].map((x) => WaitingTimeInfoList.fromJson(x))),
        image: json["image"],
        totalAmount: json["total_amount"],
        currency: json["currency"],
    );

    Map<String, dynamic> toJson() => {
        "transfer_id":       transferId,
        "search_code":       searchCode,
        "service_type_code": serviceTypeCode,
        "service_type_name": serviceTypeName,
        "product_type_name": productTypeName,
        "vehicle_type_name":       vehicleTypeName,
        "general_info_list":        List<dynamic>.from(generalInfoList.map((x) => x)),
        "waiting_time_info_list":   List<dynamic>.from(waitingTimeInfoList.map((x) => x.toJson())),
        "image": image,
        "total_amount": totalAmount,
        "currency": currency,
    };
}

class WaitingTimeInfoList {
    WaitingTimeInfoList({
        required this.minutes,
        required this.description,
    });

    String minutes;
    String description;

    factory WaitingTimeInfoList.fromJson(Map<String, dynamic> json) => WaitingTimeInfoList(
        minutes: json["minutes"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "minutes": minutes,
        "description": description,
    };
}
