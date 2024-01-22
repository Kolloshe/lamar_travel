// ignore_for_file: import_of_legacy_library_into_null_safe, must_be_immutable, library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';

import 'package:sizer/sizer.dart';

import 'package:flutter_svg/svg.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/change_room_from_fromhotel.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../Assistants/assistant_methods.dart';
import '../../../Datahandler/adaptive_texts_size.dart';
import '../../../Datahandler/app_data.dart';
import '../../../Model/changehotel.dart' as changehotelmodel;
import '../../../config.dart';

import '../../../widget/googlemap-dialog.dart';
import '../../../widget/image_spinnig.dart';

import '../../../widget/loading.dart';
import '../../../widget/street_view.dart';
import 'package:provider/provider.dart';

import '../new-customize/new_customize.dart';

class HotelCustomize extends StatefulWidget {
  HotelCustomize({Key? key, required this.oldHotelID, required this.hotelFailedName})
      : super(key: key);
  static String idScreen = 'HotelCustomize';
  final String oldHotelID;
  String hotelFailedName = '';

  @override
  _HotelCustomizeState createState() => _HotelCustomizeState();
}

class _HotelCustomizeState extends State<HotelCustomize> {
  String dropdownValue = '3 stars';

  // Completer<GoogleMapController> _controller = Completer();
  late changehotelmodel.Changehotel hotles;
  List<changehotelmodel.ResponseHotel> filtring = [];

  late changehotelmodel.Changehotel nameSearchHotile;

  List<changehotelmodel.Room> selectedroom = [];

  bool namesort = true;
  bool pricesort = true;
  bool starsort = true;
  bool isLoaded = false;

  lodeHotel() async {
    if (Provider.of<AppData>(context, listen: false).changehotel != null) {
      isLoaded = true;
      hotles = Provider.of<AppData>(context, listen: false).changehotel!;
      filtring = hotles.response;

      nameSearchHotile = Provider.of<AppData>(context, listen: false).changehotel!;
      dropdownValue = Provider.of<AppData>(context, listen: false).hotelStarfilter;
    }
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void initState() {
    lodeHotel();
    // initPlatformState();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: cardcolor,
            title: Text(
              AppLocalizations.of(context)!.chooseAlternativeHotel,
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                if (Provider.of<AppData>(context, listen: false).isPreBookFailed) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text(AppLocalizations.of(context)!.sureToCancelTheBooking),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Provider.of<AppData>(context, listen: false)
                                        .changePrebookFaildStatus(false);
                                    if (context.read<AppData>().searchMode.isEmpty &&
                                        context.read<AppData>().searchMode.trim().toLowerCase() ==
                                            '') {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                    } else {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const IndividualPackagesScreen()),
                                          (route) => false);
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                    style: const TextStyle(color: Colors.redAccent),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.contin,
                                    style: const TextStyle(color: Colors.green),
                                  )),
                            ],
                          ));
                } else {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
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
          ),
          backgroundColor: background,
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: isLoaded == false
                  ? const Center(
                      child: Text('No hotel available'),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.07,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          color: cardcolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                    width: size.width * 0.7,
                                    color: cardcolor,
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      onChanged: (name) {
                                        setState(() {
                                          filtring = Provider.of<AppData>(context, listen: false)
                                              .searchonHotelList(name);
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: AppLocalizations.of(context)!.searchByHotelName,
                                      ),
                                    )),
                              ),
                              VerticalDivider(
                                color: Colors.black.withOpacity(0.25),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            padding: const EdgeInsets.all(15),
                                            width: size.width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context)!.sortByName,
                                                      style: TextStyle(fontSize: titleFontSize),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        pressIndcatorDialog(context);

                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) =>
                                                        //             MiniLoader()));
                                                        final customizpackage =
                                                            Provider.of<AppData>(context,
                                                                    listen: false)
                                                                .packagecustomiz;
                                                        //    print(newValue!.substring(0,1));
                                                        await AssistantMethods.changehotel(context,
                                                            customizeId:
                                                                customizpackage.result.customizeId,
                                                            checkIn: DateFormat('yyyy-MM-dd')
                                                                .format(customizpackage
                                                                    .result.hotels[0].checkIn),
                                                            checkOut: DateFormat('yyyy-MM-dd')
                                                                .format(customizpackage
                                                                    .result.hotels[0].checkOut),
                                                            hId:
                                                                customizpackage.result.hotels[0].id,
                                                            star: '');
                                                        // Provider.of<AppData>(context, listen: false)
                                                        //     .gethotelstarefilter("3");
                                                        if (!mounted) return;
                                                        Navigator.of(context)
                                                            .pushNamedAndRemoveUntil(
                                                                HotelCustomize.idScreen,
                                                                (route) => false);
                                                      },
                                                      child: Text('Clear',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: primaryblue)),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: size.height * 0.03),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            filtring.sort((a, b) => a.name
                                                                .toLowerCase()
                                                                .compareTo(b.name.toLowerCase()));
                                                          });
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.4,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                              AppLocalizations.of(context)!.aToz,
                                                              style: TextStyle(
                                                                  fontSize: subtitleFontSize),
                                                            ))),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            filtring.sort((a, b) => b.name
                                                                .toLowerCase()
                                                                .compareTo(a.name.toLowerCase()));
                                                          });
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.4,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                              AppLocalizations.of(context)!.zToa,
                                                              style: TextStyle(
                                                                  fontSize: subtitleFontSize),
                                                            ))),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.03,
                                                ),

                                                Text(
                                                  AppLocalizations.of(context)!.sortByPrice,
                                                  style: TextStyle(fontSize: titleFontSize),
                                                ),
                                                SizedBox(
                                                  height: size.height * 0.03,
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            filtring.sort((a, b) => int.parse(
                                                                    a.rooms[0][0].type.toString() +
                                                                        a.rooms[0][0].amountChange
                                                                            .toString())
                                                                .compareTo(int.parse(
                                                                    b.rooms[0][0].type.toString() +
                                                                        b.rooms[0][0].amountChange
                                                                            .toString())));
                                                          });
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.4,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                              AppLocalizations.of(context)!
                                                                  .lowestToHighest,
                                                              style: TextStyle(
                                                                  fontSize: subtitleFontSize),
                                                            ))),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            filtring.sort((a, b) => int.parse(
                                                                    b.rooms[0][0].type.toString() +
                                                                        b.rooms[0][0].amountChange
                                                                            .toString())
                                                                .compareTo(int.parse(
                                                                    a.rooms[0][0].type.toString() +
                                                                        a.rooms[0][0].amountChange
                                                                            .toString())));
                                                          });
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.4,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                                AppLocalizations.of(context)!
                                                                    .highestToLowest,
                                                                style: TextStyle(
                                                                    fontSize: subtitleFontSize)))),
                                                  ],
                                                ),

                                                // hotles.response[index].rooms[0][0].amountChange

                                                SizedBox(
                                                  height: size.height * 0.03,
                                                ),

                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(context)!.hotelStars,
                                                        style: TextStyle(fontSize: titleFontSize),
                                                      ),
                                                    ]),
                                                SizedBox(
                                                  height: size.height * 0.03,
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                        onTap: () async {
                                                          pressIndcatorDialog(context);

                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             MiniLoader()));
                                                          final customizpackage0 =
                                                              Provider.of<AppData>(context,
                                                                      listen: false)
                                                                  .packagecustomiz;
                                                          //    print(newValue!.substring(0,1));
                                                          await AssistantMethods.changehotel(
                                                              context,
                                                              customizeId: customizpackage0
                                                                  .result.customizeId,
                                                              checkIn: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage0
                                                                      .result.hotels[0].checkIn),
                                                              checkOut: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage0
                                                                      .result.hotels[0].checkOut),
                                                              hId: customizpackage0
                                                                  .result.hotels[0].id,
                                                              star: "3");
                                                          if (!mounted) return;
                                                          Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .gethotelstarefilter("3");

                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  HotelCustomize.idScreen,
                                                                  (route) => false);
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.25,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                              AppLocalizations.of(context)!
                                                                  .stars("3"),
                                                              style: TextStyle(
                                                                  fontSize: subtitleFontSize),
                                                            ))),
                                                    InkWell(
                                                        onTap: () async {
                                                          pressIndcatorDialog(context);
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             MiniLoader()));
                                                          final customizpackage1 =
                                                              Provider.of<AppData>(context,
                                                                      listen: false)
                                                                  .packagecustomiz;
                                                          //    print(newValue!.substring(0,1));
                                                          await AssistantMethods.changehotel(
                                                              context,
                                                              customizeId: customizpackage1
                                                                  .result.customizeId,
                                                              checkIn: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage1
                                                                      .result.hotels[0].checkIn),
                                                              checkOut: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage1
                                                                      .result.hotels[0].checkOut),
                                                              hId: customizpackage1
                                                                  .result.hotels[0].id,
                                                              star: "4");
                                                          if (!mounted) return;
                                                          Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .gethotelstarefilter("4");

                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  HotelCustomize.idScreen,
                                                                  (route) => false);
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.25,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                                AppLocalizations.of(context)!
                                                                    .stars("4"),
                                                                style: TextStyle(
                                                                    fontSize: subtitleFontSize)))),
                                                    InkWell(
                                                        onTap: () async {
                                                          pressIndcatorDialog(context);
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             MiniLoader()));
                                                          final customizpackage2 =
                                                              Provider.of<AppData>(context,
                                                                      listen: false)
                                                                  .packagecustomiz;
                                                          //    print(newValue!.substring(0,1));
                                                          await AssistantMethods.changehotel(
                                                              context,
                                                              customizeId: customizpackage2
                                                                  .result.customizeId,
                                                              checkIn: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage2
                                                                      .result.hotels[0].checkIn),
                                                              checkOut: DateFormat('yyyy-MM-dd')
                                                                  .format(customizpackage2
                                                                      .result.hotels[0].checkOut),
                                                              hId: customizpackage2
                                                                  .result.hotels[0].id,
                                                              star: "5");
                                                          if (!mounted) return;
                                                          Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .gethotelstarefilter("5");

                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  HotelCustomize.idScreen,
                                                                  (route) => false);
                                                        },
                                                        child: Container(
                                                            alignment: Alignment.center,
                                                            width: size.width * 0.25,
                                                            padding: const EdgeInsets.all(10),
                                                            decoration: BoxDecoration(
                                                                color: cardcolor,
                                                                boxShadow: [shadow]),
                                                            child: Text(
                                                                AppLocalizations.of(context)!
                                                                    .stars("5"),
                                                                style: TextStyle(
                                                                    fontSize: subtitleFontSize)))),
                                                  ],
                                                ),
                                                SizedBox(height: size.height * 0.03),
                                              ],
                                            ),
                                          ));
                                },
                                child: Container(
                                  color: cardcolor,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.sort),
                                      Text(
                                        AppLocalizations.of(context)!.sort,
                                        style: TextStyle(fontSize: titleFontSize),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Provider.of<AppData>(context, listen: false).isPreBookFailed
                            ? Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15), color: cardcolor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'This hotel failed to booking please chose other one:',
                                      style: TextStyle(fontSize: titleFontSize - 1),
                                    ),
                                    Text(
                                      widget.hotelFailedName.split("failed")[0],
                                      style: TextStyle(
                                          fontSize: titleFontSize - 1, fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),

                        SizedBox(
                          width: size.width,
                          height: Provider.of<AppData>(context, listen: false).isPreBookFailed
                              ? size.height * 0.66
                              : size.height * 0.79,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 5, bottom: 20),
                            shrinkWrap: true,
                            itemCount: filtring.isEmpty ? 1 : filtring.length,
                            itemBuilder: (context, index) {
                              return filtring.isEmpty
                                  ? SizedBox(
                                      width: size.width,
                                      height: size.height * 0.60,
                                      child: Center(
                                        child: Text(
                                          'They are no hotel matched with this name',
                                          style: TextStyle(fontSize: titleFontSize),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: cardcolor,
                                          borderRadius: BorderRadius.circular(10)),
                                      height: 180.sp,
                                      width: size.width,
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(5),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: size.width * 0.40,
                                            margin: const EdgeInsets.symmetric(horizontal: 1),
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: filtring[index].image,
                                                  height: 180.sp,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => const Center(
                                                      child: ImageSpinning(
                                                    withOpasity: true,
                                                  )),
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    'assets/images/image.jpeg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0.0,
                                                  right: 0.0,
                                                  child: InkWell(
                                                    onTap: () {
                                                      CarouselController buttonCarouselController =
                                                          CarouselController();
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => Dialog(
                                                                child: SizedBox(
                                                                  width: size.width,
                                                                  height: size.height * 0.5,
                                                                  child: Stack(
                                                                    children: [
                                                                      CarouselSlider(
                                                                        items: filtring[index]
                                                                            .imgAll
                                                                            .map(
                                                                              (e) => ClipRect(
                                                                                child: Stack(
                                                                                  fit: StackFit
                                                                                      .expand,
                                                                                  children: [
                                                                                    CachedNetworkImage(
                                                                                      imageUrl: e
                                                                                          .src
                                                                                          .trimLeft(),
                                                                                      fit: BoxFit
                                                                                          .cover,
                                                                                      width: size
                                                                                          .width,
                                                                                      height:
                                                                                          size.height *
                                                                                              0.5,
                                                                                      placeholder: (context,
                                                                                              url) =>
                                                                                          const Center(
                                                                                        child:
                                                                                            ImageSpinning(
                                                                                          withOpasity:
                                                                                              true,
                                                                                        ),
                                                                                      ),
                                                                                      errorWidget: (context,
                                                                                              url,
                                                                                              error) =>
                                                                                          Image
                                                                                              .asset(
                                                                                        'assets/images/image-not-available.png',
                                                                                        fit: BoxFit
                                                                                            .cover,
                                                                                        width: size
                                                                                            .width,
                                                                                        height:
                                                                                            size.height *
                                                                                                0.5,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                        carouselController:
                                                                            buttonCarouselController,
                                                                        options: CarouselOptions(
                                                                          height: size.height * 0.5,
                                                                          initialPage: 0,
                                                                          autoPlay: false,
                                                                          // scrollPhysics: ScrollPhysics(parent: )
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        right: 10,
                                                                        bottom: size.height / 5,
                                                                        child: Container(
                                                                          color: primaryblue
                                                                              .withOpacity(0.50),
                                                                          child: IconButton(
                                                                            onPressed: () =>
                                                                                buttonCarouselController.nextPage(
                                                                                    duration:
                                                                                        const Duration(
                                                                                            milliseconds:
                                                                                                300),
                                                                                    curve: Curves
                                                                                        .linear),
                                                                            icon: const Icon(
                                                                              Icons
                                                                                  .keyboard_arrow_right,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        left: 10,
                                                                        bottom: size.height / 5,
                                                                        child: Container(
                                                                          color: primaryblue
                                                                              .withOpacity(0.50),
                                                                          child: IconButton(
                                                                            onPressed: () =>
                                                                                buttonCarouselController
                                                                                    .previousPage(
                                                                                        duration: const Duration(
                                                                                            milliseconds:
                                                                                                300),
                                                                                        curve: Curves
                                                                                            .linear),
                                                                            icon: const Icon(
                                                                              Icons
                                                                                  .keyboard_arrow_left_rounded,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                          right: 3,
                                                                          child: GestureDetector(
                                                                            onTap: () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                            },
                                                                            child: Icon(
                                                                              Icons.cancel,
                                                                              color: primaryblue,
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ));
                                                    },
                                                    child: const Icon(
                                                      Icons.switch_camera,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 2),
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    filtring[index].name,
                                                    style: TextStyle(
                                                        fontSize: subtitleFontSize,
                                                        fontWeight: FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SmoothStarRating(
                                                  isReadOnly: true,
                                                  allowHalfRating: false,
                                                  rating: double.parse(filtring[index].starRating),
                                                  borderColor: yellowColor,
                                                  color: yellowColor,
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.location_pin,
                                                          size: 18,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            filtring[index].address,
                                                            style: TextStyle(
                                                              fontSize: detailsFontSize,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => GoogleMapDialog(
                                                              lat: double.parse(
                                                                  filtring[index].latitude),
                                                              lon: double.parse(
                                                                  filtring[index].longitude),
                                                            ));
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context)!.mapView,
                                                    style: TextStyle(
                                                      color: primaryblue,
                                                      decoration: TextDecoration.underline,
                                                      fontSize: detailsFontSize,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => StreetView(
                                                              lat: double.parse(
                                                                  filtring[index].latitude),
                                                              lon: double.parse(
                                                                  filtring[index].longitude),
                                                              isFromCus: null,
                                                              isfromHotel: true,
                                                            )));
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context)!.streetview,
                                                    style: TextStyle(
                                                        color: primaryblue,
                                                        fontSize: detailsFontSize,
                                                        decoration: TextDecoration.underline),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width / 1.99,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        '${filtring[index].rooms[0][0].type}${filtring[index].rooms[0][0].amountChange} ${localizeCurrency(filtring[index].currency)}',
                                                        style: TextStyle(
                                                            color:
                                                                filtring[index].rooms[0][0].type ==
                                                                        '-'
                                                                    ? greencolor
                                                                    : Colors.redAccent,
                                                            fontSize: subtitleFontSize,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(context)!
                                                            .packagePriceDifference,
                                                        style: TextStyle(
                                                            color: footerbuttoncolor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: detailsFontSize),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(45.w, 5.h),
                                                            backgroundColor: yellowColor),
                                                        onPressed: () async {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ChangeRoomFromHotel(
                                                                        hotel: filtring[index],
                                                                        oldHotelID:
                                                                            Provider.of<AppData>(
                                                                                    context)
                                                                                .packagecustomiz
                                                                                .result
                                                                                .hotels
                                                                                .first
                                                                                .id
                                                                                .toString(),
                                                                        i: Provider.of<AppData>(
                                                                                context,
                                                                                listen: false)
                                                                            .hotelindex,
                                                                      )));
                                                          // showRooms(size: size, index: index);
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(context)!.select,
                                                          style: TextStyle(
                                                            fontSize: subtitleFontSize,
                                                            color: cardcolor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                        //Footer()
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  void showRooms({required Size size, required int index}) async {
    await showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: cardcolor,
              child: Container(
                height: 500,
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Container(
                      color: cardcolor,
                      padding: const EdgeInsets.all(20),
                      width: size.width,
                      child: Text(
                        'Available Room',
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 400,
                      child: ListView.builder(
                          itemCount: filtring[index].rooms.length,
                          itemBuilder: (context, ind) {
                            return Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < filtring[index].rooms[ind].length; i++)
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: cardcolor,
                                        ),
                                        margin: const EdgeInsets.only(bottom: 5),
                                        //    height: size.height*0.10,
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CachedNetworkImage(
                                                  imageUrl: filtring[index].image,
                                                  height: size.height * 0.10,
                                                  width: 100,
                                                  placeholder: (context, url) =>
                                                      const LoadingWidgetMain(),
                                                  errorWidget: (context, erorr, x) =>
                                                      SvgPicture.asset(
                                                        'images/image-not-available.svg',
                                                        color: Colors.grey,
                                                      )),
                                              Container(
                                                  margin: const EdgeInsets.all(5),
                                                  width: 140,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          filtring[index].rooms[ind][i].name,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: const AdaptiveTextSize()
                                                                  .getadaptiveTextSize(
                                                                      context, 20)),
                                                        ),
                                                        Text(
                                                            '${filtring[index].rooms[ind][i].boardName}\n\n'),
                                                        //   Text('\n\n'+hotles.response[index].rooms[ind][0].rateKey+'\n\n'),
                                                      ]))
                                            ])),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.30,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  filtring[index].rooms[ind][0].type.toString(),
                                                  style: TextStyle(
                                                      color: filtring[index]
                                                                  .rooms[ind][0]
                                                                  .type
                                                                  .toString() ==
                                                              '+'
                                                          ? greencolor
                                                          : Colors.red,
                                                      fontSize: const AdaptiveTextSize()
                                                          .getadaptiveTextSize(context, 24),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  ' ${filtring[index].rooms[ind][0].amountChange}',
                                                  style: TextStyle(
                                                      color: filtring[index]
                                                                  .rooms[ind][0]
                                                                  .type
                                                                  .toString() ==
                                                              '+'
                                                          ? greencolor
                                                          : Colors.red,
                                                      fontSize: const AdaptiveTextSize()
                                                          .getadaptiveTextSize(context, 24),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  localizeCurrency(filtring[index]
                                                      .rooms[ind][0]
                                                      .sellingCurrency
                                                      .toString()),
                                                  style: TextStyle(
                                                      color: filtring[index]
                                                                  .rooms[ind][0]
                                                                  .type
                                                                  .toString() ==
                                                              '+'
                                                          ? greencolor
                                                          : Colors.red,
                                                      fontSize: const AdaptiveTextSize()
                                                          .getadaptiveTextSize(context, 24),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          pressIndcatorDialog(context);
                                          //  print(Provider.of<AppData>(context,listen: false).packagecustomiz.result.hotels[0].selectedRoom.length);
                                          //  Navigator.pushNamed(context, MiniLoader.idScreen);
                                          //  for (var i = 0; i < Provider.of<AppData>(context,listen: false).packagecustomiz.result.hotels[0].selectedRoom.length; i++) {

                                          final jeybin = filtring[index].rooms[ind];

                                          //  selectedroom.addAll(hotles.response[index].rooms[ind]);

                                          //  print(selectedroom[0].toString());
                                          changehotelmodel.ResponseHotel selectedHotile =
                                              filtring[index];

                                          //  selectedHotile.selectedRoom = selectedroom;
                                          selectedHotile.selectedRoom = jeybin;

                                          //  print(selectedHotile.selectedRoom?.toJson());
                                          var w = selectedHotile.toJson();
                                          List x = [];
                                          x.add(w);

                                          Map<String, dynamic> saveddata = {
                                            "customizeId":
                                                Provider.of<AppData>(context, listen: false)
                                                    .packagecustomiz
                                                    .result
                                                    .customizeId,
                                            "splitHotels": x,
                                            "currency": gencurrency,
                                            "language": "en"
                                          };

                                          String a = jsonEncode(saveddata);

                                          await AssistantMethods.saveHotel(a, context);
                                          // await AssistantMethods.updatethepackage(
                                          //     Provider.of<AppData>(context, listen: false)
                                          //         .packagecustomiz
                                          //         .result
                                          //         .customizeId);
                                          if (!mounted) return;
                                          await AssistantMethods.updateHotelDetails(
                                              Provider.of<AppData>(context, listen: false)
                                                  .packagecustomiz
                                                  .result
                                                  .customizeId,
                                              context);

                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => CustomizePackage(),
                                          //   ),
                                          // );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(160, 45),
                                            backgroundColor: yellowColor),
                                        child: const Text('Select'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ));
  }

  hundlerimj(int index) {
    filtring.removeAt(index);
    setState(() {});
  }
}
