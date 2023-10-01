import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/splash_screen.dart';
import 'package:rive/rive.dart';

import '../config.dart';

class MaintenanceMode {
  static Future showMaintenanceDialog(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            RiveAnimationController controller = SimpleAnimation('show');
            return Dialog(
              child: Stack(
                children: [
                  Positioned(
                      bottom: 6,
                      right: 10,
                      child: Opacity(
                          opacity: 0.2,
                          child: Image.asset(
                            'assets/images/loader-aiwa.png',
                            width: 40,
                          ))),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.transparent),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.5,
                            child: RiveAnimation.asset(
                              'assets/images/vectors/alert_icon.riv',
                              controllers: [controller],
                              onInit: (_) => setState(() {}),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              'We are making something special for you.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: 1),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "And we can't wait for you to book it ",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "please check back soon",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    SplashScreen.idScreen, (route) => false);
                              },
                              child: const Text('Back'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      )),
                ],
              ),
            );
          }));
}
