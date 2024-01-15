// To parse this JSON data, do
//
//     final newChangeTransfer = newChangeTransferFromJson(jsonString);
import 'dart:convert';

NewChangeTransfer newChangeTransferFromJson(String str) =>
    NewChangeTransfer.fromJson(json.decode(str));

String newChangeTransferToJson(NewChangeTransfer data) => json.encode(data.toJson());

class NewChangeTransfer {
  final String message;
  final List<List<Datum>> data;

  NewChangeTransfer({
    required this.message,
    required this.data,
  });

  factory NewChangeTransfer.fromJson(Map<String, dynamic> json) => NewChangeTransfer(
        message: json["message"],
        data: List<List<Datum>>.from(
            json["data"].map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  final String id;
  final String searchId;
  final String routeId;
  final PickupInformation pickupInformation;
  final num serviceId;
  final String direction;
  final String transferType;
  final Category vehicle;
  final Category category;
  final num minPaxCapacity;
  final num maxPaxCapacity;
  final Content content;
  final Price price;
  final String rateKey;
  final List<NewCancellationPolicyForTransfer> cancellationPolicies;
  final List<Link> links;
  final num factsheetId;
  final SearchQuery searchQuery;
  final String packageSearchCode;

  Datum({
    required this.id,
    required this.searchId,
    required this.routeId,
    required this.pickupInformation,
    required this.serviceId,
    required this.direction,
    required this.transferType,
    required this.vehicle,
    required this.category,
    required this.minPaxCapacity,
    required this.maxPaxCapacity,
    required this.content,
    required this.price,
    required this.rateKey,
    required this.cancellationPolicies,
    required this.links,
    required this.factsheetId,
    required this.searchQuery,
    required this.packageSearchCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        searchId: json["search_id"],
        routeId: json["route_id"],
        pickupInformation: PickupInformation.fromJson(json["pickupInformation"]),
        serviceId: json["service_id"],
        direction: json["direction"],
        transferType: json["transferType"],
        vehicle: Category.fromJson(json["vehicle"]),
        category: Category.fromJson(json["category"]),
        minPaxCapacity: json["minPaxCapacity"],
        maxPaxCapacity: json["maxPaxCapacity"],
        content: Content.fromJson(json["content"]),
        price: Price.fromJson(json["price"]),
        rateKey: json["rateKey"],
        cancellationPolicies: List<NewCancellationPolicyForTransfer>.from(
            json["cancellationPolicies"].map((x) => NewCancellationPolicyForTransfer.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        factsheetId: json["factsheetId"],
        searchQuery: SearchQuery.fromJson(json["search_query"]),
        packageSearchCode: json["package_search_code"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "search_id": searchId,
        "route_id": routeId,
        "pickupInformation": pickupInformation.toJson(),
        "service_id": serviceId,
        "direction": direction,
        "transferType": transferType,
        "vehicle": vehicle.toJson(),
        "category": category.toJson(),
        "minPaxCapacity": minPaxCapacity,
        "maxPaxCapacity": maxPaxCapacity,
        "content": content.toJson(),
        "price": price.toJson(),
        "rateKey": rateKey,
        "cancellationPolicies": List<dynamic>.from(cancellationPolicies.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "factsheetId": factsheetId,
        "search_query": searchQuery.toJson(),
        "package_search_code": packageSearchCode,
      };
}

class NewCancellationPolicyForTransfer {
  final double amount;
  final DateTime from;
  final String currencyId;
  final dynamic isForceMajeure;
  final num sellingAmount;
  final String sellingCurrency;

  NewCancellationPolicyForTransfer({
    required this.amount,
    required this.from,
    required this.currencyId,
    required this.isForceMajeure,
    required this.sellingAmount,
    required this.sellingCurrency,
  });

  factory NewCancellationPolicyForTransfer.fromJson(Map<String, dynamic> json) =>
      NewCancellationPolicyForTransfer(
        amount: json["amount"]?.toDouble(),
        from: DateTime.parse(json["from"]),
        currencyId: json["currencyId"],
        isForceMajeure: json["isForceMajeure"],
        sellingAmount: json["selling_amount"],
        sellingCurrency: json["selling_currency"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "from": from.toIso8601String(),
        "currencyId": currencyId,
        "isForceMajeure": isForceMajeure,
        "selling_amount": sellingAmount,
        "selling_currency": sellingCurrency,
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

class Content {
  final Category vehicle;
  final Category category;
  final List<TransferImage> images;
  final List<TransferDetailInfo> transferDetailInfo;
  final List<dynamic> customerTransferTimeInfo;
  final List<dynamic> supplierTransferTimeInfo;
  final List<TransferRemark> transferRemarks;

  Content({
    required this.vehicle,
    required this.category,
    required this.images,
    required this.transferDetailInfo,
    required this.customerTransferTimeInfo,
    required this.supplierTransferTimeInfo,
    required this.transferRemarks,
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
        transferRemarks: List<TransferRemark>.from(
            json["transferRemarks"].map((x) => TransferRemark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehicle": vehicle.toJson(),
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "transferDetailInfo": List<dynamic>.from(transferDetailInfo.map((x) => x.toJson())),
        "customerTransferTimeInfo": List<dynamic>.from(customerTransferTimeInfo.map((x) => x)),
        "supplierTransferTimeInfo": List<dynamic>.from(supplierTransferTimeInfo.map((x) => x)),
        "transferRemarks": List<dynamic>.from(transferRemarks.map((x) => x.toJson())),
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

class TransferRemark {
  final String type;
  final String description;
  final bool mandatory;

  TransferRemark({
    required this.type,
    required this.description,
    required this.mandatory,
  });

  factory TransferRemark.fromJson(Map<String, dynamic> json) => TransferRemark(
        type: json["type"],
        description: json["description"],
        mandatory: json["mandatory"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
        "mandatory": mandatory,
      };
}

class Link {
  final String rel;
  final String href;
  final String method;

  Link({
    required this.rel,
    required this.href,
    required this.method,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
        "method": method,
      };
}

class PickupInformation {
  final From from;
  final From to;
  final DateTime? date;
  final String time;
  final Pickup pickup;

  PickupInformation({
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.pickup,
  });

  factory PickupInformation.fromJson(Map<String, dynamic> json) => PickupInformation(
        from: From.fromJson(json["from"]),
        to: From.fromJson(json["to"]),
        date: json.containsKey("date")
            ? json["date"] != null
                ? DateTime.parse(json["date"])
                : null
            : null,
        time: json["time"],
        pickup: Pickup.fromJson(json["pickup"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from.toJson(),
        "to": to.toJson(),
        //"date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "pickup": pickup.toJson(),
      };
}

class From {
  final String code;
  final String description;
  final String type;

  From({
    required this.code,
    required this.description,
    required this.type,
  });

  factory From.fromJson(Map<String, dynamic> json) => From(
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

class Pickup {
  final dynamic address;
  final dynamic number;
  final dynamic town;
  final dynamic zip;
  final String description;
  final dynamic altitude;
  final double latitude;
  final double longitude;
  final CheckPickup checkPickup;
  final dynamic pickupId;
  final dynamic stopName;
  final dynamic image;

  Pickup({
    required this.address,
    required this.number,
    required this.town,
    required this.zip,
    required this.description,
    required this.altitude,
    required this.latitude,
    required this.longitude,
    required this.checkPickup,
    required this.pickupId,
    required this.stopName,
    required this.image,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
        address: json["address"],
        number: json["number"],
        town: json["town"],
        zip: json["zip"],
        description: json["description"],
        altitude: json["altitude"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        checkPickup: CheckPickup.fromJson(json["checkPickup"]),
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
        "checkPickup": checkPickup.toJson(),
        "pickupId": pickupId,
        "stopName": stopName,
        "image": image,
      };
}

class CheckPickup {
  final bool mustCheckPickupTime;
  final String url;
  final dynamic hoursBeforeConsulting;

  CheckPickup({
    required this.mustCheckPickupTime,
    required this.url,
    required this.hoursBeforeConsulting,
  });

  factory CheckPickup.fromJson(Map<String, dynamic> json) => CheckPickup(
        mustCheckPickupTime: json["mustCheckPickupTime"],
        url: json["url"],
        hoursBeforeConsulting: json["hoursBeforeConsulting"],
      );

  Map<String, dynamic> toJson() => {
        "mustCheckPickupTime": mustCheckPickupTime,
        "url": url,
        "hoursBeforeConsulting": hoursBeforeConsulting,
      };
}

class Price {
  final double totalAmount;
  final dynamic netAmount;
  final String currencyId;
  final num sellingAmount;
  final String sellingCurrency;

  Price({
    required this.totalAmount,
    required this.netAmount,
    required this.currencyId,
    required this.sellingAmount,
    required this.sellingCurrency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        totalAmount: json["totalAmount"]?.toDouble(),
        netAmount: json["netAmount"],
        currencyId: json["currencyId"],
        sellingAmount: json["selling_amount"],
        sellingCurrency: json["selling_currency"],
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "netAmount": netAmount,
        "currencyId": currencyId,
        "selling_amount": sellingAmount,
        "selling_currency": sellingCurrency,
      };
}

class SearchQuery {
  final String travelType;
  final Pax pax;
  final List<Transfer> transfers;
  final Filters filters;
  final String searchFromPackage;
  final String packageSearchCode;
  final String sellingCurrency;

  SearchQuery({
    required this.travelType,
    required this.pax,
    required this.transfers,
    required this.filters,
    required this.searchFromPackage,
    required this.packageSearchCode,
    required this.sellingCurrency,
  });

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
        travelType: json["travel_type"],
        pax: Pax.fromJson(json["pax"]),
        transfers: List<Transfer>.from(json["transfers"].map((x) => Transfer.fromJson(x))),
        filters: Filters.fromJson(json["filters"]),
        searchFromPackage: json["search_from_package"],
        packageSearchCode: json["package_search_code"],
        sellingCurrency: json["selling_currency"],
      );

  Map<String, dynamic> toJson() => {
        "travel_type": travelType,
        "pax": pax.toJson(),
        "transfers": List<dynamic>.from(transfers.map((x) => x.toJson())),
        "filters": filters.toJson(),
        "search_from_package": searchFromPackage,
        "package_search_code": packageSearchCode,
        "selling_currency": sellingCurrency,
      };
}

class Filters {
  final String allowPartial;

  Filters({
    required this.allowPartial,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        allowPartial: json["allow_partial"],
      );

  Map<String, dynamic> toJson() => {
        "allow_partial": allowPartial,
      };
}

class Pax {
  final String adults;
  final String children;
  final String infants;

  Pax({
    required this.adults,
    required this.children,
    required this.infants,
  });

  factory Pax.fromJson(Map<String, dynamic> json) => Pax(
        adults: json["adults"],
        children: json["children"],
        infants: json["infants"],
      );

  Map<String, dynamic> toJson() => {
        "adults": adults,
        "children": children,
        "infants": infants,
      };
}

class Transfer {
  final String from;
  final String fromType;
  final String to;
  final String toType;
  final DateTime date;
  final String time;
  final String transferType;
  final DateTime returnDate;
  final String returnTime;

  Transfer({
    required this.from,
    required this.fromType,
    required this.to,
    required this.toType,
    required this.date,
    required this.time,
    required this.transferType,
    required this.returnDate,
    required this.returnTime,
  });

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        from: json["from"],
        fromType: json["from_type"],
        to: json["to"],
        toType: json["to_type"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        transferType: json["transfer_type"],
        returnDate: DateTime.parse(json["return_date"]),
        returnTime: json["return_time"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "from_type": fromType,
        "to": to,
        "to_type": toType,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "transfer_type": transferType,
        "return_date":
            "${returnDate.year.toString().padLeft(4, '0')}-${returnDate.month.toString().padLeft(2, '0')}-${returnDate.day.toString().padLeft(2, '0')}",
        "return_time": returnTime,
      };
}
