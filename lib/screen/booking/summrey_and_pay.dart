// ignore_for_file: prefer_interpolation_to_compose_strings, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lamar_travel_packages/core/payment_core.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search_room_passinger.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamar_travel_packages/Model/prebookfaild.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/widget/pdfpage.dart';

import '../../Assistants/assistant_methods.dart';
import '../../Datahandler/adaptive_texts_size.dart';
import '../../Datahandler/app_data.dart';
import '../../Model/cancelation_model.dart';
import '../../Model/customizpackage.dart';
import '../../config.dart';

import '../../setting/my-bookinglist.dart';
import '../../setting/setting_widgets/billing_information.dart';
import '../../widget/image_spinnig.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

enum PaymentMethod { card, coin, creditAmount, mada, applePay }

class SumAndPay extends StatefulWidget {
  const SumAndPay({Key? key, required this.isIndv}) : super(key: key);
  static String idScreen = 'SumAndPay';
  final bool isIndv;
  static Duration? paymentUrlDuration;

  @override
  _SumAndPayState createState() => _SumAndPayState();
}

class _SumAndPayState extends State<SumAndPay> {
  late Customizpackage package;
  late PrebookFalid prebook;

  String checkoutId = '';

  bool partialAmountWithCredit = false;

  PaymentMethod _paymentMethods = PaymentMethod.card;

  final couponController = TextEditingController();

  final controller = ScrollController();

  bool _isUseCoupon = false;
  final FocusNode _focusNode = FocusNode();

  String initialAmount = '';
  String finalAmount = '';
  String discountAmount = '';
  String creditAmount = '';
  String gameDiscount = '';
  String transactionFees = '0';

  // List<PaymentItem> _paymentItems = [];
  //
  getData() async {
    package = Provider.of<AppData>(context, listen: false).packagecustomiz;
    prebook = Provider.of<AppData>(context, listen: false).prebookFalid!;
    initialAmount = prebook.data.payment?.packageAmountWithoutAnyDiscount ?? '';
    finalAmount = prebook.data.payment?.finalSellingAmount ?? '';
    discountAmount = prebook.data.payment?.discounts.totalDiscount.amount ?? '';
    creditAmount = prebook.data.payment?.discounts.credit.amount ?? '';
    gameDiscount = prebook.data.payment?.discounts.gamePointsDiscount.amount ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final data = await AssistantMethods.updatePaymentMethods(
        context,
        PaymentMethod.creditAmount,
        //  _paymentMethods,
        package.result.customizeId,
      );

      transactionFees = data?.data.paymentData.transactionFees ?? '0';
      url = data?.data.paymentData.paymentUrl ?? '';
    });

    // _paymentItems = [
    //   PaymentItem(
    //     label: 'Your total package price',
    //     amount: package.result.totalAmount.toString(),
    //     status: PaymentItemStatus.final_price,
    //   )
    // ];
  }

  String session = '';

  String url = '';

  late Timer timer;

  Duration? currentDuration;

  @override
  void initState() {
    SumAndPay.paymentUrlDuration = const Duration(minutes: 15);
    getData();
    context.read<AppData>().stopCountDownTimer = false;
    timer = Timer(const Duration(seconds: 10), () {}
        // ,
        //     () => Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => CustomyizeSlider(),
        //     ))
        );

    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    couponController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    billingStreet.dispose();
    billingCity.dispose();
    billingState.dispose();
    billingCountry.dispose();
    billingPostcode.dispose();
    SumAndPay.paymentUrlDuration = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          width: 100.w,
          height: 100.h,
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Theme(
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
                                  'Time to confirm your booking  ',
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SlideCountdownSeparated(
                              duration: SumAndPay.paymentUrlDuration ?? const Duration(minutes: 9),
                              showZeroValue: false,
                              countUp: false,
                              onChanged: (d) {
                                currentDuration = d;
                              },
                              onDone: () {
                                if (!context.read<AppData>().stopCountDownTimers) {
                                  session = ' ';
                                  setState(() {});
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                            content: Text(AppLocalizations.of(context)
                                                    ?.uDidnotProceedyourbooking ??
                                                "You  didn’t proceed for booking please try again "),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    AssistantMethods.removeTheCoupon(
                                                        context, package.result.customizeId);
                                                    if (widget.isIndv) {
                                                      Navigator.of(context).pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const IndividualPackagesScreen()),
                                                          (route) => false);
                                                    } else {
                                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                                          CustomizeSlider.idScreen, (r) => false);
                                                    }
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context)?.tryAgain ??
                                                        'Try again',
                                                    style: TextStyle(color: primaryblue),
                                                  ))
                                            ],
                                          ));
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ),
                elevation: 0.1,
                backgroundColor: cardcolor,
                title: Text(
                  AppLocalizations.of(context)!.bookingSummary,
                  style: TextStyle(color: blackTextColor, fontSize: titleFontSize),
                ),
                leading: IconButton(
                    onPressed: () async {
                      // IndividualProducts.facebookAppEvents.setAutoLogAppEventsEnabled(true);
                      // IndividualProducts.facebookAppEvents.setAdvertiserTracking(enabled: true);
                      // IndividualProducts.facebookAppEvents.logEvent(
                      // name: 'back_from_check_out',
                      // parameters: {"Description": "didn't complete the booking"});
                      await AssistantMethods.removeTheCoupon(context, package.result.customizeId);
                      if (!mounted) return;
                      widget.isIndv
                          ? Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const IndividualPackagesScreen()),
                              (route) => false)
                          : Navigator.of(context)
                              .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                    },
                    icon: Icon(
                      Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? Icons.keyboard_arrow_left
                          : Icons.keyboard_arrow_right,
                      color: primaryblue,
                      size: 30.sp,
                    )),
              ),
              // appbar(context, ''),
              extendBody: false,
              body: SingleChildScrollView(
                controller: controller,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //  HolidayHeder(idscreen: SumAndPay.idScreen),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // currentState('Book', context, SumAndPay.idScreen),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
                          package.result.hotels.isNotEmpty ? _buildHaderImage() : const SizedBox(),
                          SizedBox(
                            height: 1.h,
                          ),
                          _buildPackageInfomation(),
                          SizedBox(height: 2.h),
                          _buildCancellationButton(),
                          SizedBox(
                            height: 2.h,
                          ),
                          _buildPackageDetails(),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5),
                            width: 100.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: primaryblue,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Image.asset(
                                    'assets/images/iconss/coupontick.png',
                                    color: primaryblue,
                                    width: 5.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 45.w,
                                  child: TextField(
                                      focusNode: _focusNode,
                                      controller: couponController,
                                      cursorColor: primaryblue,
                                      readOnly: _isUseCoupon,
                                      textCapitalization: TextCapitalization.characters,
                                      decoration: InputDecoration(

                                          //     labelText: "Coupon code",
                                          // labelStyle: TextStyle(color: yellowColor),
                                          border: InputBorder.none,
                                          // enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: yellowColor)),
                                          // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: yellowColor)),
                                          hintText: AppLocalizations.of(context)!.couponCode,
                                          hintStyle: TextStyle(color: primaryblue)),

                                      // InputDecoration(
                                      //   focusedBorder: OutlineInputBorder(
                                      //     borderSide: BorderSide(color: yellowColor),
                                      //   ),
                                      //   focusColor: yellowColor,
                                      //   labelText: 'Coupon code',
                                      //   labelStyle: TextStyle(color: yellowColor),
                                      //   //      border: InputBorder.none,
                                      // ),
                                      //
                                      onChanged: (v) {}),
                                ),
                                SizedBox(
                                  width: 33.w,
                                  child: TextButton(
                                    // style:
                                    //  ElevatedButton.styleFrom(
                                    //    fixedSize: Size(100.w,5.5.h),
                                    //      side: BorderSide(color: Colors.transparent),
                                    //      primary: yellowColor,
                                    //      padding: const EdgeInsets.symmetric(vertical: 13)),
                                    // style: TextButton.styleFrom(
                                    //   fixedSize: Size(width, height)
                                    // ),
                                    onPressed: () async {
                                      if (!_isUseCoupon) {
                                        _isUseCoupon = await AssistantMethods.useCoupon(context,
                                            couponController.text, package.result.customizeId);
                                        changePriceData();
                                      } else {
                                        await AssistantMethods.removeTheCoupon(
                                            context, package.result.customizeId);
                                        changePriceData();
                                      }
                                      if (!mounted) return;
                                      FocusScope.of(context).unfocus();
                                      setState(() {});
                                    },
                                    child: Text(
                                      _isUseCoupon
                                          ? AppLocalizations.of(context)!.removeTheCoupon
                                          : AppLocalizations.of(context)!.coupon,
                                      style: TextStyle(
                                          fontSize: subtitleFontSize - 2, color: primaryblue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 100.w,
                            child: const Divider(),
                          ),

                          _buildPricing(),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            width: 100.w,
                            child: const Divider(),
                          ),

                          Container(
                              padding: const EdgeInsets.only(left: 5),
                              width: 100.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: primaryblue,
                                  width: 1.0,
                                ),
                              ),
                              child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                SizedBox(
                                  height: 1.h,
                                ),

                                Text(
                                  AppLocalizations.of(context)?.paymentMethod ?? 'Payment methods',
                                  style: TextStyle(
                                      fontSize:
                                          const AdaptiveTextSize().getadaptiveTextSize(context, 35),
                                      fontWeight: FontWeight.bold,
                                      color: primaryblue),
                                ),
                                const Divider(indent: 10, endIndent: 10),
                                GestureDetector(
                                  onTap: () {
                                    _paymentMethods = PaymentMethod.card;

                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100.w,
                                      height: 3.h,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/vectors/credit-card.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)?.card ??
                                                    '  Credit/Debit Cards ',
                                                style: TextStyle(
                                                    fontSize: const AdaptiveTextSize()
                                                        .getadaptiveTextSize(context, 30),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Radio<PaymentMethod>(
                                              value: PaymentMethod.card,
                                              groupValue: _paymentMethods,
                                              onChanged: (method) async {
                                                _paymentMethods = method!;
                                                // _uerChangingPayment = false;
                                                // await AssistantMethods.updatePaymentMethods(
                                                //   context,
                                                //   _paymentMethods,
                                                //   package.result.customizeId,
                                                // );
                                                // print('here');

                                                // changePriceData();

                                                paymentBrand = PaymentBrands.visaMaster;

                                                setState(() {});
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // prebook.data.coinbase == null
                                //     ? const SizedBox()
                                //     :

                                // MADA PAYMENT

                                GestureDetector(
                                  onTap: () {
                                    _paymentMethods = PaymentMethod.mada;

                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 100.w,
                                      height: 3.h,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/vectors/mada.png',
                                                width: 20,
                                                height: 20,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)?.mada ?? '  Mada ',
                                                style: TextStyle(
                                                    fontSize: const AdaptiveTextSize()
                                                        .getadaptiveTextSize(context, 30),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Radio<PaymentMethod>(
                                              value: PaymentMethod.mada,
                                              groupValue: _paymentMethods,
                                              onChanged: (method) async {
                                                //  changePriceData();
                                                _paymentMethods = method!;

                                                // New Payment Hyperpay

                                                paymentBrand = PaymentBrands.mada;

                                                setState(() {});
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // APPLEPAY

                                Platform.isIOS
                                    ? GestureDetector(
                                        onTap: () {
                                          _paymentMethods = PaymentMethod.applePay;

                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 100.w,
                                            height: 3.h,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/vectors/apple-pay.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(context)?.applePay ??
                                                          '  Apple Pay ',
                                                      style: TextStyle(
                                                          fontSize: const AdaptiveTextSize()
                                                              .getadaptiveTextSize(context, 30),
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Radio<PaymentMethod>(
                                                    value: PaymentMethod.applePay,
                                                    groupValue: _paymentMethods,
                                                    onChanged: (method) async {
                                                      changePriceData();
                                                      _paymentMethods = method!;

                                                      // New Payment Hyperpay

                                                      paymentBrand = PaymentBrands.applePay;

                                                      setState(() {});
                                                    })
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),

                                //Cridet Balance

                                // GestureDetector(
                                //   onTap: () {
                                //     _paymentMethods = PaymentMethod.creditAmount;
                                //     setState(() {});
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: SizedBox(
                                //       width: 100.w,
                                //       height: 3.h,
                                //       child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Row(
                                //             children: [
                                //               Image.asset(
                                //                 'assets/images/iconss/money.png',
                                //                 width: 20,
                                //                 height: 20,
                                //               ),
                                //               Text(
                                //                 AppLocalizations.of(context)?.useCreditBalance ??
                                //                     '',
                                //                 style: TextStyle(
                                //                     fontSize: const AdaptiveTextSize()
                                //                         .getadaptiveTextSize(context, 30),
                                //                     fontWeight: FontWeight.bold),
                                //               )
                                //             ],
                                //           ),
                                //           Radio<PaymentMethod>(
                                //               value: PaymentMethod.coin,
                                //               groupValue: _paymentMethods,
                                //               onChanged: (method) async {
                                //                 _paymentMethods = method!;
                                //                 _uerChangingPayment = false;
                                //                 await AssistantMethods.updatePaymentMethods(
                                //                   context,
                                //                   _paymentMethods,
                                //                   package.result.customizeId,
                                //                 );
                                //                 changePriceData();
                                //                 setState(() {});
                                //               })
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                //Coinbase
                                // GestureDetector(
                                //   onTap: () {
                                //     _paymentMethods = PaymentMethod.coin;
                                //     setState(() {});
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: SizedBox(
                                //       width: 100.w,
                                //       height: 3.h,
                                //       child: Row(
                                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Row(
                                //             children: [
                                //               Image.asset(
                                //                 'assets/images/iconss/coinbase-icon.png',
                                //                 width: 20,
                                //                 height: 20,
                                //               ),
                                //               RichText(
                                //                 text: TextSpan(children: [
                                //                   TextSpan(
                                //                       text: AppLocalizations.of(context)!
                                //                           .cryptoCurrency,
                                //                       style: TextStyle(
                                //                           fontSize: const AdaptiveTextSize()
                                //                               .getadaptiveTextSize(context, 30),
                                //                           fontWeight: FontWeight.w500,
                                //                           color: Colors.black)),
                                //                   TextSpan(
                                //                       text: 'pay by Crypto currency',
                                //                       style: TextStyle(
                                //                           color: Colors.grey, fontSize: 10.sp))
                                //                 ]),
                                //               ),
                                //             ],
                                //           ),
                                //           Radio<PaymentMethod>(
                                //               value: PaymentMethod.coin,
                                //               groupValue: _paymentMethods,
                                //               onChanged: (method) async {
                                //                 _paymentMethods = method!;
                                //                 _uerChangingPayment = false;
                                //                 await AssistantMethods.updatePaymentMethods(
                                //                   context,
                                //                   _paymentMethods,
                                //                   package.result.customizeId,
                                //                 );
                                //                 changePriceData();
                                //                 setState(() {});
                                //               })
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                const Divider(indent: 10, endIndent: 10),
                                prebook.data.payment?.payPartialAmountByCredit ??
                                        false ||
                                            (prebook.data.payment?.payFullAmountByCredit ?? false)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 100.w,
                                          height: 3.h,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/vectors/credit-card.png',
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)
                                                            ?.useCreditBalance ??
                                                        '  Use you credit balance',
                                                    style: TextStyle(
                                                        fontSize: const AdaptiveTextSize()
                                                            .getadaptiveTextSize(context, 30),
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              (prebook.data.payment?.payFullAmountByCredit ?? false)
                                                  ? Radio<PaymentMethod>(
                                                      value: PaymentMethod.creditAmount,
                                                      groupValue: _paymentMethods,
                                                      onChanged: (method) async {
                                                        _paymentMethods = method!;
                                                        setState(() {});
                                                      })
                                                  : (prebook.data.payment
                                                              ?.payPartialAmountByCredit ??
                                                          false)
                                                      ? Checkbox(
                                                          value: partialAmountWithCredit,
                                                          onChanged: (v) async {
                                                            partialAmountWithCredit = v!;

                                                            setState(() {});

                                                            await AssistantMethods.applyCredit(
                                                                context,
                                                                package.result.customizeId,
                                                                partialAmountWithCredit,
                                                                prebook.data.userCredits
                                                                    ?.creditCanBeUsed);
                                                            changePriceData();
                                                          })
                                                      : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ])),

                          SizedBox(
                            width: 100.w,
                            child: const Divider(),
                          ),

                          Container(
                            padding: const EdgeInsets.all(5).copyWith(top: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: primaryblue, width: 1, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: 100.w,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: accept,
                                  onChanged: (v) {
                                    setState(() {
                                      accept = v!;
                                    });
                                    Provider.of<AppData>(context, listen: false)
                                        .accepttheterm(accept);
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PdfScreen(
                                              path: 'https://ibookholiday.com/services/terms',
                                              title:
                                                  AppLocalizations.of(context)!.termsAndConditions,
                                              isPDF: false,
                                            )));
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: RichText(
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      text: TextSpan(
                                          text: AppLocalizations.of(context)!.iHaveReadAndAccept,
                                          style: TextStyle(color: Colors.black, fontSize: 12.sp),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.generalTerms,
                                              style: TextStyle(
                                                  color: Colors.blueAccent, fontSize: 12.sp),
                                            ),
                                            TextSpan(
                                              text: AppLocalizations.of(context)!
                                                  .andCancellationPolicyConditions,
                                              style:
                                                  TextStyle(color: Colors.black, fontSize: 12.sp),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 2.h,
                    )
                  ],
                ),
              ),
              bottomSheet:
                  MediaQuery.of(context).viewInsets.bottom > 1 ? null : _buildBottomSheet(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHaderImage() {
    return SizedBox(
      width: 100.w,
      height: 25.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: prebook.data.details.hotel[0].hotelImage,
          fit: BoxFit.cover,
          placeholder: (context, url) => const ImageSpinning(
            withOpasity: true,
          ),
          errorWidget: (context, erorr, x) => SvgPicture.asset(
            'images/image-not-available.svg',
          ),
        ),
      ),
    );
  }

  Widget _buildPackageInfomation() {
    // int adult = package.result.adults;
    // int child = package.result.children;

    // if (child > 0) {
    //   passingerText =
    //       'Total package price from ${package.result.fromCity} for $adult adult and ${prebook.data.details.childrenCount} child ';
    // } else {
    //   passingerText = 'Total package price from ${package.result.fromCity} for $adult adult ';
    // }
    return Container(
      padding: EdgeInsets.only(top: 1.h),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${package.result.totalAmount} ${localizeCurrency(gencurrency)}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 35),
                color: greencolor),
          ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              '${AppLocalizations.of(context)!.totalPACKAGEPRICE} ${package.result.fromCity} - ${packagesIncluding()}',
              style: TextStyle(
                  fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                  color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          context.read<AppData>().searchMode.toLowerCase().contains('transfer')
              ? const SizedBox()
              : RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: (package.result.packageDays - 1).isNegative
                              ? ""
                              : "${AppLocalizations.of(context)!.nightCount(package.result.packageDays - 1)} ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: subtitleFontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan')),
                      TextSpan(
                          text: AppLocalizations.of(context)!.dayCount(package.result.packageDays),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: 90.w,
            child: Text(
              package.result.packageName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: false,
              style: TextStyle(
                color: Colors.black,
                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationButton() {
    return SizedBox(
      width: 100.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 1.8.h),
          backgroundColor: yellowColor,
        ),
        onPressed: () async {
          try {
            pressIndcatorDialog(context);
            Canceliation? canceliation = await AssistantMethods.getCancelationPrice(
                currency: package.result.sellingCurrency,
                custoizeId: package.result.customizeId,
                packageId: package.result.packageId);
            if (!mounted) return;
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.cancellationPolicy
                          //   'Current cancellation amount is $gencurrency ${canceliation!.data.total}'
                          ),
                      content: Text(
                        AppLocalizations.of(context)!.currentRefundableAmount(
                            canceliation!.data.total.toString(),
                            localizeCurrency(canceliation.data.currency.toString())),
                        //  'Current Refundable amount is ${canceliation!.data.total}  ${canceliation.data.currency}  and it mat change depending on the time of cancellation'
                        //   'Above cancellation charge is applicable now and it may vary depending on the time of cancellation.',
                        textAlign: TextAlign.start,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.close,
                              style: TextStyle(color: primaryblue, fontSize: titleFontSize),
                            ))
                      ],
                    ));
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        child: Text(
          AppLocalizations.of(context)!.cancellationPolicy,
          style: TextStyle(
              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPackageDetails() {
    List<Activity> act = [];
    try {
      package.result.activities.forEach((key, value) {
        act.addAll(value);
      });
    } catch (e) {
      act = [];
    }

    // if (package.result.noflight == false) {
    //   if (package.result.flight!.from.carrierName == package.result.flight!.to.carrierName) {
    //     flihgtname = '';
    //   } else {
    //     flihgtname = package.result.flight!.to.carrierName;
    //   }
    // }

    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.alsoIncludes,
            style: TextStyle(
              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
              fontWeight: FontWeight.bold,
            ),
          ),
          prebook.data.details.noFlights
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100.w,
                    child: package.result.noflight == false
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.plane,
                                    size: 20,
                                    color: primaryblue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                                    child: Text(
                                      AppLocalizations.of(context)!.flight,
                                      style: TextStyle(
                                          fontSize: const AdaptiveTextSize()
                                              .getadaptiveTextSize(context, 30),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                      context.read<AppData>().flightType == FlightType.roundedFlight
                                          ? AppLocalizations.of(context)!.roundTrip
                                          : AppLocalizations.of(context)!.onewayTrip),
                                ),
                              ),
                              SizedBox(
                                width: 100.w,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                  child: Text(
                                      prebook.data.details.flight!.travelData[0].carriers[0].name +
                                          " " +
                                          prebook.data.details.flight!.startDate.substring(0, 7) +
                                          ' - ' +
                                          //   flihgtname +
                                          ' ' +
                                          prebook.data.details.flight!.endDate.substring(0, 7)),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ),
          prebook.data.details.noHotels
              ? const SizedBox()
              : SizedBox(
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.hotel,
                                size: 20,
                                color: primaryblue,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.h),
                                child: Text(
                                  AppLocalizations.of(context)!.yourhotel,
                                  style: TextStyle(
                                      fontSize:
                                          const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        prebook.data.details.noHotels
                            ? const SizedBox()
                            : Column(children: [
                                for (var i = 0; i < prebook.data.details.hotel.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        prebook.data.details.hotel.isNotEmpty
                                            ? prebook.data.details.hotel[i].name
                                            : '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                              ])
                      ],
                    ),
                  ),
                ),
          prebook.data.details.noActivities
              ? const SizedBox()
              : SizedBox(
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.hiking,
                                size: 20,
                                color: primaryblue,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.h),
                                child: Text(
                                  AppLocalizations.of(context)!.activity,
                                  style: TextStyle(
                                      fontSize:
                                          const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 80.w,
                            child: Column(
                              children: [
                                if (prebook.data.details.noActivities == false)
                                  for (var i = 0;
                                      i < prebook.data.details.activities!.name.length;
                                      i++)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      width: 80.w,
                                      child: Text(
                                        prebook.data.details.activities != null
                                            ? prebook.data.details.activities!.name[i]
                                            : '',
                                      ),
                                    )
                                else
                                  const SizedBox(
                                    height: 0,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          prebook.data.details.noTransfers
              ? const SizedBox()
              : SizedBox(
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.car,
                                size: 20,
                                color: primaryblue,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.h),
                                child: Text(
                                  AppLocalizations.of(context)!.transfer,
                                  style: TextStyle(
                                      fontSize:
                                          const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 80.w,
                            child: Text(
                              package.result.transfer.isNotEmpty
                                  ? package.result.transfer[0].serviceTypeName
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // Widget _buildCouponCode() {
  //   return Container(
  //       padding: const EdgeInsets.all(5).copyWith(top: 5),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: primaryblue, width: 1, style: BorderStyle.solid),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       width: 100.w,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: 1.h,
  //           ),
  //           Text(
  //             AppLocalizations.of(context)!.orderSummary,
  //             style: TextStyle(
  //                 fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 35),
  //                 fontWeight: FontWeight.bold,
  //                 color: primaryblue),
  //           ),
  //           const Divider(
  //             indent: 10,
  //             endIndent: 10,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: SizedBox(
  //               width: 100.w,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     AppLocalizations.of(context)!.initialAmount,
  //                     style: TextStyle(
  //                         fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   Text(
  //                     prebook.data.creditFlagStatus.initalAmount+
  //                         ' ' +
  //                         localizeCurrency(prebook.data.creditFlagStatus.initalAmountCurrency),
  //                     style: TextStyle(
  //                         fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const Divider(
  //             indent: 10,
  //             endIndent: 10,
  //           ),
  //           prebook.data.creditFlagStatus.creditAvailable.toString() == '0'
  //               ? const SizedBox()
  //               : Column(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: SizedBox(
  //                         width: 100.w,
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Text(
  //                               AppLocalizations.of(context)!.payByCreditBalance,
  //                               style: TextStyle(
  //                                   fontSize:
  //                                       const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                             Text(
  //                               prebook.data.creditFlagStatus.creditUsedForBooking.toString() +
  //                                   ' ' +
  //                                   localizeCurrency(prebook.data.creditFlagStatus.creditCurrency),
  //                               style: TextStyle(
  //                                   fontSize:
  //                                       const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     prebook.data.creditFlagStatus.discountAmount.toString() != "0"
  //                         ? const Divider(
  //                             indent: 10,
  //                             endIndent: 10,
  //                           )
  //                         : const SizedBox(),
  //                   ],
  //                 ),
  //           prebook.data.creditFlagStatus.discountAmount.toString() != "0"
  //               ? Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: SizedBox(
  //                     width: 100.w,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           AppLocalizations.of(context)!.discount,
  //                           style: TextStyle(
  //                               fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         Text(
  //                           _isUseCoupon
  //                               ? '-' +
  //                                   Provider.of<AppData>(context, listen: false)
  //                                       .coupon!
  //                                       .result
  //                                       .discountApplicable
  //                                       .toString() +
  //                                   " " +
  //                                   localizeCurrency(package.result.sellingCurrency)
  //                               : prebook.data.creditFlagStatus.discountAmount.toString() +
  //                                   " " +
  //                                   localizeCurrency(package.result.sellingCurrency),
  //                           style: TextStyle(
  //                               fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                               fontWeight: FontWeight.bold,
  //                               color: greencolor),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               : const SizedBox(),
  //           _paymentMethods == PaymentMethod.coin
  //               ? const Divider(
  //                   indent: 10,
  //                   endIndent: 10,
  //                 )
  //               : const SizedBox(),
  //           _paymentMethods == PaymentMethod.coin
  //               ? Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: SizedBox(
  //                     width: 100.w,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           AppLocalizations.of(context)?.transactionFees ?? "Transaction fees",
  //                           style: TextStyle(
  //                               fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         Text(
  //                           prebook.data.coinbase!.transactionFees! +
  //                               " " +
  //                               localizeCurrency(prebook.data.coinbase!.currency!),
  //                           style: TextStyle(
  //                               fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                               fontWeight: FontWeight.bold,
  //                               color: greencolor),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               : const SizedBox(),
  //           const Divider(
  //             indent: 10,
  //             endIndent: 10,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: SizedBox(
  //               width: 100.w,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     AppLocalizations.of(context)!.totalP,
  //                     style: TextStyle(
  //                         fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   Text(
  //                     _isUseCoupon
  //                         ? Provider.of<AppData>(context, listen: false)
  //                                 .coupon!
  //                                 .result
  //                                 .afterDiscount
  //                                 .toString() +
  //                             " " +
  //                             localizeCurrency(package.result.sellingCurrency)
  //                         : _paymentMethods == PaymentMethod.coin
  //                             ? prebook.data.coinbase!.totalAmount.toString()+' '+ localizeCurrency(
  //                         prebook.data.coinbase?.currency?? localizeCurrency(
  //                             prebook.data.creditFlagStatus.finalAmountCurrency))
  //                             : prebook.data.creditFlagStatus.finalAmount.toString() +
  //                                 ' ' +
  //                                 localizeCurrency(
  //                                     prebook.data.creditFlagStatus.finalAmountCurrency),
  //                     style: TextStyle(
  //                         fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
  //                         fontWeight: FontWeight.bold,
  //                         color: greencolor),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 100.w,
  //           ),
  //         ],
  //       ));
  // }

  Widget _buildPricing() {
    return Container(
        padding: const EdgeInsets.all(5).copyWith(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: primaryblue, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(15),
        ),
        width: 100.w,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 1.h,
          ),
          Text(
            AppLocalizations.of(context)!.orderSummary,
            style: TextStyle(
                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 35),
                fontWeight: FontWeight.bold,
                color: primaryblue),
          ),
          const Divider(indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.initialAmount,
                    style: TextStyle(
                        fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$initialAmount ${localizeCurrency(prebook.data.payment?.userCurrency ?? gencurrency)}',
                    style: TextStyle(
                        fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          discountAmount == '0' ? const SizedBox() : const Divider(indent: 10, endIndent: 10),
          discountAmount == '0'
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.discount,
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$discountAmount ${localizeCurrency(prebook.data.payment?.discounts.totalDiscount.userCurrency ?? gencurrency)}',
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
          gameDiscount == '0'
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.gameDiscount,
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$gameDiscount ${localizeCurrency(prebook.data.payment?.discounts.gamePointsDiscount.userCurrency ?? gencurrency)}',
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
          gameDiscount == '0' ? const SizedBox() : const Divider(indent: 10, endIndent: 10),
          transactionFees == '0'
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.transactionFees,
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$transactionFees ${localizeCurrency(prebook.data.payment?.discounts.gamePointsDiscount.userCurrency ?? gencurrency)}',
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
          const Divider(indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.totalP,
                    style: TextStyle(
                        fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$finalAmount ${localizeCurrency(prebook.data.payment?.discounts.totalDiscount.userCurrency ?? gencurrency)}',
                    style: TextStyle(
                        fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(indent: 10, endIndent: 10),
        ]));
  }

  bool accept = false;

  Widget _buildBottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 100.w,
          child: ElevatedButton(
            onPressed: accept
                ? payNow
                : () {
                    controller.animateTo(controller.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
                    displayTostmessage(context, false,
                        message: AppLocalizations.of(context)!.pleaseAcceptTheGeneralTerms,
                        isInformation: true);
                  },
            style: ElevatedButton.styleFrom(backgroundColor: accept ? primaryblue : Colors.grey),
            child: Text(_paymentMethods == PaymentMethod.applePay
                ? AppLocalizations.of(context)!.next
                : AppLocalizations.of(context)!.payNow),
          ),
        ),
      ],
    );
  }

  // showBottomModelSheet() => showModalBottomSheet<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(10),
  //         height: 200,
  //         color: cardcolor,
  //         child: Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Text(
  //                     'Select your payment option:',
  //                     style: TextStyle(fontSize: titleFontSize),
  //                   )),
  //               SizedBox(
  //                 height: 4.h,
  //               ),
  //               SizedBox(
  //                 width: 100.w,
  //                 height: 10.h,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     ElevatedButton(
  //                       child: const Text('Pay now'),
  //                       style: ElevatedButton.styleFrom(
  //                           primary: primaryblue,
  //                           fixedSize: Size(
  //                             40.w,
  //                             50,
  //                           )),
  //                       onPressed: payNow,
  //                     ),
  //                     GooglePayButton(
  //                       width: 40.w,
  //                       height: 100,
  //                       paymentConfigurationAsset: 'gpay.json',
  //                       paymentItems: _paymentItems,
  //                       style: GooglePayButtonStyle.black,
  //                       type: GooglePayButtonType.pay,
  //                       onPaymentResult: onGooglePayResult,
  //                       loadingIndicator: const Center(
  //                         child: CircularProgressIndicator(),
  //                       ),
  //                       onError: (e){
  //                         es=e;
  //                         print(e.toString());
  //
  //                       },
  //                       childOnError: InkWell(
  //                           onTap: (){
  //                             print(es.toString());
  //                           },
  //                           child: Icon(Icons.cancel)),
  //
  //
  //                     ),
  //                     ApplePayButton(
  //                       width: 40.w,
  //                       height: 50,
  //                       paymentConfigurationAsset: 'applepay.json',
  //                       paymentItems: _paymentItems,
  //                       style: ApplePayButtonStyle.black,
  //                       type: ApplePayButtonType.buy,
  //                       onPaymentResult: onApplePayResult,
  //                       loadingIndicator: const Center(
  //                         child: CircularProgressIndicator(),
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     });

  void onApplePayResult(paymentResult) {
    log(paymentResult.toString());
  }

  void payNow() async {
    final data = await AssistantMethods.updatePaymentMethods(
        context, PaymentMethod.card, package.result.customizeId);
    if (data == null) {
      dialogViewer(
          animation: 'assets/images/loading/pending.json',
          title: "prebook timeup",
          description: "prebook time expired kindly prebook again",
          onPressed: () {
            Navigator.of(context).pop();

            context.read<AppData>().searchMode.isNotEmpty
                ? Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
                    (route) => false)
                : Navigator.of(context)
                    .pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
          });
      return;
    }
    url = data.data.paymentData.paymentUrl;
    if (!mounted) return;
    pressIndcatorDialog(context);

    final userData = context.read<AppData>().userupadate;

    Map<String, String> billingData = {};
    if (userData?.data.city != null &&
        userData?.data.country != null &&
        userData?.data.address != null &&
        userData?.data.postalCode != null) {
      billingData = {
        "customer.givenName": userData?.data.name ?? "",
        "customer.surname": userData?.data.lastName ?? "",
        "customer.email": userData?.data.email ?? "",
        "billing.street1": userData?.data.address ?? "",
        "billing.city": userData?.data.city ?? "",
        "billing.state": userData?.data.city ?? "",
        "billing.country": userData?.data.countryCode ?? "",
        "billing.postcode": userData?.data.postalCode ?? "".toString()
      };
    } else {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BillingInformationScreen()));
      return;
    }

    if (data.data.merchantTransactionId == null) return;

    final id = await AssistantMethods.fetchCheckOutId(
        amount: finalAmount,
        data: billingData,
        testMode: _paymentMethods == PaymentMethod.applePay ? 'INTERNAL' : 'EXTERNAL',
        merchantTransactionId: data.data.merchantTransactionId ?? "");

    if (!mounted) return;
    Navigator.of(context).pop();
    id.isNotEmpty ? checkoutId = id : checkoutId = '';
    if (checkoutId.isNotEmpty & url.isNotEmpty) {
      final data = await PaymentCore.payRequestNowReadyUI(
          brandsName: getPaymentType(), checkoutId: checkoutId);

      final result = await AssistantMethods.checkPaymentStatus(checkoutId);
      log(result.toString());
      final isSuccess = result.isEmpty
          ? false
          : (result['code'].toString().toLowerCase().contains("000.000.000") ||
                  result['code'].toString().toLowerCase().contains("000.000.100") ||
                  result['code'].toString().toLowerCase().contains("000.100.112"))
              ? true
              : false;

      if (!mounted) return;
      if (isSuccess) {
        // PAYMENT SUCCESS
        // START BOOKING
        pressIndcatorDialog(context);
        Map<String, dynamic> stortionData = result['data'];
        stortionData.putIfAbsent("customizeId", () => prebook.data.customizeID);
        await AssistantMethods.storeTransaction(stortionData);

        final bookingResult = await AssistantMethods.proceedBookingV2(url);
        if (!mounted) return;
        Navigator.pop(context);

        if (bookingResult.containsKey("message") &&
            (bookingResult["message"] as String).toLowerCase().contains("success")) {
          // BOOKING SUCCESS

          dialogViewer(
              animation: 'assets/images/loading/done.json',
              title: AppLocalizations.of(context)!.congratulations,
              description: AppLocalizations.of(context)!.bookingWasSuccessfully,
              onPressed: () async {
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
              });
        } else {
          // BOOKING FAILD
          await dialogViewer(
            animation: 'assets/images/loading/failed.json',
            title: bookingResult["message"] ?? 'Booking Failed',
            description: bookingResult.containsKey("data")
                ? bookingResult["data"].containsKey("desc")
                    ? bookingResult["data"]["desc"]
                    : "Apologies, we couldn't secure your booking this time. Our team is working to improve the process. Please contact support for assistance. Thank you for considering us."
                : "Apologies, we couldn't secure your booking this time. Our team is working to improve the process. Please contact support for assistance. Thank you for considering us.",
            onPressed: () {
              Navigator.pop(context);
            },
          );
          //     if (!mounted) return;
          pressIndcatorDialog(context);
          final refundID = await AssistantMethods.reversePayment(
            result["id"],
            testMode: _paymentMethods == PaymentMethod.applePay ? 'INTERNAL' : 'EXTERNAL',
          );

          if (refundID.isNotEmpty) {
            await dialogViewer(
              animation: 'assets/images/loading/refund_animation.json',
              title: AppLocalizations.of(context)?.weHaveProcessedYourRefund ??
                  'We have processed your refund',
              description:
                  "${AppLocalizations.of(context)?.theAmountWillBeCredited ?? 'The amount will be credited to your account shortly.'}\n${AppLocalizations.of(context)?.transactionId ?? 'Transaction id:'} $refundID ",
              onPressed: () {
                Navigator.pop(context);
                context.read<AppData>().searchMode.isNotEmpty
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
                        (route) => false)
                    : Navigator.of(context)
                        .pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
              },
            );
          } else {}
        }
      } else {
        // PAYMENT FAILD OR CANCELED

        dialogViewer(
            animation: 'assets/images/loading/failed.json',
            title: AppLocalizations.of(context)?.paymentCancelled ?? 'Payment Cancelled',
            description: result['status'],
            onPressed: () {
              Navigator.pop(context);
            });
      }
    }

    // final payData = context.read<AppData>().coupon;
    // // final url = payData?.data.paymentData.paymentUrl;
    // pressIndcatorDialog(context);
    // final id = await AssistantMethods.fetchCheckOutId(amount: finalAmount);
    // if (!mounted) return;
    // Navigator.of(context).pop();
    // id.isNotEmpty ? checkoutId = id : checkoutId = '';
    // // if (url.isEmpty) return;
    // if (checkoutId.isNotEmpty) {
    //   await PaymentCore.payRequestNowReadyUI(brandsName: getPaymentType(), checkoutId: checkoutId);
    //   final result = await AssistantMethods.checkPaymentStatus(checkoutId);
    //   final isSuccess = result.isEmpty
    //       ? false
    //       : result.toLowerCase().contains("success")
    //           ? true
    //           : false;
    //   if (!mounted) return;
    //   if (isSuccess) {
    //     final isBookingSuccess = await AssistantMethods.proceedBookingV2(url);
    //     if (!mounted) return;
    //     if ((isBookingSuccess is bool) && isBookingSuccess) {
    //       Dialogs.materialDialog(
    //           barrierDismissible: false,
    //           context: context,
    //           color: Colors.white,
    //           msg: result,
    //           title: 'Booking Success',
    //           lottieBuilder: Lottie.asset(
    //             'assets/images/loading/done.json',
    //             fit: BoxFit.contain,
    //           ),
    //           actions: [
    //             IconsButton(
    //               onPressed: () {},
    //               text: AppLocalizations.of(context)!.cancel,
    //               color: primaryblue,
    //               textStyle: const TextStyle(color: Colors.white),
    //             ),
    //           ]);
    //     }
    //   } else {
    //     context.read<AppData>().setStopCountDownTimer(true);
    //     Dialogs.materialDialog(
    //         barrierDismissible: false,
    //         context: context,
    //         color: Colors.white,
    //         msg: result,
    //         title: 'Payment Cancelled',
    //         lottieBuilder: Lottie.asset(
    //           'assets/images/loading/failed.json',
    //           fit: BoxFit.contain,
    //         ),
    //         actions: [
    //           IconsButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //               // context.read<AppData>().searchMode.isNotEmpty
    //               //     ? Navigator.of(context).pushAndRemoveUntil(
    //               //         MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()),
    //               //         (route) => false)
    //               //     : Navigator.of(context)
    //               //         .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
    //             },
    //             text: AppLocalizations.of(context)!.cancel,
    //             color: primaryblue,
    //             textStyle: const TextStyle(color: Colors.white),
    //           ),
    //         ]);
    //   }
    // }
    // if (_paymentMethods == PaymentMethod.coin) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => PaymentViewForCoin(
    //           url: url,
    //           duration: currentDuration ?? const Duration(minutes: 2),
    //           id: payData!.data.paymentData.streamApi)));
    // } else {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) =>
    //    PaymentView(url: url, duration: currentDuration ?? const Duration(minutes: 2))));
    // }
  }

  void changePriceData() {
    final coupon = context.read<AppData>().coupon;

    discountAmount = coupon?.data.paymentDetails?.discounts.totalDiscount.amount ?? '0';
    initialAmount = coupon?.data.paymentDetails?.packageAmountWithoutAnyDiscount ??
        prebook.data.payment?.packageAmountWithoutAnyDiscount ??
        '0';
    finalAmount =
        coupon?.data.paymentData.totalAmount ?? prebook.data.payment?.finalSellingAmount ?? '0';
    transactionFees = coupon?.data.paymentData.transactionFees ?? '0';
    setState(() {});
  }

  void onGooglePayResult(paymentResult) {
    log(paymentResult.toString());
  }

  String packagesIncluding() {
    String including = '';
    String adult = '';
    String child = '';
    String infent = '';

    if (prebook.data.details.adultsCount > 0) {
      adult = ' ${AppLocalizations.of(context)!.adultCount(prebook.data.details.adultsCount)}';
    }
    if (prebook.data.details.childrenCount > 0) {
      child = ' , ${AppLocalizations.of(context)!.childCount(prebook.data.details.childrenCount)}';
    }
    if (prebook.data.details.infantsCount > 0) {
      infent = ' , ${prebook.data.details.infantsCount} infants';
    }

    including = adult + child + infent;

    if (including.endsWith(',')) {
      including = including.substring(0, including.length - 1);
    } else if (including.startsWith(',')) {
      including = including.substring(1, including.length);
    }

    return including;
  }

  Future<void> dialogViewer(
          {required String animation,
          required String title,
          required String description,
          required Function onPressed}) =>
      Dialogs.materialDialog(
          barrierDismissible: false,
          context: context,
          color: Colors.white,
          msg: description,
          title: title,
          lottieBuilder: Lottie.asset(
            animation,
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: onPressed,
              text: AppLocalizations.of(context)!.cancel,
              color: primaryblue,
              textStyle: const TextStyle(color: Colors.white),
            ),
          ]);

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final billingStreet = TextEditingController();
  final billingCity = TextEditingController();
  final billingState = TextEditingController();
  final billingCountry = TextEditingController();
  final billingPostcode = TextEditingController();

  Future showHolderDetailsBottomSheet(
      {required String firstName, required String lastName, required String email}) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    emailController.text = email;
    return showModalBottomSheet<Map<String, String>>(
        backgroundColor: Colors.transparent,
        isDismissible: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              color: Colors.white,
              height: 85.h,
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add billing information ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: primaryblue, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 1.h),
                    const Divider(),
                    SizedBox(height: 1.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 45.w,
                          child: TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                                label: Text('First name', style: TextStyle(color: inCardColor)),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 45.w,
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                                label: Text('Last name', style: TextStyle(color: inCardColor)),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return "This field is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: Text('Email', style: TextStyle(color: inCardColor)),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: billingStreet,
                      decoration: InputDecoration(
                          label: Text('Billing street', style: TextStyle(color: inCardColor)),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: billingCity,
                      decoration: InputDecoration(
                          label: Text('Billing city', style: TextStyle(color: inCardColor)),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: billingState,
                      decoration: InputDecoration(
                          label: Text('Billing state', style: TextStyle(color: inCardColor)),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 1.h),
                    SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 45.w,
                            child: TextFormField(
                              controller: billingPostcode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text('Billing postcode',
                                      style: TextStyle(color: inCardColor)),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 45.w,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    onSelect: (c) {
                                      billingCountry.text = c.countryCode;
                                    });
                                setState(() {});
                              },
                              controller: billingCountry,
                              decoration: InputDecoration(
                                  label:
                                      Text('Billing country', style: TextStyle(color: inCardColor)),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 95.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          final isValed = _formKey.currentState?.validate() ?? false;
                          String givenName = firstName;
                          String surname = lastName;
                          String customerEmail = email;
                          _formKey.currentState?.save();

                          if (isValed) {
                            final data = <String, String>{
                              "customer.givenName": givenName,
                              "customer.surname": surname,
                              "customer.email": customerEmail,
                              "billing.street1": billingStreet.text,
                              "billing.city": billingCity.text,
                              "billing.state": billingState.text,
                              "billing.country": billingCountry.text,
                              "billing.postcode": billingPostcode.text.toString(),
                            };
                            Navigator.of(context).pop(data);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: accept ? primaryblue : Colors.grey),
                        child: Text(AppLocalizations.of(context)?.apply ?? 'Apply'),
                      ),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ));
  }
}
