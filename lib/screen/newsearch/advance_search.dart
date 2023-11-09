// ignore_for_file: unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Assistants/assistant_data.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/widget/loading.dart';
import 'package:lamar_travel_packages/widget/searchfrom.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../config.dart';
import '../customize/new-customize/new_customize.dart';
import '../packages_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FlightStop { direct, stops }

enum FlightClass { economic, business }

enum HotelRating { H, M, l }

class AdvanceSearchOption extends StatefulWidget {
  const AdvanceSearchOption({Key? key, required this.ontap, required this.next}) : super(key: key);

  final VoidCallback ontap;
  final VoidCallback next;

  @override
  _AdvanceSearchOptionState createState() => _AdvanceSearchOptionState();
}

class _AdvanceSearchOptionState extends State<AdvanceSearchOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _animation;

  String flightPref = '';

  bool isSerchForFlight = false;

  String hotelPref = '';

  bool isSerchForHotel = false;
  FocusNode budgetFocus = FocusNode();

  final budgetController = TextEditingController();

  final flightcontroller = TextEditingController();

  final hotelController = TextEditingController();

  bool economic = true;
  bool business = false;

  Map<HotelRating, bool> selectedHotelStars = {
    HotelRating.l: false,
    HotelRating.M: false,
    HotelRating.H: false,
  };

  getuserdatafrompref() {
    final budgetfrompref = AssistenData.getUserPreferredBudget();
    final flightclass = AssistenData.getuserPreferredFlightClass();
    final hstarpre = AssistenData.getUserPreferredStarhotel();
    if (hstarpre != null) {
      switch (hstarpre) {
        case 3:
          {
            selectedHotelStars.update(HotelRating.l, (value) => true);
          }
          break;
        case 4:
          {
            selectedHotelStars.update(HotelRating.M, (value) => true);
          }
          break;
        case 5:
          {
            selectedHotelStars.update(HotelRating.H, (value) => true);
          }
          break;
      }
    }
    if (flightclass != null) {
      if (flightclass == 'business') {
        business = true;
        economic = false;
      } else {
        business = false;
        economic = true;
      }
    }

    if (budgetfrompref != null) {
      budgetController.text = budgetfrompref.toString();
    }
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(_animationController);

    getuserdatafrompref();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    budgetController.dispose();
    flightcontroller.dispose();
    hotelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SizedBox.expand(
        child: DraggableScrollableSheet(
          maxChildSize: 0.95,
          minChildSize: 0.75,
          initialChildSize: 0.80,
          // expand: true,
          builder: (BuildContext context, ScrollController scrollController) {
            //print(_scrollController.position.minScrollExtent);
            return NotificationListener(
              onNotification: (OverscrollNotification notification) {
                return true;
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: SlideTransition(
                  position: _animation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onPanUpdate: (d) {},
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            primary: false,
                            controller: scrollController,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              height: 8.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: primaryblue.withAlpha(100),
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(
                              width: 6.w,
                              child: InkWell(
                                  onTap: widget.ontap,
                                  child: Icon(
                                    Provider.of<AppData>(context, listen: false).locale ==
                                            const Locale('en')
                                        ? Icons.keyboard_arrow_left
                                        : Icons.keyboard_arrow_right,
                                    color: primaryblue,
                                    size: 30.sp,
                                  ))),
                          SizedBox(
                            width: 80.w,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  Provider.of<AppData>(context, listen: false).title,
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                                )),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller: flightcontroller,
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.preferredAirline,
                                      border: InputBorder.none),
                                  readOnly: true,
                                  onTap: () async {
                                    final result = await showSearch<String>(
                                      context: context,
                                      delegate: SearchFlight(),
                                    );

                                    if (result != null) {
                                      flightcontroller.text = result;
                                    }
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),

                              // Text('Stops'),
                              // SizedBox(
                              //     width: 100.w,
                              //     height: 5.h,
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         SizedBox(
                              //           width: 40.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             title: Text(
                              //               'Stop',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<FlightStop>(
                              //               value: FlightStop.stops,
                              //               groupValue: _flightstopvalue,
                              //               onChanged: (FlightStop? value) {
                              //                 setState(() {
                              //                   _flightstopvalue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 40.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             title: Text(
                              //               'Direct',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<FlightStop>(
                              //               value: FlightStop.direct,
                              //               groupValue: _flightstopvalue,
                              //               onChanged: (FlightStop? value) {
                              //                 setState(() {
                              //                   _flightstopvalue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     )),

                              Text(
                                AppLocalizations.of(context)!.flightClass,
                                style: TextStyle(color: Colors.grey, fontSize: titleFontSize + 2),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              //
                              // SizedBox(
                              //     width: 100.w,
                              //     height: 5.h,
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         SizedBox(
                              //           width: 40.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             title: Text(
                              //               'economic',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<FlightClass>(
                              //               value: FlightClass.economic,
                              //               groupValue: _flightClassvlaue,
                              //               onChanged: (FlightClass? value) {
                              //                 setState(() {
                              //                   _flightClassvlaue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 40.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             title: Text(
                              //               'business',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<FlightClass>(
                              //               value: FlightClass.business,
                              //               groupValue: _flightClassvlaue,
                              //               onChanged: (FlightClass? value) {
                              //                 setState(() {
                              //                   _flightClassvlaue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     )),
                              //

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(AppLocalizations.of(context)!.economic),
                                Switch.adaptive(
                                  value: economic,
                                  onChanged: (v) {
                                    setState(() {
                                      economic = v;
                                      business = false;
                                    });
                                  },
                                  activeColor: primaryblue,
                                )
                              ]),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text(AppLocalizations.of(context)!.business),
                                Switch.adaptive(
                                  value: business,
                                  onChanged: (v) {
                                    setState(() {
                                      business = v;
                                      economic = false;
                                    });
                                  },
                                  activeColor: primaryblue,
                                )
                              ]),

                              Container(
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: hotelController,
                                  decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.preferredHotel,
                                      border: InputBorder.none),
                                  onTap: () async {
                                    final result = await showSearch<String>(
                                      context: context,
                                      delegate: SearchHotel(),
                                    );
                                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                                    if (result != null) {
                                      hotelController.text = result;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                AppLocalizations.of(context)!.hotelStars,
                                style: TextStyle(color: Colors.grey, fontSize: titleFontSize),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),

                              for (var i = 0; i <= 2; i++) _buildSwitcher(i),
                              _buildFillterByBudget(),

                              // Text('Hotel rating'),
                              // SizedBox(
                              //     width: 100.w,
                              //     height: 5.h,
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         SizedBox(
                              //           width: 30.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             horizontalTitleGap: 0,
                              //             contentPadding: EdgeInsets.all(0),
                              //             title: Text(
                              //               '3 stars',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<HotelRating>(
                              //               value: HotelRating.l,
                              //               groupValue: _hotelRatingvalue,
                              //               onChanged: (HotelRating? value) {
                              //                 setState(() {
                              //                   _hotelRatingvalue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 30.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             horizontalTitleGap: 0,
                              //             contentPadding: EdgeInsets.all(0),
                              //             title: Text(
                              //               '4 stars',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<HotelRating>(
                              //               value: HotelRating.M,
                              //               groupValue: _hotelRatingvalue,
                              //               onChanged: (HotelRating? value) {
                              //                 setState(() {
                              //                   _hotelRatingvalue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 30.w,
                              //           height: 5.h,
                              //           child: ListTile(
                              //             horizontalTitleGap: 0,
                              //             contentPadding: EdgeInsets.all(0),
                              //             title: Text(
                              //               '5 stars',
                              //               style: TextStyle(fontSize: subtitleFontSize),
                              //             ),
                              //             leading: Radio<HotelRating>(
                              //               value: HotelRating.H,
                              //               groupValue: _hotelRatingvalue,
                              //               onChanged: (HotelRating? value) {
                              //                 setState(() {
                              //                   _hotelRatingvalue = value;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     )),
                              // Text('Budget'),
                              //       _buildFillterByBudget(),
                              Container(
                                padding: const EdgeInsets.all(8).copyWith(top: 25),
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          clearsavedPref();
                                        },
                                        child:
                                            Text(AppLocalizations.of(context)!.clearSavedSettings)),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(30.w, 6.h), backgroundColor: primaryblue),
                                      onPressed: () {
                                        widget.next();

                                        if (Provider.of<AppData>(context, listen: false)
                                            .ismakefilter) {
                                          Provider.of<AppData>(context, listen: false)
                                              .restTheFilter();
                                        }
                                        makeSearch();

                                        // print(Provider.of<AppData>(context, listen: false).payloadto.id);

                                        // print(
                                        //     Provider.of<AppData>(context, listen: false).newSearchsecoundDate);
                                        // print(Provider.of<AppData>(context, listen: false).newSearchFirstDate);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.search,
                                        style: const TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFillterByBudget() => InkWell(
        onTap: () {
          budgetController.clear();
          budgetFocus.requestFocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.preferredBudgets,
                style: TextStyle(fontSize: titleFontSize, color: Colors.grey.shade700),
              ),
              SizedBox(
                width: 25.w,
                child: TextField(
                  controller: budgetController,
                  focusNode: budgetFocus,
                  decoration: const InputDecoration(border: InputBorder.none),
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      Provider.of<AppData>(context, listen: false)
                          .getTuningBudget(true, maxB: double.parse(v));
                    } else {
                      Provider.of<AppData>(context, listen: false).getTuningBudget(false);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );

  //
  // Column(
  //   children: [
  //     SliderTheme(
  //       data: SliderThemeData.fromPrimaryColors(
  //           primaryColor: primaryblue,
  //           primaryColorDark: yellowColor,
  //           primaryColorLight: primaryblue,
  //           valueIndicatorTextStyle: TextStyle(color: Colors.white)),
  //       child: RangeSlider(
  //         values: _currentRangeValues!,
  //         max: _maxpakagesprice,
  //         min: _minpakagesprice,
  //         divisions: 9,
  //         labels: RangeLabels(
  //           gencurrency + ' ' + _currentRangeValues!.start.round().toString(),
  //           gencurrency + ' ' +  _currentRangeValues!.end.round().toString(),
  //         ),
  //         onChanged: (RangeValues values) {
  //           setState(() {
  //             _currentRangeValues = values;
  //           });
  //           Provider.of<AppData>(context,listen: false).getTuningBudget(true,minB:_currentRangeValues!.start,maxB:_currentRangeValues!.end);
  //         },
  //       ),
  //     ),
  //     // SizedBox(
  //     //   height: 1.h,
  //     // ),
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'Min',
  //               style: TextStyle(
  //                   fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12.sp),
  //             ),
  //             Card(
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 padding: EdgeInsets.all(10),
  //                 child: Text(
  //                   _currentRangeValues!.start.round().toString(),
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.normal, color: primaryblue, fontSize: 12.sp),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: [
  //             Text(
  //               'Max',
  //               style:
  //                   TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12.sp),
  //             ),
  //             Card(
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 padding: EdgeInsets.all(10),
  //                 child: Text(
  //                   _currentRangeValues!.end.round().toString(),
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.normal, color: primaryblue, fontSize: 12.sp),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     )
  //   ],
  // );
  //

  List<String> stars = ["★ ★ ★", "★ ★ ★ ★", "★ ★ ★ ★ ★"];

  makeSearch() async {
    List s = [];
    selectedHotelStars.forEach((key, value) {
      if (value == true) {
        s.add(key);
      }
    });
    String ss = '';
    for (var element in s) {
      if (element == HotelRating.l) {
        ss = '${ss}3,';
      }
      if (element == HotelRating.M) {
        ss = '${ss}4,';
      }
      if (element == HotelRating.H) {
        ss = '${ss}5';
      }
    }
    ss = ss.replaceAll(',', '');
    Provider.of<AppData>(context, listen: false).makeresarchResearchCurr(true);
    String childage = '';
    String firstdate = DateFormat('dd/MM/y')
        .format(Provider.of<AppData>(context, listen: false).newSearchFirstDate!);
    String secdate = DateFormat('dd/MM/y')
        .format(Provider.of<AppData>(context, listen: false).newSearchsecoundDate!);

    Provider.of<AppData>(context, listen: false).getdates(firstdate, secdate);

    if (budgetController.text.isNotEmpty) {
      AssistenData.setUserPreferredBudget(double.parse(budgetController.text));
    }
    if (business) {
      AssistenData.setuserPreferredFlightClass('business');
    } else {
      AssistenData.setuserPreferredFlightClass('economic');
    }
    if (ss.isNotEmpty) {
      AssistenData.setUserPreferredStarhotel(int.parse(ss));
    }

    //  try {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoadingWidgetMain()));
    pressIndcatorDialog(context);
    bool error = await AssistantMethods.mainSearchpackage(
        context,
        firstdate,
        secdate,
        Provider.of<AppData>(context, listen: false).payloadFrom!.id,
        Provider.of<AppData>(context, listen: false).payloadto.id,
        hotelController.text != ''
            ? Provider.of<AppData>(context, listen: false).selectdHoteltcode
            : '',
        flightcontroller.text != ''
            ? Provider.of<AppData>(context, listen: false).selectedflightcode
            : '',
        business ? 'c' : 'y',
        Provider.of<AppData>(context, listen: false).rooms,
        Provider.of<AppData>(context, listen: false).adults,
        Provider.of<AppData>(context, listen: false).childrens,
        childage,
        ss,
        context.read<AppData>().searchMode,
        '2');
    if (!mounted) return;

    ///! for research change vlaidation/////
    Provider.of<AppData>(context, listen: false).cheakResarh(
        fday: firstdate,
        secday: secdate,
        fcity: Provider.of<AppData>(context, listen: false).payloadFrom!.cityName,
        secCity: Provider.of<AppData>(context, listen: false).payloadto.cityName,
        room: Provider.of<AppData>(context, listen: false).rooms.toString(),
        child: Provider.of<AppData>(context, listen: false).adults.toString(),
        adult: Provider.of<AppData>(context, listen: false).childrens.toString(),
        fclass: business ? 'c' : 'y');

    ///! for research change vlaidation end/////

    setState(() {
      bucket = PageStorageBucket();
    });

    // await AssistantMethods.getPackages(
    //     context, mainPackageId);
    Navigator.pop(context);
    if (error == true) {
      Provider.of<AppData>(context, listen: false).hundletheloading(false);
      Navigator.of(context).pushNamed(PackagesScreen.idScreen);
    }
    // } catch (e) {
    //   print(e);
    //   Navigator.pop(context);
    //   displayTostmessage(context, true, message: 'please try again');
    // }
  }

//

  Widget _buildSwitcher(int i) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            stars[i].toString(),
            style: TextStyle(color: yellowColor, fontSize: titleFontSize),
          ),
          Switch.adaptive(
            value: selectedHotelStars.values.toList()[i],
            onChanged: (v) {
              selectedHotelStars.updateAll((key, value) => value = false);

              setState(() {
                selectedHotelStars.update(selectedHotelStars.keys.toList()[i], (value) => v);
              });
            },
            activeColor: primaryblue,
          )
        ],
      );

  void clearsavedPref() {
    AssistenData.removeUserPreferredBudget();
    AssistenData.removeuserPreferredFlightClass();
    AssistenData.removeUserPreferredStarhotel();
    budgetController.clear();
    business = false;
    economic = false;
    selectedHotelStars.updateAll((key, value) => value = false);

    setState(() {});
  }
}
