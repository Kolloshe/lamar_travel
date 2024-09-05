// ignore_for_file: library_private_types_in_public_api

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/mainsearch.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FillterScreen extends StatefulWidget {
  const FillterScreen({Key? key}) : super(key: key);

  @override
  _FillterScreenState createState() => _FillterScreenState();
}

class _FillterScreenState extends State<FillterScreen> {
  late MainSarchForPackage packages;

  double? _maxpakagesprice;
  double? _minpakagesprice;
  double _lowerValue = 50;
  double _upperValue = 180;

  List<CheckboxStateHolder> flightStopCheck = [];

  List<CheckboxStateHolder> starRatingcheck = [];

  loadPackages() {
    flightStopCheck = Provider.of<AppData>(context, listen: false).flightCheck;
    starRatingcheck = Provider.of<AppData>(context, listen: false).starRatingcheck;

    packages = Provider.of<AppData>(context, listen: false).mainsarchForPackage;
    _maxpakagesprice = double.parse(packages.data.priceRange.max.toString());
    _minpakagesprice = double.parse(packages.data.priceRange.min.toString());
    _lowerValue = double.parse(packages.data.priceRange.min.toString());
    _upperValue = double.parse(packages.data.priceRange.max.toString());
    if (Provider.of<AppData>(context, listen: false).max != null &&
        Provider.of<AppData>(context, listen: false).min != null) {
    } else {}
  }

  @override
  void initState() {
    loadPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // if (Provider.of<AppData>(context, listen: false).packagefilter.length == 0) {
              // displayTostmessage(context,true,
              //     messeage: ' No packages to display\n please make different filter selection');
              // } else {
              Navigator.of(context).pop();
              // }
            },
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              size: 28.sp,
            ),
          ),
          backgroundColor: primaryblue,
          elevation: 0.0,
          title: Text(AppLocalizations.of(context)!.filters),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 100.w,
            height: 100.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFillterTitle(title: AppLocalizations.of(context)!.preferredBudgets),
                  _buildSpacer(wspace: 0, hspace: 1),
                  _buildFillterByBudget(),
                  _buildSpacer(wspace: 0, hspace: 2),
                  _buildFillterTitle(title: AppLocalizations.of(context)!.fStops),
                  _buildSpacer(wspace: 0, hspace: 1),
                  _buildCheckBoxForFLight(),
                  _buildSpacer(wspace: 0, hspace: 2),
                  _buildFillterTitle(title: AppLocalizations.of(context)!.hotelStars),
                  _buildSpacer(wspace: 0, hspace: 1),
                  _buildCheckBoxForStarRating(),
                  _buildSpacer(wspace: 0, hspace: 7),
                ],
              ),
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
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(width: 1.5, color: Colors.redAccent),
                  ),
                  onPressed: () {
                    Provider.of<AppData>(context, listen: false).restTheFilter();
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.clear)),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryblue,
                  side: BorderSide(width: 1.5, color: primaryblue),
                ),
                onPressed: () {
                  getFilterDataFromUser();
                },
                child: Text(
                  AppLocalizations.of(context)!.applyFilter,
                  style:
                      TextStyle(fontWeight: FontWeight.normal, color: primaryblue, fontSize: 12.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFillterTitle({required String title}) => SizedBox(
        width: 100.w,
        child: Text(title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 12.sp)),
      );

  Widget _buildSpacer({required double wspace, required double hspace}) => SizedBox(
        height: hspace.h,
        width: wspace.w,
      );

  Widget _buildFillterByBudget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.min}\n${_lowerValue.round()}',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, color: primaryblue, fontSize: 10.sp),
                ),
                Text(
                  '${AppLocalizations.of(context)!.max}\n${_upperValue.round()}',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, color: primaryblue, fontSize: 10.sp),
                ),
              ],
            ),
            _buildSpacer(wspace: 0, hspace: 1),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: FlutterSlider(
                  values: [_lowerValue, _upperValue],
                  rangeSlider: true,
                  tooltip: FlutterSliderTooltip(disabled: true),
                  trackBar: const FlutterSliderTrackBar(
                    activeTrackBarHeight: 2,
                  ),
                  handler: FlutterSliderHandler(
                      child: Container(
                          width: 0.1.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ))),
                  rightHandler: FlutterSliderHandler(
                      child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  )),
                  max: _maxpakagesprice!,
                  min: _minpakagesprice!,
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    if (handlerIndex == 0) {
                      _lowerValue = lowerValue;
                    }
                    if (handlerIndex == 1) {
                      _upperValue = upperValue;
                    }

                    Provider.of<AppData>(context, listen: false).getsliderLimit(
                        mins: _lowerValue.roundToDouble(), maxs: _upperValue.roundToDouble());

                    setState(() {});
                  },
                )),

//           Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), child: SfRangeSliderTheme(
//             data: SfRangeSliderThemeData(
//                 thumbColor: Colors.white,
//                 thumbRadius: 15,
//                 thumbStrokeWidth: 1,
//                 thumbStrokeColor: primaryblue
//             ),
//             child: SfRangeSlider(
//               min:_minpakagesprice!,
//               max:  _maxpakagesprice!,
//               values: _currentRangeValues!,
//               interval: (_minpakagesprice! + _maxpakagesprice!)/10,
//               showTicks: true,
//               showLabels: false,
//               enableTooltip: true,
//               minorTicksPerInterval:1,
//               stepSize: 100                                     ,
//
//               onChanged: (SfRangeValues values){
//                 setState(() {
//                   _currentRangeValues = values;
//                   Provider.of<AppData>(context, listen: false).getsliderLimit(
//                       mins: _currentRangeValues!.start, maxs: _currentRangeValues!.end);
//                 });
//               },
//               startThumbIcon: Icon(
//                   Icons.arrow_back_ios,
//                   color:primaryblue,
//                   size: 20.0),
//               endThumbIcon: Icon(
//                   Icons.arrow_forward_ios,
//                   color: primaryblue,
//                   size: 20.0),
//             ),
//           ),)
//
// ,

            // SliderTheme(
            //   data: SliderThemeData.fromPrimaryColors(
            //       primaryColor: primaryblue,
            //       primaryColorDark: yellowColor,
            //       primaryColorLight: primaryblue,
            //       valueIndicatorTextStyle: TextStyle(color: Colors.white)),
            //   child: RangeSlider(
            //     values: _currentRangeValues!,
            //     max: _maxpakagesprice!,
            //     min: _minpakagesprice!,
            //     divisions: 6,
            //     labels: RangeLabels(
            //     localizeCurrency(gencurrency) + ' ' + _currentRangeValues!.start.round().toString(),
            //       localizeCurrency(gencurrency) + ' ' + _currentRangeValues!.end.round().toString(),
            //     ),
            //     onChanged: (RangeValues values) {
            //       setState(() {
            //         _currentRangeValues = values;
            //         Provider.of<AppData>(context, listen: false).getsliderLimit(
            //             mins: _currentRangeValues!.start, maxs: _currentRangeValues!.end);
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      );

  Widget _buildCheckBoxForFLight() => Column(
        children: [
          ...flightStopCheck.map((e) => CheckboxListTile(
              title: Text(
                localizetext(e.tilte),
                style:
                    TextStyle(color: primaryblue, fontSize: 11.sp, fontWeight: FontWeight.normal),
              ),
              value: e.value,
              onChanged: (v) {
                setState(() {
                  e.value = v!;
                });
                Provider.of<AppData>(context, listen: false).getflightCheck(flightStopCheck);
              }))
        ],
      );

  String localizetext(String val) {
    switch (val) {
      case "Non stop":
        {
          return AppLocalizations.of(context)!.nonStop;
        }
      case "One stop":
        {
          return AppLocalizations.of(context)!.oneStop;
        }
      case "Mutli stop":
        {
          return AppLocalizations.of(context)!.mutliStop;
        }
      default:
        {
          return val;
        }
    }
  }

  Widget _buildCheckBoxForStarRating() => Column(
        children: [
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
                Provider.of<AppData>(context, listen: false).getStarRatingCheck(starRatingcheck);
              }))
        ],
      );

  //! ///////////////////////////////////////////
  //! ///////////////////////////////////////////
  //! ///////////////////////////////////////////
  //! ////////////.  FUNCTIONS.  ////////////////
  //! ///////////////////////////////////////////
  //! ///////////////////////////////////////////
  //! ///////////////////////////////////////////

  getFilterDataFromUser() {
    Map<int, bool> starsRate = {
      3: false,
      4: false,
      5: false,
    };

    Map<int, bool> flightStops = {
      0: false,
      1: false,
      2: false,
    };

    for (var element in flightStopCheck) {
      if (element.value == true) {
        flightStops.update(flightStopCheck.indexOf(element), (value) => true);
      }
    }

    Provider.of<AppData>(context, listen: false).flightStops = flightStops;

    for (var element in starRatingcheck) {
      if (element.value == true) {
        starsRate.update(element.tilte.replaceAll(' ', '').length, (v) => true);
      }
    }
   

    Provider.of<AppData>(context, listen: false).starsRate = starsRate;

    Provider.of<AppData>(context, listen: false).ismakefilter = true;
    Provider.of<AppData>(context, listen: false).filter();

    if (Provider.of<AppData>(context, listen: false).packagefilter.isEmpty) {
      Provider.of<AppData>(context, listen: false).restTheFilter();
      displayTostmessage(context, true,
          message: ' No packages to display\n please make different filter selection');
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
    }
  }
}

class CheckboxStateHolder {
  final String tilte;
  bool value;

  CheckboxStateHolder({
    required this.tilte,
    required this.value,
  });
}
