// ignore_for_file: file_names, library_private_types_in_public_api


import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/widget/activityitem.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageActivity extends StatefulWidget {
  const ManageActivity({Key? key}) : super(key: key);
  static String idScreen = 'ManageActivity';

  @override
  _ManageActivityState createState() => _ManageActivityState();
}

class _ManageActivityState extends State<ManageActivity> {
  late Customizpackage _activitys;

  bool firstdayvisi = true;
  int numberofday = 0;
  List activityDaysList = [];
  List<Activity> activity = [];
  List<dynamic> allactivitycount = [];

  void loadActivityData() {
    _activitys = Provider.of<AppData>(context, listen: false).packagecustomiz;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const CustomizeSlider()),
        );
        return Future.value(true);
      },
      child: Container(
        color: cardcolor,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.1,
              backgroundColor: cardcolor,
              leading: IconButton(
                icon: Icon(
                  Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  size: 35,
                  color: primaryblue,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                },
              ),
              title: Text(
                AppLocalizations.of(context)!.manageYourActivities,
                style: TextStyle(color: Colors.black, fontSize: titleFontSize),
              ),
            ),
            //appbar(context, ''),
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
                          SizedBox(height: 10),
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

                 const   SizedBox(
                      height: 10
                    ),

                    InkWell(
                      child: Column(
                        children: [
                          for (var i = 0; i < powerfull.length; i++)
                            ActivityItems(
                              activityDay: nameDayList[i],
                              activitys: _activitys,
                              index: i,
                              list: powerfull,
                            )
                        ],
                      ),
                    ),
                   const SizedBox(
                      height: 10
                    ),
                  ],
                ),
              ),
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
      for (var i = 0; i <= daysBetween(); i++) {
        nameDayList.add('${fir.add(Duration(days: i)).day} ${DateFormat('MMM', genlang).format(fir.add(Duration(days: i)))}');
        activityDaysList.add(numberofday);
        numberofday++;
      }
    } else {
      DateTime fir = _activitys.result.packageStart;
      for (var i = 0; i <= _activitys.result.packageDays; i++) {
        nameDayList.add('${DateFormat('MMM', genlang).format(fir.add(Duration(days: i)))} ${fir.add(Duration(days: i)).day}');
        activityDaysList.add(numberofday);
        numberofday++;
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

    for (int i = 0; i <= lenForPowerFullList; i++) {
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
