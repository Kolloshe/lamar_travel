// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';

import '../Datahandler/app_data.dart';
import '../Model/customizpackage.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../config.dart';
import 'image_spinnig.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FlightDetial extends StatefulWidget {
  const FlightDetial({Key? key}) : super(key: key);
  static String idScreen = 'FlightDetials';

  @override
  _FlightDetialState createState() => _FlightDetialState();
}

class _FlightDetialState extends State<FlightDetial> {
  late Customizpackage selectedFlight;
  void loadSelectedFlight() {
    selectedFlight = Provider.of<AppData>(context, listen: false).packagecustomiz;
  }

  @override
  void initState() {
    loadSelectedFlight();
    super.initState();
  }

  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: cardcolor,
        title: Text(
          AppLocalizations.of(context)!.flightDetails,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [shadow],
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width,
                      padding: const EdgeInsets.all(10),
                      color: background,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              AppLocalizations.of(context)!.departureInformation,
                              style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: primaryblue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat('EEEE', genlang).format(selectedFlight.result.flight!.from.departureFdate)}, ${DateFormat('MMMMd', genlang).format(selectedFlight.result.flight!.from.departureFdate)}',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${selectedFlight.result.flight!.from.itinerary[0].departure.city}(${selectedFlight.result.flight!.from.departure}) > ${selectedFlight.result.flight!.to.itinerary[0].departure.city} (${selectedFlight.result.flight!.from.arrival})',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                selectedFlight.result.flight!.from.travelTime,
                                style: TextStyle(fontSize: subtitleFontSize),
                              ),
                            ],
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                    for (var i = 0; i < selectedFlight.result.flight!.from.itinerary.length; i++)
                      filghtcard(selectedFlight.result.flight!.from,
                          selectedFlight.result.flight!.from.itinerary[i]),
                  ],
                ),
              ),

// chaking if it have stoped

              Divider(
                color: Colors.black.withOpacity(0.25),
                endIndent: 5,
                indent: 5,
              ),
              //++++++++++++++++++++++++++++++++++++++++++++++++++++RETURN CONTANER++++++++++++++++++++++++++++++++++++++++++++++++++++++
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [shadow],
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      color: background,
                      child: Text(
                        AppLocalizations.of(context)!.returnInformation,
                        style: TextStyle(
                            fontSize: titleFontSize,
                            color: primaryblue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat('EEEE', genlang).format(selectedFlight.result.flight!.to.departureFdate)}, ${DateFormat('MMMMd', genlang).format(selectedFlight.result.flight!.to.departureFdate)}',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${selectedFlight.result.flight!.to.itinerary.first.departure.city}(${selectedFlight.result.flight!.to.departure}) > ${selectedFlight.result.flight!.to.itinerary.last.arrival.city} (${selectedFlight.result.flight!.to.arrival})',
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(selectedFlight.result.flight!.to.travelTime),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < selectedFlight.result.flight!.to.itinerary.length; i++)
                          filghtcard(selectedFlight.result.flight!.to,
                              selectedFlight.result.flight!.to.itinerary[i])
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return ' ${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }

  Widget filghtcard(From from, Itinerary itinerary) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itinerary.layover > 0
              ? Container(
                  height: size.height * 0.1,
                  width: size.width,
                  color: background,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.changeIn} ${itinerary.departure.city} , (${itinerary.departure.locationId})',
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.waitingTime} - ${durationToString(itinerary.layover)}',
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Divider(
            color: Colors.black.withOpacity(0.25),
            indent: 5,
            endIndent: 5,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: itinerary.company.logo,
                  width: 50,
                  height: 50,
                  placeholder: (context, url) => const Center(
                      child: ImageSpinning(
                    withOpasity: true,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),

                // Image.network(
                //   itinerary.company.logo,
                //   width: 50,
                //   height: 50,
                // ),
                Text(
                  '   - ${itinerary.company.operatingCarrier} ${itinerary.flightNo}',
                  style: TextStyle(fontSize: detailsFontSize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: size.width * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('MMMM d ', genlang).format(itinerary.departure.date)} ${itinerary.departure.time}',
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                        ),
                        Text(
                          '${itinerary.departure.city} (${itinerary.departure.locationId})',
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                        ),
                        Text(
                          itinerary.departure.airport,
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMMM d ', genlang).format(itinerary.arrival.date) +
                            itinerary.arrival.time,
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      Text(
                        '${itinerary.arrival.city} (${itinerary.arrival.locationId})',
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.35,
                        child: Text(
                          itinerary.arrival.airport,
                          style: TextStyle(
                            fontSize: detailsFontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.20,
                  child: Column(
                    children: [
                      Text(
                        durationToString(itinerary.flightTime),
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      Text(
                        selectedFlight.result.flight!.flightClass,
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${AppLocalizations.of(context)!.baggageDetails} : ${AppLocalizations.of(context)!.baggageInfo(int.tryParse(itinerary.baggageInfo.isNotEmpty ? itinerary.baggageInfo.first.toString().trim().substring(0, 1) : "0") ?? 0)}',
              locale: const Locale('EN'),
              style: TextStyle(
                color: primaryblue,
                fontSize: detailsFontSize,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
}
