// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromMap(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromMap(String str) => DeleteAccountModel.fromMap(json.decode(str));

String deleteAccountModelToMap(DeleteAccountModel data) => json.encode(data.toMap());

class DeleteAccountModel {
  DeleteAccountModel({
   required this.code,
   required this.error,
   required this.message,
   required this.data,
  });

  final int code;
  final bool error;
  final String message;
  final Data data;

  factory DeleteAccountModel.fromMap(Map<String, dynamic> json) => DeleteAccountModel(
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
  required  this.deactivatedOn,
  required  this.deletionDate,
  required  this.email,
  required  this.remainingDays,
  required  this.supportEmail,
  });

  final String deactivatedOn;
  final String deletionDate;
  final String email;
  final int remainingDays;
  final String supportEmail;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    deactivatedOn: json["deactivated_on"],
    deletionDate: json["deletion_date"],
    email: json["email"],
    remainingDays: json["remaining_days"],
    supportEmail: json["support_email"],
  );

  Map<String, dynamic> toMap() => {
    "deactivated_on": deactivatedOn,
    "deletion_date": deletionDate,
    "email": email,
    "remaining_days": remainingDays,
    "support_email": supportEmail,
  };
}
