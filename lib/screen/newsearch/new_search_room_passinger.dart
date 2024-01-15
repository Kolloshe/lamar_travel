// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/privet_jet_category_model.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/widget/individual_products/my_custom_number_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../customize/new-customize/new_customize.dart';
import '../main_screen1.dart';
import '../packages_screen.dart';

enum FlightClass { economy, premiumEconomy, business, firstClass }

enum FlightType { onewayFlight, roundedFlight }

class NewSearchRoomAndPassinger extends StatefulWidget {
  const NewSearchRoomAndPassinger(
      {Key? key, required this.ontap, required this.next, required this.isfromnavbar})
      : super(key: key);
  final VoidCallback ontap;
  final VoidCallback next;
  final VoidCallback isfromnavbar;

  @override
  _NewSearchRoomAndPassingerState createState() => _NewSearchRoomAndPassingerState();
}

class _NewSearchRoomAndPassingerState extends State<NewSearchRoomAndPassinger>
    with SingleTickerProviderStateMixin {
  FlightClass selectedFlightClass = FlightClass.economy;
  FlightType selectedFlightType = FlightType.roundedFlight;

  int childeringCount = 0;
  int roomcount = 1;
  int adultscount = 1;
  int olderCount = 0;
  int childCountForIn = 0;
  int pax = 1;
  Categories? minCategory;

  bool child1 = false;
  bool child2 = false;
  bool child3 = false;
  bool child4 = false;
  bool child5 = false;
  bool child6 = false;
  bool child7 = false;
  bool chiledDivider = false;
  num childage0 = 1;
  num childage1 = 1;
  num childage2 = 1;
  num childage3 = 1;
  num childage4 = 1;
  num childage5 = 1;
  num childage6 = 1;
  num childage7 = 1;
  num childage8 = 1;

  Map<String, int> childAgeMap = {};

  late AnimationController _animationController;

  late Animation<Offset> _animation;
  String searchMode = '';
  PrivetJetCategoryModel? privetJetCategories;

  @override
  void initState() {
    searchMode = context.read<AppData>().searchMode.toLowerCase().trim();
    if (searchMode == 'privet jet') {
      pax = context.read<AppData>().paxCount;
      privetJetCategories = context.read<AppData>().getPrivetJetCategories;
      minCategory = privetJetCategories?.data.first;
    }

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(_animationController);
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize: 0.50,
          initialChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return NotificationListener(
              onNotification: (OverscrollNotification notification) {
                if (notification.metrics.pixels == -1.0) {
                  widget.isfromnavbar();
                }
                return true;
              },
              child: Container(
                  padding: const EdgeInsets.all(20).copyWith(top: 10),
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
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        !searchMode.contains('privet jet')
                            ? Expanded(
                                child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                primary: false,
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    !searchMode.contains('flight') &&
                                            !searchMode.contains('activity') &&
                                            !searchMode.contains('transfer') &&
                                            !searchMode.contains('travel insurance')
                                        ? SizedBox(
                                            width: 100.w,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.room,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                                CustomNumberPicker(
                                                  w: 7.w,
                                                  valueTextStyle: TextStyle(fontSize: 14.sp),
                                                  shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none),
                                                  initialValue: 1,
                                                  maxValue: 10,
                                                  minValue: 1,
                                                  step: 1,
                                                  onValue: (step) {
                                                    int x = int.parse(step.toString());
                                                    roomcount = x;
                                                  },
                                                  customAddButton: customNumberPickerIcon(
                                                      iconData: Icons.add, ontap: () {}),
                                                  customMinusButton: customNumberPickerIcon(
                                                      iconData: MdiIcons.minus, ontap: () {}),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                    searchMode.contains('flight')
                                        ? _buildFlightType()
                                        : const SizedBox(),
                                    // Divider(
                                    //   color: Colors.black.withOpacity(0.50),
                                    // ),
                                    searchMode.contains('flight')
                                        ? _buildSelectFlightClass()
                                        : const SizedBox(),
                                    Divider(
                                      color: Colors.black.withOpacity(0.50),
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.adults,
                                            style: TextStyle(
                                                fontSize: 14.sp, fontWeight: FontWeight.normal),
                                          ),
                                          CustomNumberPicker(
                                            w: 7.w,
                                            valueTextStyle: TextStyle(fontSize: 14.sp),
                                            shape:
                                                const RoundedRectangleBorder(side: BorderSide.none),
                                            initialValue: 1,
                                            maxValue: 10,
                                            minValue: 1,
                                            step: 1,
                                            onValue: (step) {
                                              int x = int.parse(step.toString());
                                              adultscount = x;
                                            },
                                            customAddButton: customNumberPickerIcon(
                                                iconData: Icons.add, ontap: () {}),
                                            customMinusButton: customNumberPickerIcon(
                                                iconData: MdiIcons.minus, ontap: () {}),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.50),
                                    ),
                                    searchMode.contains('travel insurance')
                                        ? SizedBox(
                                            width: 100.w,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                  text:
                                                      AppLocalizations.of(context)!.seniorTravelers,
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            ' 65 ${AppLocalizations.of(context)!.to} 69',
                                                        style: const TextStyle(
                                                            fontSize: 12, color: Colors.grey))
                                                  ],
                                                  style: TextStyle(
                                                      color: blackTextColor,
                                                      fontSize: 14.sp,
                                                      fontFamily: Provider.of<AppData>(context,
                                                                      listen: false)
                                                                  .locale ==
                                                              const Locale('en')
                                                          ? 'Lato'
                                                          : 'Bhaijaan'),
                                                )),
                                                CustomNumberPicker(
                                                  w: 7.w,
                                                  valueTextStyle: TextStyle(fontSize: 14.sp),
                                                  shape: const RoundedRectangleBorder(
                                                      side: BorderSide.none),
                                                  initialValue: 0,
                                                  maxValue: 10,
                                                  minValue: 0,
                                                  step: 1,
                                                  onValue: (step) {
                                                    int x = int.parse(step.toString());
                                                    olderCount = x;
                                                  },
                                                  customAddButton: customNumberPickerIcon(
                                                      iconData: Icons.add, ontap: () {}),
                                                  customMinusButton: customNumberPickerIcon(
                                                      iconData: MdiIcons.minus, ontap: () {}),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                    searchMode.contains('travel insurance')
                                        ? Divider(
                                            color: Colors.black.withOpacity(0.50),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: AppLocalizations.of(context)!.children,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black),
                                                children: const [
                                                  TextSpan(
                                                      text: " (2-11) years old",
                                                      style: TextStyle(
                                                          color: Colors.grey, fontSize: 12))
                                                ]),
                                          ),
                                          CustomNumberPicker(
                                            w: 9.w,
                                            valueTextStyle: TextStyle(fontSize: 14.sp),
                                            shape:
                                                const RoundedRectangleBorder(side: BorderSide.none),
                                            initialValue: 0,
                                            maxValue: 10,
                                            minValue: 0,
                                            step: 1,
                                            onValue: (dynamic step) {
                                              if (searchMode.contains('travel insurance')) {
                                                childCountForIn = int.parse(step.toString());
                                                return;
                                              } else {
                                                setState(() {
                                                  int x = int.parse(step.toString());
                                                  childeringCount = x;
                                                  if (childeringCount - 1 > -1) {
                                                    childAgeMap.putIfAbsent(
                                                        (childeringCount - 1).toString(), () => 1);
                                                  }

                                                  if (childeringCount < childAgeMap.length) {
                                                    final childAgeMapLen = childAgeMap.length;
                                                    final numFoAction =
                                                        childAgeMapLen - childeringCount;
                                                    for (int i = 0; i < numFoAction; i++) {
                                                      childAgeMap.remove(
                                                          (childAgeMapLen - i - 1).toString());
                                                    }
                                                  }
                                                });
                                              }
                                            },
                                            customAddButton: customNumberPickerIcon(
                                                iconData: Icons.add, ontap: () {}),
                                            customMinusButton: customNumberPickerIcon(
                                                iconData: MdiIcons.minus, ontap: () {}),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black.withOpacity(0.50),
                                    ),
                                    Wrap(
                                      direction: Axis.vertical,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        for (var i = 0; i < childeringCount; i++)
                                          SizedBox(
                                            width: 90.w,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                      Provider.of<AppData>(context, listen: false)
                                                                  .locale ==
                                                              const Locale('en')
                                                          ? '${i + 1}${i == 0 ? "st" : i == 1 ? "nd" : i == 2 ? "rd" : "th"} Child age: '
                                                          : "${AppLocalizations.of(context)!.childAges} ${AppLocalizations.of(context)!.number}  ${(i + 1)}",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: CustomNumberPicker(
                                                      w: 8.w,
                                                      shape: const RoundedRectangleBorder(
                                                          side: BorderSide.none),
                                                      valueTextStyle: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10.sp),
                                                      customAddButton: customNumberPickerIcon(
                                                          iconData: Icons.add, ontap: () {}),
                                                      customMinusButton: customNumberPickerIcon(
                                                          iconData: MdiIcons.minus, ontap: () {}),
                                                      step: 1,
                                                      initialValue: 1,
                                                      maxValue: 11,
                                                      minValue: 1,
                                                      onValue: (dynamic val) {
                                                        childAgeMap.update(
                                                            i.toString(), (value) => val as int,
                                                            ifAbsent: () => val as int);

                                                        if (i == 0) {
                                                          setState(() {
                                                            childage0 = val as int;
                                                          });
                                                        }
                                                        if (i == 1) {
                                                          childage1 = val as int;
                                                        }
                                                        if (i == 2) {
                                                          childage2 = val as int;
                                                        }
                                                        if (i == 3) {
                                                          childage3 = val as int;
                                                        }
                                                        if (i == 4) {
                                                          childage4 = val as int;
                                                        }
                                                        if (i == 5) {
                                                          childage5 = val as int;
                                                        }
                                                        if (i == 6) {
                                                          childage6 = val as int;
                                                        }
                                                        if (i == 7) {
                                                          childage7 = val as int;
                                                        }
                                                        if (i == 8) {
                                                          childage8 = val as int;
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            : _buildPrivetJet(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Provider.of<AppData>(context, listen: false).locale ==
                                  const Locale('en')
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(30.w, 6.h), backgroundColor: primaryblue),
                            onPressed: () {
                              switch (searchMode) {
                                case "":
                                  {
                                    makeSearch();
                                    break;
                                  }
                                case "privet jet":
                                  {
                                    context.read<AppData>().setPax = pax;
                                    context.read<AppData>().setTravelInsurancePax(pax, 0, 0);
                                    if (minCategory != null) {
                                      context.read<AppData>().setMinCategory = minCategory!.id;
                                      widget.next();
                                      _sendRequestForPrivetJet();
                                    } else {
                                      displayTostmessage(context, false,
                                          isInformation: true,
                                          message:
                                              AppLocalizations.of(context)!.plzSelectMinCategory);
                                    }

                                    break;
                                  }
                                case "travel insurance":
                                  {
                                    widget.next();
                                    _sendRequestForTravelInsurance();
                                    break;
                                  }
                                case "flight":
                                  {
                                    makeSearch();
                                    break;
                                  }
                                case "hotel":
                                  {
                                    makeSearch();
                                    break;
                                  }
                                case "activity":
                                  {
                                    makeSearch();
                                    break;
                                  }
                                case "transfer":
                                  {
                                    searchForTransfer();

                                    break;
                                  }
                              }
                            },
                            child: Text(
                              searchMode.contains('privet jet') ||
                                      searchMode.contains('travel insurance')
                                  ? AppLocalizations.of(context)!.next
                                  : AppLocalizations.of(context)!.search,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  Widget _buildPrivetJet() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black.withOpacity(0.50),
        ),
        SizedBox(
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.pax,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
              ),
              MyCustomNumberPicker(
                w: 7.w,
                valueTextStyle: TextStyle(fontSize: 14.sp),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                initialValue: pax,
                maxValue: 30,
                minValue: 1,
                step: 1,
                onValue: (step, v) {
                  int x = int.parse(step.toString());
                  pax = x;
                  context.read<AppData>().setPax = pax;
                },
                customAddButton: customNumberPickerIcon(iconData: Icons.add, ontap: () {}),
                customMinusButton: customNumberPickerIcon(iconData: MdiIcons.minus, ontap: () {}),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black.withOpacity(0.50),
        ),
        InkWell(
          onTap: _showMinCategory,
          child: SizedBox(
            width: 100.w,
            height: 9.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.minCategory,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      minCategory?.name ?? '',
                      style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down)
              ],
            ),
          ),
        )
      ],
    ));
  }

  _showMinCategory() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              color: Colors.white,
              width: 100.w,
              padding: const EdgeInsets.all(10).copyWith(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.minCategory,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        privetJetCategories != null
                            ? Column(
                                children: [
                                  for (int i = 0; i < privetJetCategories!.data.length; i++)
                                    _buildCategoryItem(privetJetCategories!.data[i])
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                  ))
                ],
              ),
            ));
  }

  _buildCategoryItem(Categories item) => InkWell(
        onTap: () {
          minCategory = item;

          if (item.name.contains('>19 PAX') && context.read<AppData>().getPax < 19) {
            pax = 19;
            context.read<AppData>().setPax = pax;
            setState(() {});
            displayTostmessage(context, false,
                message: 'This option need at lest 19 PAX and Pax number set to 19 ',
                isInformation: true);
          }
          setState(() {});
          Navigator.of(context).pop();
        },
        child: ListTileTheme(
          selectedTileColor: primaryblue,
          selectedColor: primaryblue,
          child: ListTile(
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            minLeadingWidth: 1,
            selected: item == minCategory ? true : false,
            leading: item == minCategory ? const Icon(Icons.done) : null,
            title: Text(
              item.name,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ),
      );

//! ///////  FUNCTIONS//////////

  makeSearch() async {
    Provider.of<AppData>(context, listen: false).makeresarchResearchCurr(true);
    String childage = '';
    String firstdate = DateFormat('dd/MM/y')
        .format(Provider.of<AppData>(context, listen: false).newSearchFirstDate!);
    String secdate = DateFormat('dd/MM/y').format(
        Provider.of<AppData>(context, listen: false).newSearchsecoundDate ??
            Provider.of<AppData>(context, listen: false).newSearchFirstDate!);
    String selectedhotelcode = '';
    String selectedflightcode = '';

    Provider.of<AppData>(context, listen: false).getdates(firstdate, secdate);
    Provider.of<AppData>(context, listen: false)
        .getRoomAndChildrenDetails(roomcount, adultscount, childeringCount);

    switch (childeringCount) {
      case 1:
        childage = 'childAge[1][1]=$childage0';
        break;
      case 2:
        childage = 'childAge[1][1]=$childage0&childAge[1][2]=$childage1';
        break;
      case 3:
        childage = 'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2';
        break;
      case 4:
        childage =
            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage4';
        break;
      case 5:
        childage =
            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4';
        break;
      case 6:
        childage =
            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5';
        break;
      case 7:
        childage =
            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5&childAge[1][7]=$childage6';
        break;
      case 8:
        childage =
            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5&childAge[1][7]=$childage6&childAge[1][8]=$childage7';
        break;
      default:
    }
    Provider.of<AppData>(context, listen: false).getfinalchildrenstext(childage);

    // try {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoadingWidgetMain()));
    pressIndcatorDialog(context);
    String fCLass = '';

    if (searchMode.contains('flight')) {
      switch (selectedFlightClass) {
        case FlightClass.economy:
          fCLass = 'Y';
          break;
        case FlightClass.premiumEconomy:
          fCLass = 'W';
          break;
        case FlightClass.business:
          fCLass = 'C';
          break;
        case FlightClass.firstClass:
          fCLass = 'F';
          break;
      }
    }
    context.read<AppData>().flightType = selectedFlightType;
    bool error = await AssistantMethods.mainSearchpackage(
        context,
        firstdate,
        selectedFlightType == FlightType.onewayFlight ? firstdate : secdate,
        context.read<AppData>().searchMode.contains('activity')
            ? Provider.of<AppData>(context, listen: false).payloadto.id
            : Provider.of<AppData>(context, listen: false).payloadFrom!.id,
        Provider.of<AppData>(context, listen: false).payloadto.id,
        selectedhotelcode,
        selectedflightcode,
        fCLass,
        roomcount,
        adultscount,
        childeringCount,
        childage,
        '',
        context.read<AppData>().searchMode,
        selectedFlightType == FlightType.onewayFlight ? "1" : "2");

    ///! for research change vlaidation/////
    if (!mounted) return;
    Provider.of<AppData>(context, listen: false).cheakResarh(
        fday: firstdate,
        secday: selectedFlightType == FlightType.onewayFlight ? firstdate : secdate,
        fcity: Provider.of<AppData>(context, listen: false).payloadFrom!.cityName,
        secCity: Provider.of<AppData>(context, listen: false).payloadto.cityName,
        room: roomcount.toString(),
        child: childeringCount.toString(),
        adult: adultscount.toString(),
        fclass: 'Y');

    ///! for research change vlaidation end/////

    String? mainPackageId = Provider.of<AppData>(context, listen: false).mainpackageId;

    setState(() {
      bucket = PageStorageBucket();
    });

// await AssistantMethods.getPackages(
//     context, mainPackageId);
    if (error == true) {
      Provider.of<AppData>(context, listen: false).hundletheloading(false);
    } else {
      Navigator.pop(context);
    }
    // } catch (e) {
    // if (kDebugMode) {
    //   print(e);
    // }
    //   Navigator.pop(context);
    //   displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgain);
    // }
  }

  _sendRequestForPrivetJet() async {}

  _sendRequestForTravelInsurance() async {
    context.read<AppData>().setTravelInsurancePax(adultscount, olderCount, childCountForIn);
  }

  void searchForTransfer() async {
    try {
      final preData = context.read<AppData>();
      Map req = {
        "selling_currency": gencurrency,
        "transfer_type": preData.transferTimeAndDate["transfer_type"],
        "pickup_code": preData.transferPointsData['from']?.code,
        "pickup_mode": preData.transferPointsData['from']?.category,
        "dropoff_code": preData.transferPointsData['to']?.code,
        "dropoff_mode": preData.transferPointsData['to']?.category,
        "pax": {
          "adults": adultscount,
          "children": childeringCount,
          "children_age": childAgeMap,
        },
        "pickup": preData.transferTimeAndDate["departure"],
        "return": preData.transferTimeAndDate["return"],
        "country": {
          "pickup": preData.transferPointsData['from']?.country,
          "dropoff": preData.transferPointsData['to']?.country
        },
      };
      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoadingWidgetMain()));
      pressIndcatorDialog(context);
      final hasError = await AssistantMethods.makeTransferSearch(context, json.encode(req));
      if (hasError == true) {
        if (!mounted) return;
        Navigator.of(context)
          ..pop()
          ..push(MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()));
      } else {
        if (!mounted) return;
        displayTostmessage(context, false,
            isInformation: true, message: 'They are no transfer to this location');
        Navigator.of(context).pop();
      }
    } catch (e) {
      displayTostmessage(context, false,
          isInformation: true, message: 'They are no transfer to this location');
      Navigator.of(context).pop();
    }
  }

  Widget _buildFlightType() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flight Type ',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 1.h,
          ),
          Wrap(
            spacing: 15,
            runAlignment: WrapAlignment.start,
            children: [
              _buildFlightTypeData(FlightType.roundedFlight, 'Rounded flight'),
              _buildFlightTypeData(FlightType.onewayFlight, 'One way flight'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectFlightClass() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cabin class  ',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 1.h,
          ),
          Wrap(
            spacing: 15,
            runAlignment: WrapAlignment.start,
            children: [
              _buildFlightComp(FlightClass.economy, 'Economy'),
              _buildFlightComp(FlightClass.premiumEconomy, 'Premium Economy'),
              _buildFlightComp(FlightClass.business, 'Business'),
              _buildFlightComp(FlightClass.firstClass, 'First Class')
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlightComp(FlightClass value, String title) {
    return GestureDetector(
      onTap: () {
        selectedFlightClass = value;
        setState(() {});
      },
      child: Container(
        width: 40.w,
        height: 5.h,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: value == selectedFlightClass ? primaryblue : Colors.grey.shade500,
                width: value == selectedFlightClass ? 3 : 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(title),
      ),
    );
  }

  Widget _buildFlightTypeData(FlightType value, String title) {
    return GestureDetector(
      onTap: () {
        selectedFlightType = value;
        setState(() {});
      },
      child: Container(
        width: 40.w,
        height: 5.h,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: value == selectedFlightType ? primaryblue : Colors.grey.shade500,
                width: value == selectedFlightType ? 3 : 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(title),
      ),
    );
  }
}

Widget customNumberPickerIcon({required IconData iconData, required VoidCallback ontap}) =>
    Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        iconData,
        color: Colors.grey,
        size: 18.sp,
      ),
    );
