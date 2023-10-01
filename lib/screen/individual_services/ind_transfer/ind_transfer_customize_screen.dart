// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_customize_model.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../main_screen1.dart';

class IndTransferCustomizeScreen extends StatefulWidget {
  const IndTransferCustomizeScreen({Key? key, required this.customize, required this.id})
      : super(key: key);
  final IndTransferCustomizeModel customize;
  final String id;

  @override
  _IndTransferCustomizeScreenState createState() => _IndTransferCustomizeScreenState();
}

class _IndTransferCustomizeScreenState extends State<IndTransferCustomizeScreen> {
  IndTransferCustomizeModel? customize;
  bool isLogin = false;

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  @override
  void initState() {
    getlogin();
    customize = widget.customize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.transferDetail,
          style: TextStyle(fontSize: 12.sp),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: kToolbarHeight - 20),
            child: Column(
              children: [for (var transfer in customize!.result.transfer) _buildFromTo(transfer)],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: 100.w,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
          onPressed: () async {
            getlogin();
            // <=======   Check if it loggedIn then   =======>>>>
            await AssistantMethods.customizingPackage(context, widget.id);
            if (Provider.of<AppData>(context, listen: false).isFromdeeplink) {
              pressIndcatorDialog(context);
              await Future.delayed(const Duration(seconds: 2), () {
                if (!isLogin) {
                  getlogin();
                }
              });
              Navigator.of(context).pop();
            }
            if (isLogin) {
              if (users.data.phone.isEmpty) {
                displayTostmessage(context, false,
                    message: AppLocalizations.of(context)!.youAccountMissSomeInformation);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserProfileInfomation(
                          isFromPreBook: true,
                        )));
              } else {
                Provider.of<AppData>(context, listen: false)
                    .newPreBookTitle(AppLocalizations.of(context)!.passengersInformation);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PreBookStepper(
                          isFromNavBar: true,
                        )));
                Provider.of<AppData>(context, listen: false).resetSelectedPassingerfromPassList();
              }
            } else {
              isFromBooking = true;
              Navigator.of(context).pushNamed(NewLogin.idScreen);
            }
          },
          child: Text(AppLocalizations.of(context)!.bookNow),
        ),
      ),
    );
  }

  Widget _buildFromTo(IndCustomizeTransferData data) => Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.07))
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 100.w,
                child: Row(
                  children: [
                    Text(data.date, style: const TextStyle(color: Colors.grey)),
                    SizedBox(width: 5.w),
                    Text(data.time, style: const TextStyle(color: Colors.grey))
                  ],
                )),
            SizedBox(height: 1.h),
            Divider(color: Colors.black.withOpacity(0.2), indent: 10, endIndent: 10),
            SizedBox(
                width: 100.w,
                height: 7.h,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 20,
                      color: primaryblue,
                    ),
                    SizedBox(width: 1.w),
                    SizedBox(width: 75.w, child: Text(data.pickup)),
                  ]),
                  Row(children: [
                    const Icon(
                      FontAwesomeIcons.crosshairs,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(width: 1.w),
                    SizedBox(
                        width: 70.w,
                        child: Text(
                          data.dropoff,
                        ))
                  ])
                ])),
            SizedBox(height: 1.h),
            const Divider(),
            SizedBox(height: 1.h),
            _buildTitle(AppLocalizations.of(context)!.pickupInformation),
            SizedBox(height: 0.5.h),
            ReadMoreText(
              data.pickupInformation,
              style: const TextStyle(color: Colors.black),
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: AppLocalizations.of(context)!.showMore,
              trimExpandedText: AppLocalizations.of(context)!.showLess,
              moreStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 1.h),
            _buildTitle(AppLocalizations.of(context)!.carDetails),
            SizedBox(height: 0.5.h),
            SizedBox(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    "${data.serviceTypeName} ${data.productTypeName} ${data.vehicleTypeName}"),
              ]),
            ),
            SizedBox(height: 1.h),
            data.waitingInfo.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(AppLocalizations.of(context)!.waitingInformation),
                      SizedBox(height: 0.5.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < data.waitingInfo.length; i++)
                            Text(data.waitingInfo[i]),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            data.waitingInfo.isNotEmpty
                ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(height: 1.h),
                    _buildTitle(AppLocalizations.of(context)!.generalInformation),
                    SizedBox(height: 0.5.h),
                    for (int i = 0; i < data.generalInformation.length; i++)
                      Text(data.generalInformation[i])
                  ])
                : const SizedBox(),
          ],
        ),
      );

  _buildTitle(String title) => SizedBox(
        width: 100.w,
        child: Text(title, style: const TextStyle(color: Colors.grey)),
      );
}
