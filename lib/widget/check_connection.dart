// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/splash_screen.dart';

import '../main.dart';

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
            // TextButton(
            //     onPressed: () {
            //       // print('HERE');
            //       //   RestartWidget.restartApp(context);
            //       //  Navigator.of(context).pushReplacementNamed(SplashScreen.idScreen);

            //       // Navigator.of(context)
            //       //     .push(MaterialPageRoute(builder: (context) => SplashScreen()));
            //     },
            //     child: const Text("Close"))
          ]);
        });
  }

  bool isConnected = false;
  Future<DataConnectionStatus> checkConnection(BuildContext context) async {
    print("BEFOR LISTEN :  ");

    listener = DataConnectionChecker().onStatusChange.listen((status) {
      print("LISTEN :  ");
      switch (status) {
        case DataConnectionStatus.connected:
          if (isConnected) {
            Navigator.of(context).canPop()
                ? Navigator.pop(context)
                : Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                    (route) => false);
            isConnected = false;
          } else {
            isConnected = true;
          }

          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection and open the app again ";
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
