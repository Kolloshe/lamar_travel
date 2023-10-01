// // To parse required this JSON data, do
// //
// //     final login = loginFromJson(jsonString);

// import 'dart:convert';

// import 'package:lamar_travel_packages/Model/login/user_from_pref.dart';
// import 'package:lamar_travel_packages/screen/booking/prebooking_model.dart';

// Login loginFromJson(String str) => Login.fromJson(json.decode(str));

// String loginToJson(Login data) => json.encode(data.toJson());

// class Login {
//   Login({
//     required this.error,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.phone,
//     required this.currency,
//     required this.language,
//     required this.token,
//     required this.phoneVerifiedAt,
//     this.passengers,
//   });

//   bool error;
//   String firstName;
//   String lastName;
//   String email;
//   String phone;
//   String currency;
//   String language;
//   String token;
//   int phoneVerifiedAt;
//   List<Passengers>? passengers;

//   factory Login.fromJson(Map<String, dynamic> json) => Login(
//         error: json["error"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         phone: json["phone"],
//         currency: json["currency"],
//         language: json["language"],
//         token: json["token"],
//         phoneVerifiedAt: json["phone_verified_at"],
//         passengers: json["passengers"] == null && json["passengers"] == []
//             ? null
//             : List<Passengers>.from(
//                 json["passengers"].map((x) => Passengers.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "phone": phone,
//         "currency": currency,
//         "language": language,
//         "token": token,
//         "phone_verified_at": phoneVerifiedAt,
//         "passengers": passengers == null
//             ? null
//             : List<dynamic>.from(passengers!.map((x) => x.toJson())),
//       };
// }
