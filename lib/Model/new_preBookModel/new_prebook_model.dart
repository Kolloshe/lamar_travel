// To parse this JSON data, do
//
//     final prebook = prebookFromMap(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

Prebook prebookFromMap(String str) => Prebook.fromMap(json.decode(str));

String prebookToMap(Prebook data) => json.encode(data.toMap());

class Prebook {
  Prebook({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  Data data;

  factory Prebook.fromMap(Map<String, dynamic> json) => Prebook(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.customizeId,
    required this.payment,
    required this.userCredits,
    required this.details,
    required this.holder,
    required this.passengers,
    required this.specialRequest,
    required this.selectedSpecialRequests,
    required this.specialRequestComment,
  });

  String customizeId;
  Payment payment;
  UserCredits userCredits;
  DataDetails? details;
  Holder holder;
  List<Passenger> passengers;
  List<Map<String, bool>> specialRequest;
  List<dynamic> selectedSpecialRequests;
  String specialRequestComment;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        customizeId: json["customizeId"],
        payment: Payment.fromMap(json["payment"]),
        userCredits: UserCredits.fromMap(json["user_credits"]),
        details: DataDetails.fromJson(json["details"]),
        holder: Holder.fromJson(json["holder"]),
        passengers: List<Passenger>.from(json["passengers"].map((x) => Passenger.fromJson(x))),
        specialRequest: List<Map<String, bool>>.from(json["specialRequest"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, bool>(k, v == null ? null : v)))),
        selectedSpecialRequests: List<dynamic>.from(json["selectedSpecialRequests"].map((x) => x)),
        specialRequestComment: json["specialRequestComment"],
      );

  Map<String, dynamic> toMap() => {
        "customizeId": customizeId,
        "payment": payment.toMap(),
        "user_credits": userCredits.toMap(),
        "details": details?.toJson(),
        "holder": holder.toJson(),
        "passengers": List<dynamic>.from(passengers.map((x) => x.toJson())),
        "specialRequest": List<dynamic>.from(specialRequest.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
        "selectedSpecialRequests": List<dynamic>.from(selectedSpecialRequests.map((x) => x)),
        "specialRequestComment": specialRequestComment,
      };
}

class DataDetails {
  DataDetails({
    required this.packageName,
    required this.packageDays,
    required this.flight,
    required this.totalAmount,
    required this.hotel,
    required this.transfer,
    required this.activities,
    required this.adultsCount,
    required this.childrenCount,
    required this.infantsCount,
    required this.noFlights,
    required this.noHotels,
    required this.noTransfers,
    required this.noActivities,
  });

  String packageName;
  int packageDays;
  Flight? flight;
  int totalAmount;
  List<Hotel> hotel;
  List<Transfer> transfer;
  Activities? activities;
  int adultsCount;
  int childrenCount;
  int infantsCount;
  bool noFlights;
  bool noHotels;
  bool noTransfers;
  bool noActivities;

  factory DataDetails.fromJson(Map<String, dynamic> json) => DataDetails(
    packageName: json["package_name"],
    packageDays: json["package_days"],
    flight: json["no_flights"] ? null : Flight.fromJson(json["flight"]),
    totalAmount: json["total_amount"],
    hotel: json["hotel"] != null
        ? List<Hotel>.from(json["hotel"].map((x) => Hotel.fromJson(x)))
        : [],
    transfer: json["transfer"] != null
        ? List<Transfer>.from(json["transfer"].map((x) => Transfer.fromJson(x)))
        : [],
    activities: json["no_activities"] ? null : Activities.fromJson(json["activities"]),
    adultsCount: json["adults_count"],
    childrenCount: json["children_count"],
    infantsCount: json["infants_count"],
    noFlights: json["no_flights"],
    noHotels: json["no_hotels"],
    noTransfers: json["no_transfers"],
    noActivities: json["no_activities"],
  );

  Map<String, dynamic> toJson() => {
    "package_name": packageName,
    "package_days": packageDays,
    "flight": flight!.toJson(),
    "total_amount": totalAmount,
    "hotel": List<dynamic>.from(hotel.map((x) => x.toJson())),
    "transfer": List<dynamic>.from(transfer.map((x) => x.toJson())),
    "activities": activities!.toJson(),
    "adults_count": adultsCount,
    "children_count": childrenCount,
    "infants_count": infantsCount,
    "no_flights": noFlights,
    "no_hotels": noHotels,
    "no_transfers": noTransfers,
    "no_activities": noActivities,
  };
}

class Activities {
  Activities({
    required this.name,
  });

  List<String> name;

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
    name: List<String>.from(json["name"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": List<dynamic>.from(name.map((x) => x)),
  };
}

class Flight {
  Flight({
    required this.carriers,
    required this.sellingCurrency,
    required this.maxStop,
    required this.startDate,
    required this.endDate,
    required this.travelData,
  });

  Carriers? carriers;
  String sellingCurrency;
  int maxStop;
  String startDate;
  String endDate;
  List<Traveldatum> travelData;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    carriers: Carriers.fromJson(json["carriers"]),
    sellingCurrency: json["selling_currency"],
    maxStop: json["max_stop"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    travelData: List<Traveldatum>.from(json["travel_data"].map((x) => Traveldatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carriers": carriers?.toJson() ?? '',
    "selling_currency": sellingCurrency,
    "max_stop": maxStop,
    "start_date": startDate,
    "end_date": endDate,
    "travel_data": List<dynamic>.from(travelData.map((x) => x.toJson())),
  };
}

class Carriers {
  Carriers({
    required this.rj,
  });

  String? rj;

  factory Carriers.fromJson(Map<String, dynamic> json) => Carriers(
    rj: json["RJ"],
  );

  Map<String, dynamic> toJson() => {
    "RJ": rj,
  };
}

class Traveldatum {
  Traveldatum({
    required this.travelTime,
    required this.numstops,
    required this.stops,
    required this.carriers,
    required this.start,
    required this.end,
    required this.itenerary,
  });

  int travelTime;
  int numstops;
  List<String> stops;
  List<Carrier> carriers;
  End start;
  End end;
  List<Itenerary> itenerary;

  factory Traveldatum.fromJson(Map<String, dynamic> json) => Traveldatum(
    travelTime: json["travel_time"],
    numstops: json["numstops"],
    stops: List<String>.from(json["stops"].map((x) => x)),
    carriers: List<Carrier>.from(json["carriers"].map((x) => Carrier.fromJson(x))),
    start: End.fromJson(json["start"]),
    end: End.fromJson(json["end"]),
    itenerary: List<Itenerary>.from(json["itenerary"].map((x) => Itenerary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "travel_time": travelTime,
    "numstops": numstops,
    "stops": List<dynamic>.from(stops.map((x) => x)),
    "carriers": List<dynamic>.from(carriers.map((x) => x.toJson())),
    "start": start.toJson(),
    "end": end.toJson(),
    "itenerary": List<dynamic>.from(itenerary.map((x) => x.toJson())),
  };
}

class Carrier {
  Carrier({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
  };
}

class End {
  End({
    required this.date,
    required this.time,
    required this.locationId,
    required this.terminal,
    required this.timezone,
  });

  DateTime date;
  String time;
  String locationId;
  bool terminal;
  String timezone;

  factory End.fromJson(Map<String, dynamic> json) => End(
    date: DateTime.parse(json["date"]),
    time: json["time"],
    locationId: json["locationId"],
    terminal: json["terminal"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "locationId": locationId,
    "terminal": terminal,
    "timezone": timezone,
  };
}

class Itenerary {
  Itenerary({
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

  factory Itenerary.fromJson(Map<String, dynamic> json) => Itenerary(
    company: Company.fromJson(json["company"]),
    flightNo: json["flightNo"],
    departure: Arrival.fromJson(json["departure"]),
    flightTime: json["flight_time"],
    arrival: Arrival.fromJson(json["arrival"]),
    numstops: json["numstops"],
    baggageInfo: List<String>.from(json["baggageInfo"].map((x) => x)),
    bookingClass: json["bookingClass"],
    cabinClass: json["cabinClass"],
    layover: json["layover"],
  );

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
  String timezone;
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

class Hotel {
  Hotel({
    required this.name,
    required this.starRating,
    required this.hotelImage,
  });

  String name;
  String starRating;
  String hotelImage;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
    name: json["name"],
    starRating: json["starRating"],
    hotelImage: json["hotelImage"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "starRating": starRating,
    "hotelImage": hotelImage,
  };
}

class Transfer {
  Transfer({
    required this.transferIn,
    required this.out,
  });

  In? transferIn;
  In? out;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
    transferIn: json.containsKey('IN') ? In.fromJson(json["IN"]) : null,
    out: json.containsKey('OUT') ? In.fromJson(json["OUT"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "IN": transferIn?.toJson(),
    "OUT": out?.toJson(),
  };
}

class In {
  In({
    required this.date,
    required this.time,
  });

  String date;
  String time;

  factory In.fromJson(Map<String, dynamic> json) => In(
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "time": time,
  };
}



class Holder {
  Holder({
    required this.code,
    required this.email,
    required this.phone,
    required this.title,
    required this.firstName,
    required this.lastname,
  });

  String code;
  String email;
  String phone;
  dynamic title;
  String firstName;
  String lastname;

  factory Holder.fromJson(Map<String, dynamic> json) => Holder(
    code: json["code"],
    email: json["email"],
    phone: json["phone"],
    title: json["title"],
    firstName: json["firstName"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "email": email,
    "phone": phone,
    "title": title,
    "firstName": firstName,
    "lastname": lastname,
  };
}

class Passenger {
  Passenger({
    required this.guestId,
    required this.guestType,
    required this.guestAgeType,
    required this.guestTitle,
    required this.guestName,
    required this.guestSurame,
    required this.guestDob,
    required this.guestPassportIssue,
    required this.guestPassportNo,
    required this.guestPassportExpiry,
    required this.guestNationality,
    required this.guestDobFormat,
    required this.dob,
    required this.guestPassportExpiryFormat,
    required this.passportExpiry,
    required this.guestNationalityName,
    required this.guestPassportIssueName,
  });

  dynamic guestId;
  dynamic guestType;
  String guestAgeType;
  String guestTitle;
  String guestName;
  String guestSurame;
  DateTime guestDob;
  String guestPassportIssue;
  String guestPassportNo;
  DateTime guestPassportExpiry;
  String guestNationality;
  DateTime guestDobFormat;
  String dob;
  String guestPassportExpiryFormat;
  String passportExpiry;
  String guestNationalityName;
  String guestPassportIssueName;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    guestId: json["guestId"],
    guestType: json["guestType"],
    guestAgeType: json["guestAgeType"],
    guestTitle: json["guestTitle"],
    guestName: json["guestName"],
    guestSurame: json["guestSurame"],
    guestDob: DateTime.parse(json["guestDob"]),
    guestPassportIssue: json["guestPassportIssue"],
    guestPassportNo: json["guestPassportNo"],
    guestPassportExpiry: DateTime.parse(json["guestPassportExpiry"]),
    guestNationality: json["guestNationality"],
    guestDobFormat: DateTime.parse(json["guestDobFormat"]),
    dob: json["dob"],
    guestPassportExpiryFormat: json["guestPassportExpiryFormat"],
    passportExpiry: json["passportExpiry"],
    guestNationalityName: json["guestNationalityName"],
    guestPassportIssueName: json["guestPassportIssueName"],
  );

  Map<String, dynamic> toJson() => {
    "guestId": guestId,
    "guestType": guestType,
    "guestAgeType": guestAgeType,
    "guestTitle": guestTitle,
    "guestName": guestName,
    "guestSurame": guestSurame,
    "guestDob":
    "${guestDob.year.toString().padLeft(4, '0')}-${guestDob.month.toString().padLeft(2, '0')}-${guestDob.day.toString().padLeft(2, '0')}",
    "guestPassportIssue": guestPassportIssue,
    "guestPassportNo": guestPassportNo,
    "guestPassportExpiry":
    "${guestPassportExpiry.year.toString().padLeft(4, '0')}-${guestPassportExpiry.month.toString().padLeft(2, '0')}-${guestPassportExpiry.day.toString().padLeft(2, '0')}",
    "guestNationality": guestNationality,
    "guestDobFormat":
    "${guestDobFormat.year.toString().padLeft(4, '0')}-${guestDobFormat.month.toString().padLeft(2, '0')}-${guestDobFormat.day.toString().padLeft(2, '0')}",
    "dob": dob,
    "guestPassportExpiryFormat": guestPassportExpiryFormat,
    "passportExpiry": passportExpiry,
    "guestNationalityName": guestNationalityName,
    "guestPassportIssueName": guestPassportIssueName,
  };
}

class TravelDate {
  TravelDate({
    required this.date,
    required this.time,
  });

  DateTime date;
  String time;

  factory TravelDate.fromJson(Map<String, dynamic> json) => TravelDate(
    date: DateTime.parse(json["date"]),
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
  };
}

class FluffyDetails {
  FluffyDetails({
    required this.flightId,
    required this.flightClass,
    required this.carrierName,
    required this.sellingCurrency,
    required this.total,
    required this.payableCurrency,
    required this.netAmount,
    required this.tripType,
    required this.maxStop,
    required this.tripStart,
    required this.tripEnd,
    required this.carriers,
    required this.travelDate,
    required this.traveldata,
    required this.prebook,
    required this.transactionId,
  });

  String flightId;
  String flightClass;
  String carrierName;
  String sellingCurrency;
  int total;
  String payableCurrency;
  int netAmount;
  int tripType;
  int maxStop;
  String tripStart;
  String tripEnd;
  Carriers? carriers;
  List<TravelDate> travelDate;
  List<Traveldatum> traveldata;
  int prebook;
  int transactionId;

  factory FluffyDetails.fromJson(Map<String, dynamic> json) => FluffyDetails(
    flightId: json["flight_id"],
    flightClass: json["flight_class"],
    carrierName: json["carrier_name"],
    sellingCurrency: json["selling_currency"],
    total: json["total"],
    payableCurrency: json["payable_currency"],
    netAmount: json["net_amount"],
    tripType: json["trip_type"],
    maxStop: json["max_stop"],
    tripStart: json["trip_start"],
    tripEnd: json["trip_end"],
    carriers: Carriers.fromJson(json["carriers"]),
    travelDate: List<TravelDate>.from(json["travel_date"].map((x) => TravelDate.fromJson(x))),
    traveldata: List<Traveldatum>.from(json["traveldata"].map((x) => Traveldatum.fromJson(x))),
    prebook: json["prebook"],
    transactionId: json["transactionId"],
  );

  Map<String, dynamic> toJson() => {
    "flight_id": flightId,
    "flight_class": flightClass,
    "carrier_name": carrierName,
    "selling_currency": sellingCurrency,
    "total": total,
    "payable_currency": payableCurrency,
    "net_amount": netAmount,
    "trip_type": tripType,
    "max_stop": maxStop,
    "trip_start": tripStart,
    "trip_end": tripEnd,
    "carriers": carriers?.toJson() ?? '',
    "travel_date": List<dynamic>.from(travelDate.map((x) => x.toJson())),
    "traveldata": List<dynamic>.from(traveldata.map((x) => x.toJson())),
    "prebook": prebook,
    "transactionId": transactionId,
  };
}


class HotelsDetail {
  HotelsDetail({
    required this.date,
    required this.key,
    required this.details,
  });

  DateTime date;
  int key;
  TentacledDetails details;

  factory HotelsDetail.fromJson(Map<String, dynamic> json) => HotelsDetail(
    date: DateTime.parse(json["date"]),
    key: json["key"],
    details: TentacledDetails.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "key": key,
    "details": details.toJson(),
  };
}
class FlightsDetail {
  FlightsDetail({
    required this.date,
    required this.key,
    required this.details,
  });

  DateTime date;
  int key;
  FluffyDetails details;

  factory FlightsDetail.fromJson(Map<String, dynamic> json) => FlightsDetail(
    date: DateTime.parse(json["date"]),
    key: json["key"],
    details: FluffyDetails.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "key": key,
    "details": details.toJson(),
  };
}

class Flights {
  Flights(
      {required this.prebookSuccess,
        required this.message,
        required this.details,
        required this.failedReasons});

  bool prebookSuccess;
  String message;
  List<FlightsDetail> details;
  FailedReasons? failedReasons;

  factory Flights.fromJson(Map<String, dynamic> json) => Flights(
    prebookSuccess: json["prebook_success"],
    message: json["message"],
    details: json["prebook_success"] == false
        ? List<FlightsDetail>.from(json["details"].map((x) => FlightsDetail.fromJson(x)))
        : [],
    failedReasons: json.containsKey("failed_reasons")
        ? FailedReasons.fromJson(json["failed_reasons"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "prebook_success": prebookSuccess,
    "message": message,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "failed_reasons": failedReasons!.toJson(),
  };
}
class Hotels {
  Hotels({
    required this.prebookSuccess,
    required this.message,
    required this.details,
  });

  bool prebookSuccess;
  String message;
  List<HotelsDetail> details;

  factory Hotels.fromJson(Map<String, dynamic> json) => Hotels(
    prebookSuccess: json["prebook_success"],
    message: json["message"],
    details: json["prebook_success"] == true
        ? []
        : List<HotelsDetail>.from(json["details"].map((x) => HotelsDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "prebook_success": prebookSuccess,
    "message": message,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class PrebookDetails {
  PrebookDetails({
    required this.flights,
    required this.hotels,
    required this.activites,
    required this.transfers,
  });

  Flights flights;
  Hotels hotels;
  Activites activites;
  Transfers transfers;

  factory PrebookDetails.fromJson(Map<String, dynamic> json) {
    return PrebookDetails(
      flights: Flights.fromJson(json["flights"]),
      hotels: Hotels.fromJson(json["hotels"]),
      activites: Activites.fromJson(json["activites"]),
      transfers: Transfers.fromJson(json["transfers"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "flights": flights.toJson(),
    "hotels": hotels.toJson(),
    "activites": activites.toJson(),
    "transfers": transfers.toJson(),
  };
}

class Activites {
  Activites({
    required this.prebookSuccess,
    required this.message,
    required this.details,
  });

  bool prebookSuccess;
  String message;
  List<ActivitesDetail> details;

  factory Activites.fromJson(Map<String, dynamic> json) => Activites(
    prebookSuccess: json["prebook_success"],
    message: json["message"],
    details: json["prebook_success"] == false
        ? List<ActivitesDetail>.from(json["details"].map((x) => ActivitesDetail.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "prebook_success": prebookSuccess,
    "message": message,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class ActivitesDetail {
  ActivitesDetail({
    required this.date,
    required this.key,
    required this.details,
  });

  DateTime date;
  int key;
  PurpleDetails details;

  factory ActivitesDetail.fromJson(Map<String, dynamic> json) => ActivitesDetail(
    date: DateTime.parse(json["date"]),
    key: json["key"],
    details: PurpleDetails.fromJson(json["details"]),
  );

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "key": key,
    "details": details.toJson(),
  };
}


class PurpleDetails {
  PurpleDetails({
    required this.name,
    required this.searchId,
    required this.code,
    required this.activityId,
    required this.modalityCode,
    required this.modalityName,
    required this.sellingCurrency,
    required this.netAmount,
    required this.paybleCurency,
    required this.modalityAmount,
    required this.activityDate,
    required this.questions,
    required this.rateKey,
    required this.images,
    required this.bookingReference,
    required this.prebook,

  });

  String name;
  String searchId;
  String code;
  String activityId;
  String modalityCode;
  String modalityName;

  //List<AmountsFrom> amountsFrom;
  String sellingCurrency;
  double netAmount;
  String paybleCurency;
  int modalityAmount;
  DateTime activityDate;
  List<Question> questions;
  String rateKey;
  List<ImagePrebook> images;
  String bookingReference;
  int prebook;

  // String prebookedAt;
  // String supplierReference;
  // String supplierCurrency;
  // double supplierPrice;

  factory PurpleDetails.fromJson(Map<String, dynamic> json) => PurpleDetails(
    name: json["name"],
    searchId: json["searchId"],
    code: json["code"],
    activityId: json["activity_id"],
    modalityCode: json["modality_code"],
    modalityName: json["modality_name"],
    // amountsFrom:
    //     List<AmountsFrom>.from(json["amountsFrom"].map((x) => AmountsFrom.fromJson(x))),
    sellingCurrency: json["selling_currency"],
    netAmount: json["net_amount"].toDouble(),
    paybleCurency: json["paybleCurency"],
    modalityAmount: json["modality_amount"],
    activityDate: DateTime.parse(json["activity_date"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    rateKey: json["rateKey"],
    images: List<ImagePrebook>.from(json["images"].map((x) => ImagePrebook.fromJson(x))),
    bookingReference: json["bookingReference"],
    prebook: json["prebook"],
    //prebookedAt: json["prebooked_at"],
    // supplierReference: json["supplierReference"],
    // supplierCurrency: json["supplier_currency"],
    // supplierPrice: json["supplier_price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "searchId": searchId,
    "code": code,
    "activity_id": activityId,
    "modality_code": modalityCode,
    "modality_name": modalityName,
    // "amountsFrom": List<dynamic>.from(amountsFrom.map((x) => x.toJson())),
    "selling_currency": sellingCurrency,
    "net_amount": netAmount,
    "paybleCurency": paybleCurency,
    "modality_amount": modalityAmount,
    "activity_date":
    "${activityDate.year.toString().padLeft(4, '0')}-${activityDate.month.toString().padLeft(2, '0')}-${activityDate.day.toString().padLeft(2, '0')}",
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    "rateKey": rateKey,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "bookingReference": bookingReference,
    "prebook": prebook,
    // "prebooked_at": prebookedAt,
    // "supplierReference": supplierReference,
    // "supplier_currency": supplierCurrency,
    // "supplier_price": supplierPrice,
  };
}

class ImagePrebook {
  ImagePrebook({
    required this.visualizationOrder,
    required this.mimeType,
    required this.urls,
  });

  int visualizationOrder;
  String mimeType;
  List<Url> urls;

  factory ImagePrebook.fromJson(Map<String, dynamic> json) => ImagePrebook(
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
class Question {
  Question({
    required this.code,
    required this.text,
    required this.required,
  });

  String code;
  String text;
  bool required;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    code: json["code"],
    text: json["text"],
    required: json["required"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "text": text,
    "required": required,
  };
}
class TentacledDetails {
  TentacledDetails({
    required this.hotelId,
    required this.hotelCode,
    required this.name,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.starRating,
    required this.numOfRooms,
    required this.sellingCurrency,
    required this.amount,
    required this.payableCurrency,
    // required this.netAmount,
    required this.totalAmount,
    required this.adults,
    required this.children,
    //  required this.childrenAges,
    required this.destinationCode,
    required this.destinationName,
    required this.checkIn,
    required this.checkOut,
    required this.checkin,
    required this.checkout,
    required this.selectedRoom,
    required this.availability,
    required this.searchId,
    required this.prebook,
  });

  int hotelId;
  dynamic hotelCode;
  String name;
  String image;
  String latitude;
  String longitude;
  String starRating;
  int numOfRooms;
  String sellingCurrency;
  int amount;
  String payableCurrency;

  // String netAmount;
  int totalAmount;
  Adults adults;
  Adults children;

  // int childrenAges;
  String destinationCode;
  String destinationName;
  DateTime checkIn;
  DateTime checkOut;
  DateTime checkin;
  DateTime checkout;
  List<SelectedRoom> selectedRoom;
  bool availability;
  String searchId;
  int prebook;

  factory TentacledDetails.fromJson(Map<String, dynamic> json) => TentacledDetails(
    hotelId: json["hotel_id"],
    hotelCode: json["hotel_code"],
    name: json["name"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    starRating: json["starRating"],
    numOfRooms: json["numOfRooms"],
    sellingCurrency: json["selling_currency"],
    amount: json["amount"],
    payableCurrency: json["payable_currency"],
    //   netAmount: json["net_amount"],
    totalAmount: json["total_amount"],
    adults: Adults.fromJson(json["adults"]),
    children: Adults.fromJson(json["children"]),
    //   childrenAges: json["childrenAges"],
    destinationCode: json["destination_code"],
    destinationName: json["destination_name"],
    checkIn: DateTime.parse(json["checkIn"]),
    checkOut: DateTime.parse(json["checkOut"]),
    checkin: DateTime.parse(json["checkin"]),
    checkout: DateTime.parse(json["checkout"]),
    selectedRoom:
    List<SelectedRoom>.from(json["selectedRoom"].map((x) => SelectedRoom.fromJson(x))),
    availability: json["availability"],
    searchId: json["searchId"],
    prebook: json["prebook"],
  );

  Map<String, dynamic> toJson() => {
    "hotel_id": hotelId,
    "hotel_code": hotelCode,
    "name": name,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "starRating": starRating,
    "numOfRooms": numOfRooms,
    "selling_currency": sellingCurrency,
    "amount": amount,
    "payable_currency": payableCurrency,
    //"net_amount": netAmount,
    "total_amount": totalAmount,
    "adults": adults.toJson(),
    "children": children.toJson(),
    // "childrenAges": childrenAges,
    "destination_code": destinationCode,
    "destination_name": destinationName,
    "checkIn":
    "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
    "checkOut":
    "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
    "checkin":
    "${checkin.year.toString().padLeft(4, '0')}-${checkin.month.toString().padLeft(2, '0')}-${checkin.day.toString().padLeft(2, '0')}",
    "checkout":
    "${checkout.year.toString().padLeft(4, '0')}-${checkout.month.toString().padLeft(2, '0')}-${checkout.day.toString().padLeft(2, '0')}",
    "selectedRoom": List<dynamic>.from(selectedRoom.map((x) => x.toJson())),
    "availability": availability,
    "searchId": searchId,
    "prebook": prebook,
  };
}

class Adults {
  Adults({
    required this.the1,
  });

  String the1;

  factory Adults.fromJson(Map<String, dynamic> json) => Adults(
    the1: json["1"],
  );

  Map<String, dynamic> toJson() => {
    "1": the1,
  };
}

class SelectedRoom {
  SelectedRoom({
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
    required this.prebook,
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
  String type;
  int prebook;

  factory SelectedRoom.fromJson(Map<String, dynamic> json) => SelectedRoom(
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
    prebook: json["prebook"],
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
    "prebook": prebook,
  };
}

class Transfers {
  Transfers({
    required this.prebookSuccess,
    required this.message,
    required this.details,
  });

  bool prebookSuccess;
  String message;
  List<TransfersDetail> details;

  factory Transfers.fromJson(Map<String, dynamic> json) {
    return Transfers(
        prebookSuccess: json["prebook_success"],
        message: json["message"],
        details: json["details"].isEmpty
            ? []
            : List<TransfersDetail>.from(json["details"].map((x) => TransfersDetail.fromJson(x))));
  }

  Map<String, dynamic> toJson() => {
    "prebook_success": prebookSuccess,
    "message": message,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TransfersDetail {
  TransfersDetail({
    required this.date,
    required this.key,
    required this.details,
  });

  DateTime date;
  int key;
  StickyDetails details;

  factory TransfersDetail.fromJson(Map<String, dynamic> json) {
    return TransfersDetail(
      date: DateTime.parse(json["date"]),
      key: json["key"],
      details: StickyDetails.fromJson(json["details"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "date":
    "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "key": key,
    "details": details.toJson(),
  };
}

class StickyDetails {
  StickyDetails({
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
    required this.prebook,
    required this.supplierCurrency,
    required this.supplierPrice,
  });

  String id;
  String searchCode;
  String type;
  String group;
  DateTime date;
  String time;
  String currency;
  String payableCurrency;
  double netAmount;
  num totalAmount;
  double sellingPrice;
  String serviceTypeCode;
  String serviceTypeName;
  String productTypeName;
  String vehicleTypeName;
  int units;
  int prebook;
  String supplierCurrency;
  String supplierPrice;

  factory StickyDetails.fromJson(Map<String, dynamic> json) => StickyDetails(
    id: json["_id"],
    searchCode: json["search_code"],
    type: json["type"],
    group: json["group"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    currency: json["currency"],
    payableCurrency: json["payable_currency"],
    netAmount: json["net_amount"].toDouble(),
    totalAmount: json["total_amount"],
    sellingPrice: json["selling_price"].toDouble(),
    serviceTypeCode: json["service_type_code"],
    serviceTypeName: json["service_type_name"],
    productTypeName: json["product_type_name"],
    vehicleTypeName: json["vehicle_type_name"],
    units: json["units"],
    prebook: json["prebook"],
    supplierCurrency: json["supplier_currency"],
    supplierPrice: json["supplier_price"],
  );

  Map<String, dynamic> toJson() => {
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
    "prebook": prebook,
    "supplier_currency": supplierCurrency,
    "supplier_price": supplierPrice,
  };
}

class SpecialRequest {
  SpecialRequest({
    required this.interconnectingRooms,
    required this.smokingRoom,
    required this.nonSmokingRoom,
    required this.roomLowFloor,
    required this.roomHighFloor,
    required this.vipGuest,
    required this.honeymoon,
    required this.babycot,
    required this.birthday,
    required this.anniversary,
    required this.otherRequest,
  });

  final bool interconnectingRooms;
  final bool smokingRoom;
  final bool nonSmokingRoom;
  final bool roomLowFloor;
  final bool roomHighFloor;
  final bool vipGuest;
  final bool honeymoon;
  final bool babycot;
  final bool birthday;
  final bool anniversary;
  final String? otherRequest;

  factory SpecialRequest.fromMap(Map<String, dynamic> json) => SpecialRequest(
    interconnectingRooms: json["interconnecting_rooms"],
    smokingRoom: json["smoking_room"],
    nonSmokingRoom: json["non_smoking_room"],
    roomLowFloor: json["room_low_floor"],
    roomHighFloor: json["room_high_floor"],
    vipGuest: json["vip_guest"],
    honeymoon: json["honeymoon"],
    babycot: json["babycot"],
    birthday: json["birthday"],
    anniversary: json["anniversary"],
    otherRequest: json["other_request"],
  );

  Map<String, dynamic> toMap() => {
    "interconnecting_rooms": interconnectingRooms,
    "smoking_room": smokingRoom,
    "non_smoking_room": nonSmokingRoom,
    "room_low_floor": roomLowFloor,
    "room_high_floor": roomHighFloor,
    "vip_guest": vipGuest,
    "honeymoon": honeymoon,
    "babycot": babycot,
    "birthday": birthday,
    "anniversary": anniversary,
    "other_request": otherRequest,
  };
}

class FailedReasons {
  FailedReasons({
    required this.fielderrors,
    required this.unknownerror,
  });

  bool fielderrors;
  bool unknownerror;

  factory FailedReasons.fromJson(Map<String, dynamic> json) => FailedReasons(
    fielderrors: json["fielderrors"],
    unknownerror: json["unknownerror"],
  );

  Map<String, dynamic> toJson() => {
    "fielderrors": fielderrors,
    "unknownerror": unknownerror,
  };
}


class Payment {
  Payment({
required this.userCurrency,
required this.packageAmountWithoutAnyDiscount,
required this.packageAmountWithCouponDiscount,
required this.packageAmountWithCouponWithCredit,
required this.packageAmountWithCouponWithCreditWithOtherDiscounts,
required this.finalSellingAmount,
required this.payFullAmountByCredit,
required this.payPartialAmountByCredit,
required this.discounts,
  });

  String userCurrency;
  String packageAmountWithoutAnyDiscount;
  String packageAmountWithCouponDiscount;
  String packageAmountWithCouponWithCredit;
  String packageAmountWithCouponWithCreditWithOtherDiscounts;
  String finalSellingAmount;
  bool payFullAmountByCredit;
  bool payPartialAmountByCredit;
  Discounts discounts;

  factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        userCurrency: json["user_currency"],
        packageAmountWithoutAnyDiscount: json["package_amount_without_any_discount"],
        packageAmountWithCouponDiscount: json["package_amount_with_coupon_discount"],
        packageAmountWithCouponWithCredit: json["package_amount_with_coupon_with_credit"],
        packageAmountWithCouponWithCreditWithOtherDiscounts:
            json["package_amount_with_coupon_with_credit_with_other_discounts"],
        finalSellingAmount: json["final_selling_amount"],
        payFullAmountByCredit: json["pay_full_amount_by_credit"],
        payPartialAmountByCredit: json["pay_partial_amount_by_credit"],
        discounts: Discounts.fromMap(json["discounts"]),
      );

  Map<String, dynamic> toMap() => {
        "user_currency": userCurrency,
        "package_amount_without_any_discount": packageAmountWithoutAnyDiscount,
        "package_amount_with_coupon_discount": packageAmountWithCouponDiscount,
        "package_amount_with_coupon_with_credit": packageAmountWithCouponWithCredit,
        "package_amount_with_coupon_with_credit_with_other_discounts":
            packageAmountWithCouponWithCreditWithOtherDiscounts,
        "final_selling_amount": finalSellingAmount,
        "pay_full_amount_by_credit": payFullAmountByCredit,
        "pay_partial_amount_by_credit": payPartialAmountByCredit,
        "discounts": discounts.toMap(),
      };
}

class Discounts {
  Discounts({
 required  this.totalDiscount,
 required  this.credit,
 required  this.gamePointsDiscount,
 required  this.coupons,
  });

  Coupons totalDiscount;
  Coupons credit;
  Coupons gamePointsDiscount;
  Coupons coupons;

  factory Discounts.fromMap(Map<String, dynamic> json) => Discounts(
        totalDiscount: Coupons.fromMap(json["total_discount"]),
        credit: Coupons.fromMap(json["credit"]),
        gamePointsDiscount: Coupons.fromMap(json["game_points_discount"]),
        coupons: Coupons.fromMap(json["coupons"]),
      );

  Map<String, dynamic> toMap() => {
        "total_discount": totalDiscount.toMap(),
        "credit": credit.toMap(),
        "game_points_discount": gamePointsDiscount.toMap(),
        "coupons": coupons.toMap(),
      };
}

class Coupons {
  Coupons({
 required  this.currency,
 required  this.amount,
 required  this.userCurrency,
 required  this.userAmount,
  });

  String currency;
  String amount;
  String userCurrency;
  String userAmount;

  factory Coupons.fromMap(Map<String, dynamic> json) => Coupons(
        currency: json["currency"],
        amount: json["amount"],
        userCurrency: json["user_currency"],
        userAmount: json["user_amount"],
      );

  Map<String, dynamic> toMap() => {
        "currency": currency,
        "amount": amount,
        "user_currency": userCurrency,
        "user_amount": userAmount,
      };
}

class UserCredits {
  UserCredits({
  required  this.creditCurrency,
  required  this.creditExisting,
  required  this.creditCanBeUsed,
  required  this.creditBalanceAfterUsage,
  });

  String creditCurrency;
  String creditExisting;
  String creditCanBeUsed;
  String creditBalanceAfterUsage;

  factory UserCredits.fromMap(Map<String, dynamic> json) => UserCredits(
        creditCurrency: json["credit_currency"],
        creditExisting: json["credit_existing"],
        creditCanBeUsed: json["credit_can_be_used"],
        creditBalanceAfterUsage: json["credit_balance_after_usage"],
      );

  Map<String, dynamic> toMap() => {
        "credit_currency": creditCurrency,
        "credit_existing": creditExisting,
        "credit_can_be_used": creditCanBeUsed,
        "credit_balance_after_usage": creditBalanceAfterUsage,
      };
}
