// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api, unused_local_variable, prefer_const_declarations, dead_code, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:lamar_travel_packages/widget/check_connection.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'Assistants/assistant_methods.dart';

import 'Assistants/assistant_data.dart';
import 'Datahandler/app_data.dart';

import 'Model/currencies.dart';
import 'Model/payload.dart';
import 'widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String idScreen = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool isFromdeep = false;

  DataConnectionStatus? internet;

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData? dynamicLink) async {
  //         final Uri deepLink = dynamicLink!.link;
  //         print("deeplink found");
  //         if (deepLink != null) {
  //           print(deepLink);
  //         }
  //       }, onError: (OnLinkErrorException e) async {
  //     print("deeplink error");
  //     print(e.message);
  //   });
  // }

  @override
  void initState() {
    // initDynamicLinks();
    startapp();
    super.initState();
  }

  startapp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String type = Platform.isIOS ? 'ios' : 'android';
    String buildNumber = packageInfo.buildNumber;
    final hasLatestVersion = true;
    //await AssistantMethods.checkVersion(type, buildNumber);
    if (hasLatestVersion) {
      await startTimer();
    } else {
      // Dialogs.materialDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     color: Colors.white,
      //     msg: 'Please update app for enjoying uninterrupted services',
      //     title: 'App update required',
      //     msgStyle: TextStyle(fontSize: 10.sp),
      //     lottieBuilder: Lottie.asset(
      //       'assets/images/loading/updateDialogAnimation.json',
      //       fit: BoxFit.contain,
      //     ),
      //     actions: [
      //       IconsButton(
      //         onPressed: () async {
      //           String url = type == 'ios'
      //               ? 'https://apps.apple.com/app/i-book-holiday/id1601412493'
      //               : 'https://play.google.com/store/apps/details?id=com.ibh.app';

      //           if (await canLaunchUrl(Uri.parse(url))) {
      //             await launchUrl(Uri.parse(url));
      //           }
      //         },
      //         text: 'Update',
      //         color: primaryblue,
      //         textStyle: TextStyle(color: Colors.white),
      //       ),
      //     ]);
    }

    if (kDebugMode) {
      print(buildNumber);
    }
  }

  Future<void> ddynamicLink() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      isFromdeep = true;
if (!mounted) return;
      await AssistantMethods.customizeingFormDeepLink(data.link, context);
    }
    // FirebaseDynamicLinks.instance.onLink(onSuccess: (data) async {
    //   displayTostmessage(context, false, message: data?.link.toString()??"null");
    //   final Uri? deepLinks = data?.link;
    //   if (deepLinks != null) {
    //
    //   }
    // }, onError: (e) async {
    //   displayTostmessage(context, false, message: e.toString());
    //
    // });
  }

  @override
  void dispose() {
    CheckInternet().cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) => Scaffold(
        body: Container(
           color:  const Color.fromARGB(240, 255, 255, 255),
          width: 100.w,
          height: 100.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  top: 15.h,
                  left: 10.w,
                  child: SizedBox(
                    width: 75.w,
                    child: Image.asset(
                      'assets/images/lamarlogo/logo_with_text.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.h,
                  child: SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: const Center(
                        child: ImageSpinning(
                          withOpasity: false,
                        ),
                      )),
                ),
                // Positioned(
                //             bottom: 300,
                //             left: 0.w,
                //             right: 0.w,
                //             child: SizedBox(
                //                 width: 80.w,
                //                 child: Text(baseUrl,
                //                     style: TextStyle(color: Colors.red,fontSize:80,))),
                //           )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> startTimer() async {
    Timer(const Duration(milliseconds: 200), () async {
      final loclaFromLocal = AssistenData.getUserLocal();
      if (loclaFromLocal != null) {
        Provider.of<AppData>(context, listen: false).setLocale(Locale(loclaFromLocal));
      }
      await getaddress();

      await getUserFromLocal();
    });
  }

  getaddress() async {
    try {
      await AssistantMethods.getlocationFromApi(context);
      PayloadElement fromCode = await AssistantMethods.getPayloadFromLocation(context,
          Provider.of<AppData>(context, listen: false).citinameFormApi.toLowerCase().trim());

      Provider.of<AppData>(context, listen: false).getpayloadFromlocation(fromCode);
      Provider.of<AppData>(context, listen: false).getpayloadFrom(fromCode);
    } catch (e) {
      gencurrency = 'SAR';
    }
  }

  getUserFromLocal() async {
    internet = await CheckInternet().checkConnection(context);
    if (internet == DataConnectionStatus.connected) {
      await AssistantMethods.getTrendsAndOffers(
          context, Provider.of<AppData>(context, listen: false).citinameFormApi);
      Currencies? currencies = await AssistantMethods.getCurrency(context);
      if (currencies != null) {
        currencyapi = currencies.currencies!.map((e) => e.code).toList();

      } else {
        currencyapi = [
          'AED',
          'USD',
          'SAR',
          'EUR',
          'KWD',
          'OMR',
          'INR',
          'GBP',
          'QAR',
        ];
      }

      await Provider.of<AppData>(context, listen: false).getUserFromPref(context);

      final popUpData = await AssistantMethods.getPromoPopupData();

      if (popUpData != null) {
        final oldPromoCodeId = AssistenData.getPromoCodeId();

        if (oldPromoCodeId != null) {
          if (popUpData.data != null &&
              popUpData.data!.id != null &&
              oldPromoCodeId != popUpData.data!.id) {
            context.read<AppData>().promoPopupData = popUpData;
            AssistenData.setPromoCodeID(popUpData.data!.id!);
          } else {
            context.read<AppData>().promoPopupData = null;
          }
        } else {
          context.read<AppData>().promoPopupData = popUpData;
          await AssistenData.setPromoCodeID(popUpData.data!.id!);
        }
      }

      await AssistantMethods.getPromotionList(context);
      await ddynamicLink();
      if (!isFromdeep) {
        Navigator.pushNamedAndRemoveUntil(context, TabPage.idScreen, (route) => false);
      }
    } else {
      CheckInternet().checkConnection(context);
    }
  }
}
