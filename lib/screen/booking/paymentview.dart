// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/my-bookinglist.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key, required this.url, required this.duration}) : super(key: key);
  final String url;
  final Duration duration;

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> with WidgetsBindingObserver {
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };
  late WebViewController controller;
  bool showBackButton = true;

  double showWebView = 1.0;

  @override
  void initState() {
    if (Platform.isAndroid) if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  Stream<Response> getData() {
    final x = AssistantMethods.getRandomNumberFact(
        context.read<AppData>().coupon!.data.paymentData.streamApi);
    return x;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool hideTimer = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(true),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: cardcolor,
            title: Text(
              AppLocalizations.of(context)!.payment,
              style: TextStyle(color: blackTextColor),
            ),
            leading: showBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? Icons.keyboard_arrow_left
                          : Icons.keyboard_arrow_right,
                      color: primaryblue,
                      size: 30.sp,
                    ))
                : const SizedBox(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: hideTimer
                  ? const SizedBox()
                  : Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 48.0,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)?.countdownConfirm ??
                                    ' Time to confirm ',
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
          body: StreamBuilder<Response>(
            stream: getData(),
            builder: (context, AsyncSnapshot<Response> snap) {
              String statusText = '';
              String paymentMessage = '';

              if (snap.data?.body != null) {
                final dd = json.decode(snap.data?.body.replaceFirst('data: ', '') ?? '');

                statusText = dd['code'].toString();

                paymentMessage = dd['status_text'];
              }

              //['code'=>'102', 'message'=>'Processing transaction/waiting for payment'];
              //
              // ['code'=>'402','message'=>'Transaction Failed']
              //
              // ['code'=>'499','message'=>'Transaction Cancelled']
              //
              // ['code'=>'202','message'=>'Transaction completed, processing booking !']
              //
              // ['code'=>'406','message'=>'Transaction success,booking failed']
              //
              // ['code'=>'100','message'=>'Transaction success,booking in progress']
              //
              // ['code'=>'200','message'=>'Transaction success,booking success']
              //{"code":422,
              // "error":true,
              // "message":"Prebook failed",
              // "data":{"payUrl":"","details":{"package_name":"London(5N) with Jack the Ripper Walking Tour",
              // "package_days":5,"flight":{"carriers":{"SV":"Saudi Arabian"},"selling_currency":"AED","max_stop":1,
              // "start_date":"04 May 2022","end_date":"09 May 2022","travel_data":[{"travel_time":650,"numstops":1,
              // "stops":["RUH"],"carriers":[{"code":"SV","name":"Saudi Arabian"}],
              // "start":{"date":"2022-05-04","time":"22:30","locationId":"DXB",
              // "terminal":true,"timezone":"Asia/Dubai"},"end":{"date":"2022-05-05",
              // "time":"06:20","locationId":"LHR","terminal":true,"timezone":"Europe/London"},
              // "itenerary":[{"company":{"marketingCarrier":"SV","operatingCarrier":"SV",
              // "logo":"https://mapi2.ibookholiday.com/flight/image/SV"},"flightNo":"553",
              // "departure":{"date":"2022-05-04","time":"22:30","locationId":"DXB",
              // "timezone":"Asia/Dubai","airport":"Dubai Intl Arpt","city"
              // :"Dubai","terminal":true},"flight_time":120,"arrival":{"date":"2022-05-04","time":"23:30","locationId":"RUH","<…>
              // Reloaded 82 of 2912 libraries in 1,213ms (compile: 664 ms, reload: 266 ms, reassemble: 263 ms).

              switch (statusText.trim().toLowerCase()) {
                case '200':
                  return _buildCompletedPaymentUI(paymentMessage);
                case '100':
                  return _buildPendingPaymentUI(paymentMessage);

                case '402':
                  return _buildCancelledPaymentUI(paymentMessage);

                case '499':
                  return _buildCancelledPaymentUI(paymentMessage);
                case '202':
                  return _buildPendingPaymentUI(paymentMessage);
                default:
                  return Opacity(
                    opacity: showWebView,
                    child: WebView(
                      key: Keyz.riKey1,
                      gestureRecognizers: gestureRecognizers,
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: //'http://192.168.0.222/ibookaholidaynew/err-2?payment=failed',
                          widget.url,
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      onProgress: (i) {},
                      onPageStarted: (v) {
                        if (v == 'https://migs.mastercard.com.au/ssl') {
                          showBackButton = false;
                          setState(() {});
                        }
                        pressIndcatorDialog(context);
                      },
                      onPageFinished: (url) {
                        Navigator.of(context).pop();

                        readJS(url);
                      },
                    ),
                  );
              }
            },
          ),
        ));
  }

  void readJS(String url) async {
    String status;
    try {
      if (url.contains('payment=')) {
        final result = await controller.currentUrl();

        status = result!.split('payment=').last;
        String html = await controller.evaluateJavascript("document.documentElement.innerText");
        controller.evaluateJavascript(
            "document.getElementsByClassName('design-header')[0].style.display='none'");
        controller.evaluateJavascript(
            "document.getElementsByClassName('explore-main')[0].style.display='none'");
        controller
            .evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
        // this.controller.evaluateJavascript(
        //     "document.getElementsByClassName('breadcrumb')[0].style.display='none'");

        if (status == 'success') {
          if (!mounted) return;
          context.read<AppData>().setStopCountDownTimer(true);
          Dialogs.materialDialog(
              barrierDismissible: false,
              context: context,
              color: Colors.white,
              msg: AppLocalizations.of(context)!.bookingWasSuccessfully,
              title: AppLocalizations.of(context)!.congratulations,
              lottieBuilder: Lottie.asset(
                'assets/images/loading/done.json',
                fit: BoxFit.contain,
              ),
              actions: [
                IconsButton(
                  onPressed: () async {
                    // Navigator.of(context).pushNamed(MiniLoader.idScreen);
                    pressIndcatorDialog(context);
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
              ]);
        }
      } else if (url.contains('transaction/cancelled')) {
        showWebView = 0.0;
        setState(() {});

        final paymentFailedReason = await AssistantMethods.getPaymentFailedReason(url);
        if (!mounted) return;
        if (paymentFailedReason != null) {
          context.read<AppData>().setStopCountDownTimer(true);
          Dialogs.materialDialog(
              barrierDismissible: false,
              context: context,
              color: Colors.white,
              msg: paymentFailedReason.data?.errorDesc ?? '',
              title: paymentFailedReason.data?.errorMsg ?? 'Payment Cancelled',
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
                            MaterialPageRoute(
                                builder: (context) => const IndividualPackagesScreen()),
                            (route) => false)
                        : Navigator.of(context)
                            .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                  },
                  text: AppLocalizations.of(context)!.cancel,
                  color: primaryblue,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ]);
        }
      } else if (url.contains('booking-failed')) {
        showWebView = 0.0;
        setState(() {});

        final bookingFailedReason = await AssistantMethods.getBookingFailedReason(url);

        if (bookingFailedReason != null) {
                              if (!mounted) return;

          context.read<AppData>().setStopCountDownTimer(true);
          Dialogs.materialDialog(
              barrierDismissible: false,
              context: context,
              color: Colors.white,
              msg: bookingFailedReason.data?.desc ?? '',
              title: bookingFailedReason.data?.message ?? 'Booking Failed',
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
                            MaterialPageRoute(
                                builder: (context) => const IndividualPackagesScreen()),
                            (route) => false)
                        : Navigator.of(context)
                            .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                  },
                  text: AppLocalizations.of(context)!.cancel,
                  color: primaryblue,
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ]);
        }
      }
    } catch (e) {
      context.read<AppData>().setStopCountDownTimer(true);
      Dialogs.materialDialog(
          barrierDismissible: false,
          context: context,
          color: Colors.white,
          msg: 'something went wrong please try again',
          title: 'booking failed',
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
    }
  }

  Widget _buildCancelledPaymentUI(String message) {
    hideTimer = true;

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      context.read<AppData>().setStopCountDownTimer(true);
      setState(() {});
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                        .pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
              },
              text: AppLocalizations.of(context)?.back ?? 'Back',
              color: primaryblue,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
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
              // Navigator.of(context).pushNamed(MiniLoader.idScreen);

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

}

class Keyz {
  static const riKey1 = Key('__RIKEY1__');
  static const riKey2 = Key('__RIKEY2__');
}
