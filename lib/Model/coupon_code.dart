// To parse this JSON data, do
//
//     final coupon = couponFromMap(jsonString);

import 'dart:convert';

import 'new_preBookModel/new_prebook_model.dart';

CheckOutModel couponFromMap(String str) => CheckOutModel.fromMap(json.decode(str));

String couponToMap(CheckOutModel data) => json.encode(data.toMap());

class CheckOutModel {
  CheckOutModel({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  num code;
  bool error;
  String message;
  Data data;

  factory CheckOutModel.fromMap(Map<String, dynamic> json) => CheckOutModel(
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
    required this.paymentData,
    this.customizeId,
    this.packageName,
    this.packageStart,
    this.packageEnd,
    this.packageDays,
    this.adults,
    this.children,
    this.paymentDetails,
    this.merchantTransactionId
  });

  PaymentData paymentData;
  String? customizeId;
  String? packageName;
  DateTime? packageStart;
  DateTime? packageEnd;
  num? packageDays;
  num? adults;
  num? children;
  PaymentDetails? paymentDetails;
  String? merchantTransactionId;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        paymentData: PaymentData.fromMap(json["payment_data"]),
        customizeId: json["customize_id"],
        packageName: json["package_name"],
        packageStart: DateTime.parse(json["package_start"]),
        packageEnd: DateTime.parse(json["package_end"]),
        packageDays: json["package_days"],
        adults: json["adults"],
        children: json["children"],
        paymentDetails: PaymentDetails.fromMap(json["payment_details"],),
        merchantTransactionId: json.containsKey("merchantTransactionId")?json["merchantTransactionId"]:null
      );

  Map<String, dynamic> toMap() => {
        "payment_data": paymentData.toMap(),
        "customize_id": customizeId,
        "package_name": packageName,
        "package_start":
            "${packageStart?.year.toString().padLeft(4, '0')}-${packageStart?.month.toString().padLeft(2, '0')}-${packageStart?.day.toString().padLeft(2, '0')}",
        "package_end":
            "${packageEnd?.year.toString().padLeft(4, '0')}-${packageEnd?.month.toString().padLeft(2, '0')}-${packageEnd?.day.toString().padLeft(2, '0')}",
        "package_days": packageDays,
        "adults": adults,
        "children": children,
        "payment_details": paymentDetails?.toMap(),
      };
}

class PaymentData {
  PaymentData(
      {required this.paymentUrl,
      required this.gateway,
      required this.currency,
      required this.transactionFees,
      required this.ibhAmount,
      required this.totalAmount,
      required this.streamApi,
      required this.streamTest});

  String paymentUrl;
  String gateway;
  String currency;
  String transactionFees;
  String ibhAmount;
  String totalAmount;
  String streamApi;
  String streamTest;

  factory PaymentData.fromMap(Map<String, dynamic> json) => PaymentData(
      paymentUrl: json["payment_url"],
      gateway: json["gateway"],
      currency: json["currency"],
      transactionFees: json["transaction_fees"],
      ibhAmount: json["ibh_amount"],
      totalAmount: json["total_amount"],
      streamApi: json["stream_api"],
      streamTest: json["stream_api_test"]);

  Map<String, dynamic> toMap() => {
        "payment_url": paymentUrl,
        "gateway": gateway,
        "currency": currency,
        "transaction_fees": transactionFees,
        "ibh_amount": ibhAmount,
        "total_amount": totalAmount,
        "stream_api": streamApi,
      };
}

class PaymentDetails {
  PaymentDetails({
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

  factory PaymentDetails.fromMap(Map<String, dynamic> json) => PaymentDetails(
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
