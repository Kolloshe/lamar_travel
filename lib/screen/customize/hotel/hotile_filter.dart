import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/changehotel.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../filtter_screen.dart';

class HotelFilter extends StatefulWidget {
  const HotelFilter({Key? key, required this.hotels}) : super(key: key);

  final Changehotel hotels;

  @override
  // ignore: library_private_types_in_public_api
  _HotelFilterState createState() => _HotelFilterState();
}

class _HotelFilterState extends State<HotelFilter> {
  String dropdownValueName = 'A to Z';
  String dropdownValuePrice = 'Lowest';
  // double? _maxpakagesprice;
  // double? _minpakagesprice;
  // RangeValues? _currentRangeValues;
  List<CheckboxStateHolder> starRatingcheck = [];

  gethotilsdata() {
    //  _maxpakagesprice = double.parse('2');

    starRatingcheck = Provider.of<AppData>(context, listen: false).starRatingcheckHotel;
  }

  @override
  void initState() {
    gethotilsdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: primaryblue,
              size: 30,
            )),
        backgroundColor: cardcolor,
        title: const Text(
          'Filter',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.5,
      ),
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: 'Stars'),
              _buildSpacer(w: 0, h: 1),
              _buildCheckBoxForStarRating(),
              _buildSpacer(w: 0, h: 2),
              _buildTitle(title: 'Hotel name'),
              _buildSpacer(w: 0, h: 1),
              _buildHotelName(),
              _buildSpacer(w: 0, h: 1),
              _buildTitle(title: 'Hotel price'),
              _buildSpacer(w: 0, h: 1),
              _buildHotelPrice(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        //color: primaryblue,
        width: 100.w,
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent, side: const BorderSide(width: 1.5, color: Colors.redAccent),
                ),
                onPressed: () {
                  Provider.of<AppData>(context, listen: false).restTheFilter();
                  Navigator.of(context).pop();
                },
                child: const Text('Clear')),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryblue, side: BorderSide(width: 1.5, color: primaryblue),
              ),
              onPressed: () {
                getFilterDataFromUser();
              },
              child: Text(
                'Apply Fillter',
                style:
                    TextStyle(fontWeight: FontWeight.normal, color: primaryblue, fontSize: 12.sp),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildSlider() => SliderTheme(
  //       data: SliderThemeData.fromPrimaryColors(
  //           primaryColor: primaryblue,
  //           primaryColorDark: yellowColor,
  //           primaryColorLight: primaryblue,
  //           valueIndicatorTextStyle: TextStyle(color: Colors.white)),
  //       child: RangeSlider(
  //         values: _currentRangeValues!,
  //         max: _maxpakagesprice!,
  //         min: _minpakagesprice!,
  //         divisions: 6,
  //         labels: RangeLabels(
  //           gencurrency + ' ' + _currentRangeValues!.start.round().toString(),
  //           gencurrency + ' ' + _currentRangeValues!.end.round().toString(),
  //         ),
  //         onChanged: (RangeValues values) {
  //           setState(() {
  //             _currentRangeValues = values;
  //             Provider.of<AppData>(context, listen: false)
  //                 .getsliderLimit(mins: _currentRangeValues!.start, maxs: _currentRangeValues!.end);
  //           });
  //         },
  //       ),
  //     );

  Widget _buildTitle({required String title}) => Text(title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14.sp));

  Widget _buildSpacer({required int w, required int h}) => SizedBox(width: w.w, height: h.h);

  Widget _buildCheckBoxForStarRating() => Column(children: [
        ...starRatingcheck.map((e) => CheckboxListTile(
            title: Text(
              e.tilte,
              style: TextStyle(color: yellowColor, fontSize: 12.sp),
            ),
            value: e.value,
            onChanged: (v) {
              setState(() {
                e.value = v!;
              });
              Provider.of<AppData>(context, listen: false).getStarRatingCheckHotel(starRatingcheck);
            }))
      ]);

  Widget _buildHotelName() => Container(
        padding: const EdgeInsets.all(10).copyWith(left: 16),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hotel Name',
              style: TextStyle(fontSize: 12.sp),
            ),
            DropdownButton<String>(
              value: dropdownValueName,
              // icon: const Icon(Icons.),
              elevation: 16,
              style: TextStyle(color: primaryblue),
              underline: Container(
                height: 2,
                color: primaryblue,
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  Provider.of<AppData>(context, listen: false).nameForHotelDroplist = newValue;
                  setState(() {
                    dropdownValueName = newValue;
                  });
                }
              },
              items: <String>['A to Z', 'Z to A'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      );

  Widget _buildHotelPrice() => Container(
        padding: const EdgeInsets.all(10).copyWith(left: 16),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hotel price',
              style: TextStyle(fontSize: 12.sp),
            ),
            DropdownButton<String>(
              value: dropdownValuePrice,
              // icon: const Icon(Icons.),
              elevation: 16,
              style: TextStyle(color: primaryblue),
              underline: Container(
                height: 2,
                color: primaryblue,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValuePrice = newValue!;
                });
              },
              items: <String>['Lowest', 'Highest'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      );

  getFilterDataFromUser() {
    Map<int, bool> starsRate = {
      3: false,
      4: false,
      5: false,
    };

    Provider.of<AppData>(context, listen: false).priceForHotelDropList = dropdownValuePrice;
    Provider.of<AppData>(context, listen: false).nameForHotelDroplist = dropdownValueName;
    for (var element in starRatingcheck) {
      if (element.value == true) {
        starsRate.update(element.tilte.replaceAll(' ', '').length, (v) => true);
      }
    }

    Provider.of<AppData>(context, listen: false).starsRateHotel = starsRate;

    //   print(starsRate.toString());
    //   print(_currentRangeValues!.start.round().toString() +
    //       " - " +
    //       _currentRangeValues!.end.round().toString());
    //  // Provider.of<AppData>(context, listen: false).ismakefilter = true;
    Provider.of<AppData>(context, listen: false).filterHotel();

    if (Provider.of<AppData>(context, listen: false).packagefilter.isEmpty) {
      Provider.of<AppData>(context, listen: false).makeHotelFiters(false);
      displayTostmessage(context, true,
          message: ' No packages to display\n please make different filter selection');
    } else {
      Provider.of<AppData>(context, listen: false).makeHotelFiters(true);
      Navigator.of(context).pop();
    }
  }
}
