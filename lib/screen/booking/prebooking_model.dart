// To parse required this  JSON data, do
//
//     final prebook = prebookFromJson(jsonString);

import 'dart:convert';

Prebook prebookFromJson(String str) => Prebook.fromJson(json.decode(str));

String prebookToJson(Prebook data) => json.encode(data.toJson());

class Prebook {
  Prebook({
    required this.success,
    required this.data,
    required this.creditFlagStatus,
    required this.discountDetails
  });

  bool success;
  Data data;
  CreditFlagStatus creditFlagStatus;
  DiscountDetails discountDetails;

  factory Prebook.fromJson(Map<String, dynamic> json) => Prebook(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        creditFlagStatus: CreditFlagStatus.fromJson(json["creditFlagStatus"]),
    discountDetails: DiscountDetails.fromJson(json["discountDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "creditFlagStatus": creditFlagStatus.toJson(),
    "discountDetails": discountDetails.toJson(),
      };
}

class CreditFlagStatus {
  CreditFlagStatus({
    required this.creditStatusCode,
    required this.initalAmountCurrency,
    required this.initalAmount,
    required this.creditCurrency,
    required this.creditAvailable,
    required this.discountCurrency,
    required this.discountAmount,
    required this.amountAfterCurrency,
    required this.finalAmountCurrency,
    required this.finalAmount,
  });

  int creditStatusCode;
  String initalAmountCurrency;
  String initalAmount;
  String creditCurrency;
  String creditAvailable;
  String discountCurrency;
  String discountAmount;
  String amountAfterCurrency;
  String finalAmountCurrency;
  String finalAmount;

  factory CreditFlagStatus.fromJson(Map<String, dynamic> json) =>
      CreditFlagStatus(
        creditStatusCode: json["creditStatusCode"],
        initalAmountCurrency: json["initalAmountCurrency"],
        initalAmount: json["initalAmount"],
        creditCurrency: json["creditCurrency"],
        creditAvailable: json["creditAvailable"],
        discountCurrency: json["discountCurrency"],
        discountAmount: json["discountAmount"],
        amountAfterCurrency: json["amountAfterCurrency"],
        finalAmountCurrency: json["finalAmountCurrency"],
        finalAmount: json["finalAmount"],
      );

  Map<String, dynamic> toJson() => {
    "creditStatusCode": creditStatusCode,
    "initalAmountCurrency": initalAmountCurrency,
    "initalAmount": initalAmount,
    "creditCurrency": creditCurrency,
    "creditAvailable": creditAvailable,
    "discountCurrency": discountCurrency,
    "discountAmount": discountAmount,
    "amountAfterCurrency": amountAfterCurrency,
    "finalAmountCurrency": finalAmountCurrency,
    "finalAmount": finalAmount,

      };
}

class Data {
  Data({
    required this.message,
    required this.payUrl,
    required this.details,
    required this.holder,
    required this.passengers,
    required this.specialRequest,
    required this.selectedSpecialRequests,
    required this.specialRequestComment,
  });

  String message;
  String payUrl;
  Details details;
  Holder holder;
  List<Passenger>? passengers;
  List<Map<String, bool>> specialRequest;
  List<dynamic> selectedSpecialRequests;
  String specialRequestComment;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        payUrl: json["payUrl"],
        details: Details.fromJson(json["details"]),
        holder: Holder.fromJson(json["holder"]),
        passengers: List<Passenger>.from(
            json["passengers"].map((x) => Passenger.fromJson(x))),
        specialRequest: List<Map<String, bool>>.from(json["specialRequest"].map(
            (x) => Map.from(x).map(
                (k, v) => MapEntry<String, bool>(k, v)))),
        selectedSpecialRequests:
            List<dynamic>.from(json["selectedSpecialRequests"].map((x) => x)),
        specialRequestComment: json["specialRequestComment"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "payUrl": payUrl,
        "details": details.toJson(),
        "holder": holder.toJson(),
        "passengers": List<dynamic>.from(passengers!.map((x) => x.toJson())),
        "specialRequest": List<dynamic>.from(specialRequest.map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, dynamic>(k, v)))),
        "selectedSpecialRequests":
            List<dynamic>.from(selectedSpecialRequests.map((x) => x)),
        "specialRequestComment": specialRequestComment,
      };
}

class Details {
  Details({
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
  List<Hotel>? hotel;
  List<Transfer>? transfer;
  Activities? activities;
  int adultsCount;
  int childrenCount;
  int infantsCount;
  bool noFlights;
  bool noHotels;
  bool noTransfers;
  bool noActivities;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        packageName: json["package_name"],
        packageDays: json["package_days"],
        flight: json["flight"] == null ? null : Flight.fromJson(json["flight"]),
        totalAmount: json["total_amount"],
        hotel: json["hotel"] == null
            ? null
            : List<Hotel>.from(json["hotel"].map((x) => Hotel.fromJson(x))),
        transfer: json["transfer"] == null
            ? null
            : List<Transfer>.from(
                json["transfer"].map((x) => Transfer.fromJson(x))),
        activities: json["activities"] == null
            ? null
            : Activities.fromJson(json["activities"]),
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
        "hotel": List<dynamic>.from(hotel!.map((x) => x.toJson())),
        "transfer": List<dynamic>.from(transfer!.map((x) => x.toJson())),
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
    required this.sellingCurrency,
    required this.maxStop,
    required this.startDate,
    required this.endDate,
    required this.travelData,
  });

  String sellingCurrency;
  int maxStop;
  String startDate;
  String endDate;
  List<TravelDatum> travelData;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        sellingCurrency: json["selling_currency"],
        maxStop: json["max_stop"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        travelData: List<TravelDatum>.from(
            json["travel_data"].map((x) => TravelDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "selling_currency": sellingCurrency,
        "max_stop": maxStop,
        "start_date": startDate,
        "end_date": endDate,
        "travel_data": List<dynamic>.from(travelData.map((x) => x.toJson())),
      };
}

class TravelDatum {
  TravelDatum({
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

  factory TravelDatum.fromJson(Map<String, dynamic> json) => TravelDatum(
        travelTime: json["travel_time"],
        numstops: json["numstops"],
        stops: List<String>.from(json["stops"].map((x) => x)),
        carriers: List<Carrier>.from(
            json["carriers"].map((x) => Carrier.fromJson(x))),
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
        itenerary: List<Itenerary>.from(
            json["itenerary"].map((x) => Itenerary.fromJson(x))),
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

  In transferIn;
  In out;

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
        transferIn: In.fromJson(json["IN"]),
        out: In.fromJson(json["OUT"]),
      );

  Map<String, dynamic> toJson() => {
        "IN": transferIn.toJson(),
        "OUT": out.toJson(),
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

  dynamic code;
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

  String guestId;
  dynamic guestType;
  String guestAgeType;
  String guestTitle;
  String guestName;
  String guestSurame;
  DateTime guestDob;
  String guestPassportIssue;
  String guestPassportNo;
  DateTime? guestPassportExpiry;
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
        guestPassportExpiry: json["guestPassportExpiry"] == null
            ? null
            : DateTime.parse(json["guestPassportExpiry"]),
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
            "${guestPassportExpiry!.year.toString().padLeft(4, '0')}-${guestPassportExpiry!.month.toString().padLeft(2, '0')}-${guestPassportExpiry!.day.toString().padLeft(2, '0')}",
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
class DiscountDetails {
  DiscountDetails({
   required this.gamePoints,
   required this.discountAmount,
   required this.gamePointsCurrency,
   required this.customizeId,
   required this.sellingCurrency,
   required this.amountBeforeDiscount,
   required this.amountAfterDiscount,
  });

  int gamePoints;
  int discountAmount;
  String gamePointsCurrency;
  String customizeId;
  String sellingCurrency;
  int amountBeforeDiscount;
  int amountAfterDiscount;

  factory DiscountDetails.fromJson(Map<String, dynamic> json) => DiscountDetails(
    gamePoints: json["game_points"],
    discountAmount: json["discount_amount"],
    gamePointsCurrency: json["game_points_currency"],
    customizeId: json["customizeId"],
    sellingCurrency: json["sellingCurrency"],
    amountBeforeDiscount: json["amount_before_discount"],
    amountAfterDiscount: json["amount_after_discount"],
  );

  Map<String, dynamic> toJson() => {
    "game_points": gamePoints,
    "discount_amount": discountAmount,
    "game_points_currency": gamePointsCurrency,
    "customizeId": customizeId,
    "sellingCurrency": sellingCurrency,
    "amount_before_discount": amountBeforeDiscount,
    "amount_after_discount": amountAfterDiscount,
  };
}
