// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/splash_screen.dart';

class CheckInternet {
  StreamSubscription<DataConnectionStatus>? listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(title: const Text(''), content: Text(content), actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(SplashScreen.idScreen);
                },
                child: const Text("Close"))
          ]);
        });
  }

  Future<DataConnectionStatus> checkConnection(BuildContext context) async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection";
          _showDialog(internetStatus, contentmessage, context);
          //  Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.idScreen, (route) => false);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  void cancel() {
    if (listener != null) {
      listener!.cancel();
    }
  }
}
