// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';

import '../../Datahandler/adaptive_texts_size.dart';
import '../../Datahandler/app_data.dart';
import '../../Model/changeflight.dart';
import '../../config.dart';

import 'package:sizer/sizer.dart';

import '../../widget/image_spinnig.dart';

import '../../widget/selectedflightdetials.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../packages_screen.dart';

class FlightCustomize extends StatefulWidget {
  FlightCustomize({Key? key, required this.failedFlightNamed}) : super(key: key);
  static String idScreen = 'FlightCustomize';
  String failedFlightNamed = '';

  @override
  _FlightCustomizeState createState() => _FlightCustomizeState();
}

class _FlightCustomizeState extends State<FlightCustomize> {
  bool sortFlightClass = false;

  bool flightStops = false;

  List<FlightData> filtring = [];

  // bool sort

  late Changeflight changeflight;
  Changeflight? flightname;
  Changeflight? genflightList;
  bool isLoaded = false;

  void loadflight() {
    if (Provider.of<AppData>(context, listen: false).changeflight != null) {
      changeflight = Provider.of<AppData>(context, listen: false).changeflight!;
      flightname = Provider.of<AppData>(context, listen: false).changeflight;
      filtring = changeflight.data;
      genflightList = flightname;
      isLoaded = true;
    }
  }

  @override
  void initState() {
    loadflight();
    super.initState();
  }

  filterflightbyname(String name) {
    List<FlightData> x = genflightList!.data;
    if (name.length > 1) {
      x = genflightList!.data
          .where(
              (element) => element.carrier.name.toLowerCase().trim() == name.toLowerCase().trim())
          .toList();
      setState(() {
        changeflight.data = x;
      });
    } else {
      setState(() {
        x = flightname!.data;
        changeflight.data = x;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: cardcolor,
            title: Text(
              AppLocalizations.of(context)!.changeFlightAppbarTitle,
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
            elevation: 0.1,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  if (Provider.of<AppData>(context, listen: false).isPreBookFailed == false) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(AppLocalizations.of(context)!.sureToCancelTheBooking),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Provider.of<AppData>(context, listen: false)
                                          .changePrebookFaildStatus(false);
                                      if (context.read<AppData>().searchMode == '' &&
                                          context.read<AppData>().searchMode.isEmpty) {
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
                  }
                },
                icon: Icon(
                  Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  color: primaryblue,
                  size: 35,
                )),
          ),

          // appbar(context, ''),
          backgroundColor: background,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: isLoaded == false
                ? const Center(child: Text('No flight available'))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            .searchonFlightList(name);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!.searchByAirlines,
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!.sortByName,
                                                style: TextStyle(fontSize: subtitleFontSize),
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
                                                          filtring.sort((a, b) => a.carrier.name
                                                              .compareTo(b.carrier.name));
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                            AppLocalizations.of(context)!.aToz,
                                                            style: TextStyle(
                                                                fontSize: detailsFontSize),
                                                          ))),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          filtring.sort((a, b) => b.carrier.name
                                                              .compareTo(a.carrier.name));
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                            AppLocalizations.of(context)!.zToa,
                                                            style: TextStyle(
                                                                fontSize: detailsFontSize),
                                                          ))),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.03,
                                              ),

                                              Text(
                                                AppLocalizations.of(context)!.sortByPrice,
                                                style: TextStyle(fontSize: subtitleFontSize),
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
                                                          changeflight.data.sort((a, b) =>
                                                              a.priceDiff.compareTo(b.priceDiff));
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                            AppLocalizations.of(context)!
                                                                .lowestToHighest,
                                                            style: TextStyle(
                                                                fontSize: detailsFontSize),
                                                          ))),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          filtring.sort((a, b) =>
                                                              b.priceDiff.compareTo(a.priceDiff));
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                              AppLocalizations.of(context)!
                                                                  .highestToLowest,
                                                              style: TextStyle(
                                                                  fontSize: detailsFontSize)))),
                                                ],
                                              ),
                                              SizedBox(height: size.height * 0.05),

                                              Text(AppLocalizations.of(context)!.sortByFlightStop,
                                                  style: TextStyle(fontSize: subtitleFontSize)),
                                              SizedBox(height: size.height * 0.03),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          filtring.sort((a, b) {
                                                            return a.from.stops.length
                                                                .compareTo(b.from.stops.length);
                                                          });
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                              AppLocalizations.of(context)!.nonStop,
                                                              style: TextStyle(
                                                                  fontSize: detailsFontSize)))),
                                                  InkWell(
                                                      onTap: () {
                                                        try {
                                                          setState(() {
                                                            filtring.sort((a, b) {
                                                              return b.from.stops.length
                                                                  .compareTo(a.from.stops.length)
                                                                  .compareTo(a.to.stops.length);
                                                            });
                                                          });
                                                          Navigator.of(context).pop();
                                                        } catch (e) {
                                                          Navigator.of(context).pop();
                                                        }
                                                      },
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          width: size.width * 0.4,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: cardcolor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.1),
                                                                    blurRadius: 5,
                                                                    spreadRadius: 2,
                                                                    offset: const Offset(1, 0))
                                                              ]),
                                                          child: Text(
                                                              AppLocalizations.of(context)!
                                                                  .mutliStop,
                                                              style: TextStyle(
                                                                  fontSize: detailsFontSize)))),
                                                ],
                                              ),
                                              SizedBox(
                                                height: size.height * 0.03,
                                              )
                                              // hotles.response[index].rooms[0][0].amountChange
                                            ],
                                          ),
                                        ));
                              },
                              child: Container(
                                color: cardcolor,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.sort),
                                    Text(
                                      AppLocalizations.of(context)!.sort,
                                      style: TextStyle(fontSize: subtitleFontSize),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                    AppLocalizations.of(context)!.thisFlightFailedToBookingPlease,
                                    style: TextStyle(fontSize: titleFontSize - 1),
                                  ),
                                  Text(
                                    widget.failedFlightNamed.split("failed")[0],
                                    style: TextStyle(
                                        fontSize: titleFontSize - 1, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        flex: 8,
                        //height: 500,
                        child: ListView.builder(
                          itemCount: filtring.isNotEmpty ? filtring.length : 0,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: cardcolor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      offset: const Offset(1, 2),
                                      blurRadius: 7),
                                ],
                              ),
                              padding: const EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.yourDepartureFlight,
                                    style: TextStyle(
                                        fontSize: subtitleFontSize, fontWeight: FontWeight.bold),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.70,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            filtring[index].from.arrivalDate,
                                                            style: TextStyle(
                                                                fontSize: detailsFontSize),
                                                          ),
                                                        ],
                                                      ),
                                                      CachedNetworkImage(
                                                        imageUrl:
                                                            filtring[index].from.carrierImage,
                                                        width: 20.w,
                                                        height: 60,
                                                        placeholder: (context, url) => const Center(
                                                            child:
                                                                ImageSpinning(withOpasity: true)),
                                                        errorWidget: (context, url, error) =>
                                                            const Icon(Icons.error),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            filtring[index].from.departureTime,
                                                            style: TextStyle(
                                                              fontSize: detailsFontSize,
                                                            ),
                                                          ),
                                                          Text(
                                                            filtring[index]
                                                                .from
                                                                .departureCityCode,
                                                            style: TextStyle(
                                                              fontSize: detailsFontSize,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      filtring[index].from.stops.isNotEmpty
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                  '●',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          const AdaptiveTextSize()
                                                                              .getadaptiveTextSize(
                                                                                  context, 20),
                                                                      color: yellowColor),
                                                                ),
                                                                Text(
                                                                  filtring[index]
                                                                          .from
                                                                          .stops
                                                                          .isNotEmpty
                                                                      ? filtring[index]
                                                                          .from
                                                                          .stops
                                                                          .first
                                                                      : '',
                                                                  style: TextStyle(
                                                                    fontSize: detailsFontSize,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : SizedBox(
                                                              width: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.02,
                                                            ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            filtring[index].from.arrivalTime,
                                                            style: TextStyle(
                                                              fontSize: detailsFontSize,
                                                            ),
                                                          ),
                                                          Text(
                                                            filtring[index].from.arrivalCityCode,
                                                            style: TextStyle(
                                                              fontSize: detailsFontSize,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              indent: 20,
                                              endIndent: 10,
                                              color: black,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!.yourArrivalFlight,
                                                  style: TextStyle(
                                                      fontSize: subtitleFontSize,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width *
                                                          0.70,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                filtring[index].to.departureDate,
                                                                style: TextStyle(
                                                                  fontSize: detailsFontSize,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                filtring[index].to.carrierImage,
                                                            width: 20.w,
                                                            height: 60,
                                                            placeholder: (context, url) => const Center(
                                                                child: ImageSpinning(
                                                              withOpasity: true,
                                                            )),
                                                            errorWidget: (context, url, error) =>
                                                                const Icon(Icons.error),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                filtring[index].to.departureTime,
                                                                style: TextStyle(
                                                                  fontSize: detailsFontSize,
                                                                ),
                                                              ),
                                                              Text(
                                                                filtring[index]
                                                                    .to
                                                                    .departureCityCode,
                                                                style: TextStyle(
                                                                  fontSize: detailsFontSize,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          filtring[index].to.stops.isNotEmpty
                                                              ? Column(
                                                                  children: [
                                                                    Text(
                                                                      '●',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              const AdaptiveTextSize()
                                                                                  .getadaptiveTextSize(
                                                                                      context,
                                                                                      20),
                                                                          color: yellowColor),
                                                                    ),
                                                                    Text(
                                                                      filtring[index]
                                                                              .to
                                                                              .stops
                                                                              .isNotEmpty
                                                                          ? filtring[index]
                                                                              .to
                                                                              .stops
                                                                              .first
                                                                          : '',
                                                                      style: TextStyle(
                                                                        fontSize: detailsFontSize,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : SizedBox(
                                                                  width: MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      0.02,
                                                                ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                filtring[index].to.arrivalTime,
                                                                style: TextStyle(
                                                                    fontSize: detailsFontSize),
                                                              ),
                                                              Text(
                                                                filtring[index]
                                                                    .to
                                                                    .arrivalCityCode,
                                                                style: TextStyle(
                                                                  fontSize: detailsFontSize,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.24,
                                        height: 18.h,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${filtring[index].priceDiff.toString()} ${localizeCurrency(filtring[index].currency)}',
                                              style: TextStyle(
                                                  fontSize: detailsFontSize, color: greencolor),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .packagePriceDifference,
                                              style: TextStyle(
                                                  fontSize: detailsFontSize, color: primaryblue),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                              
                                                Provider.of<AppData>(context, listen: false)
                                                    .getselectedFlightToShowDetials(
                                                        filtring[index]);
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) => const FlightDetials(),
                                                  ),
                                                );
                                              },
                                              style:
                                                  ElevatedButton.styleFrom(backgroundColor: yellowColor),
                                              child: Text(
                                                AppLocalizations.of(context)!.contin,
                                                style: TextStyle(fontSize: detailsFontSize),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )

                                  // Column(
                                  //   children: [
                                  //
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       child: Divider(
                                  //         indent: 25,
                                  //         endIndent: 25,
                                  //         color: Colors.black,
                                  //       ),
                                  //     ),

                                  //   ],
                                  // ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  BoxShadow shadowbox = BoxShadow(
      color: yellowColor.withOpacity(0.50),
      offset: const Offset(0, 1),
      spreadRadius: 5,
      blurRadius: 9);
}
