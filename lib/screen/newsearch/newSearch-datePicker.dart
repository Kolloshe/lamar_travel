// ignore_for_file: file_names, must_be_immutable, library_private_types_in_public_api, empty_catches

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../../config.dart';

enum TripType { round, one }

class DateRangePickers extends StatefulWidget {
  DateRangePickers({Key? key, required this.ontap, required this.next, required this.isfromnavbar})
      : super(key: key);
  final VoidCallback ontap;
  final VoidCallback next;
  VoidCallback isfromnavbar;

  @override
  _DateRangePickersState createState() => _DateRangePickersState();
}

class _DateRangePickersState extends State<DateRangePickers> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  TripType? _tripType = TripType.one;

  late Animation<Offset> _animation;

  String firstDate = '';

  String secoundDate = '';

  bool isSearchForActivity = false;

  DateTime oneTripDate = DateTime.now().add(const Duration(days: 3));

  String oneTripTime = 'Pick your departure time';

  DateTime roundTripDepartureDate = DateTime.now().add(const Duration(days: 1));

  String roundTripDepartureTime = 'Pick your departure time';

  DateTime roundTripReturnDate = DateTime.now().add(const Duration(days: 2));

  String roundTripReturnTime = 'Pick your departure time';

  DateRangePickerController dateRangePickerController = DateRangePickerController();

  // ignore: unused_field
  String _selectedDate = '';

  // ignore: unused_field
  String _dateCount = '';

  // ignore: unused_field
  String _range = '';
  late Locale _locale;

  bool isEN = true;

  String searchMode = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      if (context.read<AppData>().searchMode.contains('activity')) {
      } else if (dateRangePickerController.selectedRange!.startDate!
          .isAtSameMomentAs(dateRangePickerController.selectedRange!.endDate!)) {
        displayTostmessage(context, true,
            message: AppLocalizations.of(context)!.errorSelectAtLeastNumOfDays("3"),
            isInformation: true);
      }
      setState(() {
        if (args.value is PickerDateRange) {
          _range =
              '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {}
      });
    } catch (e) {}
  }

  getPreDataForPrivetJet() {
    if (searchMode.contains('privet jet') || searchMode.contains('transfer')) {
      final nowHour = TimeOfDay.now().hour.toString().length <= 1
          ? '0${TimeOfDay.now().hour}'
          : TimeOfDay.now().hour.toString();

      final nowMinute = TimeOfDay.now().minute.toString().length <= 1
          ? '0${TimeOfDay.now().minute}'
          : TimeOfDay.now().minute.toString();
      final privetJetDateInformation = context.read<AppData>().privetJetDateInformation;
      if (privetJetDateInformation.containsKey('tripType')) {
        _tripType = privetJetDateInformation['tripType'] == 'one' ? TripType.one : TripType.round;
      }
      if (privetJetDateInformation.containsKey('departure')) {
        oneTripDate = DateFormat('y-MM-dd').parse(privetJetDateInformation['departure']['date']);
        roundTripDepartureDate = oneTripDate;
        oneTripTime = privetJetDateInformation['departure']['time'];
        roundTripDepartureTime = privetJetDateInformation['departure']['time'];
      } else {
        oneTripDate = DateTime.now().add(const Duration(days: 3));
        roundTripDepartureDate = DateTime.now().add(const Duration(days: 3));
        oneTripTime = '$nowHour:$nowMinute';

        roundTripDepartureTime = '$nowHour:$nowMinute';
      }

      if (privetJetDateInformation.containsKey('return')) {
        roundTripReturnDate =
            DateFormat('y-MM-dd').parse(privetJetDateInformation['return']['date']);
        roundTripReturnTime = privetJetDateInformation['return']['time'];
      } else {
        roundTripReturnDate = DateTime.now().add(const Duration(days: 6));
        roundTripReturnTime = '$nowHour:$nowMinute';
      }
    }
  }

  @override
  void initState() {
    searchMode = context.read<AppData>().searchMode;
    getPreDataForPrivetJet();

    _locale = Provider.of<AppData>(context, listen: false).locale;
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(_animationController);

    if (searchMode.isEmpty &&
        context.read<AppData>().newSearchFirstDate != null &&
        context.read<AppData>().newSearchsecoundDate != null) {
      dateRangePickerController.selectedRange = PickerDateRange(
          context.read<AppData>().newSearchFirstDate, context.read<AppData>().newSearchsecoundDate);
    }
    // Provider.of<AppData>(context, listen: false).newSearchTitle('When will you be there');
    super.initState();
    isEN = Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? true : false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
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
                  padding: const EdgeInsets.all(15),
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
                                      isEN ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
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
                        const SizedBox(height: 14),
                        context.read<AppData>().searchMode.toLowerCase().contains('privet jet') ||
                                context
                                    .read<AppData>()
                                    .searchMode
                                    .toLowerCase()
                                    .contains('transfer')
                            ? _buildDateAndTimeForPrivetJet()
                            : _buildDateRangePicker(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: isEN ? Alignment.centerRight : Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(30.w, 6.h), backgroundColor: primaryblue),
                            onPressed: () {
                              switch (searchMode) {
                                case 'privet jet':
                                  {
                                    Map<String, dynamic> privetJetDateInformation = {};

                                    if (_tripType == TripType.round) {
                                      final t1 = DateFormat('HH:mm').parse(roundTripDepartureTime);
                                      final t2 = DateFormat('HH:mm').parse(roundTripReturnTime);
                                      final newD1 = DateTime(
                                          roundTripDepartureDate.year,
                                          roundTripDepartureDate.month,
                                          roundTripDepartureDate.day,
                                          t1.hour,
                                          t1.minute);
                                      final newD2 = DateTime(
                                          roundTripReturnDate.year,
                                          roundTripReturnDate.month,
                                          roundTripReturnDate.day,
                                          t2.hour,
                                          t2.minute);

                                      final dif = newD2.difference(newD1);

                                      if (newD1.isAfter(newD2)) {
                                        displayTostmessage(context, false,
                                            isInformation: true,
                                            message:
                                                'The difference between departure Date should be before return date');
                                        return;
                                      } else if (dif.inHours.isNegative || dif.inHours < 6) {
                                        displayTostmessage(context, false,
                                            isInformation: true,
                                            message:
                                                'The difference between departure time and return time at lest 6 hour');
                                        return;
                                      } else {
                                        privetJetDateInformation = {
                                          'tripType': _tripType == TripType.one ? 'one' : 'round',
                                          "departure": {
                                            "date": DateFormat('y-MM-dd')
                                                .format(roundTripDepartureDate),
                                            "time": roundTripDepartureTime
                                          },
                                          "return": {
                                            "date":
                                                DateFormat('y-MM-dd').format(roundTripReturnDate),
                                            "time": roundTripReturnTime
                                          },
                                        };
                                        context.read<AppData>().setPrivetJetDateInformation =
                                            privetJetDateInformation;
                                        widget.next();
                                      }
                                    } else {
                                      privetJetDateInformation = {
                                        'tripType': _tripType == TripType.one ? 'one' : 'round',
                                        "departure": {
                                          "date": DateFormat('y-MM-dd').format(oneTripDate),
                                          "time": oneTripTime
                                        },
                                      };

                                      context.read<AppData>().setPrivetJetDateInformation =
                                          privetJetDateInformation;
                                      widget.next();
                                    }
                                    break;
                                  }
                                case 'transfer':
                                  {
                                    Map<String, dynamic> transferTripType = {};
                                    if (_tripType == TripType.round) {
                                      final t1 = DateFormat('HH:mm').parse(roundTripDepartureTime);
                                      final t2 = DateFormat('HH:mm').parse(roundTripReturnTime);
                                      final newD1 = DateTime(
                                          roundTripDepartureDate.year,
                                          roundTripDepartureDate.month,
                                          roundTripDepartureDate.day,
                                          t1.hour,
                                          t1.minute);
                                      final newD2 = DateTime(
                                          roundTripReturnDate.year,
                                          roundTripReturnDate.month,
                                          roundTripReturnDate.day,
                                          t2.hour,
                                          t2.minute);

                                      final dif = newD2.difference(newD1);

                                      if (newD1.isAfter(newD2)) {
                                        displayTostmessage(context, false,
                                            isInformation: true,
                                            message:
                                                'The difference between departure Date should be before return date');
                                        return;
                                      } else if (dif.inHours.isNegative || dif.inHours < 6) {
                                        displayTostmessage(context, false,
                                            isInformation: true,
                                            message:
                                                'The difference between departure time and return time at lest 6 hour');
                                        return;
                                      } else {
                                        transferTripType = {
                                          "transfer_type":
                                              _tripType == TripType.one ? 'one' : 'round',
                                          "departure": {
                                            "date": DateFormat('y-MM-dd')
                                                .format(roundTripDepartureDate),
                                            "time": roundTripDepartureTime
                                          },
                                          "return": {
                                            "date":
                                                DateFormat('y-MM-dd').format(roundTripReturnDate),
                                            "time": roundTripReturnTime
                                          },
                                        };

                                        context.read<AppData>().transferIndTimeAndDate =
                                            transferTripType;
                                        widget.next();
                                      }
                                    } else {
                                      transferTripType = {
                                        "transfer_type":
                                            _tripType == TripType.one ? 'one' : 'round',
                                        "departure": {
                                          "date": DateFormat('y-MM-dd').format(oneTripDate),
                                          "time": oneTripTime
                                        },
                                      };
                                    }
                                    context.read<AppData>().transferIndTimeAndDate =
                                        transferTripType;
                                    widget.next();
                                    break;
                                  }
                                case 'activity':
                                  {
                                    // print('here');
                                    //
                                    // bool dates = dateRangePickerController
                                    //             .selectedRange!.startDate!.day ==
                                    //         DateTime.now().day &&
                                    //     dateRangePickerController.selectedRange!.startDate!.month ==
                                    //         DateTime.now().month;
                                    // print(dates);
                                    //
                                    // if (dateRangePickerController.selectedRange != null &&
                                    //     dateRangePickerController.selectedRange!.startDate !=
                                    //         null) {
                                    //   Provider.of<AppData>(context, listen: false)
                                    //       .newsearchdateRange(
                                    //           dateRangePickerController.selectedRange!);
                                    //   Provider.of<AppData>(context, listen: false).getdatesfromCal(
                                    //       dateRangePickerController.selectedRange!.startDate!,
                                    //       dateRangePickerController.selectedRange!.endDate == null
                                    //           ? dateRangePickerController.selectedRange!.startDate!
                                    //           : dateRangePickerController.selectedRange!.endDate!);
                                    //   //   Provider.of<AppData>(context, listen: false).newsearchdateRange(dateRangePickerController.selectedRange!);
                                    //   widget.next();
                                    // } else {
                                    //   displayTostmessage(context, true,
                                    //       message:
                                    //           AppLocalizations.of(context)!.errorSelectRangDate);
                                    // }
                                    if (dateRangePickerController.selectedDate == null) {
                                      displayTostmessage(context, true,
                                          isInformation: true, message: 'please select dates');
                                      return;
                                    }

                                    bool dates = dateRangePickerController.selectedDate!.day ==
                                            DateTime.now().day &&
                                        dateRangePickerController.selectedDate!.month ==
                                            DateTime.now().month;
                                    if (kDebugMode) {
                                      print(dates);
                                    }

                                    if (dateRangePickerController.selectedDate != null &&
                                        dateRangePickerController.selectedDate != null) {
                                      Provider.of<AppData>(context, listen: false)
                                          .newsearchdateRange(PickerDateRange(
                                              dateRangePickerController.selectedDate,
                                              dateRangePickerController.selectedDate));
                                      Provider.of<AppData>(context, listen: false).getdatesfromCal(
                                          dateRangePickerController.selectedDate!,
                                          dateRangePickerController.selectedDate!);
                                      //   Provider.of<AppData>(context, listen: false).newsearchdateRange(dateRangePickerController.selectedRange!);
                                      widget.next();
                                    } else {
                                      displayTostmessage(context, true,
                                          message:
                                              AppLocalizations.of(context)!.errorSelectRangDate);
                                    }

                                    break;
                                  }
                                default:
                                  {
                                    bool dates = dateRangePickerController
                                                .selectedRange!.startDate!.day ==
                                            DateTime.now().day &&
                                        dateRangePickerController.selectedRange!.startDate!.month ==
                                            DateTime.now().month;
                                    if (dateRangePickerController.selectedRange != null &&
                                        dateRangePickerController.selectedRange!.startDate !=
                                            null &&
                                        dateRangePickerController.selectedRange!.endDate != null &&
                                        !dates) {
                                      Provider.of<AppData>(context, listen: false)
                                          .newsearchdateRange(
                                              dateRangePickerController.selectedRange!);
                                      Provider.of<AppData>(context, listen: false).getdatesfromCal(
                                          dateRangePickerController.selectedRange!.startDate!,
                                          dateRangePickerController.selectedRange!.endDate!);
                                      //   Provider.of<AppData>(context, listen: false).newsearchdateRange(dateRangePickerController.selectedRange!);
                                      widget.next();
                                    } else {
                                      displayTostmessage(context, true,
                                          message: dates
                                              ? AppLocalizations.of(context)!.plzSelectOneDayNext
                                              : AppLocalizations.of(context)!.errorSelectRangDate);
                                    }
                                  }
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  Widget _buildDateRangePicker() => Expanded(
        child: SfDateRangePicker(
          allowViewNavigation: true,
          navigationMode: DateRangePickerNavigationMode.scroll,
          navigationDirection: DateRangePickerNavigationDirection.vertical,
          //  initialDisplayDate: DateTime.now().add(Duration(days: 4)),

          enablePastDates: false,
          selectionColor: primaryblue,
          controller: dateRangePickerController,

          //    enableMultiView: true,
          onViewChanged: (v) {},
          onSubmit: (v) {
            //
          },
          onCancel: () {
            dateRangePickerController.dispose();
            setState(() {});
          },
          selectionTextStyle: const TextStyle(
            color: Colors.black,
          ),
          selectionShape: DateRangePickerSelectionShape.circle,
          headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: _locale == const Locale('en') ? 'Lato' : 'Bhaijaan')),
          monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              todayTextStyle: TextStyle(color: yellowColor)),
          startRangeSelectionColor: primaryblue,
          endRangeSelectionColor: primaryblue,
          rangeSelectionColor: Colors.grey.shade200,
          rangeTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              locale: _locale,
              fontFamily: _locale == const Locale('en') ? 'Lato' : 'Bhaijaan'),
          showNavigationArrow: false,
          showActionButtons: false,
          showTodayButton: false,
          initialDisplayDate: DateTime.now().add(const Duration(days: 3)),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            showTrailingAndLeadingDates: false,
          ),
          onSelectionChanged: _onSelectionChanged,
          selectableDayPredicate: (date) {
            if (date.isAtSameMomentAs(DateTime.now())) {
              return false;
            } else if (date.isBefore(DateTime.now())) {
              return false;
            } else {
              return true;
            }
          },
          selectionMode: context.read<AppData>().searchMode.contains('activity')
              ? DateRangePickerSelectionMode.single
              : DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(DateTime.now().add(const Duration(days: 1)),
              DateTime.now().add(const Duration(days: 4))),
        ),
      );

  Widget _buildDateAndTimeForPrivetJet() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select trip type',
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(
            width: 100.w,
            height: 5.h,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              SizedBox(
                  width: 35.w,
                  child: RadioListTile<TripType>(
                      title: Text(
                        AppLocalizations.of(context)!.one,
                        style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.w700),
                      ),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (TripType? value) {
                        setState(() {
                          _tripType = value;
                        });
                      },
                      groupValue: _tripType,
                      value: TripType.one)),
              SizedBox(
                  width: 40.w,
                  child: RadioListTile<TripType>(
                      activeColor: primaryblue,
                      title: Text(
                        AppLocalizations.of(context)!.round,
                        style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.w700),
                      ),
                      onChanged: (TripType? value) {
                        setState(() {
                          _tripType = value;
                        });
                      },
                      groupValue: _tripType,
                      value: TripType.round))
            ])),
        SizedBox(height: 2.h),
        _tripType! == TripType.one ? _buildPickerForOneTrip() : _buildPickerForRoundTrip()
      ],
    ));
  }

  Widget _buildPickerForOneTrip() {
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black.withOpacity(0.50),
        ),
        SizedBox(
          child: Text(
            AppLocalizations.of(context)!.departureInformation,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 2.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: _showOneDatePicker,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        offset: const Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 5)
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.departureDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    DateFormat('d-M-y').format(oneTripDate),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: _showOneTimePicker,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: const Offset(1, 1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.departureTime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    oneTripTime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    ));
  }

  Widget _buildPickerForRoundTrip() {
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black.withOpacity(0.50),
        ),
        SizedBox(
          child: Text(
            AppLocalizations.of(context)!.departureInformation,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 2.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () async {
              final date = await _showRoundDatePicker(DateTime.now(), roundTripDepartureDate);

              if (date != null) {
                roundTripDepartureDate = date;

                setState(() {});
              }
            },
            child: Container(
              width: 40.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: const Offset(1, 1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.departureDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(DateFormat('d-M-y').format(roundTripDepartureDate)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              roundTripDepartureTime =
                  await _showRoundTimePicker(DateFormat('HH:mm').parse(roundTripDepartureTime));
              setState(() {});
            },
            child: Container(
              width: 40.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: const Offset(1, 1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.departureTime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(roundTripDepartureTime),
                ],
              ),
            ),
          ),
        ]),
        SizedBox(height: 2.h),
        SizedBox(
          child: Text(
            AppLocalizations.of(context)!.returnInformation,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 2.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () async {
              final date = await _showRoundDatePicker(roundTripDepartureDate, roundTripReturnDate,
                  newInitialDate: roundTripDepartureDate);

              if (date != null) {
                roundTripReturnDate = date;
                setState(() {});
              }
            },
            child: Container(
              width: 40.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: const Offset(1, 1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.returnDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(DateFormat('d-M-y').format(roundTripReturnDate)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              roundTripReturnTime =
                  await _showRoundTimePicker(DateFormat('HH:mm').parse(roundTripReturnTime));
              setState(() {});
            },
            child: Container(
              width: 40.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      offset: const Offset(1, 1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.returnTime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 1.h),
                  Text(roundTripReturnTime),
                ],
              ),
            ),
          ),
        ]),
      ],
    ));
  }

  _showOneTimePicker() async {
    final DateTime? data = await TimePicker.show(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: DateTime.now(),
        sheetTitle: AppLocalizations.of(context)!.selectDepartureTimes,
        hourTitle: AppLocalizations.of(context)!.hour,
        minuteTitle: AppLocalizations.of(context)!.minute,
        saveButtonText: AppLocalizations.of(context)!.save,
        minuteInterval: 1,
        sheetCloseIconColor: primaryblue,
        minuteTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        hourTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        wheelNumberSelectedStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        saveButtonColor: primaryblue,
      ),
    );
    if (data != null) {
      oneTripTime = DateFormat('HH:mm').format(data);

      setState(() {});
    }

    return data;
  }

  _showOneDatePicker() async {
    final DateTime? data = await showDatePicker(
        context: context,
        selectableDayPredicate: (date) {
          if (date.isAfter(DateTime.now())) {
            return true;
          } else {
            return false;
          }
        },
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (data != null) {
      oneTripDate = data;
      setState(() {});
    }
  }

  Future<DateTime?> _showRoundDatePicker(DateTime limit, DateTime initialDate,
      {DateTime? newInitialDate}) async {
    final DateTime? data = await showDatePicker(
        context: context,
        selectableDayPredicate: (date) {
          if (date.isAfter(limit) || date.isAtSameMomentAs(limit)) {
            return true;
          } else {
            return false;
          }
        },
        initialDate: newInitialDate ?? initialDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));
    if (data != null) {
      return data;
    }
    return null;
  }

  _showRoundTimePicker(DateTime initialDateTime) async {
    String formattedTime = '';
    DateTime? data = await TimePicker.show(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: initialDateTime,
        sheetTitle: AppLocalizations.of(context)!.selectReturnTimes,
        hourTitle: AppLocalizations.of(context)!.hour,
        minuteTitle: AppLocalizations.of(context)!.minute,
        saveButtonText: AppLocalizations.of(context)!.save,
        minuteInterval: 1,
        sheetCloseIconColor: primaryblue,
        minuteTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        hourTitleStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        wheelNumberSelectedStyle: TextStyle(color: primaryblue, fontSize: 12.sp),
        saveButtonColor: primaryblue,
      ),
    );
    if (data != null) {
      formattedTime = DateFormat('HH:mm').format(data);
    } else {
      formattedTime = DateFormat('HH:mm').format(DateTime.now());
    }

    return formattedTime;
  }
}
