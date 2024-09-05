// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/splash_screen.dart';

class CheckInternet {
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";
  StreamSubscription<InternetConnectionStatus>? listener;

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(title: const Text(''), content: Text(content), actions: const [
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
  Future<InternetConnectionStatus> checkConnection(BuildContext context) async {
    InternetConnectionStatus internetState = InternetConnectionStatus.connected;
    print("BEFOR LISTEN :  ");

    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // Navigator.of(context).canPop()
      //     ? Navigator.pop(context)
      //     : Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(builder: (context) => const SplashScreen()), (route) => false);
      isConnected = false;
    } else {
      internetStatus = "You are disconnected to the Internet. ";
      contentmessage = "Please check your internet connection and open the app again ";
      _showDialog(internetStatus, contentmessage, context);
    }

    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
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
          internetState = InternetConnectionStatus.connected;
          break;
        case InternetConnectionStatus.disconnected:
          internetState = InternetConnectionStatus.disconnected;
          internetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection and open the app again ";
          _showDialog(internetStatus, contentmessage, context);
          //  Navigator.of(context).pushNamedAndRemoveUntil(SplashScreen.idScreen, (route) => false);
          break;
      }
    });
    Future.delayed(const Duration(seconds: 30), () async {
      // await listener.cancel();
    });
    print('here');
    return internetState;
    // close listener after 30 seconds, so the program doesn't run forever
  }

  void cancel() {
    if (listener != null) {
      listener!.cancel();
    }
  }
}
