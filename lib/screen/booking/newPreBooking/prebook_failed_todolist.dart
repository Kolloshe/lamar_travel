// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/Model/prebookfaild.dart';
import 'package:lamar_travel_packages/screen/customize/activity/activitylist.dart';
import 'package:lamar_travel_packages/screen/customize/flightcustomiz.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/hotelcustomize.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/customize/transfer/transferCoustomize.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';
import '../../main_screen1.dart';
import '../prebooking_steper.dart';
import '../summrey_and_pay.dart';

class PreBookTodo extends StatefulWidget {
  static const String idScreen = 'PrebookFailedScreen';

  const PreBookTodo({Key? key, required this.isIndv}) : super(key: key);
  final bool isIndv;

  @override
  _PreBookTodoState createState() => _PreBookTodoState();
}

class _PreBookTodoState extends State<PreBookTodo> {
  PrebookFalid? prebookFalid;
  bool activityCheckBox = true;
  bool flightCheckBox = true;
  bool hotelCheckBox = true;
  bool transferCheckBox = true;

  getData() {
    prebookFalid = Provider.of<AppData>(context, listen: false).prebookFalid;

    preparedata();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // preparedata();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(
          AppLocalizations.of(context)!.failedServices,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(AppLocalizations.of(context)!.sureToCancelTheBooking),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Provider.of<AppData>(context, listen: false)
                                  .changePrebookFaildStatus(false);
                              if (widget.isIndv) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const IndividualPackagesScreen()),
                                    (route) => false);

                                Provider.of<AppData>(context, listen: false)
                                    .changePrebookFaildStatus(false);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    CustomizeSlider.idScreen, (route) => false);
                                Provider.of<AppData>(context, listen: false)
                                    .changePrebookFaildStatus(false);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: const TextStyle(color: Colors.redAccent),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // if(    context.read<AppData>().searchMode.isEmpty){
                              //       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>PackagesScreen()),(route)=>false);
                              //     }else
                              //       {
                              //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>IndividualPackagesScreen()),(route)=>false);
                              //
                              //       }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.contin,
                              style: const TextStyle(color: Colors.green),
                            )),
                      ],
                    ));
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 24.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                //prebookFalid!.data.prebookDetails == null
                //               ? Column(
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.all(10),
                //                 child: Text(
                //                   'All services of your holiday package are ready and available to booking ',style: TextStyle(fontSize: titleFontSize,fontWeight: FontWeight.w500),),
                //               ),
                //               prebookFalid!.data.details.noFlights
                //                   ?SizedBox()
                //                   :
                //             _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Flight' ,  serviceIcons:
                //               ServiceIcons(
                //                 iconData: Icons.flight,
                //                 colors: Colors.green,
                //               ),),
                //               prebookFalid!.data.details.noHotels
                //                   ?SizedBox()
                //                   :
                //            _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Hotel' ,  serviceIcons:
                //               ServiceIcons(
                //                 iconData: Icons.hotel,
                //                 colors: Colors.green,
                //               ),),
                //               prebookFalid!.data.details.noTransfers
                //                   ?SizedBox()
                //                   :
                //          _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Transfer' ,  serviceIcons:
                //               ServiceIcons(
                //                 iconData: Icons.directions_car_sharp,
                //                 colors: Colors.green,
                //               ),),
                //               prebookFalid!.data.details.noActivities
                //                   ?SizedBox()
                //                   :SizedBox(),
                // // _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Activity' ,  serviceIcons:
                // //               ServiceIcons(
                // //                 iconData: Icons.directions_run_sharp,
                // //                 colors: Colors.green,
                // //               ),)
                //               ,
                //               SizedBox(
                //                 height: 3.h,
                //               ),
                //               isReadytosum?    Container(
                //                 width: 100.w,
                //                 padding: EdgeInsets.symmetric(vertical: 1.h),
                //                 child: ElevatedButton(
                //                   onPressed: (){
                //                     Navigator.of(context).pop();
                //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SumAndPay()));
                //                   }
                //                   ,
                //                   child: Text('To summery and pay'),
                //                   style: ElevatedButton.styleFrom(
                //                       primary: Colors.green,
                //                       fixedSize: Size(100.w, 6.h)
                //
                //                   ),
                //                 ),
                //               ) :SizedBox() ],
                //           )
                //               :
                prebookFalid == null
                    ? const SizedBox()
                    : prebookFalid!.data.prebookDetails == null
                        ? const SizedBox()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  AppLocalizations.of(context)!.failedSomeServices,
                                  style: TextStyle(
                                      fontSize: titleFontSize, fontWeight: FontWeight.w500),
                                ),
                              ),
                              prebookFalid!.data.details.noFlights
                                  ? const SizedBox()
                                  : !prebookFalid!.data.prebookDetails!.flights!.prebookSuccess
                                      ? (prebookFalid!.data.prebookDetails!.flights?.failedReasons
                                                  ?.fielderrors ??
                                              false)
                                          ? _buildsomething(
                                              onTap: flightHundle,
                                              serviceIcons: // ServiceIcons(
                                                  const ServiceIcons(
                                                iconData: Icons.flight,
                                                colors: Colors.redAccent,
                                              ),
                                              serviceBoolKey: false,
                                              serviceName:
                                                  AppLocalizations.of(context)!.checkPassengerInfo,
                                              serviceDetals: AppLocalizations.of(context)!
                                                  .passengerInformationIssue)
                                          : _buildsomething(
                                              onTap: flightHundle,
                                              serviceIcons: // ServiceIcons(
                                                  const ServiceIcons(
                                                iconData: Icons.flight,
                                                colors: Colors.redAccent,
                                              ),
                                              serviceBoolKey: false,
                                              serviceName: AppLocalizations.of(context)!.flight,
                                              serviceDetals: (prebookFalid!
                                                          .data.prebookDetails!.flights?.details ??
                                                      [])[0]
                                                  .details
                                                  .carrierName)
                                      : const SizedBox(),
                              // _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Flight' ,  serviceIcons:
                              //   ServiceIcons(
                              //   iconData: Icons.flight,
                              //   colors: Colors.green,
                              // ),),
                              prebookFalid!.data.details.noHotels
                                  ? const SizedBox()
                                  : SizedBox(
                                      height:
                                          !prebookFalid!.data.prebookDetails!.hotels!.prebookSuccess
                                              ? 2.h
                                              : 0,
                                    ),
                              prebookFalid!.data.details.noHotels
                                  ? const SizedBox()
                                  : !(prebookFalid!.data.prebookDetails!.hotels?.prebookSuccess ??
                                          true)
                                      ? _buildsomething(
                                          onTap: hotelHundle,
                                          serviceIcons: // ServiceIcons(
                                              const ServiceIcons(
                                            iconData: Icons.hotel,
                                            colors: Colors.redAccent,
                                          ),
                                          serviceBoolKey: false,
                                          serviceName: AppLocalizations.of(context)!.yourhotel,
                                          serviceDetals: prebookFalid!
                                              .data.prebookDetails!.hotels!.details[0].details.name)
                                      : const SizedBox(),
                              // _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Hotel' ,  serviceIcons:
                              // ServiceIcons(
                              //   iconData: Icons.hotel,
                              //   colors: Colors.green,
                              // ),),
                              SizedBox(
                                height:
                                    prebookFalid!.data.prebookDetails!.transfers?.prebookSuccess ??
                                            false
                                        ? 2.h
                                        : 0,
                              ),
                              prebookFalid!.data.details.noTransfers
                                  ? const SizedBox()
                                  : !(prebookFalid!
                                              .data.prebookDetails!.transfers?.prebookSuccess ??
                                          false)
                                      ? _buildsomething(
                                          onTap: transferHundle,
                                          serviceIcons: // ServiceIcons(
                                              const ServiceIcons(
                                            iconData: Icons.directions_car_sharp,
                                            colors: Colors.redAccent,
                                          ),
                                          serviceBoolKey: false,
                                          serviceName: AppLocalizations.of(context)!.transfer
                                          //    'Transfer'
                                          ,
                                          serviceDetals:
                                              '${prebookFalid!.data.prebookDetails!.transfers!.details[0].details.serviceTypeName} ${prebookFalid!.data.prebookDetails!.transfers!.details[0].details.vehicleTypeName}')
                                      : const SizedBox(),

                              // _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Transfer' ,  serviceIcons:
                              // ServiceIcons(
                              //   iconData: Icons.directions_car_sharp,
                              //   colors: Colors.green,
                              // ),),

                              prebookFalid!.data.details.noActivities
                                  ? const SizedBox()
                                  : !(prebookFalid!
                                              .data.prebookDetails!.activites?.prebookSuccess ??
                                          false)
                                      ? Column(
                                          children: [
                                            for (int i = 0; i < activitesDetail.length; i++)
                                              _buildsomething(
                                                  onTap: () {
                                                    pressIndcatorDialog(context);
                                                    activityHundle(activitesDetail[i]);
                                                  },
                                                  serviceIcons: // ServiceIcons(
                                                      const ServiceIcons(
                                                    iconData: Icons.directions_run_sharp,
                                                    colors: Colors.redAccent,
                                                  ),
                                                  serviceBoolKey: false,
                                                  serviceName:
                                                      AppLocalizations.of(context)!.activity,
                                                  serviceDetals:
                                                      '${activitesDetail[i].details.name.trim()} \non ${DateFormat('dd/MMM', genlang).format(activitesDetail[i].details.activityDate)}')
                                          ],
                                        )
                                      : const SizedBox()
                              //
                              // _buildsomethingcorrent(serviceBoolKey: false,serviceName: 'Activity' ,  serviceIcons:
                              // ServiceIcons(
                              //   iconData: Icons.directions_run_sharp,
                              //   colors: Colors.green,
                              // ),)
                              // _buildExpantion()
                              ,
                              isReadytosum
                                  ? Container(
                                      width: 100.w,
                                      padding: EdgeInsets.symmetric(vertical: 1.h),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => SumAndPay(
                                                    isIndv: widget.isIndv,
                                                  )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryblue,
                                            fixedSize: Size(100.w, 6.h)),
                                        child: const Text('To summery and pay'),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
          ),
        ),
      ),
    );
  }

  bool testcheck = false;

  List<ActivitesDetail> activitesDetail = [];
  List<FlightsDetail> flightDetail = [];
  List<HotelsDetail> hotelsDetail = [];
  List<TransfersDetail> transfersDetail = [];

  bool isTest = true;

//++++++++++++++++++++++++ WIDGETS ++++++++++++++++++++++++++++++//
//
//   Widget _buildExpantion() => ExpansionTile(
//
//     collapsedBackgroundColor: cardcolor,
//
//     backgroundColor: cardcolor,
//           expandedAlignment: Alignment.center,
//           tilePadding: EdgeInsets.all(0),
//           leading:null,
//           trailing:null,
//           title:
//       _buildsomething(
//           onTap: () {},
//           serviceIcons: // ServiceIcons(
//           ServiceIcons(
//             iconData: Icons.directions_run_sharp,
//             colors: Colors.redAccent,
//           ),
//           serviceBoolKey: false,
//           serviceName: 'Activity'),
//           //Text('Activity'),
//           children: [
//             for (int i = 0; i < activitesDetail.length; i++)
//               ListTile(
//                 title: Text(activitesDetail[i].details.name),
//                 leading: Icon(Icons.sports_handball_sharp),
//                 onTap: () {
//                   pressIndcatorDialog(context);
//                   activityHundle(activitesDetail[i]);
//                 },
//               )
//           ]);
//
//   Widget _buildCardForFlight() => InkWell(
//         onTap: () {
//           flightHundle();
//         },
//         child: Card(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Checkbox(value: flightCheckBox, onChanged: (v) {}),
//               Text('FLight'),
//               Icon(Icons.keyboard_arrow_right)
//             ],
//           ),
//         ),
//       );
//
//   Widget _buildCardForHotel() => InkWell(
//         onTap: () {
//           hotelHundle();
//         },
//         child: Card(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Checkbox(value: hotelCheckBox, onChanged: (v) {}),
//               Text('Hotel '),
//               Icon(Icons.keyboard_arrow_right)
//             ],
//           ),
//         ),
//       );
//
//   Widget _buildCardForTransfer() => AnimatedSwitcher(
//       duration: Duration(milliseconds: 600),
//       child: isTest
//           ? InkWell(
//               key: Key('transferOnFailed'),
//               onTap: () {
//                 transferHundle();
//               },
//               child: Card(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Checkbox(
//                         value: transferCheckBox,
//                         onChanged: (v) {
//                           isTest = !isTest;
//                           setState(() {});
//                         }),
//                     Text('Transfer '),
//                     Icon(Icons.keyboard_arrow_right)
//                   ],
//                 ),
//               ),
//             )
//           : InkWell(
//               key: Key('transferOnDone'),
//               onTap: () {
//                 isTest = !isTest;
//                 setState(() {});
//                 // transferHundle();
//               },
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(Icons.done),
//
//                     // Checkbox(
//                     //     value: transferCheckBox,
//                     //     onChanged: (v) {
//                     //       isTest = !isTest;
//                     //       setState(() {});
//                     //     }),
//
//                     Text(isTest ? 'Transfer ' : 'Transfer Booked'),
//                     //  Icon(Icons.keyboard_arrow_right)
//
//                     Opacity(
//                         opacity: 0.3,
//                         child: Image.asset('assets/images/loader-aiwa.png', width: 10.w)),
//                   ],
//                 ),
//               ),
//             ));

  Widget _buildsomething(
          {required String serviceName,
          required bool serviceBoolKey,
          required ServiceIcons serviceIcons,
          required void Function() onTap,
          required serviceDetals}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          //padding: EdgeInsets.all(5),
          width: 100.w,
          height: 12.5.h,
          decoration: BoxDecoration(color: cardcolor, boxShadow: [shadow]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 100.h,
                  width: 3.w,
                  decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)))),
              SizedBox(width: 3.w),
              serviceIcons,
              // ServiceIcons(
              //   iconData: Icons.flight,
              //   colors: Colors.redAccent,
              // ),
              SizedBox(
                width: 3.w,
              ),
              SizedBox(
                width: 75.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.pleaseReplaceYour} $serviceName',
                          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            width: 60.w,
                            child: Text(
                              serviceDetals,
                              maxLines: 2,
                            )),
                      ],
                    ),
                    Icon(
                      Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? Icons.keyboard_arrow_right_rounded
                          : Icons.keyboard_arrow_left_rounded,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  // Widget _buildsomethingcorrent(
  //     {required String serviceName,
  //       required bool serviceBoolKey,
  //       required ServiceIcons serviceIcons,
  //
  //
  //     }) =>
  //     InkWell(
  //
  //       child: Container(
  //         margin: EdgeInsets.symmetric(vertical: 5),
  //         //padding: EdgeInsets.all(5),
  //         width: 100.w,
  //         height: 12.h,
  //         decoration: BoxDecoration(color: cardcolor, boxShadow: [shadow]),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //                 height: 100.h,
  //                 width: 3.w,
  //                 decoration: BoxDecoration(
  //                     color: Colors.green,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)))),
  //             SizedBox(
  //               width: 3.w,
  //             ),
  //             serviceIcons,
  //             // ServiceIcons(
  //             //   iconData: Icons.flight,
  //             //   colors: Colors.redAccent,
  //             // ),
  //             SizedBox(
  //               width: 3.w,
  //             ),
  //             SizedBox(
  //               width: 75.w,
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       SizedBox(
  //               width: 60.w,
  //                         child: Text(
  //                           'success to prepare your $serviceName to Booking',
  //                           style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
  //                           maxLines: 2,
  //                         ),
  //                       ),
  //
  //
  //
  //                     ],
  //                   ),
  //                   Icon(Icons.keyboard_arrow_right)
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );

//++++++++++++++++++++++++  FUNCTIONS  +++++++++++++++++++++++++//
  bool isReadytosum = false;

  void preparedata() async {
    if (prebookFalid != null) {
      final failedPrebookDetails = prebookFalid!.data.prebookDetails;

      if (failedPrebookDetails != null) {
        if (failedPrebookDetails.activites?.details.isNotEmpty ?? false) {
          activitesDetail = failedPrebookDetails.activites!.details;
          activityCheckBox = false;
        } else {
          activityCheckBox = true;
          activitesDetail.clear();
        }
        if (failedPrebookDetails.flights?.details.isNotEmpty ?? false) {
          flightDetail = failedPrebookDetails.flights!.details;
          flightCheckBox = false;
        } else {
          flightCheckBox = true;
        }
        if (failedPrebookDetails.hotels?.details.isNotEmpty ?? false) {
          hotelsDetail = failedPrebookDetails.hotels!.details;
          hotelCheckBox = false;
        } else {
          hotelCheckBox = true;
        }
        if ((Provider.of<AppData>(context, listen: false)
                .prebookFalid!
                .data
                .prebookDetails!
                .transfers
                ?.details
                .isNotEmpty ??
            false)) {
          transfersDetail = failedPrebookDetails.transfers!.details;
          transferCheckBox = false;
        } else {
          transferCheckBox = true;
        }
      } else {
        setState(() {
          isReadytosum = true;
        });

        final data = jsonEncode(Provider.of<AppData>(context, listen: false).preBookREQData);

        final hasError = await AssistantMethods.newPreBook(data, users.data.token, context);
        setState(() {});
        if (hasError != null) {
          if (hasError) {
            if (!mounted) return;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SumAndPay(
                      isIndv: widget.isIndv,
                    )));
          } else {
            if (!mounted) return;
            Navigator.of(context)
              ..pop()
              ..push(MaterialPageRoute(builder: (context) => PreBookTodo(isIndv: widget.isIndv)));
            return;
          }
        } else {}
      }
    }
  }

  void activityHundle(ActivitesDetail detail) async {
    final packagecustomiz = Provider.of<AppData>(context, listen: false).packagecustomiz;

    final allActivityMap = packagecustomiz.result.activities as Map<String, List<Activity>>;
    final allActivityList = allActivityMap.values.toList();
    final allActivity = allActivityList.map((e) => e[0]).toList();

    final failedActiviyDaysList =
        allActivity.where((element) => element.activityDate.isAtSameMomentAs(detail.date)).toList();
    Provider.of<AppData>(context, listen: false).getfailedActivityDay(failedActiviyDaysList[0].day);

    Provider.of<AppData>(context, listen: false).getActivityDateString(detail.date);
    Provider.of<AppData>(context, listen: false)
        .getFailedActivityID(failedActiviyDaysList[0].activityId);

    await AssistantMethods.getActivityList(context,
        searchId: packagecustomiz.result.searchId,
        customizeId: packagecustomiz.result.customizeId,
        activityDay: detail.date.toString(),
        currency: gencurrency);
            if (!mounted) return;

    Navigator.of(context).pop();
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ActivityList(faildActivity: detail.details.name)));

    makePrebook();
  }

  void transferHundle() async {
    pressIndcatorDialog(context);

    if (context.read<AppData>().searchMode.contains('transfer')) {
      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
      return;
    }

    final hasData = await AssistantMethods.changeTransfer(
        Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
        'IN',
        context);
                    if (!mounted) return;

    Navigator.of(context).pop();
    if (hasData) {
      Provider.of<AppData>(context, listen: false).changeTransferCounter(
          Provider.of<AppData>(context, listen: false).transferChangeCounter += 1);
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const TransferCustomize()));
      makePrebook();
    } else {
      displayTostmessage(context, false, message: "We can't add transfer for this package");
      await AssistantMethods.sectionManager(context,
          section: 'transfer',
          cusID: Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
          action: 'remove');
      makePrebook();
    }
  }

  void hotelHundle() async {
    if (Provider.of<AppData>(context, listen: false)
        .prebookFalid!
        .data
        .prebookDetails!
        .hotels!
        .details
        .isNotEmpty) {
      pressIndcatorDialog(context);
     await AssistantMethods.changehotel(context,
          customizeId:
              Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
          checkIn: DateFormat("yyyy-mm-dd").format(Provider.of<AppData>(context, listen: false)
              .prebookFalid!
              .data
              .prebookDetails!
              .hotels!
              .details
              .first
              .details
              .checkIn),
          checkOut: DateFormat("yyyy-mm-dd").format(Provider.of<AppData>(context, listen: false)
              .prebookFalid!
              .data
              .prebookDetails!
              .hotels!
              .details[0]
              .details
              .checkout),
          hId: Provider.of<AppData>(context, listen: false)
              .prebookFalid!
              .data
              .prebookDetails!
              .hotels!
              .details[0]
              .details
              .hotelId,
          star: Provider.of<AppData>(context, listen: false)
              .prebookFalid!
              .data
              .prebookDetails!
              .hotels!
              .details[0]
              .details
              .starRating);
                          if (!mounted) return;

      Navigator.of(context).pop();
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HotelCustomize(
              oldHotelID: Provider.of<AppData>(context, listen: false)
                  .prebookFalid!
                  .data
                  .prebookDetails!
                  .hotels!
                  .details[0]
                  .details
                  .hotelId
                  .toString(),
              hotelFailedName: Provider.of<AppData>(context, listen: false)
                  .prebookFalid!
                  .data
                  .prebookDetails!
                  .hotels!
                  .message)));
      makePrebook();
    }
  }

  void flightHundle() async {
    var prebookDetail =
        Provider.of<AppData>(context, listen: false).prebookFalid!.data.prebookDetails;
    if ((prebookDetail!.flights?.prebookSuccess ?? false) == false) {
      if (prebookDetail.flights != null && prebookDetail.flights!.failedReasons!.fielderrors!) {
        Provider.of<AppData>(context, listen: false).resetFlightFromForm(true);

        displayTostmessage(context, true,
            message: 'Please make sure to fill the form with correct information');
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PreBookStepper(
                  isFromNavBar: widget.isIndv,
                )));
                            if (!mounted) return;

        Provider.of<AppData>(context, listen: false).resetFlightFromForm(false);
        makePrebook();
      } else {
        pressIndcatorDialog(context);
        final x = await AssistantMethods.changeflight(
            Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
            "Y",
            context);
        if (x != null) {
                      if (!mounted) return;

          Navigator.of(context).pop();
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FlightCustomize(
                    failedFlightNamed: prebookDetail.flights?.message ?? "Flight failed ",
                  )));
          makePrebook();
        } else {
                      if (!mounted) return;

          displayTostmessage(context, false, message: 'Flight booking failed ');
          Navigator.of(context).pop();
        }
                    if (!mounted) return;

        await AssistantMethods.updateThePackage(
            Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId);
      }
    }
  }

  void makePrebook() async {
    final data = jsonEncode(Provider.of<AppData>(context, listen: false).preBookREQData);
    pressIndcatorDialog(context);
    await AssistantMethods.newPreBook(data, users.data.token, context);
                if (!mounted) return;

    Navigator.of(context).pop();
    getData();
    setState(() {});
  }

  showFailedActivity() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        'Unsecured Activity',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: titleFontSize),
                      ),
                      SizedBox(
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                      )
                    ],
                  ),
                ),
                for (int i = 0; i < activitesDetail.length; i++)
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${activitesDetail[i].details.name.trim()} \non ${DateFormat('dd/MMM').format(activitesDetail[i].details.activityDate)}'),
                        SizedBox(
                          height: 1.h,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.3),
                        )
                      ],
                    ),
                    leading: const ServiceIcons(
                      iconData: Icons.directions_run_sharp,
                      colors: Colors.redAccent,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      pressIndcatorDialog(context);
                      activityHundle(activitesDetail[i]);
                    },
                  )
              ],
            ));
  }
}

class ServiceIcons extends StatelessWidget {
  const ServiceIcons({Key? key, required this.iconData, required this.colors}) : super(key: key);

  final Color colors;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
