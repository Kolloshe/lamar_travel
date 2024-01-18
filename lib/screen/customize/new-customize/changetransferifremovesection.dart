// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/change_transfer_distnation_if_remove_model.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/Model/transfer_listing_model.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:lamar_travel_packages/widget/press-indcator-widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChangeTransferIfRemoveSection extends StatefulWidget {
  ChangeTransferIfRemoveSection(
      {Key? key,
      required this.searchType,
      required this.cusId,
      required this.isboth,
      required this.isflight,
      required this.ishotel,
      required this.customizpackage})
      : super(key: key);
  final String searchType;
  final String cusId;
  bool isflight = false;
  bool ishotel = false;
  bool isboth = false;
  final Customizpackage customizpackage;

  @override
  _ChangeTransferIfRemoveSectionState createState() => _ChangeTransferIfRemoveSectionState();
}

class _ChangeTransferIfRemoveSectionState extends State<ChangeTransferIfRemoveSection>
    with TickerProviderStateMixin {
  bool isSelectTransfer = false;

  bool isSearchForAirPort = false;

  bool showtransferList = false;

  bool issearch = false;

  final searchController = TextEditingController();

  TransferListing? _transferListing;

  String searchFor = '';

  String time1 = '0000';
  String time2 = '0000';

  bool searchContainerV = false;

  List distnations = [];

  late SearchTransferIfRemoveForH _ifRemoveForHData;

  double searchContainerHeights = 0.0;

  double transferListingHeighrts = 0.0;

  late AnimationController _controller;
  late AnimationController _animationController;

  var scaleAnimation;
  var scaleAnimationfortransfer;

  var selectedData;

  Timer? debouncer;

  getdata() async {
    if (widget.isboth) {
    } else {
      await AssistantMethods.searchDistnationsForTransfer(
          context, '', widget.cusId, widget.searchType);
    }

    _ifRemoveForHData = Provider.of<AppData>(context, listen: false).searchTransferDistnation;

    if (isSearchForAirPort) {
      distnations = _ifRemoveForHData.data.airports!;
    } else {
      distnations = _ifRemoveForHData.data.hotels!;
    }
  }

  @override
  void initState() {
    searchFor = widget.searchType;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    getdata();
    getuserSearch('');

    scaleAnimationfortransfer = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  void debounce(VoidCallback callback, {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    } else {
      debouncer = Timer(duration, callback);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    debouncer?.cancel();
    searchController.dispose();

    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: cardcolor,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.searchForTransfer,
            style: TextStyle(color: black),
          ),
          leading: IconButton(
              onPressed: () {
                if (isSelectTransfer) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                } else {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.youDidSelectAnyLocationForTransfer,
                              style: TextStyle(fontSize: titleFontSize),
                              textAlign: TextAlign.justify,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    await AssistantMethods.updateThePackage(widget.cusId);

                                    final currentdata = Provider.of<AppData>(context, listen: false)
                                        .packagecustomiz
                                        .result;
                                    if (currentdata.noflight &&
                                        currentdata.nohotels &&
                                        currentdata.noActivity) {
                                      displayTostmessage(context, true,
                                          message: AppLocalizations.of(context)!.thePackageIsEmpty);
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                    } else if (currentdata.noflight || currentdata.nohotels) {
                                      await AssistantMethods.sectionManager(context,
                                          section: 'transfer',
                                          cusID: widget.cusId,
                                          action: "remove");
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                      // displayTostmessage(context, true,
                                      //     messeage: "the transfer has been removed");
                                    } else {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.contin,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                    style: TextStyle(
                                      color: greencolor,
                                    ),
                                  )),
                            ],
                          ));
                }
              },
              icon: Icon(
                Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                    ? Icons.keyboard_arrow_left
                    : Icons.keyboard_arrow_right,
                color: primaryblue,
                size: 28.sp,
              )),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: 100.h,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            timetitle(widget.searchType),
                            style: TextStyle(fontSize: titleFontSize),
                          ),
                        ),
                        _buildSpacer(0, 3),
                        SizedBox(
                          width: 100.w,
                          // child: Text(
                          //   "Select the airport in ${Provider.of<AppData>(context, listen: false).packagecustomiz.result.toCity} ",
                          //   style: TextStyle(fontSize: titleFontSize),
                          // ),
                        ),
                        _buildSpacer(0, 3),
                        InkWell(
                          onTap: showsearchContaner,
                          child: Container(
                            width: 100.w,
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.search),
                                _buildSpacer(4, 0),
                                SizedBox(
                                  width: 70.w,
                                  child: Text(
                                    title(searchFor),
                                    style: TextStyle(fontSize: titleFontSize),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildSpacer(0, 5),
                        isSearchForAirPort
                            ? Column(
                                children: [
                                  Container(
                                    width: 100.w,
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .selectTimeForPickupFromAirportToTheHotel,
                                      style: TextStyle(fontSize: titleFontSize),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    height: 25.h,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (d) {
                                        String h;
                                        String m;
                                        if (d.hour.toString().length < 2) {
                                          h = '0${d.hour}';
                                        } else {
                                          h = d.hour.toString();
                                        }
                                        if (d.minute.toString().length < 2) {
                                          m = '0${d.minute}';
                                        } else {
                                          m = d.minute.toString();
                                        }

                                        time1 = h + m;
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        _buildSpacer(0, 5),
                        isSearchForAirPort
                            ? Column(
                                children: [
                                  Container(
                                    width: 100.w,
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .selectTimeForPickupBackToTheAirport,
                                      style: TextStyle(fontSize: titleFontSize),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    height: 25.h,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.time,
                                      onDateTimeChanged: (d) {
                                        String h;
                                        String m;
                                        if (d.hour.toString().length < 2) {
                                          h = '0${d.hour}';
                                        } else {
                                          h = d.hour.toString();
                                        }
                                        if (d.minute.toString().length < 2) {
                                          m = '0${d.minute}';
                                        } else {
                                          m = d.minute.toString();
                                        }

                                        time2 = h + m;
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        _buildSpacer(0, 10),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onVerticalDragEnd: (details) {
                        _controller.reverse();
                      },
                      child: SizeTransition(
                        sizeFactor: scaleAnimation,
                        child: _buildDistnationPlace(),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0.0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (details.primaryVelocity! > 0) {
                            _animationController.reverse();
                          }
                        },
                        child: SizeTransition(
                          sizeFactor: scaleAnimationfortransfer,
                          child: _buildtransferListing(),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 100.w,
              height: 7.h,
              child: ElevatedButton(
                  onPressed: collectuserData,
                  style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                  child: Text(AppLocalizations.of(context)!.select,
                      style: TextStyle(fontSize: titleFontSize)))),
        ),
      ),
    );
  }

  Widget _buildtransferListing() {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadow],
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: transferListingHeighrts,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 100.w,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose you transfer ',
                  style: TextStyle(fontSize: titleFontSize),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      _animationController.reverse();
                    },
                    icon: const Icon(Icons.keyboard_arrow_down)),
              ],
            ),
          ),
          SizedBox(
            height: 65.h,
            child: ListView.separated(
              separatorBuilder: (context, ind) => SizedBox(
                height: 1.h,
              ),
              itemCount: _transferListing != null ? _transferListing!.data.length : 0,
              itemBuilder: (context, index) => InkWell(
                onTap: () => getSelectedTransfer(index),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cardcolor,
                    boxShadow: [shadow],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CachedNetworkImage(
                          imageUrl: _transferListing!.data[index].image,
                          height: 20.h,
                          width: 30.w,
                          placeholder: (context, url) => const ImageSpinning(
                            withOpasity: true,
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              text: TextSpan(
                                text: "${AppLocalizations.of(context)!.name} : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: subtitleFontSize,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _transferListing!.data[index].vehicleTypeName,
                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.4.h,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              text: TextSpan(
                                text: "${AppLocalizations.of(context)!.type} : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: subtitleFontSize,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _transferListing!.data[index].productTypeName,
                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.4.h,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.serviceName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: subtitleFontSize,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _transferListing!.data[index].serviceTypeName,
                                      style: const TextStyle(fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.4.h,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.price,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: subtitleFontSize,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: _transferListing!.data[index].totalAmount.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal, color: greencolor)),
                                  TextSpan(
                                      text: " ${_transferListing!.data[index].currency}",
                                      style: const TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistnationPlace() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadow],
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: searchContainerHeights,
      width: 100.w,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            width: 100.w,
            child: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  _controller.reverse();
                  //   searchContainerHeights = 0.0;
                });
                _controller.reverse();
              },
            ),
          ),
          SizedBox(
            width: 100.w,
            height: 7.h,
            child: TextFormField(
              controller: searchController,
              //  onChanged: getuserSearch,
              decoration: InputDecoration(
                suffix: InkWell(
                  onTap: () async {
                    await getuserSearch(searchController.text);
                    setState(() {
                      issearch = false;
                    });
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(color: primaryblue),
                  ),
                ),
                labelText: AppLocalizations.of(context)!.search,
                hintText: AppLocalizations.of(context)!.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 65.h,
            child: !issearch
                ? ListView.builder(
                    itemCount: distnations.isEmpty ? 1 : distnations.length,
                    itemBuilder: (context, index) {
                      return distnations.isEmpty
                          ? Center(
                              child: Text('No ${widget.searchType} found by this name'),
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  searchFor = distnations[index].name;
                                  selectedData = distnations[index];
                                });
                                FocusScope.of(context).unfocus();
                                _controller.reverse();
                                //  _controller.reset();
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: cardcolor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [shadow]),
                                height: 10.h,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      //  padding: EdgeInsets.all(10),
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(10)),
                                      width: 40.sp,
                                      height: 40.sp,
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.location_on,
                                        color: primaryblue,
                                        size: 24.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            distnations[index].name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: titleFontSize - 1,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${widget.isflight ? distnations[index].code : distnations[index].destinationName}',
                                            style: const TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildSpacer(double w, double h) => SizedBox(
        width: w.w,
        height: h.h,
      );

  //! /////////////////// FUNCTIONS/////////////////////////
  //! /////////////////// FUNCTIONS/////////////////////////
  //! /////////////////// FUNCTIONS/////////////////////////
  //! /////////////////// FUNCTIONS/////////////////////////

  void showsearchContaner() async {
    //getuserSearch('');
    setState(() {
      searchContainerHeights = 80.h;
      searchContainerV = true;
    });
    _controller.forward();
  }

  getuserSearch(String q) async {
    setState(() {
      issearch = true;
    });
    await AssistantMethods.searchDistnationsForTransfer(
        context, q, widget.cusId, widget.searchType);

    setState(() {
      issearch = false;
      if (isSearchForAirPort) {
        distnations = Provider.of<AppData>(context, listen: false)
            .searchTransferDistnation
            .data
            .airports!
            .where((element) => element.name.toLowerCase().startsWith(q.toLowerCase()))
            .toList();
      } else {
        distnations = Provider.of<AppData>(context, listen: false)
            .searchTransferDistnation
            .data
            .hotels!
            .where((element) => element.name.toLowerCase().contains(q.toLowerCase()))
            .toList();
      }
    });
  }

  String timetitle(String type) {
    if (type == 'hotels') {
      isSearchForAirPort = false;
      if (widget.customizpackage.result.noflight) {
        return AppLocalizations.of(context)!.pleaseSelectTheHotelNameOrDropOffLocation;
      } else {
        return AppLocalizations.of(context)!.pleaseSelectYourDropOffLocation;
      }
    } else {
      isSearchForAirPort = true;
      if (widget.customizpackage.result.nohotels) {
        return AppLocalizations.of(context)!.pleaseSelectTheAirportToHotel;
      } else {
        return AppLocalizations.of(context)!.pleaseSelectPickupLocation;
      }
    }
  }

  collectuserData() async {
    showDialog(
        context: context, barrierDismissible: false, builder: (context) => const PressIndcator());
    if (selectedData == null) {
      displayTostmessage(context, true,
          message:
              AppLocalizations.of(context)!.plzSelectServiceFirst(titleType(widget.searchType)));
      return;
    }
    Map<String, dynamic> data = {};

    if (widget.isboth) {
      data = {
        "customizeId": widget.cusId,
        "pickUp": {
          "code": selectedData!.code,
          "name": selectedData!.name,
          "country_code": selectedData!.countryCode,
          "city_name": selectedData!.cityName
        },
        "dropOff": {
          "id": selectedData!.id,
          "hotelId": selectedData!.hotelId,
          "hotelCode": selectedData!.hotelCode,
          "name": selectedData!.name,
          "destinationCode": selectedData!.destinationCode,
          "destinationName": selectedData!.destinationName,
          "latitude": selectedData!.latitude,
          "longitude": selectedData!.longitude
        },
        "pickupTime": time1,
        "returnTime": time2,
        "sellingCurrency": gencurrency
      };
    } else {
      if (isSearchForAirPort) {
        data = {
          "customizeId": widget.cusId,
          "pickUp": {
            "code": selectedData!.code,
            "name": selectedData!.name,
            "country_code": selectedData!.countryCode,
            "city_name": selectedData!.cityName
          },
          "dropOff": null,
          "pickupTime": time1,
          "returnTime": time2,
          "sellingCurrency": gencurrency
        };
      } else {
        data = {
          "customizeId": widget.cusId,
          "pickUp": null,
          "dropOff": {
            "id": selectedData!.id,
            "hotelId": selectedData!.hotelId,
            "hotelCode": selectedData!.hotelCode,
            "name": selectedData!.name,
            "destinationCode": selectedData!.destinationCode,
            "destinationName": selectedData!.destinationName,
            "latitude": selectedData!.latitude,
            "longitude": selectedData!.longitude
          },
          "pickupTime": time1,
          "returnTime": time2,
          "sellingCurrency": gencurrency
        };
      }
    }
    if (Provider.of<AppData>(context, listen: false).transferListing != null) {
      Provider.of<AppData>(context, listen: false).transferListing!.data.clear();
    }

    await AssistantMethods.addtransferListing(context, data: data);
    Navigator.of(context).pop();

    _transferListing = Provider.of<AppData>(context, listen: false).transferListing;

    if (_transferListing != null && _transferListing!.data.isNotEmpty) {
      setState(() {
        showtransferList = true;
        transferListingHeighrts = 80.h;
      });
      _animationController.forward();
    }
  }

  void getSelectedTransfer(int i) async {
     if (_transferListing != null) {
      final selectedtransfer = _transferListing!.data[i];

      Map<String, dynamic> req = {
        "customizeId": widget.cusId,
        "transferId": selectedtransfer.transferId,
        "sellingCurrency": gencurrency,
        "total_amount": selectedtransfer.totalAmount,
        "image": selectedtransfer.image
      };

      await AssistantMethods.addrTransferIfNoForH(context, req);
    }
  }

  String title(String type) {
    switch (type) {
      case "hotels":
        {
          return AppLocalizations.of(context)!.yourhotels;
        }
      case "airports":
        {
          return AppLocalizations.of(context)!.airports;
        }
      default:
        {
          return type;
        }
    }
  }

  String titleType(String type) {
    switch (type) {
      case "hotels":
        {
          return AppLocalizations.of(context)!.yourhotel;
        }
      case "airports":
        {
          return AppLocalizations.of(context)!.airport;
        }
      default:
        {
          return type;
        }
    }
  }
}
