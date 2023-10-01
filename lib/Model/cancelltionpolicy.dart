// To parse this JSON data, do
//
//     final cancellationPolicy = cancellationPolicyFromMap(jsonString);

import 'dart:convert';

CancellationPolicy cancellationPolicyFromMap(String str) => CancellationPolicy.fromMap(json.decode(str));

String cancellationPolicyToMap(CancellationPolicy data) => json.encode(data.toMap());

class CancellationPolicy {
    CancellationPolicy({
     required   this.code,
     required   this.error,
     required   this.message,
     required   this.data,
    });

    int code;
    bool error;
    String message;
    Data data;

    factory CancellationPolicy.fromMap(Map<String, dynamic> json) => CancellationPolicy(
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
       required this.cancellationPolicy,
       required this.cancellationReasons,
    });

    CancellationPolicyClass cancellationPolicy;
    List<String> cancellationReasons;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        cancellationPolicy: CancellationPolicyClass.fromMap(json["cancellation_policy"]),
        cancellationReasons: List<String>.from(json["cancellation_reasons"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "cancellation_policy": cancellationPolicy.toMap(),
        "cancellation_reasons": List<dynamic>.from(cancellationReasons.map((x) => x)),
    };
}

class CancellationPolicyClass {
    CancellationPolicyClass({
    required    this.selectedCurrency,
    required    this.totalAmount,
    required    this.purchasedAmount,
    required    this.creditOrVoucherApplied,
    required    this.refundAmount,
    required    this.refundText,
    });

    String selectedCurrency;
    num totalAmount;
    num purchasedAmount;
    num creditOrVoucherApplied;
    num refundAmount;
    String refundText;

    factory CancellationPolicyClass.fromMap(Map<String, dynamic> json) => CancellationPolicyClass(
        selectedCurrency: json["selected_currency"],
        totalAmount: json["total_amount"],
        purchasedAmount: json["purchased_amount"],
        creditOrVoucherApplied: json["credit_or_voucher_applied"],
        refundAmount: json["refund_amount"],
        refundText: json["refund_text"],
    );

    Map<String, dynamic> toMap() => {
        "selected_currency": selectedCurrency,
        "total_amount": totalAmount,
        "purchased_amount": purchasedAmount,
        "credit_or_voucher_applied": creditOrVoucherApplied,
        "refund_amount": refundAmount,
        "refund_text": refundText,
    };
}
