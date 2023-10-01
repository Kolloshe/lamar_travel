// ignore_for_file: file_names, avoid_init_to_null, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lamar_travel_packages/Assistants/assistant_data.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/delete_account_model.dart';
import 'package:lamar_travel_packages/Model/login/user.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/errordialog.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuth {
  static appleSignAuth<bool>(BuildContext context) async {
    dynamic window = null;
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.ibh.app',
        redirectUri: kIsWeb
            ? Uri.parse('https://${window.location.host}/')
            : Uri.parse(
                'https://mapi2.ibookholiday.com/api/v1/user/social-auth/apple',
              ),
      ),
    );
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'mapi2.ibookholiday.com',
      path: '/api/v1/user/social-auth/apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null) 'firstName': credential.givenName!,
        if (credential.familyName != null) 'lastName': credential.familyName!,
        'useBundleId': !kIsWeb && (Platform.isIOS || Platform.isMacOS) ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );


    if (session.statusCode == 200) {
      final userlogedin = userFromJson(session.body);

      Provider.of<AppData>(context, listen: false).getUser(userlogedin);
      await AssistenData.setUserdata(userlogedin.data.token);
      await AssistenData.setUserLoginProvider();
      return true;
    } else if (session.statusCode == 403) {
      final deleteAccountModel = deleteAccountModelFromMap(session.body);
      await showDialog(
        context: context,
        builder: (context) => const Errordislog().error(
            context,
            AppLocalizations.of(context)!.loginDeactivated(
                deleteAccountModel.data.deactivatedOn,
                deleteAccountModel.data.remainingDays.toString(),
                deleteAccountModel.data.deletionDate,
                deleteAccountModel.data.supportEmail)),
      );
      return false;
    } else {
      final error = jsonDecode(session.body);
      displayTostmessage(context, true, message: error["message"]);
      return false;
    }
  }
}
