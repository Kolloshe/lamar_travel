// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Model/cancelltionpolicy.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screen/customize/new-customize/new_customize.dart';
import 'my-bookinglist.dart';

class CancelBookingScreen extends StatefulWidget {
  const CancelBookingScreen(
      {Key? key, required this.cancelReasons, required this.cancellation, required this.refNO})
      : super(key: key);

  final List<String> cancelReasons;
  final CancellationPolicy cancellation;
  final String refNO;

  @override
  _CancelBookingScreenState createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  String _reasonValue = '';

  CancellationPolicyClass? _policyClass;

  final userNoteController = TextEditingController();

  @override
  void initState() {
    _policyClass = widget.cancellation.data.cancellationPolicy;
    _reasonValue = widget.cancelReasons[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cancelBooking,
          style: TextStyle(color: blackTextColor, fontSize: titleFontSize),
        ),
        centerTitle: true,
        backgroundColor: cardcolor,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 25.sp,
              color: primaryblue,
            )),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child:  widget.cancellation.data.cancellationPolicy.c!= null ? _buildPricereturn():const SizedBox(),
                // ),
                _buildSpacer(w: 0, h: 1),
                SizedBox(
                  width: 100.w,
                  child: Text(widget.cancellation.data.cancellationPolicy.refundText,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                _buildSpacer(w: 0, h: 2),
                SizedBox(
                  width: 100.w,
                  height: 30.h,
                  child: _buildCancelReasons(widget.cancelReasons),
                ),
                _buildSpacer(w: 0, h: 3),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: userNoteController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.otherReason,
                        border: InputBorder.none),
                  ),
                ),
                _buildSpacer(w: 0, h: 3),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: getUserData,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryblue, fixedSize: Size(60.w, 5.h)),
                      child: Text(AppLocalizations.of(context)!.cancelBooking),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpacer({required double w, required double h}) => SizedBox(width: w.w, height: h.h);

  Widget _buildCancelReasons(List<String> reasons) => Wrap(
        children: [
          for (var i = 0; i < reasons.length; i++)
            ListTile(
              minVerticalPadding: 1.sp,
              title: Text(reasons[i]),
              horizontalTitleGap: 1,
              leading: Radio<String>(
                value: reasons[i],
                groupValue: _reasonValue,
                onChanged: (value) {
                  setState(() {
                    _reasonValue = value!;
                    if (kDebugMode) {
                      print(_reasonValue);
                    }
                  });
                },
              ),
            ),
        ],
      );

  // Widget _buildPricereturn() {
  //   return Container(
  //     width: 40.w,
  //     margin: EdgeInsets.all(5),
  //     padding: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: greencolor, width: 1.5),
  //     ),
  //     child: Center(
  //       child: Text(
  //         widget.cancellation.data.cancellationType.toString(),
  //         style: TextStyle(color: greencolor, fontWeight: FontWeight.w600),
  //       ),
  //     ),
  //   );
  // }

  //?  FUNCTIONS  ///////////////////////////

  getUserData() async {
    bool acceptCancelling = false;

    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('Are you sure you want to cancel this booking'),
              actions: [
                TextButton(
                    onPressed: () {
                      acceptCancelling = true;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel', style: TextStyle(color: Colors.redAccent))),
                TextButton(
                    onPressed: () {
                      acceptCancelling = false;
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      style: TextStyle(color: greencolor),
                    ))
              ],
            ));

    if (!acceptCancelling) return;

    Map<String, dynamic> userInput = {
      "refNo": widget.refNO,
      "cancel": userNoteController.text,
      "reasonOpn": _reasonValue,
      "currency": gencurrency
    };
    final data = jsonEncode(userInput);

    // displayTostmessage(context, true, message: 'Under development');
   // Navigator.of(context).pushNamed(MiniLoader.idScreen);
   if (!mounted) return;
                                     pressIndcatorDialog(context);

    final cancellationRES = await AssistantMethods.cancelBooking(data, context);
    if (!mounted) return;
    Navigator.of(context).pop();

    if (cancellationRES != null) {
      if (cancellationRES.code == 200) {
        if (!mounted) return;
        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: cancellationRES.message,
            title: 'your Booking has been Cancelled',
            lottieBuilder: Lottie.asset(
              'assets/images/loading/done.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () async {
                  final pastbooking = await AssistantMethods.getuserBookingList(context);
if (!mounted) return;
                  Navigator.of(context)
                    ..pop()
                    ..pushReplacement(MaterialPageRoute(
                        builder: (context) => MyBookingScreen(
                              bookingList: pastbooking,
                            )));
                },
                text: AppLocalizations.of(context)!.backToBookingList,
                color: primaryblue,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ]);
      } else {
        if (!mounted) return;
        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: cancellationRES.message,
            title: 'Failed to Cancel your booking',
            lottieBuilder: Lottie.asset(
              'assets/images/loading/failed.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                text: AppLocalizations.of(context)!.cancel,
                color: primaryblue,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ]);
      }
    }
  }
}
