// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import '../../Assistants/assistant_methods.dart';
import '../../Datahandler/adaptive_texts_size.dart';

import '../../Datahandler/app_data.dart';
import '../../Model/customizpackage.dart';
import '../../config.dart';
import '../customize/new-customize/new_customize.dart';
import 'passingerinfomation.dart';
import 'summrey_and_pay.dart';
import '../customize/activity/manageActivity.dart';

import '../customize/flightcustomiz.dart';

import '../../widget/errordialog.dart';

import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'InfomationModel.dart';

enum FaildMessages { flightFail, hotelFail, activityFail, transferFail }

class CheckoutInformation extends StatefulWidget {
  const CheckoutInformation({Key? key}) : super(key: key);
  static String idScreen = 'CheckoutInformation';

  @override
  _CheckoutInformationState createState() => _CheckoutInformationState();
}

class _CheckoutInformationState extends State<CheckoutInformation> {
  bool? showadvancePassengerInformations = false;
  int adult = 1;
  int child = 0;
  int infant = 0;
  int totalpassenger = 1;
  Map<int, bool> filled = {};
  bool f = false;
  bool isreadysubmit = false;
  bool _activateTheFinalButton = false;
  bool isLogin = false;

  int currentStep = 0;
  late Map<String, Forms> finalpassingerList;
  late Customizpackage customizpackage;
  String custoizeId = '';
  bool isAllFildDone = false;

  List ids = [];
  loadpackagedata() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
      currentStep = 1;
    }

    custoizeId = Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId;
    filled = Provider.of<AppData>(context, listen: false).isfilled;
    if (Provider.of<AppData>(context, listen: false).passingerList.isNotEmpty) {
      finalpassingerList = Provider.of<AppData>(context, listen: false).passingerList;
    }

    customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;
    adult = customizpackage.result.adults;
    child = customizpackage.result.children;
    totalpassenger = child + adult;
    isreadysubmit = (filled.length >= totalpassenger && _activateTheFinalButton == true);

    // if (customizpackage.result.childAge != null) {
    //   Map x = {};
    //   x = customizpackage.result.childAge;
    //
    // }

    for (var i = 0; i < adult; i++) {
      ids.add('adult');
    }
    for (var i = 0; i < child; i++) {
      ids.add('child');
    }
    for (var i = 0; i < infant; i++) {
      ids.add('infant');
    }
    //   print(customizpackage.result.childAge[2].toString());
  }
  ////////////////////////////////////////اعمل الداتا و اصلح الدزاين و اصلح الفالديشن و البروفايدر

  @override
  void initState() {
    loadpackagedata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // double width = size.width;
    // double height = size.height;
    // print(customizpackage.result.childAge['2'].toString());
    return WillPopScope(
        onWillPop: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const CustomizeSlider()));
          return Future.value(true);
        },
        child: PreBookStepper(
          isFromNavBar: false,
        ));
  }

  Widget forms(double height, double width) {
    return SizedBox(
      height: height * 0.40,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 2),
        itemCount: totalpassenger,
        itemBuilder: (context, index) {
          return SizedBox(
            // height: height * 0.14,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Passingerfiled(
                      false,
                      ids: ids[index],
                      isChild: adult < index + 1 ? true : false,
                      numberofpassinger: index + 1,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(color: cardcolor, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(1, 1))
                ]),
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            index + 1 > adult
                                ? 'Passinger  ${index + 1} \n ${ids[index]}'
                                : 'Passinger ${index + 1}\n adult',
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 35),
                                fontWeight: FontWeight.w400),
                          ),
                          filled.containsKey(index)
                              ? InkWell(
                                  onTap: () {
                                    // print(index + 1 < adult ? true : false);
                                    //  print(adult);

                                    getpassingerByIndex(index + 1);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Passingerfiled(
                                          true,
                                          ids: ids[index],
                                          isChild: index + 1 > adult ? true : false,
                                          numberofpassinger: index + 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryblue,
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Passingerfiled(
                                          false,
                                          ids: ids[index],
                                          isChild: adult < index + 1 ? true : false,
                                          numberofpassinger: index + 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/go.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  getpassingerByIndex(int index) {
    // print(adult);
    // print(child);
    // print(index + 1);
    String passingerId;
    passingerId = '${ids[index - 1]}$index';
    //  print(passingerId + "dddd");
    Provider.of<AppData>(context, listen: false).getPassingerByIndex(passingerId);
  }

  bool requireaSmokingRoom = false;
  bool requestRoomonaLowFloor = false;
  bool honeymoonTrip = false;
  bool celebratingBirthday = false;
  bool requireaNonSmokingRoom = false;
  bool requestRoomonaHighFloor = false;
  bool requestforaBabyCot = false;
  bool celebratingAnniversary = false;

  Widget requestToRoom() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cardcolor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            blurRadius: 2,
            spreadRadius: 1,
            offset: (const Offset(0, 1)),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Require a Smoking Room'),
              value: requireaSmokingRoom,
              onChanged: (v) {
                setState(() {
                  requireaSmokingRoom = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Require a Non Smoking Room'),
              value: requireaNonSmokingRoom,
              onChanged: (v) {
                setState(() {
                  requireaNonSmokingRoom = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Request Room on a Low Floor'),
              value: requestRoomonaLowFloor,
              onChanged: (v) {
                setState(() {
                  requestRoomonaLowFloor = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Request Room on a High Floor'),
              value: requestRoomonaHighFloor,
              onChanged: (v) {
                setState(() {
                  requestRoomonaHighFloor = v!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget requesttoyourbooking() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cardcolor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Honeymoon Trip'),
              value: honeymoonTrip,
              onChanged: (v) {
                setState(() {
                  honeymoonTrip = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Request for a Baby Cot'),
              value: requestforaBabyCot,
              onChanged: (v) {
                setState(() {
                  requestforaBabyCot = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Celebrating Birthday'),
              value: celebratingBirthday,
              onChanged: (v) {
                setState(() {
                  celebratingBirthday = v!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Celebrating Anniversary'),
              value: celebratingAnniversary,
              onChanged: (v) {
                setState(() {
                  celebratingAnniversary = v!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController commentController = TextEditingController();
  Widget comments() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: cardcolor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 2,
            spreadRadius: 1,
            offset: (const Offset(0, 1)),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // Text(
          //   ,
          //   style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 27)),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Would you like to add a comment'),
              controller: commentController,
              maxLength: 150,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }

  bool accept = false;
  Widget acceptTerms() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Checkbox(
            value: accept,
            onChanged: (v) {
              setState(() {
                accept = v!;
              });
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: RichText(
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                  text: 'I have read and accept the',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24)),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' general terms',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24)),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                    TextSpan(
                      text: ' and cancellation policy conditions.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24)),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  List<Step> steps() {
    return [
      Step(
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.editing,
          title: const Text('Login'),
          content: _buildlogin()),
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.editing,
        isActive: currentStep >= 1,
        content: forms(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
        title: const Text(
          'Passinger Infomation',
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        content: requestToRoom(),
        title: const Text(
          'Request to your room booking',
          softWrap: true,
          overflow: TextOverflow.fade,
          maxLines: 1,
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        content: requesttoyourbooking(),
        title: const Text(
          'Request to your room booking',
          softWrap: true,
          overflow: TextOverflow.fade,
          maxLines: 1,
        ),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        content: comments(),
        title: const Text(
          'Add Comments',
          softWrap: true,
          overflow: TextOverflow.fade,
          maxLines: 1,
        ),
      ),
      Step(
        title: const Text('accept the general terms'),
        content: acceptTerms(),
      ),
    ];

    //  isActive: currentStep >= );
  }

  final itemController = ItemScrollController();

  collectingUserInformation() async {
    // Navigator.pushNamed(context, LoadingWidgetMain.idScreen);
    pressIndcatorDialog(context);
    List<dynamic> finalPassingerInformationList = [];

    finalpassingerList.forEach(
      (key, value) {
        finalPassingerInformationList.add(value.toJson());
      },
    );
    Map<String, dynamic> userlogin = {
      "email": users.data.email,
      "selected_title": "",
      "surname": "dd",
      "name": users.data.name,
      "phonenumber": "971585853633",
      "phonecode": 971
    };
    //print(userlogin.toString());
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
          "smoking_room": requireaSmokingRoom,
          "non_smoking_room": requireaNonSmokingRoom,
          "room_low_floor": requestRoomonaLowFloor,
          "room_high_floor": requestRoomonaHighFloor,
          "vip_guest": false,
          "honeymoon": honeymoonTrip,
          "babycot": requestforaBabyCot,
          "birthday": celebratingBirthday,
          "anniversary": celebratingAnniversary,
          "other_request": commentController.text
        }
      ],
      "accept_terms": accept,
      "selected_language": genlang,
      "selected_currency": gencurrency,
    };
    log(Provider.of<AppData>(context, listen: false).packagecustomiz.result.customizeId);
    log(jsonEncode(userInformation));
    String data = jsonEncode(userInformation);

    await AssistantMethods.preBooking(data, users.data.token, context);
    if (!mounted) return;
    bool isfaild = Provider.of<AppData>(context, listen: false).isfaild;
    //  Navigator.pop(context);
    if (isfaild) {
      Dialogs.materialDialog(
          barrierDismissible: false,
          context: context,
          color: Colors.white,
          msg: 'Prebooking is successfully',
          title: 'Congratulations',
          lottieBuilder: Lottie.asset(
            'assets/images/loading/done.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(
                  context,
                  SumAndPay.idScreen,
                );
              },
              text: 'To Final step',
              iconData: Icons.done,
              color: Colors.blue,
              textStyle:const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]);
    } else {
      Navigator.pop(context);
      Map<String, String> faildMessages = Provider.of<AppData>(context, listen: false).faildMessage;
      showDialog(
          context: context,
          builder: (context) => Dialog(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: ScrollablePositionedList.builder(
                    itemScrollController: itemController,
                    scrollDirection: Axis.horizontal,
                    itemCount: faildMessages.length,
                    itemBuilder: (context, i) => _buildFaildCard(faildMessages, i)),
              )

                  // Text(

                  ));
    }
  }

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

  Widget _buildFaildCard(Map<String, String> faild, int i) => Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                scrollToItem(i, false);
              },
              icon:const Icon(Icons.keyboard_arrow_left),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: yellowColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "sorry we couldn't confirm",
                  style: TextStyle(
                    fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Text(
                    faild.values.elementAt(i),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('${i + 1} / ${faild.length}'),
                OutlinedButton(
                    onPressed: () async {
                      switch (faild.keys.elementAt(i)) {
                        case "activityFail":
                          Navigator.pushNamed(context, ManageActivity.idScreen);
                          break;
                        case "flightFail":
                          String customizeId = Provider.of<AppData>(context, listen: false)
                              .packagecustomiz
                              .result
                              .customizeId;
                          String flightclass = Provider.of<AppData>(context, listen: false)
                              .packagecustomiz
                              .result
                              .flight!
                              .flightClass;
                          try {
                            await AssistantMethods.changeflight(customizeId, flightclass, context);
                         
                         if (!mounted) return;
                            Navigator.pop(context);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FlightCustomize(
                                  failedFlightNamed: '',
                                ),
                              ),
                            );
                          } catch (e) {
                            Navigator.pop(context);
                            const Errordislog().error(context, e.toString());
                          }

                          break;
                        case "transferFail":
                          updateTransfer(context, custoizeId);

                          break;
                        case "hotelFail":
                          Navigator.pushNamed(context, CustomizeSlider.idScreen);

                          break;
                        default:
                      }
                      // if (faild.keys.elementAt(i) == 'activityFail') {
                      //   Navigator.pushNamed(context, ManageActivity.idScreen);
                      //   return;
                      // }
                    },
                    child: const Text('Change'))
              ],
            ),
            IconButton(
              onPressed: () {
                scrollToItem(i, true);
              },
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      );

  Widget _buildlogin() {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NewLogin.idScreen);
          isFromBooking = true;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(isLogin ? 'you are already logged in' : 'Login or create new account'),
            isLogin
                ?const SizedBox()
                : Image.asset(
                    'assets/images/go.png',
                    width: 20,
                    height: 20,
                  ),
          ],
        ),
      ),
    );
  }
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
    await AssistantMethods.updateHotelDetails(custoizeId, context);
    await AssistantMethods.updateThePackage(custoizeId);
    await AssistantMethods.updateHotelDetails(custoizeId, context);
  } catch (e) {
    Navigator.pushNamed(context, CustomizeSlider.idScreen);
  }
}
