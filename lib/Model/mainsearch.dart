// To parse required this JSON data, do
//
//     final mainSarchForPackage = mainSarchForPackageFromJson(jsonString);

import 'dart:convert';

MainSarchForPackage mainSarchForPackageFromJson(String str) =>
    MainSarchForPackage.fromJson(json.decode(str));

String mainSarchForPackageToJson(MainSarchForPackage data) => json.encode(data.toJson());

class MainSarchForPackage {
  MainSarchForPackage({
    required this.error,
    required this.data,
  });

  bool error;
  Data data;

  factory MainSarchForPackage.fromJson(Map<String, dynamic> json) => MainSarchForPackage(
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
    required this.code,
    required this.message,
    required this.searchData,
    required this.packages,
    required this.priceRange,
    required this.packageId,
    required this.listingUrl,
  });

  int code;
  String message;
  SearchData searchData;
  List<Package> packages;
  PriceRange priceRange;
  String packageId;
  String listingUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        message: json["message"],
        searchData: SearchData.fromJson(json["search_data"]),
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
        priceRange: PriceRange.fromJson(json["priceRange"]),
        packageId: json["package_id"],
        listingUrl: json["listing_url"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "search_data": searchData.toJson(),
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
        "priceRange": priceRange.toJson(),
        "package_id": packageId,
        "listing_url": listingUrl,
      };
}

class Package {
  Package({
    required this.id,
    required this.packageDays,
    required this.sellingCurrency,
    required this.flights,
    required this.flightStop,
    required this.paxs,
    required this.fromCity,
    required this.toCity,
    required this.packageName,
    required this.travelDate,
    required this.hotelName,
    required this.hotelImage,
    required this.hotelImages,
    required this.hotelStar,
    required this.latitude,
    required this.longitude,
    required this.activities,
    required this.transfer,
    required this.total,
    required this.oldPrice,
    required this.responseFrom,
  });

  String id;
  int packageDays;
  String sellingCurrency;
  Flights? flights;
  int flightStop;
  String paxs;
  String fromCity;
  String toCity;
  String packageName;
  String travelDate;
  String hotelName;
  String hotelImage;
  List<HotelImage> hotelImages;
  dynamic hotelStar;
  String latitude;
  String longitude;
  List<Activity> activities;
  List<Transfer> transfer;
  num total;
  num oldPrice;
  String responseFrom;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
      id: json["id"],
      packageDays: json["package_days"],
      sellingCurrency: json["selling_currency"],
      flights: (json["flights"] as Map).isEmpty ? null : Flights.fromJson(json["flights"]),
      flightStop: json["flight_stop"],
      paxs: json["paxs"],
      fromCity: json["from_city"],
      toCity: json["to_city"],
      packageName: json["package_name"],
      travelDate: json["travel_date"],
      hotelName: json["hotel_name"],
      hotelImage: json["hotel_image"],
      hotelImages: List<HotelImage>.from(json["hotel_images"].map((x) => HotelImage.fromJson(x))),
      hotelStar: json["hotel_star"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
      transfer: json["transfer"] == null
          ? []
          : List<Transfer>.from(json["transfer"].map((x) => Transfer.fromJson(x))),
      total: json["total"],
      oldPrice: json["old_price"].toDouble(),
      responseFrom: json['response_from']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "package_days": packageDays,
        "selling_currency": sellingCurrency,
        "flights": flights!.toJson(),
        "flight_stop": flightStop,
        "paxs": paxs,
        "from_city": fromCity,
        "to_city": toCity,
        "package_name": packageName,
        "travel_date": travelDate,
        "hotel_name": hotelName,
        "hotel_image": hotelImage,
        "hotel_images": List<dynamic>.from(hotelImages.map((x) => x.toJson())),
        "hotel_star": hotelStar,
        "latitude": latitude,
        "longitude": longitude,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "transfer": List<dynamic>.from(transfer.map((x) => x.toJson())),
        "total": total,
        "old_price": oldPrice,
      };
}

class Activity {
  Activity({
    required this.name,
    required this.date,
  });

  String name;
  DateTime date;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class Flights {
  Flights({
    required this.name,
  });

  String name;

  factory Flights.fromJson(Map<String, dynamic> json) => Flights(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class HotelImage {
  HotelImage({
    required this.src,
  });

  String src;

  factory HotelImage.fromJson(Map<String, dynamic> json) => HotelImage(
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
      };
}

class Transfer {
  Transfer({
    required this.id,
    required this.searchCode,
    required this.type,
    required this.group,
    required this.date,
    required this.time,
    required this.currency,
    required this.payableCurrency,
    // required this.netAmount,
    //required this.totalAmount,
    //required this.sellingPrice,
    required this.serviceTypeCode,
    required this.serviceTypeName,
    required this.productTypeName,
    required this.vehicleTypeName,
    required this.units,
  });

  String id;
  String searchCode;
  String type;
  String group;
  DateTime? date;
  String time;
  String currency;
  String payableCurrency;
  //double netAmount;
  // double totalAmount;
  // double sellingPrice;
  String serviceTypeCode;
  String serviceTypeName;
  String productTypeName;
  String vehicleTypeName;
  int units;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        id: json["_id"],
        searchCode: json["search_code"],
        type: json["type"],
        group: json["group"],
        date: json.containsKey('date')
            ? json['date'] != null
                ? json['date'] != ''
                    ? DateTime.parse(json["date"])
                    : null
                : null
            : null,
        time: json["time"],
        currency: json["currency"],
        payableCurrency: json["payable_currency"],
        // netAmount: json["net_amount"].toDouble(),
        //  totalAmount: json["total_amount"].toDouble(),
        // sellingPrice: json["selling_price"].toDouble(),
        serviceTypeCode: json["service_type_code"],
        serviceTypeName: json["service_type_name"],
        productTypeName: json["product_type_name"],
        vehicleTypeName: json["vehicle_type_name"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "search_code": searchCode,
        "type": type,
        "group": group,
        "date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "time": time,
        "currency": currency,
        "payable_currency": payableCurrency,
        //  "net_amount": netAmount,
        // "total_amount": totalAmount,
        // "selling_price": sellingPrice,
        "service_type_code": serviceTypeCode,
        "service_type_name": serviceTypeName,
        "product_type_name": productTypeName,
        "vehicle_type_name": vehicleTypeName,
        "units": units,
      };
}

class NewTransfer {
  final String transferId;
  final String searchId;
  final String routeId;
  final PickupInformation pickupInformation;
  final String direction;
  final String transferType;
  final int minPaxCapacity;
  final int maxPaxCapacity;
  final Content content;
  final String rateKey;
  final String packageSearchCode;

  NewTransfer({
    required this.transferId,
    required this.searchId,
    required this.routeId,
    required this.pickupInformation,
    required this.direction,
    required this.transferType,
    required this.minPaxCapacity,
    required this.maxPaxCapacity,
    required this.content,
    required this.rateKey,
    required this.packageSearchCode,
  });

  factory NewTransfer.fromJson(Map<String, dynamic> json) => NewTransfer(
        transferId: json["transfer_id"],
        searchId: json["search_id"],
        routeId: json["route_id"],
        pickupInformation: PickupInformation.fromJson(json["pickupInformation"]),
        direction: json["direction"],
        transferType: json["transferType"],
        minPaxCapacity: json["minPaxCapacity"],
        maxPaxCapacity: json["maxPaxCapacity"],
        content: Content.fromJson(json["content"]),
        rateKey: json["rateKey"],
        packageSearchCode: json["package_search_code"],
      );

  Map<String, dynamic> toJson() => {
        "transfer_id": transferId,
        "search_id": searchId,
        "route_id": routeId,
        "pickupInformation": pickupInformation.toJson(),
        "direction": direction,
        "transferType": transferType,
        "minPaxCapacity": minPaxCapacity,
        "maxPaxCapacity": maxPaxCapacity,
        "content": content.toJson(),
        "rateKey": rateKey,
        "package_search_code": packageSearchCode,
      };
}

class PickupInformation {
  final TransferFrom from;
  final TransferFrom to;
  final DateTime date;
  final String time;
  final TransferPickup pickup;

  PickupInformation({
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.pickup,
  });

  factory PickupInformation.fromJson(Map<String, dynamic> json) => PickupInformation(
        from: TransferFrom.fromJson(json["from"]),
        to: TransferFrom.fromJson(json["to"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        pickup: TransferPickup.fromJson(json["pickup"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from.toJson(),
        "to": to.toJson(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "pickup": pickup.toJson(),
      };
}

class TransferFrom {
  final String code;
  final String description;
  final String type;

  TransferFrom({
    required this.code,
    required this.description,
    required this.type,
  });

  factory TransferFrom.fromJson(Map<String, dynamic> json) => TransferFrom(
        code: json["code"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "type": type,
      };
}

class TransferPickup {
  final dynamic address;
  final dynamic number;
  final dynamic town;
  final dynamic zip;
  final String description;
  final dynamic altitude;
  final double latitude;
  final double longitude;
  final dynamic pickupId;
  final dynamic stopName;
  final dynamic image;

  TransferPickup({
    required this.address,
    required this.number,
    required this.town,
    required this.zip,
    required this.description,
    required this.altitude,
    required this.latitude,
    required this.longitude,
    required this.pickupId,
    required this.stopName,
    required this.image,
  });

  factory TransferPickup.fromJson(Map<String, dynamic> json) => TransferPickup(
        address: json["address"],
        number: json["number"],
        town: json["town"],
        zip: json["zip"],
        description: json["description"],
        altitude: json["altitude"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        pickupId: json["pickupId"],
        stopName: json["stopName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "number": number,
        "town": town,
        "zip": zip,
        "description": description,
        "altitude": altitude,
        "latitude": latitude,
        "longitude": longitude,
        "pickupId": pickupId,
        "stopName": stopName,
        "image": image,
      };
}

class Content {
  final Category vehicle;
  final Category category;
  final List<TransferImage> images;
  final List<TransferDetailInfo> transferDetailInfo;
  final List<dynamic> customerTransferTimeInfo;
  final List<dynamic> supplierTransferTimeInfo;

  Content({
    required this.vehicle,
    required this.category,
    required this.images,
    required this.transferDetailInfo,
    required this.customerTransferTimeInfo,
    required this.supplierTransferTimeInfo,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        vehicle: Category.fromJson(json["vehicle"]),
        category: Category.fromJson(json["category"]),
        images: List<TransferImage>.from(json["images"].map((x) => TransferImage.fromJson(x))),
        transferDetailInfo: List<TransferDetailInfo>.from(
            json["transferDetailInfo"].map((x) => TransferDetailInfo.fromJson(x))),
        customerTransferTimeInfo:
            List<dynamic>.from(json["customerTransferTimeInfo"].map((x) => x)),
        supplierTransferTimeInfo:
            List<dynamic>.from(json["supplierTransferTimeInfo"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vehicle": vehicle.toJson(),
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "transferDetailInfo": List<dynamic>.from(transferDetailInfo.map((x) => x.toJson())),
        "customerTransferTimeInfo": List<dynamic>.from(customerTransferTimeInfo.map((x) => x)),
        "supplierTransferTimeInfo": List<dynamic>.from(supplierTransferTimeInfo.map((x) => x)),
      };
}

class TransferImage {
  final String url;
  final String type;

  TransferImage({
    required this.url,
    required this.type,
  });

  factory TransferImage.fromJson(Map<String, dynamic> json) => TransferImage(
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
      };
}

class TransferDetailInfo {
  final String id;
  final String name;
  final String description;
  final String type;

  TransferDetailInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  factory TransferDetailInfo.fromJson(Map<String, dynamic> json) => TransferDetailInfo(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
      };
}

class Category {
  final String code;
  final String name;

  Category({
    required this.code,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class PriceRange {
  PriceRange({
    required this.min,
    required this.max,
  });

  int min;
  int max;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
      };
}

class SearchData {
  SearchData({
    required this.travelStart,
    required this.packageStart,
    required this.packageEnd,
    required this.departureCode,
    required this.departureName,
    required this.arrivalCode,
    required this.arrivalName,
    required this.flightClass,
    required this.adults,
    // required this.firstChildAge,
    // required this.secondChildAges,
    required this.ageOptionOne,
    required this.ageOptionTwo,
    required this.roomsCount,
    required this.adultsCount,
    required this.children,
    required this.childrenCount,
    required this.totalPassengers,
    // required this.childAge,
    // required this.childrenAges,
    required this.modifyTravelStart,
    required this.modifyTravelEnd,
    required this.flightCode,
    required this.flightName,
    required this.hotelCode,
    required this.hotelName,
  });

  String travelStart;
  String packageStart;
  String packageEnd;
  String departureCode;
  String departureName;
  String arrivalCode;
  String arrivalName;
  String flightClass;
  List<dynamic> adults;
  // List<int> firstChildAge;
  // List<int> secondChildAges;
  List<bool> ageOptionOne;
  List<bool> ageOptionTwo;
  int roomsCount;
  int adultsCount;
  List<dynamic> children;
  int childrenCount;
  int totalPassengers;
  // List<dynamic> childAge;
  // List<dynamic> childrenAges;
  String modifyTravelStart;
  String modifyTravelEnd;
  String flightCode;
  String flightName;
  String hotelCode;
  String hotelName;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        travelStart: json["travel_start"],
        packageStart: json["package_start"],
        packageEnd: json["package_end"],
        departureCode: json["departure_code"],
        departureName: json["departure_name"],
        arrivalCode: json["arrival_code"],
        arrivalName: json["arrival_name"],
        flightClass: json["flight_class"],
        adults: List<dynamic>.from(json["adults"].map((x) => x)),
        // firstChildAge: List<int>.from(json["first_child_age"].map((x) => x)),
        // secondChildAges: List<int>.from(json["second_child_ages"].map((x) => x)),
        ageOptionOne: List<bool>.from(json["age_option_one"].map((x) => x)),
        ageOptionTwo: List<bool>.from(json["age_option_two"].map((x) => x)),
        roomsCount: json["rooms_count"],
        adultsCount: json["adults_count"],
        children: List<dynamic>.from(json["children"].map((x) => x)),
        childrenCount: json["children_count"],
        totalPassengers: json["total_passengers"],
        // childAge: List<dynamic>.from(json["child_age"].map((x) => x)),
        // childrenAges: List<dynamic>.from(json["childrenAges"].map((x) => x)),
        modifyTravelStart: json["modify_travel_start"],
        modifyTravelEnd: json["modify_travel_end"],
        flightCode: json["flight_code"],
        flightName: json["flight_name"],
        hotelCode: json["hotelCode"],
        hotelName: json["hotelName"],
      );

  Map<String, dynamic> toJson() => {
        "travel_start": travelStart,
        "package_start": packageStart,
        "package_end": packageEnd,
        "departure_code": departureCode,
        "departure_name": departureName,
        "arrival_code": arrivalCode,
        "arrival_name": arrivalName,
        "flight_class": flightClass,
        "adults": List<dynamic>.from(adults.map((x) => x)),
        // "first_child_age": List<dynamic>.from(firstChildAge.map((x) => x)),
        // "second_child_ages": List<dynamic>.from(secondChildAges.map((x) => x)),
        "age_option_one": List<dynamic>.from(ageOptionOne.map((x) => x)),
        "age_option_two": List<dynamic>.from(ageOptionTwo.map((x) => x)),
        "rooms_count": roomsCount,
        "adults_count": adultsCount,
        "children": List<dynamic>.from(children.map((x) => x)),
        "children_count": childrenCount,
        "total_passengers": totalPassengers,
        // "child_age": List<dynamic>.from(childAge.map((x) => x)),
        // "childrenAges": List<dynamic>.from(childrenAges.map((x) => x)),
        "modify_travel_start": modifyTravelStart,
        "modify_travel_end": modifyTravelEnd,
        "flight_code": flightCode,
        "flight_name": flightName,
        "hotelCode": hotelCode,
        "hotelName": hotelName,
      };
}
