// ignore_for_file: library_private_types_in_public_api, unused_field, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../Assistants/assistant_methods.dart';
import '../../Datahandler/app_data.dart';
import '../../Model/individual_services_model/indv_packages_listing_model.dart';
import '../../config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../customize/new-customize/new_customize.dart';
import '../packages_screen.dart';
import 'ind_transfer/ind_transfer_screen.dart';
import 'ind_widgets/ind_activity/ind_activity_card.dart';
import 'ind_widgets/ind_activity/ind_activity_list.dart';
import 'ind_widgets/ind_flight_card.dart';
import 'ind_widgets/ind_hotel_card.dart';

class IndividualPackagesScreen extends StatefulWidget {
  const IndividualPackagesScreen({Key? key}) : super(key: key);

  @override
  _IndividualPackagesScreenState createState() => _IndividualPackagesScreenState();
}

class _IndividualPackagesScreenState extends State<IndividualPackagesScreen>
    with SingleTickerProviderStateMixin {
  bool isScrollingup = false;
  double _lowerValue = 50;
  double _upperValue = 180;
  final maxPriceController = TextEditingController();
  final minPriceController = TextEditingController();

  IndvPackagesModel? indvData;
  List<PackageIndv> data = [];
  double? _maxPackagePrice;
  double? _minPackagePrice;
  SfRangeValues? _values;
  List<double> rangePickerValues = [];

  getData() async {
    indvData = context.read<AppData>().getIndvPackageData;
    data = indvData!.data.packages.map((e) => e).toList();

    _maxPackagePrice = double.parse(indvData?.data.priceRange.max.toString() ?? '5000');
    _minPackagePrice = double.parse(indvData?.data.priceRange.min.toString() ?? '100');
    _lowerValue = double.parse(indvData?.data.priceRange.min.toString() ?? '5000');
    _upperValue = double.parse(indvData?.data.priceRange.max.toString() ?? '100');

    _values = SfRangeValues(
      double.parse(indvData?.data.priceRange.min.toString() ?? '100'),
      double.parse(indvData?.data.priceRange.max.toString() ?? '5000'),
    );
    rangePickerValues = [
      double.parse(indvData?.data.priceRange.min.toString() ?? '100'),
      double.parse(indvData?.data.priceRange.max.toString() ?? '5000')
    ];

    maxPriceController.text = _maxPackagePrice.toString();
    minPriceController.text = _minPackagePrice.toString();

    if (indvData!.data.searchMode.toLowerCase().trim() == 'activity') {}
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void dispose() {
    maxPriceController.dispose();
    minPriceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
    containtHeight = 75.h;

  }

  double searchHeight = 0.0;
  double containtHeight = 0.0;

  int preSearchLen = 0;

  bool isSearchShown = false;

  final searchController = TextEditingController();

  showSearchCus(bool show) {
    if (show) {
      searchHeight = 7.h;
    } else {
      searchHeight = 0.0;
      searchController.text = '';
      preSearchLen = 0;
    }
  }

  bool direct = false,
      oneStop = false,
      multiStop = false,
      changePrice = false,
      threeStars = false,
      fourStars = false,
      fiveStars = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(elevation: 0.2, child: _handleFilterView(indvData!.data.searchMode)),
      key: _key,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: cardcolor,
        title: InkWell(
          onTap: () => log(jsonEncode(indvData!.toMap())),
          child: Text(
            handleSearchModeName(indvData!.data.searchMode),
            style: TextStyle(color: Colors.black, fontSize: titleFontSize),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Provider.of<AppData>(context, listen: false).makeresarchResearchCurr(false);
            Provider.of<AppData>(context, listen: false).hundletheloading(false);
            if (context.read<AppData>().searchMode.contains('activity')) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => IndActivityList(
                        fromChange: false,
                        faildActivity: '',
                      )));
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const TabPage()), (route) => false);
            }
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            size: 35,
            color: primaryblue,
          ),
        ),
        actions: [
          context.read<AppData>().searchMode.contains('hotel')
              ? IconButton(
                  icon: Icon(Icons.search, color: primaryblue),
                  onPressed: () {
                    isSearchShown = !isSearchShown;
                    showSearchCus(isSearchShown);
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                )
              : const SizedBox(),
          !context.read<AppData>().searchMode.contains('activity') &&
                  !context.read<AppData>().searchMode.contains('transfer')
              ? IconButton(
                  onPressed: () {
                    _key.currentState!.openEndDrawer();
                  },
                  icon: Icon(
                    Icons.settings,
                    color: primaryblue,
                  ))
              : const SizedBox()
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
              alignment: Alignment.center,
              height: //isSearchShown
                  40.0,
              child: Column(
                children: [
                  Text(
                    '${DateFormat('EEE, dd MMM').format(
                            DateFormat('dd/MM/y').parse(indvData!.data.searchData.packageStart))} - ${DateFormat('EEE, dd MMM').format(
                            DateFormat('dd/MM/y').parse(indvData!.data.searchData.packageEnd))}',
                    style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                  ),
                  indvData!.data.searchMode.contains('flight')
                      ? Text(
                          '${indvData!.data.searchData.fromCity} - ${indvData!.data.searchData.toCity}',
                          style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                        )
                      : Text(
                          indvData!.data.searchData.toCity,
                          style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                        ),
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              SizedBox(
                  height: 100.h,
                  child: indvData?.data.activityOnly ?? false
                      ? hundelView(indvData!.data.searchMode, 0)
                      : ListView.builder(
                          itemCount: indvData != null && indvData!.data.packages.isNotEmpty
                              ? indvData?.data.packages.length ?? 1
                              : 1,
                          itemBuilder: (context, index) {
                            return indvData != null && indvData!.data.packages.isNotEmpty
                                ? hundelView(indvData!.data.searchMode, index)
                                : const Center(
                                    child: Text('No Data'),
                                  );
                          },
                        )),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      height: searchHeight,
                      duration: const Duration(milliseconds: 300),
                      child: Visibility(
                        visible: isSearchShown,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.transparent)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade300)),
                              hintText: AppLocalizations.of(context)!.searchByHotelName,
                              hintStyle: TextStyle(fontSize: 10.sp)),
                          controller: searchController,
                          onChanged: (v) {
                            if (v.isNotEmpty) {
                              final timp = data.map((e) => e).toList();
                              final filter1 = timp
                                  .where((e) => e.hotelDetails!.name
                                      .toLowerCase()
                                      .trim()
                                      .contains(v.toLowerCase()))
                                  .toList();

                              indvData!.data.packages = filter1.map((e) => e).toList();
                              preSearchLen = v.length;
                              setState(() {});
                            } else if (v.isEmpty) {
                              indvData!.data.packages = data.map((e) => e).toList();
                              preSearchLen = 0;
                              setState(() {});
                            }
                          },
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget hundelView(String search, int i) {
    switch (search) {
      case 'flight':
        {
          return IndFlightCard(
            data: indvData!.data.packages[i].flightDetails!,
            id: indvData!.data.packages[i].id,
            pricing: {
              'price': indvData!.data.packages[i].total,
              'currency': indvData!.data.packages[i].sellingCurrency
            },
          );
        }
      case 'hotel':
        {
          return IndHotelCard(
            packageIndv: indvData!.data.packages[i],
            id: indvData!.data.packages[i].id,
          );
        }
      case 'activity':
        {
          final d1 = context.read<AppData>().newSearchFirstDate;
          final d2 = context.read<AppData>().newSearchsecoundDate;
          if (d2 == null || d1!.isAtSameMomentAs(d2)) {}
          return const IndManageActivity();
        }
      case 'transfer':
        {
          return IndTransferScreen(
            transfer: indvData!.data.packages[i].transfer!,
            price: indvData!.data.packages[i].total,
            id: indvData!.data.packages[i].id,
          );
        }
      default:
        {
          return const Center(
            child: Text('No data founds'),
          );
        }
    }
  }

  int selectedCurrncy = currencyapi.indexOf(gencurrency);

  Widget buidChangeCurrncy() => Container(
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: 100.w,
        height: 90.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 60.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.close,
                        style: TextStyle(color: primaryblue),
                      )),
                  Text(
                    AppLocalizations.of(context)!.currency,
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 48.h,
              child: ListView.separated(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: currencyapi.length,
                  itemBuilder: (context, i) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: () async {
                          gencurrency = currencyapi[i];
                          try {
                                                              pressIndcatorDialog(context);

                          //  Navigator.pushNamed(context, MiniLoader.idScreen);
                            await AssistantMethods.changeCurranceylanguage(
                                context, {"currency": gencurrency}, 'currency');

                            await AssistantMethods.updatePakagewithcurruncy(
                                Provider.of<AppData>(context, listen: false)
                                    .mainsarchForPackage
                                    .data
                                    .packageId,
                                context);
                            Navigator.of(context).pushReplacementNamed(PackagesScreen.idScreen);
                          } catch (e) {
                                                              pressIndcatorDialog(context);

                          //  Navigator.pushNamed(context, MiniLoader.idScreen);
                            await AssistantMethods.updatePakagewithcurruncy(
                                Provider.of<AppData>(context, listen: false)
                                    .mainsarchForPackage
                                    .data
                                    .packageId,
                                context);

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            setState(() {
                              //    loadPackages();
                            });
                            setState(() {
                              //     seclectedcurrncy = i;
                            });
                          }
                        },
                        horizontalTitleGap: 0,
                        minVerticalPadding: 0,
                        title: Text(localizeCurrency(currencyapi[i])),
                        leading: selectedCurrncy == i ? const Icon(Icons.check) : const SizedBox(),
                      )),
            )
          ],
        ),
      );

  String handleSearchModeName(String searchMode) {
    switch (searchMode.toLowerCase().trim()) {
      case 'flight':
        {
          return AppLocalizations.of(context)?.flights ?? searchMode;
        }
      case 'activity':
        {
          return AppLocalizations.of(context)?.activities ?? searchMode;
        }
      case 'hotel':
        {
          return AppLocalizations.of(context)?.hotels ?? searchMode;
        }
      case 'transfer':
        {
          return AppLocalizations.of(context)?.transfer ?? searchMode;
        }
      default:
        {
          return searchMode;
        }
    }
  }

  Widget _handleFilterView(String searchMode) {
    switch (searchMode.toLowerCase().trim()) {
      case 'flight':
        {
          return _buildFlightFilter();
        }
      case 'activity':
        {
          return _buildActivityFilter();
        }
      case 'hotel':
        {
          return Consumer<AppData>(builder: (context, val, child) => _buildHotelFilter());
        }
      case 'transfer':
        {
          return _buildTransferFilter();
        }
      default:
        {
          return const SizedBox();
        }
    }
  }

  Widget _buildFlightFilter() =>
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 12.h),
          height: 15.h,
          width: 100.w,
          color: primaryblue,
          child: Text(
            AppLocalizations.of(context)!.fStops,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 4.h,
          child: CheckboxListTile(
              title: Text(
                AppLocalizations.of(context)!.nonStop,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              value: direct,
              onChanged: (v) {
                direct = v!;
                setState(() {});
              }),
        ),
        SizedBox(
          height: 4.h,
          child: CheckboxListTile(
              title: Text(AppLocalizations.of(context)!.flightStop(1)),
              value: oneStop,
              onChanged: (v) {
                oneStop = v!;
                setState(() {});
              }),
        ),
        SizedBox(
          height: 4.h,
          child: CheckboxListTile(
              title: Text('+${AppLocalizations.of(context)!.flightStop(2)}'),
              value: multiStop,
              onChanged: (v) {
                multiStop = v!;
                setState(() {});
              }),
        ),
        Container(
          width: 100.w,
          margin: EdgeInsets.symmetric(vertical: 2.h),
          color: primaryblue,
          padding: const EdgeInsets.all(5),
          child: Text(
            AppLocalizations.of(context)!.price,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                    '${AppLocalizations.of(context)!.min}\n${_lowerValue.round()}'),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Text(
                    '${AppLocalizations.of(context)!.max}\n${_upperValue.round()}'),
              ),
            ],
          ),
        ),

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
            max: _maxPackagePrice,
            min: _minPackagePrice,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              if (handlerIndex == 0) {
                _lowerValue = lowerValue;
              }
              if (handlerIndex == 1) {
                _upperValue = upperValue;
              }
              changePrice = true;
              Provider.of<AppData>(context, listen: false).getsliderLimit(
                  mins: _lowerValue.roundToDouble(), maxs: _upperValue.roundToDouble());
              // if(!(lowerValue as double).isNaN && !(upperValue as double).isNaN){
              //   if(rangePickerValues.first>rangePickerValues.last){rangePickerValues.first = lowerValue;}
              //   if(rangePickerValues.last>rangePickerValues.first){  rangePickerValues.last  = upperValue;}
              //
              //
              // }

              setState(() {});
            },
          ),

          // SfRangeSliderTheme(
          //     data: SfRangeSliderThemeData(
          //         thumbColor: Colors.white,
          //         thumbRadius: 15,
          //         thumbStrokeWidth: 2,
          //         thumbStrokeColor: primaryblue),
          //     child: SfRangeSlider(
          //       min: indvData!.data.priceRange.min,
          //       max: indvData!.data.priceRange.max,
          //       values: _values!,
          //       interval: ((indvData!.data.priceRange.min + indvData!.data.priceRange.max) / 10)
          //           .roundToDouble(),
          //       labelPlacement: LabelPlacement.betweenTicks,
          //       showTicks: false,
          //       showLabels: false,
          //       enableTooltip: false,
          //       minorTicksPerInterval: 1,
          //       dragMode: SliderDragMode.onThumb,
          //       onChanged: (SfRangeValues values) {
          //         setState(() {
          //           _values = values;
          //           changePrice = true;
          //           Provider.of<AppData>(context, listen: false).getsliderLimit(
          //               mins: (_values!.start as double).roundToDouble(),
          //               maxs: (_values!.end as double).roundToDouble());
          //
          //           setState(() {});
          //         });
          //       },
          //       startThumbIcon: Icon(Icons.arrow_back_ios, color: primaryblue, size: 20.0),
          //       endThumbIcon: Icon(Icons.arrow_forward_ios, color: primaryblue, size: 20.0),
          //     ),
          //   ),
        ),

        // Form(
        //   key:_formKeyForPrice ,
        //   child: SizedBox(
        //     width: 100.w,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         SizedBox(
        //           width: 25.w,
        //           child: TextFormField(
        //             controller: minPriceController,
        //             textAlign: TextAlign.center,
        //             keyboardType: TextInputType.number,
        //             decoration: InputDecoration(
        //                 hintText: 'Min price',
        //                 label: Text('Min price')
        //             ),
        //             validator: (v) {
        //               if (v != null || v!.isNotEmpty) {
        //                 return null;
        //               }
        //               if (maxPriceController.text.isNotEmpty &&
        //                   double.parse(v) < double.parse(maxPriceController.text)){
        //                 print('here');
        //                 minPriceController.clear();
        //                 return 'the min Price should be less than Max price';
        //               }else{
        //                 return null;
        //               }
        //             },
        //             autovalidateMode: AutovalidateMode.onUserInteraction,
        //             onChanged: (s) {
        //               changePrice = true;
        //               if(s.isNotEmpty){
        //                 if (maxPriceController.text.isNotEmpty &&
        //                     double.parse(s) > double.parse(maxPriceController.text)){
        //                   minPriceController.clear();
        //
        //                 }
        //               }
        //
        //             },
        //           ),
        //
        //         ),
        //
        //         Text('to'),
        //
        //         SizedBox(
        //           width: 25.w,
        //           child: TextFormField(
        //             textAlign: TextAlign.center,
        //             controller: maxPriceController,
        //             keyboardType: TextInputType.number,
        //             decoration: InputDecoration(
        //                 hintText: 'Max price',
        //
        //                 label: Text('Max price')
        //             ),
        //             autovalidateMode: AutovalidateMode.onUserInteraction,
        //             validator: (v) {
        //               if (v != null || v!.isNotEmpty) {
        //                 return null;
        //               }
        //             },
        //             onChanged:
        //                 (s) {
        //               changePrice = true;
        //
        //             }
        //             ,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        //
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        //     child: SliderTheme(
        //         data: SliderThemeData.fromPrimaryColors(
        //             primaryColor: primaryblue,
        //             primaryColorDark: yellowColor,
        //             primaryColorLight: primaryblue,
        //             valueIndicatorTextStyle: TextStyle(color: Colors.white)),
        //         child: RangeSlider(
        //             values: _currentRangeValues!,
        //             max: _maxPackagePrice!,
        //             min: _minPackagePrice!,
        //             divisions: 6,
        //             labels: RangeLabels(
        //               localizeCurrency(gencurrency) +
        //                   ' ' +
        //                   _currentRangeValues!.start.round().toString(),
        //               localizeCurrency(gencurrency) +
        //                   ' ' +
        //                   _currentRangeValues!.end.round().toString(),
        //             ),
        //             onChanged: (RangeValues values) {
        //               _currentRangeValues = values;
        //               Provider.of<AppData>(context, listen: false).getsliderLimit(
        //                   mins: _currentRangeValues!.start, maxs: _currentRangeValues!.end);
        //               changePrice = true;
        //               setState(() {});
        //             }))),
        // SizedBox(
        //   width: 100.w,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Text(_currentRangeValues!.start.toString()),
        //       Text(_currentRangeValues!.end.toString())
        //     ],
        //   ),
        // ),
        SizedBox(height: 2.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: 100.w,
          child: ElevatedButton(
              onPressed: () {
                // Provider.of<AppData>(context, listen: false).getsliderLimit(
                //     mins: double.tryParse(minPriceController.text) ??
                //         this.data!.data.priceRange.min.toDouble(),
                //     maxs: double.tryParse(maxPriceController.text) ??
                //         this.data!.data.priceRange.max.toDouble());
                // changePrice = true;
                final data = context.read<AppData>().indFilteringFlight(context,
                    oneStop: oneStop,
                    nonStop: direct,
                    multiStop: multiStop,
                    changePrice: changePrice);
                indvData!.data.packages = data.map((e) => e).toList();
                changePrice = false;
                setState(() {});
                if (_key.currentState!.isEndDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
              child: Text(
                AppLocalizations.of(context)!.applyFilter,
                style: const TextStyle(color: Colors.white),
              )),
        ),
        GestureDetector(
          onTap: () {
            clearFilter();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              AppLocalizations.of(context)!.clear,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        )
      ]);

  Widget _buildHotelFilter() => Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 12.h),
            height: 15.h,
            width: 100.w,
            color: primaryblue,
            child: Text(
              AppLocalizations.of(context)!.hotelStars,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 4.h,
            child: CheckboxListTile(
                title: const Text('★ ★ ★', style: TextStyle(color: Colors.amber)),
                value: threeStars,
                onChanged: (v) {
                  threeStars = v!;
                  setState(() {});
                }),
          ),
          SizedBox(
            height: 4.h,
            child: CheckboxListTile(
                title: const Text(
                  '★ ★ ★ ★',
                  style: TextStyle(color: Colors.amber),
                ),
                value: fourStars,
                onChanged: (v) {
                  fourStars = v!;
                  setState(() {});
                }),
          ),
          SizedBox(
            height: 4.h,
            child: CheckboxListTile(
                title: const Text('★ ★ ★ ★ ★', style: TextStyle(color: Colors.amber)),
                value: fiveStars,
                onChanged: (v) {
                  fiveStars = v!;
                  setState(() {});
                }),
          ),
          Container(
            width: 100.w,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            color: primaryblue,
            padding: const EdgeInsets.all(5),
            child: Text(
              AppLocalizations.of(context)!.price,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                      '${AppLocalizations.of(context)!.min}\n${_lowerValue.round()}'),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                      '${AppLocalizations.of(context)!.max}\n${_upperValue.round()}'),
                ),
              ],
            ),
          ),

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
                max: _maxPackagePrice,
                min: _minPackagePrice,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  if (handlerIndex == 0) {
                    _lowerValue = lowerValue;
                  }
                  if (handlerIndex == 1) {
                    _upperValue = upperValue;
                  }
                  changePrice = true;
                  Provider.of<AppData>(context, listen: false).getsliderLimit(
                      mins: _lowerValue.roundToDouble(), maxs: _upperValue.roundToDouble());
                  // if(!(lowerValue as double).isNaN && !(upperValue as double).isNaN){
                  //   if(rangePickerValues.first>rangePickerValues.last){rangePickerValues.first = lowerValue;}
                  //   if(rangePickerValues.last>rangePickerValues.first){  rangePickerValues.last  = upperValue;}
                  //
                  //
                  // }

                  setState(() {});
                },
              )),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //   child: SfRangeSliderTheme(
          //     data: SfRangeSliderThemeData(
          //         thumbColor: Colors.white,
          //         thumbRadius: 15,
          //         thumbStrokeWidth: 2,
          //         thumbStrokeColor: primaryblue),
          //     child: SfRangeSlider(
          //       min: indvData!.data.priceRange.min,
          //       max: indvData!.data.priceRange.max,
          //       values: _values!,
          //       interval: 1,
          //       showTicks: false,
          //       showLabels: false,
          //       enableTooltip: false,
          //       stepSize: 100,
          //       minorTicksPerInterval: 1,
          //       onChanged: (SfRangeValues values) {
          //         print((values.start as double).roundToDouble());
          //         setState(() {
          //           _values = values;
          //           Provider.of<AppData>(context, listen: false).getsliderLimit(
          //               mins: (_values!.start as double).roundToDouble(),
          //               maxs: (_values!.end as double).roundToDouble());
          //           changePrice = true;
          //           setState(() {});
          //         });
          //       },
          //       startThumbIcon: Icon(Icons.arrow_back_ios, color: primaryblue, size: 20.0),
          //       endThumbIcon: Icon(Icons.arrow_forward_ios, color: primaryblue, size: 20.0),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Colors.white,
          //         ),
          //         child: Text('Min\n' + ((_values?.start as double).round()).toString()),
          //       ),
          //       Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Colors.white,
          //         ),
          //         child: Text('Max\n' + ((_values?.end as double).round()).toString()),
          //       ),
          //     ],
          //   ),
          // ),

          // Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //     child: SliderTheme(
          //         data: SliderThemeData.fromPrimaryColors(
          //             primaryColor: primaryblue,
          //             primaryColorDark: yellowColor,
          //             primaryColorLight: primaryblue,
          //             valueIndicatorTextStyle: TextStyle(color: Colors.white)),
          //         child: RangeSlider(
          //             values: _currentRangeValues!,
          //             max: _maxPackagePrice!,
          //             min: _minPackagePrice!,
          //             divisions: 6,
          //             labels: RangeLabels(
          //               localizeCurrency(gencurrency) +
          //                   ' ' +
          //                   _currentRangeValues!.start.toStringAsFixed(1),
          //               localizeCurrency(gencurrency) +
          //                   ' ' +
          //                   _currentRangeValues!.end.toStringAsFixed(1),
          //             ),
          //             onChanged: (RangeValues values) {
          //               _currentRangeValues = values;
          //               Provider.of<AppData>(context, listen: false).getsliderLimit(
          //                   mins: _currentRangeValues!.start, maxs: _currentRangeValues!.end);
          //               changePrice = true;
          //               setState(() {});
          //             }))),
          // SizedBox(
          //   width: 100.w,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text(_currentRangeValues!.start.toStringAsFixed(1)),
          //       Text(_currentRangeValues!.end.toStringAsFixed(1))
          //     ],
          //   ),
          // ),

          SizedBox(height: 2.h),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: 100.w,
            child: ElevatedButton(
                onPressed: () {
                  final data = context.read<AppData>().indFilteringHotel(context,
                      threeStars: threeStars,
                      fourStars: fourStars,
                      fiveStars: fiveStars,
                      changePrice: changePrice);
                  indvData!.data.packages = data.map((e) => e).toList();

                  setState(() {});
                  if (_key.currentState!.isEndDrawerOpen) {
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                child: Text(
                  AppLocalizations.of(context)!.applyFilter,
                  style: const TextStyle(color: Colors.white),
                )),
          ),
          GestureDetector(
            onTap: () {
              clearFilter();
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                AppLocalizations.of(context)!.clear,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      );

  Widget _buildActivityFilter() => Column();

  Widget _buildTransferFilter() => Column();

  void clearFilter() {
    direct = false;
    oneStop = false;
    multiStop = false;
    changePrice = false;
    threeStars = false;
    fourStars = false;
    fiveStars = false;
    context.read<AppData>().clearIndFilter();
    final data = context.read<AppData>().indFilteringFlight(context,
        oneStop: oneStop, nonStop: direct, multiStop: multiStop, changePrice: changePrice);
    indvData!.data.packages = data.map((e) => e).toList();

    setState(() {});
    Navigator.of(context).pop();
  }
}
