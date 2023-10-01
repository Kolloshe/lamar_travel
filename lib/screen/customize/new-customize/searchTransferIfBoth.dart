// ignore_for_file: file_names, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/change_transfer_distnation_if_remove_model.dart';
import 'package:lamar_travel_packages/Model/transfer_listing_model.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../../main_screen1.dart';
import '../../packages_screen.dart';
import 'new_customize_slider.dart';

class SearchTransferIfBoth extends StatefulWidget {
  const SearchTransferIfBoth({Key? key, required this.cusId}) : super(key: key);

  final String cusId;

  @override
  _SearchTransferIfBothState createState() => _SearchTransferIfBothState();
}

class _SearchTransferIfBothState extends State<SearchTransferIfBoth> with TickerProviderStateMixin {
  bool isSelectTransfer = false;

  bool isSearchForAirPort = false;

  bool showtransferList = false;

  TransferListing? _transferListing;

  String searchFor = '';

  String searchForAirports = 'Airports';

  String time1 = '0000';
  String time2 = '0000';

  bool searchContainerV = false;

  List distnations = [];
  List distnationAirports = [];

  late SearchTransferIfRemoveForH _ifRemoveForHData;

  double searchContainerHeights = 0.0;

  double transferListingHeighrts = 0.0;

  late AnimationController _controller;
  late AnimationController _animationController;

  var scaleAnimation;
  var scaleAnimationfortransfer;

  SearchTransferHotel? selectedData;
  SearchTransferAirport? selectedDataAirports;

  getdata() async {
    await AssistantMethods.searchDistnationsForTransfer(context, '', widget.cusId, 'hotels');
    await AssistantMethods.searchDistnationsForTransferAir(context, '', widget.cusId);

    _ifRemoveForHData = Provider.of<AppData>(context, listen: false).searchTransferDistnation;

    distnations = _ifRemoveForHData.data.hotels!;
    distnationAirports =
        Provider.of<AppData>(context, listen: false).searchTransferDistnationAir.data.airports!;
  }

  @override
  void initState() {
    searchFor = "Both";
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    getdata();
    getuserSearch('', 'hotels');

    scaleAnimationfortransfer = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    _animationController.dispose();

    super.dispose();
  }

  UniqueKey hotelket = UniqueKey();
  bool ishotelExpanded = false;

  UniqueKey airportkey = UniqueKey();
  bool isAirportExpanded = false;

  expandTile(bool ishotel) {
    setState(() {
      if (ishotel) {
        ishotelExpanded = true;
        hotelket = UniqueKey();
      } else {
        isAirportExpanded = true;
        airportkey = UniqueKey();
      }
    });
  }

  shrinktile(bool ishotel) {
    setState(() {
      if (ishotel) {
        ishotelExpanded = false;
        hotelket = UniqueKey();
      } else {
        isAirportExpanded = false;
        airportkey = UniqueKey();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: cardcolor,
          centerTitle: true,
          title: Text(
            'Search for transfer',
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
                              "you didn't select any transfer your package will be without Transfer do you want to continue",
                              style: TextStyle(fontSize: titleFontSize),
                              textAlign: TextAlign.justify,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    AssistantMethods.updateThePackage(widget.cusId);

                                    final currentdata = Provider.of<AppData>(context, listen: false)
                                        .packagecustomiz
                                        .result;
                                    if (currentdata.noflight &&
                                        currentdata.nohotels &&
                                        currentdata.noActivity) {
                                      displayTostmessage(context, true,
                                          message: 'the package is empty please select other one');
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          PackagesScreen.idScreen, (route) => false);
                                    } else if (currentdata.noflight || currentdata.nohotels) {
                                      await AssistantMethods.sectionManager(context,
                                          section: 'transfer',
                                          cusID: widget.cusId,
                                          action: "remove");
                                      displayTostmessage(context, true,
                                          message: "the transfer has been removed");
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                    } else {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                    }
                                  },
                                  child: const Text(
                                    "Continue any way",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: greencolor,
                                    ),
                                  )),
                            ],
                          ));
                }
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: primaryblue,
                size: 28.sp,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 100.h,
            child: Stack(fit: StackFit.expand, children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        'Select the hotel in ${Provider.of<AppData>(context, listen: false).packagecustomiz.result.toCity} ',
                        style: TextStyle(fontSize: titleFontSize),
                      ),
                    ),
                    ExpansionTile(
                      key: hotelket,
                      initiallyExpanded: ishotelExpanded,
                      title: Text(searchFor == 'Both' ? 'Hotel search' : searchFor),
                      childrenPadding: const EdgeInsets.only(top: 10),
                      children: [
                        SizedBox(
                          height: 70.h,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [shadow],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                            height: searchContainerHeights,
                            width: 100.w,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  height: 7.h,
                                  child: TextFormField(
                                    onChanged: (v) {
                                      getuserSearch(v, 'hotels');
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: "Search",
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                                        ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                  child: ListView.builder(
                                    itemCount: distnations.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          shrinktile(true);
                                          setState(() {
                                            searchFor = distnations[index].name;
                                            selectedData = distnations[index];
                                          });

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
                                                child: Text(
                                                  distnations[index].name.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: titleFontSize - 1,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        'Select the airports in ${Provider.of<AppData>(context, listen: false).packagecustomiz.result.toCity} ',
                        style: TextStyle(fontSize: titleFontSize),
                      ),
                    ),
                    ExpansionTile(
                      key: airportkey,
                      onExpansionChanged: (v) async {
                        if (v) {
                          await AssistantMethods.searchDistnationsForTransfer(
                              context, '', widget.cusId, 'airports');
                        }
                      },
                      title: Text(searchForAirports == 'Airports'
                          ? 'Select the Airport'
                          : searchForAirports),
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: showsearchContaner,
                              child: Container(
                                width: 100.w,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Icon(CupertinoIcons.search),
                                    SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        searchForAirports,
                                        style: TextStyle(fontSize: titleFontSize),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    // Spacer(),
                                    // Icon(
                                    //   Icons.keyboard_arrow_down,
                                    //   size: 20.sp,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100.w,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Select time for pickup from airport to the hotel:',
                                style: TextStyle(fontSize: titleFontSize),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 25.h,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (d) {
                                  String jaybinTime = d.hour.toString() + d.minute.toString();
                                  if (jaybinTime.length < 4) {
                                    jaybinTime = '0$jaybinTime';
                                  }
                                  time1 = jaybinTime;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 100.w,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                'Select time for pickup from hotel back to the airport:',
                                style: TextStyle(fontSize: titleFontSize),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 25.h,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.time,
                                onDateTimeChanged: (d) {
                                  String jaybinTime = d.hour.toString() + d.minute.toString();
                                  if (jaybinTime.length < 4) {
                                    jaybinTime = '0$jaybinTime';
                                  }
                                  time2 = jaybinTime;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    )
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
            ]),
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
                  child: Text('Select', style: TextStyle(fontSize: titleFontSize)))),
        ),
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
              onChanged: (v) {
                getuserSearch(v, 'airports');
              },
              decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ))),
            ),
          ),
          SizedBox(
            height: 65.h,
            child: ListView.builder(
              itemCount: distnationAirports.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      searchForAirports = distnationAirports[index].name;
                      selectedDataAirports = distnationAirports[index];
                    });

                    _controller.reverse();
                    FocusManager.instance.primaryFocus?.unfocus();
                    //  _controller.reset();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: cardcolor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [shadow]),
                    height: 9.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          //  padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
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
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 60.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                distnationAirports[index].name.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: titleFontSize - 1,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(distnationAirports[index].code)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
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
                                text: 'Vehicle type:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: titleFontSize,
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
                                text: "Type: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: titleFontSize,
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
                                text: "Service name: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: titleFontSize,
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
                                text: "price: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackTextColor,
                                  fontSize: titleFontSize,
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

  getuserSearch(String q, String type) async {
    if (type == 'airports') {
      await AssistantMethods.searchDistnationsForTransferAir(context, q, widget.cusId);
    } else {
      await AssistantMethods.searchDistnationsForTransfer(context, q, widget.cusId, type);
    }
    setState(() {
      if (type == 'airports') {
        distnationAirports = Provider.of<AppData>(context, listen: false)
            .searchTransferDistnationAir
            .data
            .airports!
            .where((element) => element.name.toLowerCase().contains(q.toLowerCase()))
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

  collectuserData() async {
    if (selectedData == null || selectedDataAirports == null) {
      displayTostmessage(context, true, message: 'all Selection are required');
      return;
    }
    Map<String, dynamic> data = {};

    data = {
      "customizeId": widget.cusId,
      "pickUp": {
        "code": selectedDataAirports!.code,
        "name": selectedDataAirports!.name,
        "country_code": selectedDataAirports!.countryCode,
        "city_name": selectedDataAirports!.cityName
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

    if (Provider.of<AppData>(context, listen: false).transferListing != null) {
      Provider.of<AppData>(context, listen: false).transferListing!.data.clear();
    }

    await AssistantMethods.addtransferListing(context, data: data);

    _transferListing = Provider.of<AppData>(context, listen: false).transferListing;

    if (_transferListing != null) {
      if (_transferListing!.data.isNotEmpty) {
        setState(() {
          showtransferList = true;
          transferListingHeighrts = 80.h;
        });
        _animationController.forward();
      } else {
        return;
      }
    }

    //print(data);
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

  void showsearchContaner() async {
    //getuserSearch('');
    setState(() {
      searchContainerHeights = 80.h;
      searchContainerV = true;
    });
    _controller.forward();
  }
}
