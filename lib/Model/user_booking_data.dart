// // To parse required required required this JSON data, do
// //
// //     final userBookingsData = userBookingsDataFromJson(jsonString);

// import 'dart:convert';

// UserBookingsData userBookingsDataFromJson(String str) => UserBookingsData.fromJson(json.decode(str));

// String userBookingsDataToJson(UserBookingsData data) => json.encode(data.toJson());

// class UserBookingsData {
//     UserBookingsData({
//         required required required this.code,
//         required required required this.error,
//         required required required this.message,
//         required required required this.data,
//     });

//     int code;
//     bool error;
//     String message;
//     List<BookingListData> data;

//     factory UserBookingsData.fromJson(Map<String, dynamic> json) => UserBookingsData(
//         code: json["code"],
//         error: json["error"],
//         message: json["message"],
//         data: List<BookingListData>.from(json["data"].map((x) => BookingListData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "error": error,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class BookingListData {
//     BookingListData({
//         required required required this.packageName,
//         required required required this.currency,
//         required required required this.amount,
//         required required required this.expired,
//         required required required this.activeBooking,
//         required required required this.status,
//         required required required this.startDate,
//         required required required this.endDate,
//         required required required this.paxName,
//         required required required this.hotel,
//         required required required this.flight,
//         required required required this.transfer,
//         required required required this.activity,
//         required required required this.bookingNumber,
//         required required required this.rooms,
//         required required required this.bookingDate,
//         required required required this.destination,
//     });

//     String packageName;
//     String currency;
//     String amount;
//     bool expired;
//     bool activeBooking;
//     String status;
//     String startDate;
//     String endDate;
//     String paxName;
//     List<Hotel?>? hotel;
//     List<Activity?>? flight;
//     List<Activity?>? transfer;
//     List<Activity?>? activity;
//     String bookingNumber;
//     List<List<Room>>? rooms;
//     DateTime bookingDate;
//     String destination;

//     factory BookingListData.fromJson(Map<String, dynamic> json) => BookingListData(
//         packageName: json["packageName"],
//         currency: json["currency"],
//         amount: json["amount"],
//         expired: json["expired"],
//         activeBooking: json["activeBooking"],
//         status: json["status"],
//         startDate: json["startDate"],
//         endDate: json["endDate"],
//         paxName: json["paxName"],
//         hotel:  json["hotel"]!=null ?List<Hotel>.from(json["hotel"].map((x) => Hotel.fromJson(x))):null,
//         flight: json["flight"]!=null ?List<Activity>.from(json["flight"].map((x) => Activity.fromJson(x))):null,
//         transfer: json["flight"]!= null ? List<Activity>.from(json["transfer"].map((x) => Activity.fromJson(x))):null,
//         activity:json["activity"]!= null? List<Activity>.from(json["activity"].map((x) => Activity.fromJson(x))):null,
//         bookingNumber: json["bookingNumber"],
//         rooms:json["rooms"]!= null? List<List<Room>>.from(json["rooms"].map((x) => List<Room>.from(x.map((x) => Room.fromJson(x))))):null,
//         bookingDate: DateTime.parse(json["bookingDate"]),
//         destination: json["destination"],
//     );

//     Map<String, dynamic> toJson() => {
//         "packageName": packageName,
//         "currency": currency,
//         "amount": amount,
//         "expired": expired,
//         "activeBooking": activeBooking,
//         "status": status,
//         "startDate": startDate,
//         "endDate": endDate,
//         "paxName": paxName,
//         "hotel":  List<dynamic>.from(hotel!.map((x) => x!.toJson())),
//         "flight": List<dynamic>.from(flight!.map((x) => x!.toJson())),
//         "transfer": List<dynamic>.from(transfer!.map((x) => x!.toJson())),
//         "activity": List<dynamic>.from(activity!.map((x) => x!.toJson())),
//         "bookingNumber": bookingNumber,
//         "rooms": List<dynamic>.from(rooms!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
//         "bookingDate": "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
//         "destination": destination,
//     };
// }

// class Activity {
//     Activity({
//         required required required this.id,
//         required required required this.bookingSectorId,
//         required required required this.bookingMasterId,
//         required required required this.bookingReference,
//         required required required this.supplierReference,
//         required required required this.serviceType,
//         required required required this.serviceName,
//         required required required this.serviceRouteType,
//         required required required this.serviceDescription,
//         required required required this.leadPaxName,
//         required required required this.startDate,
//         required required required this.endDate,
//         required required required this.supplierId,
//         required required required this.payableCurrency,
//         required required required this.sellingCurrency,
//         required required required this.payableToBaseRate,
//         required required required this.sellingToBaseRate,
//         required required required this.payableAmount,
//         required required required this.sellingAmount,
//         required required required this.canceled,
//         required required required this.canceledOn,
//         required required required this.canceledBy,
//         required required required this.approved,
//         required required required this.approvedBy,
//         required required required this.approvedOn,
//         required required required this.bookingStatus,
//         required required required this.comments,
//         required required required this.internalReference,
//         required required required this.newBooking,
//         required required required this.createdAt,
//         required required required this.updatedAt,
//     });

//     int id;
//     String bookingSectorId;
//     String bookingMasterId;
//     String bookingReference;
//     String supplierReference;
//     String serviceType;
//     String serviceName;
//     dynamic serviceRouteType;
//     String serviceDescription;
//     String leadPaxName;
//     String startDate;
//     String endDate;
//     String supplierId;
//     String payableCurrency;
//     String sellingCurrency;
//     String payableToBaseRate;
//     String sellingToBaseRate;
//     String payableAmount;
//     String sellingAmount;
//     String canceled;
//     String canceledOn;
//     String canceledBy;
//     String approved;
//     String approvedBy;
//     String approvedOn;
//     String bookingStatus;
//     String comments;
//     dynamic internalReference;
//     dynamic newBooking;
//     String createdAt;
//     String updatedAt;

//     factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//         id: json["id"],
//         bookingSectorId: json["BookingSectorId"],
//         bookingMasterId: json["BookingMasterId"],
//         bookingReference: json["BookingReference"],
//         supplierReference: json["SupplierReference"],
//         serviceType: json["ServiceType"],
//         serviceName: json["ServiceName"],
//         serviceRouteType: json["ServiceRouteType"],
//         serviceDescription: json["ServiceDescription"],
//         leadPaxName: json["LeadPaxName"],
//         startDate: json["StartDate"],
//         endDate: json["EndDate"],
//         supplierId: json["SupplierId"],
//         payableCurrency: json["PayableCurrency"],
//         sellingCurrency: json["SellingCurrency"],
//         payableToBaseRate: json["PayableToBaseRate"],
//         sellingToBaseRate: json["SellingToBaseRate"],
//         payableAmount: json["PayableAmount"],
//         sellingAmount: json["SellingAmount"],
//         canceled: json["Canceled"],
//         canceledOn: json["CanceledOn"],
//         canceledBy: json["CanceledBy"],
//         approved: json["Approved"],
//         approvedBy: json["ApprovedBy"],
//         approvedOn: json["ApprovedOn"],
//         bookingStatus: json["BookingStatus"],
//         comments: json["Comments"],
//         internalReference: json["InternalReference"],
//         newBooking: json["NewBooking"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "BookingSectorId": bookingSectorId,
//         "BookingMasterId": bookingMasterId,
//         "BookingReference": bookingReference,
//         "SupplierReference": supplierReference,
//         "ServiceType": serviceType,
//         "ServiceName": serviceName,
//         "ServiceRouteType": serviceRouteType,
//         "ServiceDescription": serviceDescription,
//         "LeadPaxName": leadPaxName,
//         "StartDate": startDate,
//         "EndDate": endDate,
//         "SupplierId": supplierId,
//         "PayableCurrency": payableCurrency,
//         "SellingCurrency": sellingCurrency,
//         "PayableToBaseRate": payableToBaseRate,
//         "SellingToBaseRate": sellingToBaseRate,
//         "PayableAmount": payableAmount,
//         "SellingAmount": sellingAmount,
//         "Canceled": canceled,
//         "CanceledOn": canceledOn,
//         "CanceledBy": canceledBy,
//         "Approved": approved,
//         "ApprovedBy": approvedBy,
//         "ApprovedOn": approvedOn,
//         "BookingStatus": bookingStatus,
//         "Comments": comments,
//         "InternalReference": internalReference,
//         "NewBooking": newBooking,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// class Hotel {
//     Hotel({
//         required required required this.id,
//         required required required this.bookingSectorId,
//         required required required this.bookingMasterId,
//         required required required this.bookingReference,
//         required required required this.supplierReference,
//         required required required this.serviceType,
//         required required required this.serviceName,
//         required required required this.serviceRouteType,
//         required required required this.serviceDescription,
//         required required required this.leadPaxName,
//         required required required this.startDate,
//         required required required this.endDate,
//         required required required this.supplierId,
//         required required required this.payableCurrency,
//         required required required this.sellingCurrency,
//         required required required this.payableToBaseRate,
//         required required required this.sellingToBaseRate,
//         required required required this.payableAmount,
//         required required required this.sellingAmount,
//         required required required this.canceled,
//         required required required this.canceledOn,
//         required required required this.canceledBy,
//         required required required this.approved,
//         required required required this.approvedBy,
//         required required required this.approvedOn,
//         required required required this.bookingStatus,
//         required required required this.comments,
//         required required required this.internalReference,
//         required required required this.newBooking,
//         required required required this.createdAt,
//         required required required this.updatedAt,
//         required required required this.hotelBookings,
//     });

//     int id;
//     String bookingSectorId;
//     String bookingMasterId;
//     String bookingReference;
//     String supplierReference;
//     String serviceType;
//     String serviceName;
//     dynamic serviceRouteType;
//     String serviceDescription;
//     String leadPaxName;
//     String startDate;
//     String endDate;
//     String supplierId;
//     String payableCurrency;
//     String sellingCurrency;
//     String payableToBaseRate;
//     String sellingToBaseRate;
//     String payableAmount;
//     String sellingAmount;
//     String canceled;
//     String canceledOn;
//     String canceledBy;
//     String approved;
//     String approvedBy;
//     String approvedOn;
//     String bookingStatus;
//     String comments;
//     dynamic internalReference;
//     dynamic newBooking;
//     String createdAt;
//     String updatedAt;
//     HotelBookings hotelBookings;

//     factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
//         id: json["id"],
//         bookingSectorId: json["BookingSectorId"],
//         bookingMasterId: json["BookingMasterId"],
//         bookingReference: json["BookingReference"],
//         supplierReference: json["SupplierReference"],
//         serviceType: json["ServiceType"],
//         serviceName: json["ServiceName"],
//         serviceRouteType: json["ServiceRouteType"],
//         serviceDescription: json["ServiceDescription"],
//         leadPaxName: json["LeadPaxName"],
//         startDate: json["StartDate"],
//         endDate: json["EndDate"],
//         supplierId: json["SupplierId"],
//         payableCurrency: json["PayableCurrency"],
//         sellingCurrency: json["SellingCurrency"],
//         payableToBaseRate: json["PayableToBaseRate"],
//         sellingToBaseRate: json["SellingToBaseRate"],
//         payableAmount: json["PayableAmount"],
//         sellingAmount: json["SellingAmount"],
//         canceled: json["Canceled"],
//         canceledOn: json["CanceledOn"],
//         canceledBy: json["CanceledBy"],
//         approved: json["Approved"],
//         approvedBy: json["ApprovedBy"],
//         approvedOn: json["ApprovedOn"],
//         bookingStatus: json["BookingStatus"],
//         comments: json["Comments"],
//         internalReference: json["InternalReference"],
//         newBooking: json["NewBooking"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         hotelBookings: HotelBookings.fromJson(json["hotel_bookings"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "BookingSectorId": bookingSectorId,
//         "BookingMasterId": bookingMasterId,
//         "BookingReference": bookingReference,
//         "SupplierReference": supplierReference,
//         "ServiceType": serviceType,
//         "ServiceName": serviceName,
//         "ServiceRouteType": serviceRouteType,
//         "ServiceDescription": serviceDescription,
//         "LeadPaxName": leadPaxName,
//         "StartDate": startDate,
//         "EndDate": endDate,
//         "SupplierId": supplierId,
//         "PayableCurrency": payableCurrency,
//         "SellingCurrency": sellingCurrency,
//         "PayableToBaseRate": payableToBaseRate,
//         "SellingToBaseRate": sellingToBaseRate,
//         "PayableAmount": payableAmount,
//         "SellingAmount": sellingAmount,
//         "Canceled": canceled,
//         "CanceledOn": canceledOn,
//         "CanceledBy": canceledBy,
//         "Approved": approved,
//         "ApprovedBy": approvedBy,
//         "ApprovedOn": approvedOn,
//         "BookingStatus": bookingStatus,
//         "Comments": comments,
//         "InternalReference": internalReference,
//         "NewBooking": newBooking,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "hotel_bookings": hotelBookings.toJson(),
//     };
// }

// class HotelBookings {
//     HotelBookings({
//         required required required this.id,
//         required required required this.bookingId,
//         required required required this.searchId,
//         required required required this.userId,
//         required required required this.reference,
//         required required required this.namePrefix,
//         required required required this.name,
//         required required required this.surname,
//         required required required this.email,
//         required required required this.mobile,
//         required required required this.mainGuestOnly,
//         required required required this.remarks,
//         required required required this.date,
//         required required required this.status,
//         required required required this.payableCurrency,
//         required required required this.payableTotal,
//         required required required this.currency,
//         required required required this.total,
//         required required required this.createdAt,
//         required required required this.updatedAt,
//         required required required this.rooms,
//         required required required this.hotels,
//     });

//     int id;
//     String bookingId;
//     String searchId;
//     String userId;
//     String reference;
//     String namePrefix;
//     String name;
//     String surname;
//     String email;
//     String mobile;
//     String mainGuestOnly;
//     String remarks;
//     DateTime date;
//     String status;
//     String payableCurrency;
//     String payableTotal;
//     String currency;
//     String total;
//     String createdAt;
//     String updatedAt;
//     List<Room> rooms;
//     Hotels hotels;

//     factory HotelBookings.fromJson(Map<String, dynamic> json) => HotelBookings(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         searchId: json["search_id"],
//         userId: json["user_id"],
//         reference: json["reference"],
//         namePrefix: json["name_prefix"] == null ? null : json["name_prefix"],
//         name: json["name"],
//         surname: json["surname"],
//         email: json["email"],
//         mobile: json["mobile"],
//         mainGuestOnly: json["main_guest_only"],
//         remarks: json["remarks"],
//         date: DateTime.parse(json["date"]),
//         status: json["status"],
//         payableCurrency: json["payable_currency"],
//         payableTotal: json["payable_total"],
//         currency: json["currency"],
//         total: json["total"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
//         hotels: Hotels.fromJson(json["hotels"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "search_id": searchId,
//         "user_id": userId,
//         "reference": reference,
//         "name_prefix": namePrefix == null ? null : namePrefix,
//         "name": name,
//         "surname": surname,
//         "email": email,
//         "mobile": mobile,
//         "main_guest_only": mainGuestOnly,
//         "remarks": remarks,
//         "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//         "status": status,
//         "payable_currency": payableCurrency,
//         "payable_total": payableTotal,
//         "currency": currency,
//         "total": total,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
//         "hotels": hotels.toJson(),
//     };
// }

// class Hotels {
//     Hotels({
//         required required required this.id,
//         required required required this.bookingId,
//         required required required this.code,
//         required required required this.name,
//         required required required this.destinationCode,
//         required required required this.destinationName,
//         required required required this.countryCode,
//         required required required this.countryName,
//         required required required this.checkIn,
//         required required required this.checkOut,
//         required required required this.createdAt,
//         required required required this.updatedAt,
//     });

//     int id;
//     String bookingId;
//     String code;
//     String name;
//     String destinationCode;
//     String destinationName;
//     String countryCode;
//     String countryName;
//     DateTime checkIn;
//     DateTime checkOut;
//     String createdAt;
//     String updatedAt;

//     factory Hotels.fromJson(Map<String, dynamic> json) => Hotels(
//         id: json["id"],
//         bookingId: json["booking_id"],
//         code: json["code"],
//         name: json["name"],
//         destinationCode: json["destination_code"],
//         destinationName: json["destination_name"],
//         countryCode: json["country_code"],
//         countryName: json["country_name"],
//         checkIn: DateTime.parse(json["check_in"]),
//         checkOut: DateTime.parse(json["check_out"]),
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_id": bookingId,
//         "code": code,
//         "name": name,
//         "destination_code": destinationCode,
//         "destination_name": destinationName,
//         "country_code": countryCode,
//         "country_name": countryName,
//         "check_in": "${checkIn.year.toString().padLeft(4, '0')}-${checkIn.month.toString().padLeft(2, '0')}-${checkIn.day.toString().padLeft(2, '0')}",
//         "check_out": "${checkOut.year.toString().padLeft(4, '0')}-${checkOut.month.toString().padLeft(2, '0')}-${checkOut.day.toString().padLeft(2, '0')}",
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// class Room {
//     Room({
//         required required required this.id,
//         required required required this.bookingHotelId,
//         required required required this.roomId,
//         required required required this.code,
//         required required required this.name,
//         required required required this.pax,
//         required required required this.status,
//         required required required this.createdAt,
//         required required required this.updatedAt,
//     });

//     int id;
//     String bookingHotelId;
//     String roomId;
//     String code;
//     String name;
//     String pax;
//     String status;
//     String createdAt;
//     String updatedAt;

//     factory Room.fromJson(Map<String, dynamic> json) => Room(
//         id: json["id"],
//         bookingHotelId: json["booking_hotel_id"],
//         roomId: json["room_id"],
//         code: json["code"],
//         name: json["name"],
//         pax: json["pax"],
//         status: json["status"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "booking_hotel_id": bookingHotelId,
//         "room_id": roomId,
//         "code": code,
//         "name": name,
//         "pax": pax,
//         "status": status,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//     };
// }

// To parse required required this JSON data, do
//
//   UserBookingsData  final userBookingsData = userBookingsDataFromJson(jsonString);

// To parse required this JSON data, do
//
//     final userBookingsData = userBookingsDataFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators, unnecessary_null_comparison

import 'dart:convert';

UserBookingsData userBookingsDataFromJson(String str) =>
    UserBookingsData.fromJson(json.decode(str));

String userBookingsDataToJson(UserBookingsData data) => json.encode(data.toJson());

class UserBookingsData {
  UserBookingsData({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  List<BookingListData>? data;

  factory UserBookingsData.fromJson(Map<String, dynamic> json) => UserBookingsData(
        code: json["code"] == null ? null : json["code"],
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<BookingListData>.from(json["data"].map((x) => BookingListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookingListData {
  BookingListData(
      {required this.packageName,
      required this.currency,
      required this.amount,
      required this.expired,
      required this.activeBooking,
      required this.status,
      required this.startDate,
      required this.endDate,
      required this.paxName,
      required this.hotel,
      required this.flight,
      required this.transfer,
      required this.activity,
      required this.bookingNumber,

      //required this.rooms,
      required this.bookingDate,
      required this.destination,
      this.voucherDetails,
      required this.amountPayed,
      required this.discountAmount,
      required this.canCancel,
      required this.creditBalanceUsed});

  String? packageName;
  String? currency;
  String? amount;
  String? amountPayed;
  String? discountAmount;
  String? creditBalanceUsed;
  bool? expired;
  bool? activeBooking;
  String? status;
  String? startDate;
  String? endDate;
  String? paxName;
  List<Hotel>? hotel;
  List<Activity>? flight;
  List<Activity>? transfer;
  List<Activity>? activity;
  String? bookingNumber;

  // List<dynamic>? rooms;
  DateTime? bookingDate;
  String? destination;
  String? voucherDetails;
  bool canCancel;

  factory BookingListData.fromJson(Map<String, dynamic> json) => BookingListData(
      packageName: json["packageName"] == null ? null : json["packageName"],
      currency: json["currency"] == null ? null : json["currency"],
      amount: json["amount"] == null ? null : json["amount"],
      expired: json["expired"] == null ? null : json["expired"],
      activeBooking: json["activeBooking"] == null ? null : json["activeBooking"],
      status: json["status"] == null ? null : json["status"],
      startDate: json["startDate"] == null ? null : json["startDate"],
      endDate: json["endDate"] == null ? null : json["endDate"],
      paxName: json["paxName"] == null ? null : json["paxName"],
      hotel: json["hotel"] == null
          ? null
          : List<Hotel>.from(json["hotel"].map((x) => Hotel.fromJson(x))),
      flight: json["flight"] == null
          ? null
          : List<Activity>.from(json["flight"].map((x) => Activity.fromJson(x))),
      transfer: json["transfer"] == null
          ? null
          : List<Activity>.from(json["transfer"].map((x) => Activity.fromJson(x))),
      activity: json["activity"] == null
          ? null
          : List<Activity>.from(json["activity"].map((x) => Activity.fromJson(x))),
      bookingNumber: json["bookingNumber"] == null ? null : json["bookingNumber"],
      //  rooms: json["rooms"] == null ? null : List<dynamic>.from(json["rooms"].map((x) => x)),
      bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
      destination: json["destination"] == null ? null : json["destination"],
      voucherDetails: json["voucher_details"],
      amountPayed: json["amount_payed"],
      discountAmount: json["discount_amount"],
      canCancel: json.containsKey("can_cancel") ? json['can_cancel'] : true,
      creditBalanceUsed:
          !json.containsKey('credit_balance_used') || json['credit_balance_used'] == null
              ? null
              : json['credit_balance_used']);

  Map<String, dynamic> toJson() => {
        "packageName": packageName == null ? null : packageName,
        "currency": currency == null ? null : currency,
        "amount": amount == null ? null : amount,
        "expired": expired == null ? null : expired,
        "activeBooking": activeBooking == null ? null : activeBooking,
        "status": status == null ? null : status,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "paxName": paxName == null ? null : paxName,
        "hotel": hotel == null ? null : List<dynamic>.from(hotel!.map((x) => x.toJson())),
        "flight": flight == null ? null : List<dynamic>.from(flight!.map((x) => x.toJson())),
        "transfer": transfer == null ? null : List<dynamic>.from(transfer!.map((x) => x.toJson())),
        "activity": activity == null ? null : List<dynamic>.from(activity!.map((x) => x.toJson())),
        "bookingNumber": bookingNumber == null ? null : bookingNumber,
        //  "rooms": rooms == null ? null : List<dynamic>.from(rooms!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "bookingDate": bookingDate == null
            ? null
            : "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
        "destination": destination == null ? null : destination,
        "voucher_details": voucherDetails,
        "amount_payed": amountPayed,
        "discount_amount": discountAmount,
      };
}

class Activity {
  Activity({
    required this.id,
    required this.bookingSectorId,
    required this.bookingMasterId,
    required this.bookingReference,
    required this.supplierReference,
    required this.serviceType,
    required this.serviceName,
    required this.serviceRouteType,
    required this.serviceDescription,
    required this.leadPaxName,
    required this.startDate,
    required this.endDate,
    required this.supplierId,
    required this.payableCurrency,
    required this.sellingCurrency,
    required this.payableToBaseRate,
    required this.sellingToBaseRate,
    required this.payableAmount,
    required this.sellingAmount,
    required this.canceled,
    required this.canceledOn,
    required this.canceledBy,
    required this.approved,
    required this.approvedBy,
    required this.approvedOn,
    required this.bookingStatus,
    required this.comments,
    required this.internalReference,
    required this.newBooking,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? bookingSectorId;
  String? bookingMasterId;
  String? bookingReference;
  String? supplierReference;
  String? serviceType;
  String? serviceName;
  dynamic serviceRouteType;
  String serviceDescription;
  String leadPaxName;
  String startDate;
  String endDate;
  String? supplierId;
  String? payableCurrency;
  String? sellingCurrency;
  String? payableToBaseRate;
  String? sellingToBaseRate;
  String? payableAmount;
  String? sellingAmount;
  String? canceled;
  String? canceledOn;
  String? canceledBy;
  String? approved;
  String? approvedBy;
  String? approvedOn;
  String? bookingStatus;
  String? comments;
  dynamic internalReference;
  dynamic newBooking;
  String createdAt;
  String updatedAt;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"] == null ? null : json["id"],
        bookingSectorId:
            json["BookingSectorId"] == null ? null : json["BookingSectorId"].toString(),
        bookingMasterId:
            json["BookingMasterId"] == null ? null : json["BookingMasterId"].toString(),
        bookingReference:
            json["BookingReference"] == null ? null : json["BookingReference"].toString(),
        supplierReference:
            json["SupplierReference"] == null ? null : json["SupplierReference"].toString(),
        serviceType: json["ServiceType"] == null ? null : json["ServiceType"].toString(),
        serviceName: json["ServiceName"] == null ? null : json["ServiceName"],
        serviceRouteType: json["ServiceRouteType"],
        serviceDescription: json["ServiceDescription"] == null ? null : json["ServiceDescription"],
        leadPaxName: json["LeadPaxName"] == null ? null : json["LeadPaxName"],
        startDate: json["StartDate"] == null ? null : json["StartDate"],
        endDate: json["EndDate"] == null ? null : json["EndDate"],
        supplierId: json["SupplierId"] == null ? null : json["SupplierId"].toString(),
        payableCurrency: json["PayableCurrency"] == null ? null : json["PayableCurrency"],
        sellingCurrency: json["SellingCurrency"] == null ? null : json["SellingCurrency"],
        payableToBaseRate: json["PayableToBaseRate"] == null ? null : json["PayableToBaseRate"],
        sellingToBaseRate: json["SellingToBaseRate"] == null ? null : json["SellingToBaseRate"],
        payableAmount: json["PayableAmount"] == null ? null : json["PayableAmount"].toString(),
        sellingAmount: json["SellingAmount"] == null ? null : json["SellingAmount"].toString(),
        canceled: json["Canceled"] == null ? null : json["Canceled"].toString(),
        canceledOn: json["CanceledOn"] == null ? null : json["CanceledOn"].toString(),
        canceledBy: json["CanceledBy"] == null ? null : json["CanceledBy"].toString(),
        approved: json["Approved"] == null ? null : json["Approved"].toString(),
        approvedBy: json["ApprovedBy"] == null ? null : json["ApprovedBy"].toString(),
        approvedOn: json["ApprovedOn"] == null ? null : json["ApprovedOn"],
        bookingStatus: json["BookingStatus"] == null ? null : json["BookingStatus"].toString(),
        comments: json["Comments"] == null ? null : json["Comments"],
        internalReference: json["InternalReference"],
        newBooking: json["NewBooking"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "BookingSectorId": bookingSectorId == null ? null : bookingSectorId,
        "BookingMasterId": bookingMasterId == null ? null : bookingMasterId,
        "BookingReference": bookingReference == null ? null : bookingReference,
        "SupplierReference": supplierReference == null ? null : supplierReference,
        "ServiceType": serviceType == null ? null : serviceType,
        "ServiceName": serviceName == null ? null : serviceName,
        "ServiceRouteType": serviceRouteType,
        "ServiceDescription": serviceDescription == null ? null : serviceDescription,
        "LeadPaxName": leadPaxName == null ? null : leadPaxName,
        "StartDate": startDate == null ? null : startDate,
        "EndDate": endDate == null ? null : endDate,
        "SupplierId": supplierId == null ? null : supplierId,
        "PayableCurrency": payableCurrency == null ? null : payableCurrency,
        "SellingCurrency": sellingCurrency == null ? null : sellingCurrency,
        "PayableToBaseRate": payableToBaseRate == null ? null : payableToBaseRate,
        "SellingToBaseRate": sellingToBaseRate == null ? null : sellingToBaseRate,
        "PayableAmount": payableAmount == null ? null : payableAmount,
        "SellingAmount": sellingAmount == null ? null : sellingAmount,
        "Canceled": canceled == null ? null : canceled,
        "CanceledOn": canceledOn == null ? null : canceledOn,
        "CanceledBy": canceledBy == null ? null : canceledBy,
        "Approved": approved == null ? null : approved,
        "ApprovedBy": approvedBy == null ? null : approvedBy,
        "ApprovedOn": approvedOn == null ? null : approvedOn,
        "BookingStatus": bookingStatus == null ? null : bookingStatus,
        "Comments": comments == null ? null : comments,
        "InternalReference": internalReference,
        "NewBooking": newBooking,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class Hotel {
  Hotel({
    required this.id,
    required this.bookingSectorId,
    required this.bookingMasterId,
    required this.bookingReference,
    required this.supplierReference,
    required this.serviceType,
    required this.serviceName,
    required this.serviceRouteType,
    required this.serviceDescription,
    required this.leadPaxName,
    required this.startDate,
    required this.endDate,
    required this.supplierId,
    required this.payableCurrency,
    required this.sellingCurrency,
    required this.payableToBaseRate,
    required this.sellingToBaseRate,
    required this.payableAmount,
    required this.sellingAmount,
    required this.canceled,
    required this.canceledOn,
    required this.canceledBy,
    required this.approved,
    required this.approvedBy,
    required this.approvedOn,
    required this.bookingStatus,
    required this.comments,
    required this.internalReference,
    required this.newBooking,
    required this.createdAt,
    required this.updatedAt,
    required this.hotelBookings,
  });

  int? id;
  String? bookingSectorId;
  String? bookingMasterId;
  String? bookingReference;
  String? supplierReference;
  String? serviceType;
  String? serviceName;
  dynamic serviceRouteType;
  String? serviceDescription;
  String? leadPaxName;
  String? startDate;
  String? endDate;
  String? supplierId;
  String? payableCurrency;
  String? sellingCurrency;
  String? payableToBaseRate;
  String? sellingToBaseRate;
  String? payableAmount;
  String? sellingAmount;
  String? canceled;
  String? canceledOn;
  String? canceledBy;
  String? approved;
  String? approvedBy;
  String? approvedOn;
  String? bookingStatus;
  String? comments;
  dynamic internalReference;
  dynamic newBooking;
  String? createdAt;
  String? updatedAt;
  HotelBookings? hotelBookings;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"] == null ? null : json["id"],
        bookingSectorId:
            json["BookingSectorId"] == null ? null : json["BookingSectorId"].toString(),
        bookingMasterId:
            json["BookingMasterId"] == null ? null : json["BookingMasterId"].toString(),
        bookingReference: json["BookingReference"] == null ? null : json["BookingReference"],
        supplierReference: json["SupplierReference"] == null ? null : json["SupplierReference"],
        serviceType: json["ServiceType"] == null ? null : json["ServiceType"].toString(),
        serviceName: json["ServiceName"] == null ? null : json["ServiceName"],
        serviceRouteType: json["ServiceRouteType"],
        serviceDescription: json["ServiceDescription"] == null ? null : json["ServiceDescription"],
        leadPaxName: json["LeadPaxName"] == null ? null : json["LeadPaxName"],
        startDate: json["StartDate"] == null ? null : json["StartDate"],
        endDate: json["EndDate"] == null ? null : json["EndDate"],
        supplierId: json["SupplierId"] == null ? null : json["SupplierId"].toString(),
        payableCurrency: json["PayableCurrency"] == null ? null : json["PayableCurrency"],
        sellingCurrency: json["SellingCurrency"] == null ? null : json["SellingCurrency"],
        payableToBaseRate: json["PayableToBaseRate"] == null ? null : json["PayableToBaseRate"],
        sellingToBaseRate: json["SellingToBaseRate"] == null ? null : json["SellingToBaseRate"],
        payableAmount: json["PayableAmount"] == null ? null : json["PayableAmount"].toString(),
        sellingAmount: json["SellingAmount"] == null ? null : json["SellingAmount"].toString(),
        canceled: json["Canceled"] == null ? null : json["Canceled"].toString(),
        canceledOn: json["CanceledOn"] == null ? null : json["CanceledOn"],
        canceledBy: json["CanceledBy"] == null ? null : json["CanceledBy"].toString(),
        approved: json["Approved"] == null ? null : json["Approved"].toString(),
        approvedBy: json["ApprovedBy"] == null ? null : json["ApprovedBy"].toString(),
        approvedOn: json["ApprovedOn"] == null ? null : json["ApprovedOn"],
        bookingStatus: json["BookingStatus"] == null ? null : json["BookingStatus"].toString(),
        comments: json["Comments"] == null ? null : json["Comments"],
        internalReference: json["InternalReference"],
        newBooking: json["NewBooking"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        hotelBookings:
            json["hotel_bookings"] == null ? null : HotelBookings.fromJson(json["hotel_bookings"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "BookingSectorId": bookingSectorId == null ? null : bookingSectorId,
        "BookingMasterId": bookingMasterId == null ? null : bookingMasterId,
        "BookingReference": bookingReference == null ? null : bookingReference,
        "SupplierReference": supplierReference == null ? null : supplierReference,
        "ServiceType": serviceType == null ? null : serviceType,
        "ServiceName": serviceName == null ? null : serviceName,
        "ServiceRouteType": serviceRouteType,
        "ServiceDescription": serviceDescription == null ? null : serviceDescription,
        "LeadPaxName": leadPaxName == null ? null : leadPaxName,
        "StartDate": startDate == null ? null : startDate,
        "EndDate": endDate == null ? null : endDate,
        "SupplierId": supplierId == null ? null : supplierId,
        "PayableCurrency": payableCurrency == null ? null : payableCurrency,
        "SellingCurrency": sellingCurrency == null ? null : sellingCurrency,
        "PayableToBaseRate": payableToBaseRate == null ? null : payableToBaseRate,
        "SellingToBaseRate": sellingToBaseRate == null ? null : sellingToBaseRate,
        "PayableAmount": payableAmount == null ? null : payableAmount,
        "SellingAmount": sellingAmount == null ? null : sellingAmount,
        "Canceled": canceled == null ? null : canceled,
        "CanceledOn": canceledOn == null ? null : canceledOn,
        "CanceledBy": canceledBy == null ? null : canceledBy,
        "Approved": approved == null ? null : approved,
        "ApprovedBy": approvedBy == null ? null : approvedBy,
        "ApprovedOn": approvedOn == null ? null : approvedOn,
        "BookingStatus": bookingStatus == null ? null : bookingStatus,
        "Comments": comments == null ? null : comments,
        "InternalReference": internalReference,
        "NewBooking": newBooking,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "hotel_bookings": hotelBookings == null ? null : hotelBookings!.toJson(),
      };
}

class HotelBookings {
  HotelBookings({
    required this.id,
    required this.bookingId,
    required this.searchId,
    required this.userId,
    required this.reference,
    required this.namePrefix,
    required this.name,
    required this.surname,
    required this.email,
    required this.mobile,
    required this.mainGuestOnly,
    required this.remarks,
    required this.date,
    required this.status,
    required this.payableCurrency,
    required this.payableTotal,
    required this.currency,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.rooms,
    required this.hotels,
  });

  int? id;
  String? bookingId;
  String? searchId;
  String? userId;
  String? reference;
  String? namePrefix;
  String? name;
  String? surname;
  String? email;
  String? mobile;
  String? mainGuestOnly;
  String? remarks;
  DateTime? date;
  String? status;
  String? payableCurrency;
  String? payableTotal;
  String? currency;
  String? total;
  String? createdAt;
  String? updatedAt;
  List<Room>? rooms;
  Hotels? hotels;

  factory HotelBookings.fromJson(Map<String, dynamic> json) => HotelBookings(
        id: json["id"] == null ? null : json["id"],
        bookingId: json["booking_id"] == null ? null : json["booking_id"].toString(),
        searchId: json["search_id"] == null ? null : json["search_id"].toString(),
        userId: json["user_id"] == null ? null : json["user_id"],
        reference: json["reference"] == null ? null : json["reference"],
        namePrefix: json["name_prefix"] == null ? null : json["name_prefix"],
        name: json["name"] == null ? null : json["name"],
        surname: json["surname"] == null ? null : json["surname"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        mainGuestOnly: json["main_guest_only"] == null ? null : json["main_guest_only"].toString(),
        remarks: json["remarks"] == null ? null : json["remarks"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"] == null ? null : json["status"],
        payableCurrency: json["payable_currency"] == null ? null : json["payable_currency"],
        payableTotal: json["payable_total"] == null ? null : json["payable_total"],
        currency: json["currency"] == null ? null : json["currency"],
        total: json["total"] == null ? null : json["total"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        rooms: json["rooms"] == null
            ? null
            : List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        hotels: json["hotels"] == null ? null : Hotels.fromJson(json["hotels"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "booking_id": bookingId == null ? null : bookingId,
        "search_id": searchId == null ? null : searchId,
        "user_id": userId == null ? null : userId,
        "reference": reference == null ? null : reference,
        "name_prefix": namePrefix == null ? null : namePrefix,
        "name": name == null ? null : name,
        "surname": surname == null ? null : surname,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "main_guest_only": mainGuestOnly == null ? null : mainGuestOnly,
        "remarks": remarks == null ? null : remarks,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "payable_currency": payableCurrency == null ? null : payableCurrency,
        "payable_total": payableTotal == null ? null : payableTotal,
        "currency": currency == null ? null : currency,
        "total": total == null ? null : total,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "rooms": rooms == null ? null : List<dynamic>.from(rooms!.map((x) => x.toJson())),
        "hotels": hotels == null ? null : hotels!.toJson(),
      };
}

class Hotels {
  Hotels({
    required this.id,
    required this.bookingId,
    required this.code,
    required this.name,
    required this.destinationCode,
    required this.destinationName,
    required this.countryCode,
    required this.countryName,
    required this.checkIn,
    required this.checkOut,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? bookingId;
  String? code;
  String? name;
  String? destinationCode;
  String? destinationName;
  String? countryCode;
  String? countryName;
  DateTime? checkIn;
  DateTime? checkOut;
  String? createdAt;
  String? updatedAt;

  factory Hotels.fromJson(Map<String, dynamic> json) => Hotels(
        id: json["id"] == null ? null : json["id"],
        bookingId: json["booking_id"] == null ? null : json["booking_id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        destinationCode: json["destination_code"] == null ? null : json["destination_code"],
        destinationName: json["destination_name"] == null ? null : json["destination_name"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        countryName: json["country_name"] == null ? null : json["country_name"],
        checkIn: json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null ? null : DateTime.parse(json["check_out"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "booking_id": bookingId == null ? null : bookingId,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "destination_code": destinationCode == null ? null : destinationCode,
        "destination_name": destinationName == null ? null : destinationName,
        "country_code": countryCode == null ? null : countryCode,
        "country_name": countryName == null ? null : countryName,
        "check_in": checkIn == null
            ? null
            : "${checkIn!.year.toString().padLeft(4, '0')}-${checkIn!.month.toString().padLeft(2, '0')}-${checkIn!.day.toString().padLeft(2, '0')}",
        "check_out": checkOut == null
            ? null
            : "${checkOut!.year.toString().padLeft(4, '0')}-${checkOut!.month.toString().padLeft(2, '0')}-${checkOut!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class Room {
  Room({
    required this.id,
    required this.bookingHotelId,
    required this.roomId,
    required this.code,
    required this.name,
    required this.pax,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? bookingHotelId;
  String? roomId;
  String? code;
  String? name;
  String? pax;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"] == null ? null : json["id"],
        bookingHotelId: json["booking_hotel_id"] == null ? null : json["booking_hotel_id"],
        roomId: json["room_id"] == null ? null : json["room_id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        pax: json["pax"] == null ? null : json["pax"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "booking_hotel_id": bookingHotelId == null ? null : bookingHotelId,
        "room_id": roomId == null ? null : roomId,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "pax": pax == null ? null : pax,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
