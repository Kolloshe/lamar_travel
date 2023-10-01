// ignore_for_file: file_names

import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static final _googleSign = GoogleSignIn();

  static Future googleLogin() async {
    final googleRes = await _googleSign.signIn();
    if (googleRes != null) {
      final authGoogleData = await googleRes.authentication;
      final googleToken = authGoogleData.accessToken;
      if (googleToken != null) {
        Map<String, dynamic> googleData = {
          "social_token": googleToken,
        };
        final finalData = jsonEncode(googleData);
        return finalData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future googleLogOut() async {
    await _googleSign.signOut();
  }
}
