// To parse required this JSON data, do
//
//     final customizpackage = customizpackageFromJson(jsonString);

import 'dart:convert';

Customizpackage customizpackageFromJson(String str) => Customizpackage.fromJson(json.decode(str));

String customizpackageToJson(Customizpackage data) => json.encode(data.toJson());

class Customizpackage {
  Customizpackage({
    required this.status,
    required this.result,
  });

  Status status;
  Result result;

  factory Customizpackage.fromJson(Map<String, dynamic> json) => Customizpackage(
        status: Status.fromJson(json["status"]),
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "result": result.toJson(),
      };
}

class Result {
  Result(
      {required this.paxDetails,
      required this.customizeId,
      required this.packageId,
      required this.searchId,
      required this.packageName,
      required this.packageDays,
      required this.packageStart,
      required this.packageEnd,
      required this.fromCity,
      required this.toCity,
      required this.sellingCurrency,
      required this.totalAmount,
      required this.adults,
      required this.children,
      required this.totalPassenger,
      required this.childAge,
      required this.prebook,
      required this.hotels,
      required this.flight,
      required this.transfer,
      required this.activities,
      required this.noActivity,
      required this.noflight,
      required this.nohotels,
      required this.notransfer,
      required this.sameCitiy});

  String paxDetails;
  String customizeId;
  String packageId;
  int searchId;
  String packageName;
  int packageDays;
  DateTime packageStart;
  DateTime packageEnd;
  String fromCity;
  String toCity;
  String sellingCurrency;
  num totalAmount;
  int adults;
  int children;
  int totalPassenger;
  dynamic childAge;
  int prebook;
  List<PackageHotels> hotels;
  Flight? flight;
  List<NewTransfer> transfer;
  dynamic activities;
  bool noActivity;
  bool noflight;
  bool nohotels;
  bool notransfer;
  bool sameCitiy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        noActivity: json["no_activity"],
        sameCitiy: json['same_city_search'],
        noflight: json["no_flight"],
        nohotels: json["no_hotels"],
        notransfer: json["no_transfer"],
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
        sellingCurrency: json["selling_currency"],
        totalAmount: json["total_amount"],
        adults: json["adults"],
        children: json["children"],
        totalPassenger: json["totalPassenger"],
        childAge: json["childAge"],
        prebook: json["prebook"],
        hotels: json["no_hotels"] == true
            ? []
            : List<PackageHotels>.from(json["hotels"].map((x) => PackageHotels.fromJson(x))),
        flight: json["no_flight"] == true ? null : Flight.fromJson(json["flight"]),
        transfer: json["transfer"] != null
            ? List<NewTransfer>.from(json["transfer"].map((x) => NewTransfer.fromJson(x)))
            : [],
        activities: Map.from(json["activities"]).map((k, v) => MapEntry<String, List<Activity>>(
            k, List<Activity>.from(v.map((x) => Activity.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
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
        "selling_currency": sellingCurrency,
        "total_amount": totalAmount,
        "adults": adults,
        "children": children,
        "totalPassenger": totalPassenger,
        "childAge": childAge,
        "prebook": prebook,
        "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
        "flight": flight != null ? flight!.toJson() : '',
        "transfer":  List<dynamic>.from(transfer.map((x) => x.toJson())),
        "activities": Map.from(activities).map(
            (k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "no_activity": noActivity,
      };
}

class Activity {
  Activity({
    required this.name,
    required this.searchId,
    required this.code,
    required this.activityId,
    required this.modalityCode,
    required this.modalityName,
    required this.amountsFrom,
    required this.sellingCurrency,
    required this.netAmount,
    required this.paybleCurency,
    required this.modalityAmount,
    required this.activityDate,
    required this.questions,
    required this.rateKey,
    required this.images,
    required this.day,
    required this.activityDateDisplay,
    required this.activityDestination,
    required this.image,
    required this.description,
    required this.prebook,
  });

  String name;
  String searchId;
  String code;
  String activityId;
  String modalityCode;
  String modalityName;
  dynamic amountsFrom;
  String sellingCurrency;
  double netAmount;
  String paybleCurency;
  int modalityAmount;
  DateTime activityDate;
  List<dynamic> questions;
  String rateKey;
  List<Imagee> images;
  int day;
  String activityDateDisplay;
  String activityDestination;
  String image;
  String description;
  dynamic prebook;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        name: json["name"],
        searchId: json["searchId"],
        code: json["code"],
        activityId: json["activity_id"],
        modalityCode: json["modality_code"],
        modalityName: json["modality_name"],
        amountsFrom: json["amountsFrom"].runtimeType.toString() != 'int'
            ? List<AmountsFrom>.from(json["amountsFrom"].map((x) => AmountsFrom.fromJson(x)))
            : json["amountsFrom"],
        sellingCurrency: json["selling_currency"],
        netAmount: json["net_amount"].toDouble(),
        paybleCurency: json["paybleCurency"],
        modalityAmount: json["modality_amount"],
        activityDate: DateTime.parse(json["activity_date"]),
        questions: List<dynamic>.from(json["questions"].map((x) => x)),
        rateKey: json["rateKey"],
        images: List<Imagee>.from(json["images"].map((x) => Imagee.fromJson(x))),
        day: json["day"],
        activityDateDisplay: json["activity_date_display"],
        activityDestination: json["activity_destination"],
        image: json["image"].runtimeType.toString() == 'List<dynamic>' ? '' : json["image"],
        description: json["description"],
        prebook: json["prebook"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "searchId": searchId,
        "code": code,
        "activity_id": activityId,
        "modality_code": modalityCode,
        "modality_name": modalityName,
        "amountsFrom": List<dynamic>.from(amountsFrom.map((x) => x.toJson())),
        "selling_currency": sellingCurrency,
        "net_amount": netAmount,
        "paybleCurency": paybleCurency,
        "modality_amount": modalityAmount,
        "activity_date":
            "${activityDate.year.toString().padLeft(4, '0')}-${activityDate.month.toString().padLeft(2, '0')}-${activityDate.day.toString().padLeft(2, '0')}",
        "questions": List<dynamic>.from(questions.map((x) => x)),
        "rateKey": rateKey,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "day": day,
        "activity_date_display": activityDateDisplay,
        "activity_destination": activityDestination,
        "image": image,
        "description": description,
        "prebook": prebook,
      };
}

class AmountsFrom {
  AmountsFrom({
    required this.paxType,
    required this.ageFrom,
    required this.ageTo,
    required this.amount,
    required this.boxOfficeAmount,
    required this.mandatoryApplyAmount,
  });

  String paxType;
  int ageFrom;
  int ageTo;
  double amount;
  double boxOfficeAmount;
  bool mandatoryApplyAmount;

  factory AmountsFrom.fromJson(Map<String, dynamic> json) => AmountsFrom(
        paxType: json["paxType"],
        ageFrom: json["ageFrom"],
        ageTo: json["ageTo"],
        amount: json["amount"].toDouble(),
        boxOfficeAmount: json["boxOfficeAmount"].toDouble(),
        mandatoryApplyAmount: json["mandatoryApplyAmount"],
      );

  Map<String, dynamic> toJson() => {
        "paxType": paxType,
        "ageFrom": ageFrom,
        "ageTo": ageTo,
        "amount": amount,
        "boxOfficeAmount": boxOfficeAmount,
        "mandatoryApplyAmount": mandatoryApplyAmount,
      };
}

class Imagee {
  Imagee({
    required this.visualizationOrder,
    required this.mimeType,
    required this.urls,
  });

  int visualizationOrder;
  String mimeType;
  List<Url> urls;

  factory Imagee.fromJson(Map<String, dynamic> json) => Imagee(
        visualizationOrder: json["visualizationOrder"],
        mimeType: json["mimeType"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "visualizationOrder": visualizationOrder,
        "mimeType": mimeType,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
      };
}

class Url {
  Url({
    required this.dpi,
    required this.height,
    required this.width,
    required this.resource,
    required this.sizeType,
  });

  int dpi;
  int height;
  int width;
  String resource;
  String sizeType;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        dpi: json["dpi"],
        height: json["height"],
        width: json["width"],
        resource: json["resource"],
        sizeType: json["sizeType"],
      );

  Map<String, dynamic> toJson() => {
        "dpi": dpi,
        "height": height,
        "width": width,
        "resource": resource,
        "sizeType": sizeType,
      };
}

class Flight {
  Flight({
    required this.carriers,
    required this.carrier,
    required this.tripStart,
    required this.tripEnd,
    required this.passenger,
    required this.flightClass,
    required this.from,
    required this.to,
    required this.flightId,
    required this.prebook,
  });

  Carriers carriers;
  Carrier carrier;
  String tripStart;
  String tripEnd;
  Passenger passenger;
  String flightClass;
  From from;
  From? to;
  String flightId;
  dynamic prebook;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        carriers: Carriers.fromJson(json["carriers"]),
        carrier: Carrier.fromJson(json["carrier"]),
        tripStart: json["trip_start"],
        tripEnd: json["trip_end"],
        passenger: Passenger.fromJson(json["passenger"]),
        flightClass: json["flight_class"],
        from: From.fromJson(json["from"]),
        to: json["to"] == null ? null : From.fromJson(json["to"]),
        flightId: json["flight_id"],
        prebook: json["prebook"],
      );

  Map<String, dynamic> toJson() => {
        "carriers": carriers.toJson(),
        "carrier": carrier.toJson(),
        "trip_start": tripStart,
        "trip_end": tripEnd,
        "passenger": passenger.toJson(),
        "flight_class": flightClass,
        "from": from.toJson(),
        "to": to?.toJson(),
        "flight_id": flightId,
        "prebook": prebook,
      };
}

class Carrier {
  Carrier({
    required this.code,
    required this.name,
    required this.label,
  });

  String code;
  String name;
  String label;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
        code: json["code"],
        name: json["name"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "label": label,
      };
}

class Carriers {
  Carriers({
    required this.tk,
  });

  String? tk;

  factory Carriers.fromJson(Map<String, dynamic> json) => Carriers(
        tk: json["TK"],
      );

  Map<String, dynamic> toJson() => {
        "TK": tk,
      };
}

class From {
  From({
    required this.numstops,
    required this.stops,
    required this.departure,
    required this.arrival,
    required this.arrivalDays,
    required this.departureFdate,
    required this.departureDate,
    required this.departureTime,
    required this.arrivalFdate,
    required this.arrivalDate,
    required this.arrivalTime,
    required this.travelTime,
    required this.itinerary,
    required this.carrierName,
  });

  int numstops;
  List<String> stops;
  String departure;
  String arrival;
  int arrivalDays;
  DateTime departureFdate;
  String departureDate;
  String departureTime;
  DateTime arrivalFdate;
  String arrivalDate;
  String arrivalTime;
  String travelTime;
  List<Itinerary> itinerary;
  String? carrierName;

  factory From.fromJson(Map<String, dynamic> json) => From(
        numstops: json["numstops"],
        stops: List<String>.from(json["stops"].map((x) => x)),
        departure: json["departure"],
        arrival: json["arrival"],
        arrivalDays: json["arrival_days"],
        departureFdate: DateTime.parse(json["departure_fdate"]),
        departureDate: json["departure_date"],
        departureTime: json["departure_time"],
        arrivalFdate: DateTime.parse(json["arrival_fdate"]),
        arrivalDate: json["arrival_date"],
        arrivalTime: json["arrival_time"],
        travelTime: json["travel_time"],
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromJson(x))),
        carrierName: json["carrier_name"],
      );

  Map<String, dynamic> toJson() => {
        "numstops": numstops,
        "stops": List<dynamic>.from(stops.map((x) => x)),
        "departure": departure,
        "arrival": arrival,
        "arrival_days": arrivalDays,
        "departure_fdate":
            "${departureFdate.year.toString().padLeft(4, '0')}-${departureFdate.month.toString().padLeft(2, '0')}-${departureFdate.day.toString().padLeft(2, '0')}",
        "departure_date": departureDate,
        "departure_time": departureTime,
        "arrival_fdate":
            "${arrivalFdate.year.toString().padLeft(4, '0')}-${arrivalFdate.month.toString().padLeft(2, '0')}-${arrivalFdate.day.toString().padLeft(2, '0')}",
        "arrival_date": arrivalDate,
        "arrival_time": arrivalTime,
        "travel_time": travelTime,
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toJson())),
        "carrier_name": carrierName,
      };
}

class Itinerary {
  Itinerary({
    required this.company,
    required this.flightNo,
    required this.departure,
    required this.flightTime,
    required this.arrival,
    required this.numstops,
    required this.baggageInfo,
    required this.bookingClass,
    required this.cabinClass,
    required this.layover,
  });

  Company company;
  String flightNo;
  Arrival departure;
  int flightTime;
  Arrival arrival;
  int numstops;
  List<String> baggageInfo;
  String bookingClass;
  String cabinClass;
  int layover;

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      company: Company.fromJson(json["company"]),
      flightNo: json["flightNo"],
      departure: Arrival.fromJson(json["departure"]),
      flightTime: json["flight_time"],
      arrival: Arrival.fromJson(json["arrival"]),
      numstops: json["numstops"],
      baggageInfo: json["baggageInfo"].runtimeType.toString() == 'String'
          ? [json["baggageInfo"]]
          : List<String>.from(json["baggageInfo"].map((x) => x)),
      bookingClass: json["bookingClass"],
      cabinClass: json["cabinClass"],
      layover: json["layover"],
    );
  }

  Map<String, dynamic> toJson() => {
        "company": company.toJson(),
        "flightNo": flightNo,
        "departure": departure.toJson(),
        "flight_time": flightTime,
        "arrival": arrival.toJson(),
        "numstops": numstops,
        "baggageInfo": List<dynamic>.from(baggageInfo.map((x) => x)),
        "bookingClass": bookingClass,
        "cabinClass": cabinClass,
        "layover": layover,
      };
}

class Arrival {
  Arrival({
    required this.date,
    required this.time,
    required this.locationId,
    required this.timezone,
    required this.airport,
    required this.city,
    required this.terminal,
  });

  DateTime date;
  String time;
  String locationId;
  String? timezone;
  String airport;
  String city;
  bool terminal;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        locationId: json["locationId"],
        timezone: json["timezone"],
        airport: json["airport"],
        city: json["city"],
        terminal: json["terminal"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "locationId": locationId,
        "timezone": timezone,
        "airport": airport,
        "city": city,
        "terminal": terminal,
      };
}

class Company {
  Company({
    required this.marketingCarrier,
    required this.operatingCarrier,
    required this.logo,
  });

  String marketingCarrier;
  String operatingCarrier;
  String logo;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        marketingCarrier: json["marketingCarrier"],
        operatingCarrier: json["operatingCarrier"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "marketingCarrier": marketingCarrier,
        "operatingCarrier": operatingCarrier,
        "logo": logo,
      };
}

class Passenger {
  Passenger({
    required this.adult,
  });

  int adult;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        adult: json["Adult"],
      );

  Map<String, dynamic> toJson() => {
        "Adult": adult,
      };
}

class PackageHotels {
  PackageHotels({
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
    required this.address,
    required this.currency,
    required this.rateFrom,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.imgAll,
    required this.rooms,
    required this.facilities,
    required this.selectedRoom,
    required this.availability,
    required this.prebook,
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
  String address;
  String currency;
  int rateFrom;
  String latitude;
  String longitude;
  String image;
  List<ImgAll> imgAll;
  List<List<Room>> rooms;
  List<String> facilities;
  List<Room> selectedRoom;
  bool availability;
  dynamic prebook;

  factory PackageHotels.fromJson(Map<String, dynamic> json) => PackageHotels(
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
        address: json["address"],
        currency: json["currency"],
        rateFrom: json["rateFrom"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        imgAll: List<ImgAll>.from(json["img_all"].map((x) => ImgAll.fromJson(x))),
        rooms: List<List<Room>>.from(
            json["rooms"].map((x) => List<Room>.from(x.map((x) => Room.fromJson(x))))),
        facilities: json["facilities"] != null
            ? List<String>.from(json["facilities"].map((x) => x))
            : ['No facilities'],
        selectedRoom: List<Room>.from(json["selectedRoom"].map((x) => Room.fromJson(x))),
        availability: json["availability"],
        prebook: json["prebook"],
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
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "selectedRoom": List<dynamic>.from(selectedRoom.map((x) => x.toJson())),
        "availability": availability,
        "prebook": prebook,
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
  Room(
      {required this.name,
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
      required this.roomTypeText});

  String name;
  String code;
  int allotment;
  String rateKey;
  String rateClass;
  String rateType;
  String boardCode;
  String boardName;
  String sellingCurrency;
  String? roomTypeText;
  int amount;
  int amountChange;
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
      roomTypeText: json.containsKey('roomTypeText') ? json['roomTypeText'] : null);

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
        "roomTypeText": roomTypeText,
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
    required this.netAmount,
    required this.totalAmount,
    required this.sellingPrice,
    required this.serviceTypeCode,
    required this.serviceTypeName,
    required this.productTypeName,
    required this.vehicleTypeName,
    required this.units,
    required this.image,
    required this.pickUpLocation,
    required this.dropOffLocation,
  });

  String id;
  String searchCode;
  String type;
  String group;
  String date;
  String time;
  String currency;
  String payableCurrency;
  double netAmount;
  double totalAmount;
  double sellingPrice;
  String? serviceTypeCode;
  String serviceTypeName;
  String productTypeName;
  String vehicleTypeName;
  int? units;
  String image;
  String pickUpLocation;
  String dropOffLocation;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
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
        units: json["units"],
        image: json["image"],
        pickUpLocation: json["pick_up_location"],
        dropOffLocation: json["drop_off_location"],
      );

  Map<String, dynamic> toJson() => {
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
        "units": units,
        "image": image,
        "pick_up_location": pickUpLocation,
        "drop_off_location": dropOffLocation,
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
    final TransferPrice price;
    final String rateKey;
    final List<TransferCancellationPolicy> cancellationPolicies;
    final String packageSearchCode;
    final int units;

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
        required this.price,
        required this.rateKey,
        required this.cancellationPolicies,
        required this.packageSearchCode,
        required this.units,
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
        price: TransferPrice.fromJson(json["price"]),
        rateKey: json["rateKey"],
        cancellationPolicies: List<TransferCancellationPolicy>.from(json["cancellationPolicies"].map((x) => TransferCancellationPolicy.fromJson(x))),
        packageSearchCode: json["package_search_code"],
        units: json["units"],
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
        "price": price.toJson(),
        "rateKey": rateKey,
        "cancellationPolicies": List<dynamic>.from(cancellationPolicies.map((x) => x.toJson())),
        "package_search_code": packageSearchCode,
        "units": units,
    };
}

class TransferCancellationPolicy {
    final double amount;
    final DateTime from;
    final String currencyId;
    final dynamic isForceMajeure;
    final int sellingAmount;
    final String sellingCurrency;

    TransferCancellationPolicy({
        required this.amount,
        required this.from,
        required this.currencyId,
        required this.isForceMajeure,
        required this.sellingAmount,
        required this.sellingCurrency,
    });

    factory TransferCancellationPolicy.fromJson(Map<String, dynamic> json) => TransferCancellationPolicy(
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

class Content {
    final TransferCategory vehicle;
    final TransferCategory category;
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
        vehicle: TransferCategory.fromJson(json["vehicle"]),
        category: TransferCategory.fromJson(json["category"]),
        images: List<TransferImage>.from(json["images"].map((x) => TransferImage.fromJson(x))),
        transferDetailInfo: List<TransferDetailInfo>.from(json["transferDetailInfo"].map((x) => TransferDetailInfo.fromJson(x))),
        customerTransferTimeInfo: List<dynamic>.from(json["customerTransferTimeInfo"].map((x) => x)),
        supplierTransferTimeInfo: List<dynamic>.from(json["supplierTransferTimeInfo"].map((x) => x)),
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

class TransferCategory {
    final String code;
    final String name;

    TransferCategory({
        required this.code,
        required this.name,
    });

    factory TransferCategory.fromJson(Map<String, dynamic> json) => TransferCategory(
        code: json["code"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
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

class PickupInformation {
    final PickupInformationFrom from;
    final PickupInformationFrom to;
    final DateTime date;
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
        from: PickupInformationFrom.fromJson(json["from"]),
        to: PickupInformationFrom.fromJson(json["to"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        pickup: Pickup.fromJson(json["pickup"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from.toJson(),
        "to": to.toJson(),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "pickup": pickup.toJson(),
    };
}

class PickupInformationFrom {
    final String code;
    final String description;
    final String type;

    PickupInformationFrom({
        required this.code,
        required this.description,
        required this.type,
    });

    factory PickupInformationFrom.fromJson(Map<String, dynamic> json) => PickupInformationFrom(
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
    final dynamic url;
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

class TransferPrice {
    final double totalAmount;
    final dynamic netAmount;
    final String currencyId;
    final int sellingAmount;
    final String sellingCurrency;

    TransferPrice({
        required this.totalAmount,
        required this.netAmount,
        required this.currencyId,
        required this.sellingAmount,
        required this.sellingCurrency,
    });

    factory TransferPrice.fromJson(Map<String, dynamic> json) => TransferPrice(
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