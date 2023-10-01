// ignore_for_file: library_private_types_in_public_api, void_checks, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config.dart';
import '../../main_screen1.dart';
import '../new-customize/new_customize.dart';
import 'new_change_hotel.dart';

class SplitHotel extends StatefulWidget {
  static String idScreen = 'SplitHotel';

  const SplitHotel({Key? key, required this.hotels}) : super(key: key);
  final PackageHotels? hotels;

  @override
  _SplitHotelState createState() => _SplitHotelState();
}

class _SplitHotelState extends State<SplitHotel> {
  DateRangePickerController dateRangePickerController = DateRangePickerController();

  Customizpackage? package;

  // ignore: unused_field
  String _selectedDate = '';

  // ignore: unused_field
  String _dateCount = '';

  // ignore: unused_field
  String _range = '';

  // ignore: unused_field
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      if (dateRangePickerController.selectedRange!.startDate!
          .isAtSameMomentAs(dateRangePickerController.selectedRange!.endDate!)) {
        return displayTostmessage(context, true, message: 'please select at least one day');
      }
      setState(() {
        if (args.value is PickerDateRange) {
          _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy')
                  .format(args.value.endDate ?? args.value.startDate)}';
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    // ignore: empty_catches
    } catch (e) {}
  }

  List<PackageHotels> hotelList = [];

  @override
  void initState() {
    package = Provider.of<AppData>(context, listen: false).packagecustomiz;
    hotelList = package!.result.hotels;
    hotelList.sort((a, b) => a.checkIn.compareTo(b.checkIn));

    package!.result.hotels = hotelList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('len${hotelList.length}\nlast --->${hotelList.last.checkOut}\nfirst --->${hotelList.first.checkIn}');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 30.sp,
              color: primaryblue,
            )),
        backgroundColor: cardcolor,
        title: Text(
          'Split your stay',
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: 100.w,
                //   child: Text(
                //     'Please select the period you want to split',
                //     style: TextStyle(fontSize: titleFontSize),
                //   ),
                // ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: 100.w,
                  height: 3.h,
                  child: Text(
                    'Current hotels from ${package!.result.hotels.first.checkInText}  to ${package!.result.hotels.last.checkOutText}:',
                    style: TextStyle(fontSize: titleFontSize),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                SizedBox(
                  height: 15.h,
                  width: 100.w,
                  child: ListView.separated(
                      separatorBuilder: (context, i) => VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                            width: 20,
                          ),
                      scrollDirection: Axis.horizontal,
                      itemCount: package!.result.hotels.length,
                      itemBuilder: (context, index) =>
                          _buildHotelsOnPack(package!.result.hotels[index])),
                ),

                Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 5),
                    child: Text(
                      'Select hotel from ${widget.hotels!.checkInText} to ${widget.hotels!.checkOutText}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),
                    )),

                SizedBox(
                  height: 40.h,
                  child: SfDateRangePicker(
                    enableMultiView: false,
                    allowViewNavigation: false,
                    enablePastDates: true,
                    maxDate: package!.result.packageEnd,
                    minDate: package!.result.packageStart,
                    selectableDayPredicate: (date) {
                      if (date.isAfter(widget.hotels!.checkOut) ||
                          date.isBefore(widget.hotels!.checkIn)) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                    navigationMode: DateRangePickerNavigationMode.snap,
                    navigationDirection: DateRangePickerNavigationDirection.horizontal,
                    selectionColor: primaryblue,
                    controller: dateRangePickerController,
                    onViewChanged: (v) {},
                    onSubmit: (v) {},
                    onCancel: () {
                      dateRangePickerController.dispose();
                      setState(() {});
                    },
                    selectionShape: DateRangePickerSelectionShape.circle,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                        todayTextStyle: TextStyle(color: yellowColor)),
                    startRangeSelectionColor: primaryblue,
                    endRangeSelectionColor: primaryblue,
                    rangeSelectionColor: Colors.grey.shade200,
                    rangeTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
                    showNavigationArrow: false,
                    showActionButtons: false,
                    showTodayButton: false,
                    initialDisplayDate: widget.hotels!.checkIn,
                    monthViewSettings: const DateRangePickerMonthViewSettings(
                      showTrailingAndLeadingDates: false,
                    ),
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.extendableRange,
                    initialSelectedRange:
                        PickerDateRange(widget.hotels!.checkIn, widget.hotels!.checkOut),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    onPressed: () async {
                      makeSplit();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryblue, fixedSize: Size(100.w, 7.h)),
                    child: const Text('split'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHotelsOnPack(PackageHotels hotel) => Container(
        width: 50.w,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [shadow], borderRadius: BorderRadius.circular(12), color: cardcolor),
        padding: const EdgeInsets.all(10).copyWith(right: 0, bottom: 0),
        child: Stack(children: [
          Positioned(
              bottom: -30,
              right: -20,
              child: Image.asset(
                'assets/images/iconss/hotel.png',
                width: 20.w,
                color: primaryblue.withOpacity(0.2),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hotel.name,
                  style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/iconss/check-in.png',
                    color: primaryblue,
                    width: 6.w,
                  ),
                  Text(
                    '  ${hotel.checkInText}',
                    style: TextStyle(color: blackTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/iconss/check-out.png',
                    color: primaryblue,
                    width: 6.w,
                  ),
                  Text(
                    '  ${hotel.checkOutText}',
                    style: TextStyle(color: blackTextColor),
                  ),
                ],
              )
            ],
          ),
        ]),
      );

  void makeSplit() async {
    if (dateRangePickerController.selectedRange != null) {
      if (dateRangePickerController.selectedRange!.endDate == null ||
          dateRangePickerController.selectedRange!.startDate == null ||
          dateRangePickerController.selectedRange!.startDate!
              .isAtSameMomentAs(dateRangePickerController.selectedRange!.endDate!)) {
        return displayTostmessage(context, true, message: 'please select range of days');
      }

      String firstDay =
          DateFormat('yyyy-MM-dd').format(dateRangePickerController.selectedRange!.startDate!);
      String secoundDay =
          DateFormat('yyyy-MM-dd').format(dateRangePickerController.selectedRange!.endDate!);

      if (package == null) return;
                                  pressIndcatorDialog(context);

  //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MiniLoader()));

      await AssistantMethods.newSplitHotel(context,
          id: package!.result.customizeId, checkIn: firstDay, checkOut: secoundDay);

      Navigator.of(context).pop();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const NewHotelCustomize(oldHotelID: '')));
      // await AssistantMethods.splitHotel(
      //   context,
      //   customize: package!.result.customizeId,
      //   satrt: firstDay,
      //   end: secoundDay,
      // );
    } else {
      displayTostmessage(context, true, message: 'please select date range');
    }
  }
}
