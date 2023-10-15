// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';

import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/booking/InfomationModel.dart';
import 'package:lamar_travel_packages/screen/booking/newPreBooking/new_prebook_terims_and_comments.dart';
import 'package:lamar_travel_packages/screen/booking/summrey_and_pay.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';

import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';

import 'newPreBooking/passingerprebookingform.dart';
import 'newPreBooking/request_to_room.dart';

class PreBookStepper extends StatefulWidget {
  static String idScreen = 'PreBookStepper';

  PreBookStepper({Key? key, required this.isFromNavBar}) : super(key: key);
  bool isFromNavBar = false;

  @override
  _PreBookStepperState createState() => _PreBookStepperState();
}

class _PreBookStepperState extends State<PreBookStepper> with TickerProviderStateMixin {
  final itemController = ItemScrollController();
  final controller = TextEditingController();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late Animation<double> _animation;
  String x = 'dd';
  int i = -1;

  @override
  void initState() {
    i = -1;
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [
                  0.1,
                  0.2,
                  0.5,
                ],
                colors: [
                  primaryblue,
                  const Color(0xff788cb6),
                  yellowColor,
                ],
              )),
            ),
            Positioned(
                top: 15.h,
                left: Provider.of<AppData>(context, listen: false).locale == const Locale("en")
                    ? 7.w
                    : 40.w,
                child: SizedBox(
                  //  width: 80.w,
                  child: Consumer<AppData>(
                    builder: (BuildContext context, title, Widget? child) {
                      return FadeTransition(
                        opacity: _animation,
                        child: Text(
                          title.preBookTitle,
                          style: TextStyle(
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              color: Colors.white),
                        ),
                      );
                    },
                  ),
                )),
            Builder(builder: (context) {
              switch (i) {
                case -1:
                  // Provider.of<AppData>(context, listen: false).title = ;

                  _controller.reset();
                  _controller.forward();

                  return NewPassingerPerBookingForm(
                    toNextPage: () {
                      if (context.read<AppData>().searchMode.contains('flight') ||
                          context.read<AppData>().searchMode.contains('activity')) {
                        if (context.read<AppData>().hasQuestions) {
                          setState(() {
                            i = 1;
                          });
                        } else {
                          collectingUserInformation();
                        }
                      } else {
                        i = 0;
                      }

                      setState(() {});
                    },
                    fromIndv: widget.isFromNavBar,
                  );
                case 0:
                  _controller.reset();
                  _controller.forward();
                  //  Provider.of<AppData>(context, listen: false).title = 'Where To';

                  return RequestToTheRoom(
                    goback: () {
                      setState(() {
                        i = -1;
                      });
                    },
                    tonextPage: () {
                      if (context.read<AppData>().hasQuestions) {
                        setState(() {
                          i = 1;
                        });
                      } else {
                        collectingUserInformation();
                      }
                    },
                  );

                case 1:
                  _controller.reset();
                  _controller.forward();
                  return ShowActivityQuestions(goback: () {
                    if (context.read<AppData>().searchMode.contains('activity')) {
                      i = -1;
                    } else {
                      i = 0;
                    }
                    setState(() {});
                  }, toNextPage: () {
                    collectingUserInformation();
                  });
                case 2:
                  _controller.reset();
                  _controller.forward();
                  return Builder(builder: (context) {
                    return Container();
                  });

                default:
                  return Container();
              }
            }),
          ],
        ));
  }

  String phoneNumer = '';
  String counterPhoneCode = 'AE';
  late Map<String, Forms> finalpassingerList;

  collectingUserInformation() async {
    if (users.data.phone == '') {
      displayTostmessage(context, false,
          message: AppLocalizations.of(context)!.youAccountMissSomeInformation);
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      final isupdate = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserProfileInfomation(
                isFromPreBook: true,
              )));
      //print(isupdate.toString());

      if (!isupdate) return;
    } else {
      phoneNumer = users.data.phone;
      counterPhoneCode = users.data.countryCode ?? '';
    }
    if (!mounted) return;
    // Navigator.pushNamed(context, MiniLoader.idScreen);
    pressIndcatorDialog(context);
    // Navigator.pushNamed(context, LoadingWidgetMain.idScreen);

    List<dynamic> finalPassingerInformationList = [];
    if (Provider.of<AppData>(context, listen: false).passingerList.isNotEmpty) {
      finalpassingerList = Provider.of<AppData>(context, listen: false).passingerList;
    }

    finalpassingerList.forEach(
      (key, value) {
        finalPassingerInformationList.add(value.toJson());
      },
    );

    dynamic activityQuestions = {};
    final questions = context.read<AppData>().getActivityQuestions;

    if (questions != null) {
      if (questions.data != null) {
        activityQuestions = questions.data!.map((e) => e.toMap()).toList();
      }
      //
    }

    Map<String, dynamic> userlogin = {
      "email": context.read<AppData>().getHolderEmail,
      "phonecode": context.read<AppData>().preBookPhoneCountryCode,
      "phonenumber": context.read<AppData>().preBookPhoneNumber,
      "selected_title": finalpassingerList['adult1']!.type,
      "surname": finalpassingerList['adult1']!.surname,
      "name": finalpassingerList['adult1']!.firstName,
      // "phonenumber": phoneNumer,
      // "phonecode": counterPhoneCode
    };
    Map<String, dynamic> userInformation = {
      "holder": userlogin,
      "token": users.data.token,
      "passengers": finalPassingerInformationList,
      "sellingCurrency": gencurrency,
      "customizeId":
          Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
      "specialRequest": [
        {
          "interconnecting_rooms": false,
          "smoking_room": Provider.of<AppData>(context, listen: false).requireaSmokingRoom,
          "non_smoking_room": Provider.of<AppData>(context, listen: false).requireaNonSmokingRoom,
          "room_low_floor": Provider.of<AppData>(context, listen: false).requestRoomonaLowFloor,
          "room_high_floor": Provider.of<AppData>(context, listen: false).requestRoomonaHighFloor,
          "vip_guest": false,
          "honeymoon": Provider.of<AppData>(context, listen: false).honeymoonTrip,
          "babycot": Provider.of<AppData>(context, listen: false).requestforaBabyCot,
          "birthday": Provider.of<AppData>(context, listen: false).celebratingBirthday,
          "anniversary": Provider.of<AppData>(context, listen: false).celebratingAnniversary,
          "other_request": Provider.of<AppData>(context, listen: false).otherRE
        }
      ],
      "accept_terms": Provider.of<AppData>(context, listen: false).acceptprebookterm,
      "selected_language": genlang,
      "selected_currency": gencurrency,
      "game_coins": Provider.of<AppData>(context, listen: false).userCollectedPoint,
      "activity_question_answers": activityQuestions,
    };

    String data = jsonEncode(userInformation);

    log(data);
    Provider.of<AppData>(context, listen: false).getPreBookREQData(userInformation);

    try {
      final isfaild = await AssistantMethods.newPreBook(data, users.data.token, context);

      if (isfaild == null) {
        return;
      } else if (isfaild) {
        if (!mounted) return;

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => SumAndPay(
                  isIndv: widget.isFromNavBar,
                )));
      } else {
        if (!mounted) return;

        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => context.read<AppData>().searchMode.isEmpty
                      ? const PackagesScreen()
                      : const IndividualPackagesScreen()),
              (route) => false);
        }
        // if (Navigator.of(context).canPop()) {
        //   Navigator.of(context).pop();
        // }

        if (fullName != '') {
          // pressIndcatorDialog(context);
          // Navigator.of(context).canPop()?Navigator.of(context).pop():null;
          await Provider.of<AppData>(context, listen: false).hundelPreBookResult(context);
        }
      }
    } catch (e) {
      displayTostmessage(context, false,
          isInformation: true, message: "This package is  unavailable at this moment");
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => context.read<AppData>().searchMode.isEmpty
                    ? const PackagesScreen()
                    : const IndividualPackagesScreen()),
            (route) => false);
      }
    }
  }

  String citityPhoneCode = '971';

  Future country() async {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        citityPhoneCode = country.phoneCode;
        //  print(citityPhoneCode);
        setState(() {});
      },
    );
  }

  //
  // Widget _buildFaildCard(Map<String, String> faild, int i) => Container(
  //       width: MediaQuery.of(context).size.width * 0.8,
  //       padding: const EdgeInsets.all(5),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           IconButton(
  //             onPressed: () {
  //               scrollToItem(i, false);
  //             },
  //             icon: Icon(Icons.keyboard_arrow_left),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Icons.warning,
  //                 color: yellowColor,
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 "sorry we couldn't confirm",
  //                 style: TextStyle(
  //                   fontSize: titleFontSize,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               SizedBox(
  //                 width: MediaQuery.of(context).size.width * 0.5,
  //                 height: MediaQuery.of(context).size.height * 0.15,
  //                 child: Text(
  //                   faild.values.elementAt(i),
  //                   maxLines: 6,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //               Text('${i + 1} / ${faild.length}'),
  //               OutlinedButton(
  //                   onPressed: () async {
  //                     switch (faild.keys.elementAt(i)) {
  //                       case "activityFail":
  //                         print('>>>>>' + faild.toString());
  //                         Navigator.pushNamed(context, ManageActivity.idScreen);
  //                         break;
  //                       case "flightFail":
  //                         String customizeId = Provider.of<AppData>(context, listen: false)
  //                             .packagecustomiz
  //                             .result
  //                             .customizeId;
  //                         String flightclass = Provider.of<AppData>(context, listen: false)
  //                             .packagecustomiz
  //                             .result
  //                             .flight!
  //                             .flightClass;
  //                         try {
  //                           await AssistantMethods.changeflight(customizeId, flightclass, context);
  //                           Navigator.pop(context);
  //                           Navigator.of(context).push(
  //                             MaterialPageRoute(
  //                               builder: (context) =>  FlightCustomize(failedFlightNamed: '',),
  //                             ),
  //                           );
  //                         } catch (e) {
  //                           Navigator.pop(context);
  //                           Errordislog().error(context, e.toString());
  //                         }
  //                         break;
  //                       case "transferFail":
  //                         updateTransfer(
  //                             context,
  //                             Provider.of<AppData>(context, listen: false)
  //                                 .packagecustomiz
  //                                 .result
  //                                 .customizeId);
  //                         Navigator.of(context).popAndPushNamed(CustomizeSlider.idScreen);
  //
  //                         break;
  //                       case "hotelFail":
  //                         // print('object');
  //                         Navigator.pushNamed(context, CustomizeSlider.idScreen);
  //
  //                         break;
  //                       default:
  //                     }
  //                   },
  //                   child: const Text('Change'))
  //             ],
  //           ),
  //           IconButton(
  //             onPressed: () {
  //               scrollToItem(i, true);
  //             },
  //             icon: const Icon(Icons.keyboard_arrow_right),
  //           ),
  //         ],
  //       ),
  //     );

  final itemKey = GlobalKey();

  Future scrollToItem(int i, bool isnext) async {
    setState(() {
      isnext
          ? itemController.jumpTo(index: i + 1)
          : i < 1
              ? null
              : itemController.jumpTo(index: i - 1);
    });
  }

  updateTransfer(BuildContext context, String custoizeId) async {
    try {
      Map<String, dynamic> saveddata = {
        "customizeId":
            Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId,
        "transferType": 'out',
        "sellingCurrency":
            Provider.of<AppData>(context, listen: false).packagecustomiz.result.sellingCurrency
      };

      var data = jsonEncode(saveddata);

      await AssistantMethods.removeTransfer(data);
      if (!mounted) return;

      await AssistantMethods.updateHotelDetails(custoizeId, context);
      await AssistantMethods.updateThePackage(custoizeId);
      if (!mounted) return;

      await AssistantMethods.updateHotelDetails(custoizeId, context);
    } catch (e) {
      Navigator.pushNamed(context, CustomizeSlider.idScreen);
    }
  }
}
