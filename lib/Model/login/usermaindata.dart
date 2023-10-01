// import 'package:lamar_travel_packages/Model/login/user_from_pref.dart';
// import 'package:lamar_travel_packages/screen/booking/prebooking_model.dart';

// class MainUserData {
//   MainUserData({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.token,
//     required this.phoneVerifiedAt,
//     this.passengers,
//   });

//   String firstName;
//   String lastName;
//   String email;
//   String token;
//   List<Passengers>? passengers;
//   int phoneVerifiedAt;

//   factory MainUserData.fromJson(Map<String, dynamic> json) => MainUserData(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         token: json["token"],
//         phoneVerifiedAt: json["phone_verified_at"],
//         passengers: json["passengers"] == null
//             ? null
//             : List<Passengers>.from(
//                 json["passengers"].map((x) => Passengers.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "token": token,
//         "phone_verified_at": phoneVerifiedAt,
//       };
// }
