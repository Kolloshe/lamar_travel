// To parse required this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.code,
    required this.error,
    required this.message,
    required this.data,
  });

  int code;
  bool error;
  String message;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.status,
      required this.userId,
      required this.language,
      required this.currency,
      required this.mobile,
      required this.profileImage,
      required this.address,
      required this.postalCode,
      required this.country,
      required this.city,
      required this.countryCode,
      required this.cityCode,
      required this.profilePath,
      required this.countries,
      required this.defaultCities,
      required this.passengers,
      required this.phoneCountryCode,
      required this.token,
      required this.creditBalance,
      required this.creditCurrency});

  int id;
  String name;
  String token;
  String lastName;
  String email;
  String phone;
  String creditCurrency;
  String creditBalance;
  int status;
  int userId;
  String language;
  String currency;
  String mobile;
  String profileImage;
  String phoneCountryCode;
  String? address;
  String? postalCode;
  String? country;
  String? city;
  String? countryCode;
  String? cityCode;
  dynamic profilePath;
  List<Countrys>? countries;
  List<DefaultCity>? defaultCities;
  List<Passengers>? passengers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["user_id"],
      name: json["name"],
      lastName: json["last_name"],
      token: json["token"],
      email: json["email"],
      phone: json["phone"],
      status: json["status"],
      userId: json["user_id"],
      creditCurrency: json["credit_currency"],
      creditBalance: json["credit_balance"].toString(),
      language: json["language"],
      currency: json["currency"],
      mobile: json["mobile"],
      profileImage: json["profile_image"],
      phoneCountryCode: json.containsKey('phone_country_code') ? json["phone_country_code"] : "",
      address: json["address"],
      postalCode: json["postal_code"],
      country: json["country"],
      city: json["city"],
      countryCode: json["country_code"],
      cityCode: json["city_code"],
      profilePath: json["profile_path"],
      countries: List<Countrys>.from(json["countries"].map((x) => Countrys.fromJson(x))),
      defaultCities: json["defaultCities"] != null
          ? List<DefaultCity>.from(json["defaultCities"].map((x) => DefaultCity.fromJson(x)))
          : null,
      passengers:
          List<Passengers>.from(json["passengers_details"].map((x) => Passengers.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "status": status,
        "user_id": userId,
        "language": language,
        "currency": currency,
        "mobile": mobile,
        "profile_image": profileImage,
        "credit_currency": creditCurrency,
        "credit_balance": creditBalance,
        "address": address,
        "postal_code": postalCode,
        "country": country,
        "city": city,
        "country_code": countryCode,
        "city_code": cityCode,
        "profile_path": profilePath,
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
        "defaultCities": defaultCities != null
            ? List<dynamic>.from(defaultCities!.map((x) => x.toJson()))
            : null,
      };
}

class Countrys {
  Countrys({
    required this.code,
    required this.name,
    required this.currencyCode,
  });

  String code;
  String name;
  String currencyCode;

  factory Countrys.fromJson(Map<String, dynamic> json) => Countrys(
        code: json["code"],
        name: json["name"],
        currencyCode: json["currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "currency_code": currencyCode,
      };
}

class DefaultCity {
  DefaultCity({
    required this.id,
    required this.name,
    required this.destinationCode,
    required this.countryCode,
  });

  String id;
  String name;
  String destinationCode;
  String countryCode;

  factory DefaultCity.fromJson(Map<String, dynamic> json) => DefaultCity(
        id: json["id"],
        name: json["name"],
        destinationCode: json["destinationCode"],
        countryCode: json["CountryCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "destinationCode": destinationCode,
        "CountryCode": countryCode,
      };
}

class Passengers {
  Passengers({
    required this.id,
    required this.type,
    required this.name,
    required this.surname,
    required this.selectedTitle,
    required this.nationatily,
    required this.birthdate,
    required this.passportNumber,
    required this.passportExpirityDate,
    required this.passportCountryIssued,
    required this.personType,
    required this.phoneCountryCode,
    required this.email,
    required this.phoneNumber,
  });

  int id;
  String? type;
  String name;
  String surname;
  String selectedTitle;
  dynamic nationatily;
  DateTime? birthdate;
  String? passportNumber;
  DateTime? passportExpirityDate;
  dynamic passportCountryIssued;
  String personType;
  String email;
  String phoneNumber;
  String phoneCountryCode;

  factory Passengers.fromJson(Map<String, dynamic> json) => Passengers(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        surname: json["surname"],
        selectedTitle: json["title"],
        nationatily: json["nationality"],
        birthdate: json["date_of_birth"] != null ? DateTime.parse(json["date_of_birth"]) : null,
        passportNumber: json["passport_number"],
        passportExpirityDate:
            json["passport_exp_date"] != null ? DateTime.parse(json["passport_exp_date"]) : null,
        passportCountryIssued: json["country_passport_issued"],
        personType: json["person_type"],
        phoneCountryCode: json["phone_code"] ?? "",
        phoneNumber: json["phone"] ?? "",
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "surname": surname,
        "selected_title": selectedTitle,
        "nationatily": nationatily,
        "birthdate": birthdate != null ? birthdate!.toIso8601String() : null,
        "passport_number": passportNumber,
        "passport_expirity_date":
            passportExpirityDate != null ? passportExpirityDate!.toIso8601String() : null,
        "passport_country_issued": passportCountryIssued,
        "person_type": personType,
        "email": email,
        "phone": phoneNumber,
        "phone_code": phoneCountryCode
      };
}
