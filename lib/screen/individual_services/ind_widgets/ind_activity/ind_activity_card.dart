// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_widgets/ind_activity/ind_activity_item.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IndManageActivity extends StatefulWidget {
  const IndManageActivity({Key? key}) : super(key: key);
  static String idScreen = 'ManageActivity';

  @override
  _IndManageActivityState createState() => _IndManageActivityState();
}

class _IndManageActivityState extends State<IndManageActivity> {
  bool isLogin = false;

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  late Customizpackage _activitys;

  bool firstdayvisi = true;
  int numberofday = 0;
  List activityDaysList = [];
  List<Activity> activity = [];
  List<dynamic> allactivitycount = [];

  void loadActivityData() {
    try {
      _activitys = Provider.of<AppData>(context, listen: false).packagecustomiz;
    } catch (e) {
      Navigator.of(context).pop();
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    }

    daysBetween();
    try {
      _activitys.result.activities.forEach((key, value) {
        activity.addAll(value);
        activity.sort((a, b) => a.day.compareTo(b.day));
      });
    } catch (e) {
      activity.add(Activity(
          name: 'No Avtivity',
          searchId: '0',
          code: '0',
          activityId: '0',
          modalityCode: '0',
          modalityName: '0',
          amountsFrom: [],
          sellingCurrency: 'ADE',
          netAmount: 0.0,
          paybleCurency: "ADE",
          modalityAmount: 0,
          activityDate: DateTime.now(),
          questions: [],
          rateKey: "rateKey",
          day: 1,
          activityDateDisplay: "activityDateDisplay",
          activityDestination: "activityDestination",
          image: "image",
          description: "description",
          prebook: 1,
          images: []));
    }

    allactivitycount.insert(0, 'Add activity');
    allactivitycount.addAll(activity);

    // print(all[1]);
    if (_activitys.result.flight != null) {
      numberofday = int.parse(_activitys.result.flight!.from.arrivalDate.substring(0, 2));
    } else {
      numberofday = _activitys.result.packageStart.day;
    }

    makelistofdays();
    makePowerfulllist();
  }

  @override
  void initState() {
    loadActivityData();
    getlogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
        return Future.value(true);
      },
      child: Container(
        color: cardcolor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: background,
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 50,
                    //   child: HolidayHeder(
                    //     idscreen: ManageActivity.idScreen,
                    //   ),
                    // ),
                    //+++++++++++++++++++++++++HEADER ++++++++++++++++++++++++++++++++++++++++++
                    Container(
                      color: background,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // currentState(
                          //     'Customize', context, ManageActivity.idScreen),
                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   'Manage your daily activities',
                          //   style: TextStyle(
                          //     fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30),
                          //     fontWeight: FontWeight.normal,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // )
                        ],
                      ),
                    ),
                    ////+++++++++++++++++++++++++++++++++++++++ACTIVITY CONTANT+++++++++++++++++++++++++++++++++++++++++

                    const SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Column(
                          children: [
                            for (var i = 0; i < powerfull.length; i++)
                              IndActivityItems(
                                activityDay: nameDayList[i],
                                activitys: _activitys,
                                index: i,
                                list: powerfull,
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'price: ${_activitys.result.totalAmount.toString()} ${localizeCurrency(_activitys.result.sellingCurrency)}',
                  style: TextStyle(color: primaryblue, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: () async {
                      getlogin();
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
                          context.read<AppData>().toggleHasQuestions(
                              await AssistantMethods.getActivityQuestions(
                                  context, _activitys.result.customizeId));
                                     if (!mounted) return;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PreBookStepper(
                                    isFromNavBar: true,
                                  )));
                          Provider.of<AppData>(context, listen: false)
                              .resetSelectedPassingerfromPassList();
                        }
                      } else {
                        isFromBooking = true;
                        Navigator.of(context).pushNamed(NewLogin.idScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                    child: Text(AppLocalizations.of(context)!.bookNow),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool checkFirstDayAvalabelty() {
    if (_activitys.result.flight != null) {
      int maxAllowedDate = 12;
      int time = int.parse(_activitys.result.flight!.from.arrivalTime.substring(0, 2));
      if (_activitys.result.flight!.from.departureFdate ==
              _activitys.result.flight!.from.arrivalFdate &&
          time > maxAllowedDate) {
        return true;
      } else if (time > maxAllowedDate) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  List<String> nameDayList = [];

  makelistofdays() {
    if (_activitys.result.flight != null) {
      DateTime fir = _activitys.result.flight!.from.departureFdate;
      String formattedDate = DateFormat('MMM', genlang).format(fir);
      if (kDebugMode) {
        print(formattedDate);
      }
      for (var i = 0; i <= daysBetween(); i++) {
        nameDayList.add('${fir.add(Duration(days: i)).day} ${DateFormat('MMM', genlang).format(fir.add(Duration(days: i)))}');
        activityDaysList.add(numberofday);
        numberofday++;
      }
    } else {
      DateTime fir = _activitys.result.packageStart;
      String formattedDate = DateFormat('MMM', genlang).format(fir);
      if (kDebugMode) {
        print(formattedDate);
      }
      for (var i = 0; i <= _activitys.result.packageDays; i++) {
        nameDayList.add('${DateFormat('MMM', genlang).format(fir.add(Duration(days: i)))} ${fir.add(Duration(days: i)).day}');
        activityDaysList.add(numberofday);
        numberofday++;
      }
      if (kDebugMode) {
        print(nameDayList);
      }
    }

    // print(nameDayList.toString());
  }

  int daysBetween() {
    // if (_activitys.result.flight != null) {
    //   DateTime first = _activitys.result.flight!.from.departureFdate;
    //   DateTime seconde = _activitys.result.flight!.to.arrivalFdate;
    // }else{

    // }

    return _activitys.result.packageDays;
    //(seconde.difference(first)).inDays;
  }

  List<Activity?> powerfull = [];

  makePowerfulllist() async {
    int lenForPowerFullList = _activitys.result.packageDays;
    List<Activity> halfPower = [];

    powerfull.length = lenForPowerFullList;
    // print(nameDayList);

    for (int i = 0; i < lenForPowerFullList; i++) {
      halfPower.add(Activity(
          name: 'No Avtivity',
          searchId: '0',
          code: '0',
          activityId: '0',
          modalityCode: '0',
          modalityName: '0',
          amountsFrom: [],
          sellingCurrency: 'ADE',
          netAmount: 0.0,
          paybleCurency: "ADE",
          modalityAmount: 0,
          activityDate: DateTime.now(),
          questions: [],
          rateKey: "rateKey",
          day: i,
          activityDateDisplay: nameDayList[i],
          activityDestination: "activityDestination",
          image: "image",
          description: "description",
          prebook: 1,
          images: []));
      //  print(halfPower[i].activityDateDisplay);
      for (var element in activity) {
        if (element.day == halfPower[i].day) {
          halfPower[i] = element;
        }
      }
    }
    powerfull = halfPower;

    setState(() {
      powerfull.sort((a, b) => a!.day.compareTo(b!.day));
    });

    //  getindex();
  }

  List<int> days = [];

  getindex() {
    days.clear();
    for (var i = 0; i <= activity.length; i++) {
      days.add(activity[i].day);
    }
  }
}
