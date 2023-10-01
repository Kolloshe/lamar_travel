// To parse required required this JSON data, do
//
//     final indTransferCustomizeModel = indTransferCustomizeModelFromMap(jsonString);

import 'dart:convert';

IndTransferCustomizeModel indTransferCustomizeModelFromMap(String str) =>
    IndTransferCustomizeModel.fromMap(json.decode(str));

String indTransferCustomizeModelToMap(IndTransferCustomizeModel data) => json.encode(data.toMap());

class IndTransferCustomizeModel {
  IndTransferCustomizeModel({
    required this.status,
    required this.result,
  });

  Status status;
  Result result;

  factory IndTransferCustomizeModel.fromMap(Map<String, dynamic> json) => IndTransferCustomizeModel(
        status: Status.fromMap(json["status"]),
        result: Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status.toMap(),
        "result": result.toMap(),
      };
}

class Result {
  Result({
    required this.paxDetails,
    required this.customizeId,
    required this.packageId,
    required this.searchId,
    required this.packageName,
    required this.packageDays,
    required this.packageStart,
    required this.packageEnd,
    required this.fromCity,
    required this.toCity,
    required this.sameCitySearch,
    required this.sellingCurrency,
    required this.totalAmount,
    required this.adults,
    required this.children,
    required this.totalPassenger,
  //  required this.childAge,
    required this.prebook,
    required this.transfer,
    required this.noTransfer,
  });

  String paxDetails;
  String customizeId;
  String packageId;
  num searchId;
  String packageName;
  num packageDays;
  DateTime packageStart;
  DateTime packageEnd;
  String fromCity;
  String toCity;
  bool sameCitySearch;
  String sellingCurrency;
  num totalAmount;
  num adults;
  num children;
  num totalPassenger;
 // List<List<num>> childAge;
  num prebook;

  List<IndCustomizeTransferData> transfer;

  bool noTransfer;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        paxDetails: json["paxDetails"],
        customizeId: json["customizeId"],
        packageId: json["packageId"],
        searchId: json["searchId"],
        packageName: json["package_name"],
        packageDays: json["package_days"],
        packageStart: DateTime.parse(json["package_start"]),
        packageEnd: DateTime.parse(json["package_end"]),
        fromCity: json["from_city"],
        toCity: json["to_city"],
        sameCitySearch: json["same_city_search"],
        sellingCurrency: json["selling_currency"],
        totalAmount: json["total_amount"],
        adults: json["adults"],
        children: json["children"],
        totalPassenger: json["totalPassenger"],
      // childAge      List<List<num>>.from(json["childAge"].map((x) => List<num>.from(x.map((x) => x)))),
        prebook: json["prebook"],
        transfer: List<IndCustomizeTransferData>.from(json["transfer"].map((x) => IndCustomizeTransferData.fromMap(x))),
        noTransfer: json["no_transfer"],
      );

  Map<String, dynamic> toMap() => {
        "paxDetails": paxDetails,
        "customizeId": customizeId,
        "packageId": packageId,
        "searchId": searchId,
        "package_name": packageName,
        "package_days": packageDays,
        "package_start":
            "${packageStart.year.toString().padLeft(4, '0')}-${packageStart.month.toString().padLeft(2, '0')}-${packageStart.day.toString().padLeft(2, '0')}",
        "package_end":
            "${packageEnd.year.toString().padLeft(4, '0')}-${packageEnd.month.toString().padLeft(2, '0')}-${packageEnd.day.toString().padLeft(2, '0')}",
        "from_city": fromCity,
        "to_city": toCity,
        "same_city_search": sameCitySearch,
        "selling_currency": sellingCurrency,
        "total_amount": totalAmount,
        "adults": adults,
        "children": children,
        "totalPassenger": totalPassenger,
       // "childAge": List<dynamic>.from(childAge.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "prebook": prebook,
        "transfer": List<dynamic>.from(transfer.map((x) => x.toMap())),
        "no_transfer": noTransfer,
      };
}

class Activities {
  Activities();

  factory Activities.fromMap(Map<String, dynamic> json) => Activities();

  Map<String, dynamic> toMap() => {};
}

class IndCustomizeTransferData {
  IndCustomizeTransferData({
    required this.id,
    required this.searchCode,
    required this.type,
    required this.group,
    required this.date,
    required this.time,
    required this.currency,
    required this.payableCurrency,
    required this.netAmount,
    required this.totalAmount,
    required this.sellingPrice,
    required this.serviceTypeCode,
    required this.serviceTypeName,
    required this.productTypeName,
    required this.vehicleTypeName,
    required this.pickup,
    required this.dropoff,
    required this.image,
    required this.units,
    required this.pickUpLocation,
    required this.dropOffLocation,
    required this.pickupInformation,
    required this.waitingInfo,
    required this.generalInformation,
  });

  String id;
  String searchCode;
  String type;
  String group;
  String date;
  String time;
  String currency;
  String payableCurrency;
  num netAmount;
  num totalAmount;
  num sellingPrice;
  String serviceTypeCode;
  String serviceTypeName;
  String productTypeName;
  String vehicleTypeName;
  String pickup;
  String dropoff;
  String image;
  num units;
  String pickUpLocation;
  String dropOffLocation;
  String pickupInformation;
  List<String> waitingInfo;
  List<String> generalInformation;

  factory IndCustomizeTransferData.fromMap(Map<String, dynamic> json) => IndCustomizeTransferData(
        id: json["_id"],
        searchCode: json["search_code"],
        type: json["type"],
        group: json["group"],
        date: json["date"],
        time: json["time"],
        currency: json["currency"],
        payableCurrency: json["payable_currency"],
        netAmount: json["net_amount"].toDouble(),
        totalAmount: json["total_amount"].toDouble(),
        sellingPrice: json["selling_price"].toDouble(),
        serviceTypeCode: json["service_type_code"],
        serviceTypeName: json["service_type_name"],
        productTypeName: json["product_type_name"],
        vehicleTypeName: json["vehicle_type_name"],
        pickup: json["pickup"],
        dropoff: json["dropoff"],
        image: json["image"],
        units: json["units"],
        pickUpLocation: json["pick_up_location"],
        dropOffLocation: json["drop_off_location"],
        pickupInformation: json["pickup_information"],
        waitingInfo: List<String>.from(json["waiting_info"].map((x) => x)),
        generalInformation: List<String>.from(json["general_information"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "search_code": searchCode,
        "type": type,
        "group": group,
        "date": date,
        "time": time,
        "currency": currency,
        "payable_currency": payableCurrency,
        "net_amount": netAmount,
        "total_amount": totalAmount,
        "selling_price": sellingPrice,
        "service_type_code": serviceTypeCode,
        "service_type_name": serviceTypeName,
        "product_type_name": productTypeName,
        "vehicle_type_name": vehicleTypeName,
        "pickup": pickup,
        "dropoff": dropoff,
        "image": image,
        "units": units,
        "pick_up_location": pickUpLocation,
        "drop_off_location": dropOffLocation,
        "pickup_information": pickupInformation,
        "waiting_info": List<dynamic>.from(waitingInfo.map((x) => x)),
        "general_information": List<dynamic>.from(generalInformation.map((x) => x)),
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

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "error": error,
      };
}
