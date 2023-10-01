// // To parse required this JSON data, do
// //
// //     final userFromPref = userFromPrefFromJson(jsonString);

// import 'dart:convert';

// UserFromPref userFromPrefFromJson(String str) => UserFromPref.fromJson(json.decode(str));

// String userFromPrefToJson(UserFromPref data) => json.encode(data.toJson());

// class UserFromPref {
//     UserFromPref({
//         required this.loginError,
//         required this.token,
//         required this.name,
//         required this.lastName,
//         required this.email,
//         required this.phone,
//         required this.phoneVerifiedAt,
//          this.passengers,
//         required this.provider,
//     });

//     bool loginError;
//     String token;
//     String name;
//     String lastName;
//     String email;
//     String phone;
//     List<dynamic> phoneVerifiedAt;
//     List<Passengers>? passengers;
//     Providers provider;

//     factory UserFromPref.fromJson(Map<String, dynamic> json) => UserFromPref(
//         loginError: json["login_error"],
//         token: json["token"],
//         name: json["name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         phone: json["phone"],
//         phoneVerifiedAt: List<dynamic>.from(json["phone_verified_at"].map((x) => x)),
//         passengers:json["passengers"] == null ? null : List<Passengers>.from(json["passengers"].map((x) => Passengers.fromJson(x))),
//         provider: Providers.fromJson(json["provider"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "login_error": loginError,
//         "token": token,
//         "name": name,
//         "last_name": lastName,
//         "email": email,
//         "phone": phone,
//         "phone_verified_at": List<dynamic>.from(phoneVerifiedAt.map((x) => x)),
//         "passengers": List<dynamic>.from(passengers!.map((x) => x)),
//         "provider": provider.toJson(),
//     };
// }

// class Passengers {
//     Passengers({
//        required this.id,
//        required this.type,
//        required this.name,
//        required this.surname,
//        required this.selectedTitle,
//        required this.nationatily,
//        required this.birthdate,
//        required this.passportNumber,
//        required this.passportExpirityDate,
//        required this.passportCountryIssued,
//        required this.personType,
//     });

//     int id;
//     dynamic type;
//     String name;
//     String surname;
//     String selectedTitle;
//     dynamic nationatily;
//     DateTime birthdate;
//     String passportNumber;
//     DateTime passportExpirityDate;
//     dynamic passportCountryIssued;
//     String personType;

//     factory Passengers.fromJson(Map<String, dynamic> json) => Passengers(
//         id: json["id"],
//         type: json["type"],
//         name: json["name"],
//         surname: json["surname"],
//         selectedTitle: json["selected_title"],
//         nationatily: json["nationatily"],
//         birthdate: DateTime.parse(json["birthdate"]),
//         passportNumber: json["passport_number"],
//         passportExpirityDate: DateTime.parse(json["passport_expirity_date"]),
//         passportCountryIssued: json["passport_country_issued"],
//         personType: json["person_type"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "name": name,
//         "surname": surname,
//         "selected_title": selectedTitle,
//         "nationatily": nationatily,
//         "birthdate": birthdate.toIso8601String(),
//         "passport_number": passportNumber,
//         "passport_expirity_date": passportExpirityDate.toIso8601String(),
//         "passport_country_issued": passportCountryIssued,
//         "person_type": personType,
//     };
// }


// class Providers {
//     Providers({
//         required this.hotel,
//         required this.transfer,
//     });

//     String hotel;
//     String transfer;

//     factory Providers.fromJson(Map<String, dynamic> json) => Providers(
//         hotel: json["hotel"],
//         transfer: json["transfer"],
//     );

//     Map<String, dynamic> toJson() => {
//         "hotel": hotel,
//         "transfer": transfer,
//     };
// }
