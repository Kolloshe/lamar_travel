// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/booking/paymentview.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/setting/my-bookinglist.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config.dart';
import '../customize/new-customize/new_customize.dart';

class PaymentViewForCoin extends StatefulWidget {
  const PaymentViewForCoin({Key? key, required this.url, required this.duration, required this.id})
      : super(key: key);
  final String url;
  final String id;

  final Duration duration;

  @override
  _PaymentViewForCoinState createState() => _PaymentViewForCoinState();
}

class _PaymentViewForCoinState extends State<PaymentViewForCoin> {
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };
  late WebViewController controller;

  double showWebView = 1.0;
  bool hideTimer = false;

  final _controller = StreamController<Response>();

  getdata() async {
    context.read<AppData>().getCoinPaymentStatus = {};
    await AssistantMethods.tryThis(context, widget.id);
  }

  @override
  void initState() {
    _controller.addStream(AssistantMethods.coinPaymentStreaming(widget.id));
    if (Platform.isAndroid) if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getdata();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: cardcolor,
            title: Text(
              AppLocalizations.of(context)!.payment,
              style: TextStyle(color: blackTextColor),
            ),
            leading: GestureDetector(
                onTap: () async {
                  final valid = await controller.canGoBack();
                  if (valid) {
                    await controller.goBack();
                  }
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: primaryblue,
                )),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
                child: hideTimer
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(10),
                        height: 48.0,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)?.countdownConfirm ?? ' Time to confirm ',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SlideCountdownSeparated(
                              duration: widget.duration,
                              showZeroValue: false,
                              countUp: false,
                              onChanged: (d) {},
                              onDone: () {
                                // 'end and you will redirect to customize phase ';
                                setState(() {});
                                // Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )),
              ),
            ),
          ),
          body: Consumer<AppData>(builder: (context, data, child) {
            switch (data.switchThePaymentResponse()) {
              case 0:
                Future.delayed(const Duration(seconds: 1), () {
                  hideTimer = false;
                  setState(() {});
                });

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Opacity(
                      opacity: showWebView,
                      child: WebView(
                        key: Keyz.riKey2,
                        gestureRecognizers: gestureRecognizers,
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: widget.url,
                        onWebViewCreated: (controller) {
                          this.controller = controller;
                        },
                        onProgress: (i) {},
                        onPageStarted: (v) async {
                          if (v.contains('ethereum:') ||
                              v.contains('bitcoin:') ||
                              v.contains('dogecoin:') ||
                              v.contains('litecoin:') ||
                              v.contains('bitcoincash:') ||
                              v.contains('usdcoint:') ||
                              v.contains('dai:') ||
                              v.contains('apecoin:') ||
                              v.contains('shibainu:') ||
                              v.contains('terther:')) {
                            if (await canLaunchUrl(Uri.parse(v))) {
                              launchUrl(Uri.parse(v));
                            } else {
                              if (!mounted) return;
                              displayTostmessage(context, false,
                                  isInformation: true,
                                  message:
                                      "we couldn't  find a wallet , \nyou can ues address to complete the payment");
                            }
                          }
                          //     pressIndcatorDialog(context);
                        },
                        onPageFinished: (url) {
                          //      Navigator.of(context).pop();
                          readJS(url);
                        },
                      ),
                    ),
                  ),
                );
              case 200:
                return _buildCompletedPaymentUI(data.getCoinPaymentStatus['message']);
              case 302:
                hideTimer = true;

                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;
                  context.read<AppData>().setStopCountDownTimer(true);
                  setState(() {});
                });
                return _buildDelayedPaymentUI(data.getCoinPaymentStatus['message']);
              case 406:
                hideTimer = true;

                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;
                  context.read<AppData>().setStopCountDownTimer(true);
                  setState(() {});
                });
                return _buildDelayedPaymentUI(data.getCoinPaymentStatus['message']);
              case 206:
                hideTimer = true;

                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;
                  context.read<AppData>().setStopCountDownTimer(true);
                  setState(() {});
                });
                return _buildPendingPaymentUI(data.getCoinPaymentStatus['message']);
              case 402:
                return _buildCancelledPaymentUI(data.getCoinPaymentStatus['message']);

              default:
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Opacity(
                      opacity: showWebView,
                      child: WebView(
                        key: Keyz.riKey2,
                        gestureRecognizers: gestureRecognizers,
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: widget.url,
                        onWebViewCreated: (controller) {
                          this.controller = controller;
                        },
                        onProgress: (i) {},
                        onPageStarted: (v) async {
                          if (v.contains('ethereum:') ||
                              v.contains('bitcoin:') ||
                              v.contains('dogecoin:') ||
                              v.contains('litecoin:') ||
                              v.contains('bitcoincash:') ||
                              v.contains('usdcoint:') ||
                              v.contains('dai:') ||
                              v.contains('apecoin:') ||
                              v.contains('shibainu:') ||
                              v.contains('terther:')) {
                            if (await canLaunchUrl(Uri.parse(v))) {
                              launchUrl(Uri.parse(v));
                            } else {
                              if (!mounted) return;
                              displayTostmessage(context, false,
                                  isInformation: true,
                                  message:
                                      "we couldn't  find a wallet , \nyou can ues address to complete the payment");
                            }
                          }
                          //     pressIndcatorDialog(context);
                        },
                        onPageFinished: (url) {
                          //      Navigator.of(context).pop();
                          readJS(url);
                        },
                      ),
                    ),
                  ),
                );
            }
          })),
    );
  }

  Widget _buildCancelledPaymentUI(String message) {
    hideTimer = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      setState(() {});
    });
    return Column(
      children: [
        Lottie.asset('assets/images/loading/failed.json', fit: BoxFit.contain, repeat: false),
        Text(
          '$message\n\n',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconsButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AppData>().searchMode.isNotEmpty
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
                      (route) => false)
                  : Navigator.of(context)
                      .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
            },
            text: AppLocalizations.of(context)?.back ?? 'Back',
            color: primaryblue,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedPaymentUI(String message) {
    hideTimer = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      setState(() {});
    });
    return Column(
      children: [
        Lottie.asset('assets/images/loading/done.json', fit: BoxFit.contain, repeat: false),
        Text(
          '$message \n\n\n',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: greencolor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconsButton(
            onPressed: () async {
              pressIndcatorDialog(context);
              //  Navigator.of(context).pushNamed(MiniLoader.idScreen);

              final pastbooking = await AssistantMethods.getuserBookingList(context);
              if (!mounted) return;
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => MyBookingScreen(
                            bookingList: pastbooking,
                          )),
                  (r) => false);
            },
            text: AppLocalizations.of(context)!.seeConfirmationDetails,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPendingPaymentUI(String message) {
    hideTimer = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      setState(() {});
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Lottie.asset('assets/images/loading/pending.json', fit: BoxFit.contain, repeat: true),
        ),
        Text(
          '$message \n\n\n',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: yellowColor),
        ),
      ],
    );
  }

  Widget _buildDelayedPaymentUI(String message) {
    hideTimer = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      setState(() {});
    });
    return Column(
      children: [
        Lottie.asset('assets/images/information-session.json', fit: BoxFit.contain, repeat: false),
        Text(
          '$message\n\n',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconsButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AppData>().searchMode.isNotEmpty
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
                      (route) => false)
                  : Navigator.of(context)
                      .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
            },
            text: AppLocalizations.of(context)?.back ?? 'Back',
            color: primaryblue,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  readJS(String url) async {
    if (url.contains('transaction/cancelled')) {
      showWebView = 0.0;
      setState(() {});
      final result = await AssistantMethods.getCoinPaymentResult(url);

      if (!mounted) return;

      context.read<AppData>().setStopCountDownTimer(true);
      Dialogs.materialDialog(
          barrierDismissible: false,
          context: context,
          color: Colors.white,
          msg: '',
          title: result,
          lottieBuilder: Lottie.asset(
            'assets/images/loading/failed.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AppData>().searchMode.isNotEmpty
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
                        (route) => false)
                    : Navigator.of(context)
                        .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
              },
              text: AppLocalizations.of(context)!.cancel,
              color: primaryblue,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ]);
    } else if (url.contains('transaction/completed')) {
      showWebView = 0.0;
      setState(() {});
      final result = await AssistantMethods.getCoinPaymentResult(url);
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      Dialogs.materialDialog(
          barrierDismissible: false,
          context: context,
          color: Colors.white,
          msg: '',
          title: result,
          lottieBuilder: Lottie.asset(
            'assets/images/loading/done.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () async {
                pressIndcatorDialog(context);
                //   Navigator.of(context).pushNamed(MiniLoader.idScreen);

                final pastbooking = await AssistantMethods.getuserBookingList(context);
                      if (!mounted) return;

                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyBookingScreen(
                              bookingList: pastbooking,
                            )),
                    (r) => false);
              },
              text: AppLocalizations.of(context)!.seeConfirmationDetails,
              color: Colors.blue,
              textStyle:const TextStyle(color: Colors.white),
            ),
          ]);
    }
  }
}
