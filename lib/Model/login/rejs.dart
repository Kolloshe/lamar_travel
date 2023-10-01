// // To parse required this JSON data, do
// //
// //     final rej = rejFromJson(jsonString);

// import 'dart:convert';

// Rej rejFromJson(String str) => Rej.fromJson(json.decode(str));

// String rejToJson(Rej data) => json.encode(data.toJson());

// class Rej {
//     Rej({
//         required this.error,
//         required this.message,
//     });

//     bool error;
//     Message message;

//     factory Rej.fromJson(Map<String, dynamic> json) => Rej(
//         error: json["error"],
//         message: Message.fromJson(json["message"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "error": error,
//         "message": message.toJson(),
//     };
// }

// class Message {
//     Message({
//         required this.firstName,
//         required this.lastName,
//         required this.email,
//         required this.token,
//         required this.phoneVerifiedAt,
//     });

//     String firstName;
//     String lastName;
//     String email;
//     String token;
//     int phoneVerifiedAt;

//     factory Message.fromJson(Map<String, dynamic> json) => Message(
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//         token: json["token"],
//         phoneVerifiedAt: json["phone_verified_at"],
//     );

//     Map<String, dynamic> toJson() => {
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//         "token": token,
//         "phone_verified_at": phoneVerifiedAt,
//     };
// }
