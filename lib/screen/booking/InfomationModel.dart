

// To parse required this JSON data, do
//
//     final forms = formsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

Forms formsFromJson(String str) => Forms.fromJson(json.decode(str));

String formsToJson(Forms data) => json.encode(data.toJson());

class Forms {
  Forms({
    required this.id,
    required this.ageType,
    required this.type,
    required this.firstName,
    required this.surname,
    required this.dateofbirth,
    required this.passportissuedcountry,
    required this.passportnumber,
    required this.passportexpirydate,
    required this.nationality,
    required this.holderType,
    required this.email,
    required this.phone
  });
  dynamic id;
  String type;
  String ageType;
  String firstName;
  String surname;
  String dateofbirth;
  String passportissuedcountry;
  String passportnumber;
  String passportexpirydate;
  String nationality;
  String holderType;
  String email;
  String phone;


  factory Forms.fromJson(Map<String, dynamic> json) => Forms(
    id: json["id"],
        ageType: json["guestAgeType"],
        type: json["selected_title"],
        firstName: json["FirstName"],
        surname: json["Surname"],
        dateofbirth: json["Dateofbirth"],
        passportissuedcountry: json["Passportissuedcountry"],
        passportnumber: json["Passportnumber"],
        passportexpirydate: json["Passportexpirydate"],
        nationality: json["Nationality"],
        holderType: json.containsKey("type")?json["type"]:'',
        email:  json.containsKey('email')?json["email"]:'',
      phone :json.containsKey("phone")?json["phone"]:""
      );

  Map<String, dynamic> toJson() => {
        "type":"holder",
        "guestId": id,
        "guestType": "",
        "guestAgeType": ageType,
        "guestTitle": type,
        "guestName": firstName,
        "guestSurame": surname,
        "guestDob": dateofbirth,
        "guestPassportIssue": passportissuedcountry,
        "guestPassportNo": passportnumber,
        "guestPassportExpiry": passportexpirydate,
        "guestNationality": nationality,
    "email":email,
    "phone":phone
      };
}
