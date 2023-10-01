// To parse this JSON data, do
//
//     final indvPackagesModel = indvPackagesModelFromMap(jsonString);

import 'dart:convert';

IndvPackagesModel indvPackagesModelFromMap(String str) =>
    IndvPackagesModel.fromMap(json.decode(str));

String indvPackagesModelToMap(IndvPackagesModel data) => json.encode(data.toMap());

class IndvPackagesModel {
  IndvPackagesModel({
    required this.error,
    required this.data,
  });

  bool error;
  Data data;

  factory IndvPackagesModel.fromMap(Map<String, dynamic> json) => IndvPackagesModel(
        error: json["error"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.searchMode,
    required this.hotelOnly,
    required this.flightOnly,
    required this.activityOnly,
    required this.transferOnly,
    required this.holidaySearch,
    required this.code,
    required this.message,
    required this.searchData,
    required this.packages,
    required this.priceRange,
    required this.packageId,
    required this.listingUrl,
  });

  String searchMode;
  bool hotelOnly;
  bool flightOnly;
  bool activityOnly;
  bool transferOnly;
  bool holidaySearch;
  num code;
  String message;
  SearchData searchData;
  List<PackageIndv> packages;
  PriceRange priceRange;
  String packageId;
  String listingUrl;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        searchMode: json["search_mode"],
        hotelOnly: json["hotel_only"],
        flightOnly: json["flight_only"],
        activityOnly: json["activity_only"],
        transferOnly: json["transfer_only"],
        holidaySearch: json["holiday_search"],
        code: json["code"],
        message: json["message"],
        searchData: SearchData.fromMap(json["search_data"]),
        packages: List<PackageIndv>.from(json["packages"].map((x) => PackageIndv.fromMap(x))),
        priceRange: PriceRange.fromMap(json["priceRange"]),
        packageId: json["package_id"],
        listingUrl: json["listing_url"],
      );

  Map<String, dynamic> toMap() => {
        "search_mode": searchMode,
        "hotel_only": hotelOnly,
        "flight_only": flightOnly,
        "activity_only": activityOnly,
        "transfer_only": transferOnly,
        "holiday_search": holidaySearch,
        "code": code,
        "message": message,
        "search_data": searchData.toMap(),
        "packages": List<dynamic>.from(packages.map((x) => x.toMap())),
        "priceRange": priceRange.toMap(),
        "package_id": packageId,
        "listing_url": listingUrl,
      };
}

class PackageIndv {
  PackageIndv(
      {required this.id,
      required this.packageDays,
      required this.sellingCurrency,
      required this.flights,
      required this.flightDetails,
      required this.flightStop,
      required this.noFlight,
      required this.paxs,
      required this.fromCity,
      required this.toCity,
      required this.hotelName,
      required this.packageName,
      required this.travelDate,
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
      required this.hotelDetails,
      required this.activityDetails});

  String id;
  num packageDays;
  String sellingCurrency;
  Flights? flights;
  FlightDetails? flightDetails;
  num flightStop;
  bool noFlight;
  String paxs;
  String fromCity;
  String toCity;
  String hotelName;
  IndHotelDetails? hotelDetails;
  String packageName;
  String travelDate;
  String hotelImage;
  List<HotelImage>? hotelImages;
  num hotelStar;
  String latitude;
  String longitude;
  List<IndTransfer>? transfer;
  num total;
  num oldPrice;
  String responseFrom;
  List<Activity>? activities;
  ActivityDetails? activityDetails;

  factory PackageIndv.fromMap(Map<String, dynamic> json) => PackageIndv(
        id: json["id"],
        packageDays: json["package_days"],
        sellingCurrency: json["selling_currency"],
        flights: Flights.fromMap(json["flights"]),
        flightDetails:
            json["flight_details"] != null ? FlightDetails.fromMap(json["flight_details"]) : null,
        flightStop: json["flight_stop"],
        noFlight: json["no_flight"],
        paxs: json["paxs"],
        fromCity: json["from_city"],
        toCity: json["to_city"],
        hotelName: json["hotel_name"],
        hotelDetails:
            json["hotel_details"] != null ? IndHotelDetails.fromMap(json["hotel_details"]) : null,
        packageName: json["package_name"],
        travelDate: json["travel_date"],
        hotelImage: json["hotel_image"],
        hotelImages: json["hotel_images"] != null
            ? List<HotelImage>.from(json["hotel_images"].map((x) => HotelImage.fromMap(x)))
            : null,
        hotelStar: json["hotel_star"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        activities: json["activities"] != null
            ? List<Activity>.from(json["activities"].map((x) => Activity.fromMap(x)))
            : null,
        activityDetails: json["activity_details"] != null
            ? ActivityDetails.fromMap(json["activity_details"])
            : null,
        transfer: json["transfer"] != null
            ? List<IndTransfer>.from(json["transfer"].map((x) => IndTransfer.fromMap(x)))
            : null,
        total: json["total"],
        oldPrice: json["old_price"],
        responseFrom: json["response_from"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "package_days": packageDays,
        "selling_currency": sellingCurrency,
        "flights": flights!.toMap(),
        "flight_details": flightDetails?.toMap(),
        "flight_stop": flightStop,
        "no_flight": noFlight,
        "paxs": paxs,
        "from_city": fromCity,
        "to_city": toCity,
        "hotel_name": hotelName,
        "package_name": packageName,
        "travel_date": travelDate,
        // "hotel_image": hotelImage,
        // "hotel_images": List<dynamic>.from(hotelImages!.map((x) => x)),
        "hotel_star": hotelStar,
        "latitude": latitude,
        "longitude": longitude,
        "activities": List<dynamic>.from(activities!.map((x) => x)),
        "transfer": List<dynamic>.from(transfer?.map((x) => x.toMap()) ?? []),
        "total": total,
        "old_price": oldPrice,
        "response_from": responseFrom,
        "activity_details": activityDetails?.toMap(),
      };
}

class FlightDetails {
  FlightDetails({
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
  From to;
  String flightId;
  String prebook;

  factory FlightDetails.fromMap(Map<String, dynamic> json) => FlightDetails(
        carriers: Carriers.fromMap(json["carriers"]),
        carrier: Carrier.fromMap(json["carrier"]),
        tripStart: json["trip_start"],
        tripEnd: json["trip_end"],
        passenger: Passenger.fromMap(json["passenger"]),
        flightClass: json["flight_class"],
        from: From.fromMap(json["from"]),
        to: From.fromMap(json["to"]),
        flightId: json["flight_id"],
        prebook: json["prebook"],
      );

  Map<String, dynamic> toMap() => {
        "carriers": carriers.toMap(),
        "carrier": carrier.toMap(),
        "trip_start": tripStart,
        "trip_end": tripEnd,
        "passenger": passenger.toMap(),
        "flight_class": flightClass,
        "from": from.toMap(),
        "to": to.toMap(),
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

  factory Carrier.fromMap(Map<String, dynamic> json) => Carrier(
        code: json["code"],
        name: json["name"],
        label: json["label"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
        "label": label,
      };
}

class Carriers {
  Carriers({
    this.ul,
    this.qr,
    this.wy,
    this.fz,
    this.ek,
  });

  String? ul;
  String? qr;
  String? wy;
  String? fz;
  String? ek;

  factory Carriers.fromMap(Map<String, dynamic> json) => Carriers(
        ul: json["UL"],
        qr: json["QR"],
        wy: json["WY"],
        fz: json["FZ"],
        ek: json["EK"],
      );

  Map<String, dynamic> toMap() => {
        "UL": ul,
        "QR": qr,
        "WY": wy,
        "FZ": fz,
        "EK": ek,
      };
}

class From {
  From(
      {required this.numstops,
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
      required this.carrierCode,
      required this.carrierLogo});

  num numstops;
  List<String> stops;
  String departure;
  String arrival;
  num arrivalDays;
  DateTime departureFdate;
  String departureDate;
  String departureTime;
  DateTime arrivalFdate;
  String arrivalDate;
  String arrivalTime;
  String travelTime;
  List<Itinerary> itinerary;
  String carrierName;
  String carrierLogo;
  String carrierCode;

  factory From.fromMap(Map<String, dynamic> json) => From(
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
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromMap(x))),
        carrierName: json["carrier_name"],
        carrierCode: json["carrier_code"],
        carrierLogo: json["carrier_logo"],
      );

  Map<String, dynamic> toMap() => {
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
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toMap())),
        "carrier_name": carrierName,
        "carrier_code": carrierCode,
        "carrier_logo": carrierLogo
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
  num flightTime;
  Arrival arrival;
  num numstops;
  List<String> baggageInfo;
  String bookingClass;
  String cabinClass;
  num layover;

  factory Itinerary.fromMap(Map<String, dynamic> json) => Itinerary(
        company: Company.fromMap(json["company"]),
        flightNo: json["flightNo"],
        departure: Arrival.fromMap(json["departure"]),
        flightTime: json["flight_time"],
        arrival: Arrival.fromMap(json["arrival"]),
        numstops: json["numstops"],
        baggageInfo: List<String>.from(json["baggageInfo"].map((x) => x)),
        bookingClass: json["bookingClass"],
        cabinClass: json["cabinClass"],
        layover: json["layover"],
      );

  Map<String, dynamic> toMap() => {
        "company": company.toMap(),
        "flightNo": flightNo,
        "departure": departure.toMap(),
        "flight_time": flightTime,
        "arrival": arrival.toMap(),
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
  String timezone;
  String airport;
  String city;
  bool terminal;

  factory Arrival.fromMap(Map<String, dynamic> json) => Arrival(
        date: DateTime.parse(json["date"]),
        time: json["time"],
        locationId: json["locationId"],
        timezone: json["timezone"],
        airport: json["airport"],
        city: json["city"],
        terminal: json["terminal"],
      );

  Map<String, dynamic> toMap() => {
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

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        marketingCarrier: json["marketingCarrier"],
        operatingCarrier: json["operatingCarrier"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "marketingCarrier": marketingCarrier,
        "operatingCarrier": operatingCarrier,
        "logo": logo,
      };
}

class Passenger {
  Passenger({
    required this.adult,
  });

  num adult;

  factory Passenger.fromMap(Map<String, dynamic> json) => Passenger(
        adult: json["Adult"],
      );

  Map<String, dynamic> toMap() => {
        "Adult": adult,
      };
}

class Flights {
  Flights({
    required this.name,
  });

  String name;

  factory Flights.fromMap(Map<String, dynamic> json) => Flights(
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class PriceRange {
  PriceRange({
    required this.min,
    required this.max,
  });

  num min;
  num max;

  factory PriceRange.fromMap(Map<String, dynamic> json) => PriceRange(
        min: json["min"],
        max: json["max"],
      );

  Map<String, dynamic> toMap() => {
        "min": min,
        "max": max,
      };
}

class SearchData {
  SearchData(
      {required this.travelStart,
      required this.packageStart,
      required this.packageEnd,
      required this.departureCode,
      required this.departureName,
      required this.arrivalCode,
      required this.arrivalName,
      required this.flightClass,
      required this.adults,
      required this.firstChildAge,
      required this.secondChildAges,
      required this.ageOptionOne,
      required this.ageOptionTwo,
      required this.roomsCount,
      required this.adultsCount,
      required this.children,
      required this.childrenCount,
      required this.totalPassengers,
//required  this.childAge,
      required this.childrenAges,
      required this.modifyTravelStart,
      required this.modifyTravelEnd,
      required this.flightCode,
      required this.flightName,
      required this.hotelCode,
      required this.hotelName,
      required this.fromCity,
      required this.toCity});

  String travelStart;
  String packageStart;
  String packageEnd;
  String departureCode;
  String departureName;
  String arrivalCode;
  String arrivalName;
  String flightClass;
  List<dynamic> adults;
  List<num> firstChildAge;
  List<num> secondChildAges;
  List<bool> ageOptionOne;
  List<bool> ageOptionTwo;
  num roomsCount;
  num adultsCount;
  List<dynamic> children;
  num childrenCount;
  num totalPassengers;

  // List<dynamic> childAge;
  List<dynamic> childrenAges;
  String modifyTravelStart;
  String modifyTravelEnd;
  String flightCode;
  String flightName;
  String hotelCode;
  String hotelName;
  String fromCity;
  String toCity;

  factory SearchData.fromMap(Map<String, dynamic> json) => SearchData(
      travelStart: json["travel_start"],
      packageStart: json["package_start"],
      packageEnd: json["package_end"],
      departureCode: json["departure_code"],
      departureName: json["departure_name"],
      arrivalCode: json["arrival_code"],
      arrivalName: json["arrival_name"],
      flightClass: json["flight_class"],
      adults: List<dynamic>.from(json["adults"].map((x) => x)),
      firstChildAge: List<num>.from(json["first_child_age"].map((x) => x)),
      secondChildAges: List<num>.from(json["second_child_ages"].map((x) => x)),
      ageOptionOne: List<bool>.from(json["age_option_one"].map((x) => x)),
      ageOptionTwo: List<bool>.from(json["age_option_two"].map((x) => x)),
      roomsCount: json["rooms_count"],
      adultsCount: json["adults_count"],
      children: List<dynamic>.from(json["children"].map((x) => x)),
      childrenCount: json["children_count"],
      totalPassengers: json["total_passengers"],
      //  childAge: List<dynamic>.from(json["child_age"].map((x) => x)),

      //        childAge: Map.from(json["child_age"]).map((k, v) => MapEntry<String, List<dynamic>>(k, List<dynamic>.from(v.map((x) => x)))),
      childrenAges: List<dynamic>.from(json["childrenAges"].map((x) => x)),
      modifyTravelStart: json["modify_travel_start"],
      modifyTravelEnd: json["modify_travel_end"],
      flightCode: json["flight_code"],
      flightName: json["flight_name"],
      hotelCode: json["hotelCode"],
      hotelName: json["hotelName"],
      fromCity: json["from_city"],
      toCity: json["to_city"]);

  Map<String, dynamic> toMap() => {
        "travel_start": travelStart,
        "package_start": packageStart,
        "package_end": packageEnd,
        "departure_code": departureCode,
        "departure_name": departureName,
        "arrival_code": arrivalCode,
        "arrival_name": arrivalName,
        "flight_class": flightClass,
        "adults": List<dynamic>.from(adults.map((x) => x)),
        "first_child_age": List<dynamic>.from(firstChildAge.map((x) => x)),
        "second_child_ages": List<dynamic>.from(secondChildAges.map((x) => x)),
        "age_option_one": List<dynamic>.from(ageOptionOne.map((x) => x)),
        "age_option_two": List<dynamic>.from(ageOptionTwo.map((x) => x)),
        "rooms_count": roomsCount,
        "adults_count": adultsCount,
        "children": List<dynamic>.from(children.map((x) => x)),
        "children_count": childrenCount,
        "total_passengers": totalPassengers,
        //"child_age": List<dynamic>.from(childAge.map((x) => x)),
        "childrenAges": List<dynamic>.from(childrenAges.map((x) => x)),
        "modify_travel_start": modifyTravelStart,
        "modify_travel_end": modifyTravelEnd,
        "flight_code": flightCode,
        "flight_name": flightName,
        "hotelCode": hotelCode,
        "hotelName": hotelName,
        "from_city": fromCity,
        "to_city": toCity
      };
}

class IndHotelDetails {
  IndHotelDetails({
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
    required this.selectedRoom,
    required this.roomCounts,
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
  num roomCounts;
  String address;
  String currency;
  num rateFrom;
  String latitude;
  String longitude;
  String image;
  List<HotelImage> imgAll;
  List<IndRoom> rooms;
  List<String> facilities;
  List<IndRoom> selectedRoom;

  factory IndHotelDetails.fromMap(Map<String, dynamic> json) => IndHotelDetails(
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
        roomCounts: json["rooms_required"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        imgAll: List<HotelImage>.from(json["img_all"].map((x) => HotelImage.fromMap(x))),
        rooms: List<IndRoom>.from(json["rooms"].map((x) => IndRoom.fromMap(x))),
        facilities:
            json["facilities"] != null ? List<String>.from(json["facilities"].map((x) => x)) : [''],
        selectedRoom: List<IndRoom>.from(json["selectedRoom"].map((x) => IndRoom.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
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
        "checkin":
            "${checkin.year.toString().padLeft(4, '0')}-${checkin.month.toString().padLeft(2, '0')}-${checkin.day.toString().padLeft(2, '0')}",
        "checkout":
            "${checkout.year.toString().padLeft(4, '0')}-${checkout.month.toString().padLeft(2, '0')}-${checkout.day.toString().padLeft(2, '0')}",
        "address": address,
        "currency": currency,
        "rateFrom": rateFrom,
        "latitude": latitude,
        "longitude": longitude,
        "rooms_required": roomCounts,
        "image": image,
        "img_all": List<dynamic>.from(imgAll.map((x) => x.toMap())),
        "rooms": List<dynamic>.from(rooms.map((x) => x.toMap())),
        "facilities": List<dynamic>.from(facilities.map((x) => x)),
        "selectedRoom": List<dynamic>.from(selectedRoom.map((x) => x.toMap())),
      };
}

class HotelImage {
  HotelImage({
    required this.src,
  });

  String src;

  factory HotelImage.fromMap(Map<String, dynamic> json) => HotelImage(
        src: json["src"],
      );

  Map<String, dynamic> toMap() => {
        "src": src,
      };
}

class IndRoom {
  IndRoom(
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
  num allotment;
  String rateKey;
  String rateClass;
  String? roomTypeText;
  String rateType;
  String boardCode;
  String boardName;
  String sellingCurrency;
  num amount;
  num amountChange;
  String type;

  factory IndRoom.fromMap(Map<String, dynamic> json) => IndRoom(
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

  Map<String, dynamic> toMap() => {
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
        "roomTypeText": roomTypeText
      };
}

class Activity {
  Activity({
    required this.name,
    required this.date,
  });

  String name;
  DateTime date;

  factory Activity.fromMap(Map<String, dynamic> json) => Activity(
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class ActivityDetails {
  ActivityDetails({
    required this.name,
    required this.searchId,
    required this.code,
    required this.searchType,
    required this.activityId,
    required this.modalityCode,
    required this.modalityName,
    required this.sellingCurrency,
    required this.modalityAmount,
    required this.activityDate,
    required this.day,
    required this.activityDateDisplay,
    required this.activityDestination,
    required this.image,
    required this.description,
  });

  String name;
  String searchId;
  String code;
  String searchType;
  String activityId;
  String modalityCode;
  String modalityName;
  String sellingCurrency;
  int modalityAmount;
  DateTime activityDate;
  int day;
  String activityDateDisplay;
  String activityDestination;
  String image;
  String description;

  factory ActivityDetails.fromMap(Map<String, dynamic> json) {
    return ActivityDetails(
      name: json["name"],
      searchId: json["searchId"],
      code: json["code"],
      searchType: json["searchType"],
      activityId: json["activity_id"],
      modalityCode: json["modality_code"],
      modalityName: json["modality_name"],
      sellingCurrency: json["selling_currency"],
      modalityAmount: json["modality_amount"],
      activityDate: DateTime.parse(json["activity_date"]),
      day: json["day"],
      activityDateDisplay: json["activity_date_display"],
      activityDestination: json["activity_destination"],
      image: json["image"].runtimeType.toString() == 'List<dynamic>' ? '' : json["image"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "searchId": searchId,
        "code": code,
        "searchType": searchType,
        "activity_id": activityId,
        "modality_code": modalityCode,
        "modality_name": modalityName,
        "selling_currency": sellingCurrency,
        "modality_amount": modalityAmount,
        "activity_date":
            "${activityDate.year.toString().padLeft(4, '0')}-${activityDate.month.toString().padLeft(2, '0')}-${activityDate.day.toString().padLeft(2, '0')}",
        "day": day,
        "activity_date_display": activityDateDisplay,
        "activity_destination": activityDestination,
        "image": image,
        "description": description,
      };
}

class IndTransfer {
  IndTransfer(
      {required this.id,
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
      required this.dropOff,
      required this.pickUp});

  String id;
  String searchCode;
  String type;
  String group;
  DateTime date;
  String time;
  String currency;
  String payableCurrency;
  double netAmount;
  double totalAmount;
  double sellingPrice;
  String serviceTypeCode;
  String serviceTypeName;
  String productTypeName;
  String vehicleTypeName;
  String dropOff;
  String pickUp;
  int units;
  String image;

  factory IndTransfer.fromMap(Map<String, dynamic> json) => IndTransfer(
      id: json["_id"],
      searchCode: json["search_code"],
      type: json["type"],
      group: json["group"],
      date: DateTime.parse(json["date"]),
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
      image: json['image'],
      pickUp: json["pickup"],
      dropOff: json["dropoff"]);

  Map<String, dynamic> toMap() => {
        "_id": id,
        "search_code": searchCode,
        "type": type,
        "group": group,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
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
        "pickup": pickUp,
        "dropoff": dropOff
      };
}
