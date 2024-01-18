// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:sizer/sizer.dart';

import '../Assistants/assistant_methods.dart';
import '../Datahandler/app_data.dart';
import '../Model/changeflight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screen/customize/new-customize/new_customize.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import 'image_spinnig.dart';

class FlightDetials extends StatefulWidget {
  const FlightDetials({Key? key}) : super(key: key);

  @override
  _FlightDetialsState createState() => _FlightDetialsState();
}

class _FlightDetialsState extends State<FlightDetials> {
  late FlightData _selectedFlight;
  late Size size;

  void loadSelectedFlight() {
    _selectedFlight = Provider.of<AppData>(context, listen: false).datum;
  }

  @override
  void initState() {
    loadSelectedFlight();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadSelectedFlight();
    size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
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
                Navigator.of(context).pop();
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
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(3),
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
                          //height: size.height * 0.07,
                          color: background,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  AppLocalizations.of(context)!.departureInformation,
                                  style: TextStyle(
                                      fontSize: subtitleFontSize,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${DateFormat('EEEE', genlang).format(_selectedFlight.from.departureFdate)}, ${DateFormat('MMMMd', genlang).format(_selectedFlight.from.departureFdate)}',
                                    style: TextStyle(
                                      fontSize: subtitleFontSize,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${_selectedFlight.from.departureCity}(${_selectedFlight.from.departureCityCode}) > ${_selectedFlight.from.arrivalCity} (${_selectedFlight.from.arrivalCityCode})',
                                    style: TextStyle(
                                      fontSize: subtitleFontSize,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _selectedFlight.from.travelTime,
                                    style: TextStyle(
                                      fontSize: subtitleFontSize,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Divider(
                        //   color: Colors.black.withOpacity(0.1),
                        //   thickness: 1,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < _selectedFlight.from.itinerary.length; i++)
                              filghtcard(_selectedFlight.from, _selectedFlight.from.itinerary[i])
                          ],
                        ),
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
                                fontSize: subtitleFontSize,
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
                                '${DateFormat('EEEE', genlang).format(_selectedFlight.to.departureFdate)}, ${DateFormat('MMMMd', genlang).format(_selectedFlight.to.departureFdate)}',
                                style: TextStyle(fontSize: subtitleFontSize),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${_selectedFlight.to.departureCity}(${_selectedFlight.to.departureCityCode}) > ${_selectedFlight.to.arrivalCity} (${_selectedFlight.to.arrivalCityCode})',
                                style: TextStyle(
                                  fontSize: subtitleFontSize,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _selectedFlight.to.travelTime,
                                style: TextStyle(fontSize: subtitleFontSize),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i = 0; i < _selectedFlight.to.itinerary.length; i++)
                              filghtcard(_selectedFlight.to, _selectedFlight.to.itinerary[i])
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${_selectedFlight.from.departureDate} - ${_selectedFlight.to.arrivalDate}",
                          style: TextStyle(fontWeight: FontWeight.w600, color: primaryblue),
                        ),
                        Text(
                          '${_selectedFlight.from.departureCity} - ${_selectedFlight.to.arrivalCity}',
                          style: TextStyle(fontWeight: FontWeight.w600, color: primaryblue),
                        ),
                      ],
                    ),
                    SizedBox(
                        child: Text(
                      ' price difference  ${_selectedFlight.priceDiff}',
                      style: TextStyle(fontWeight: FontWeight.w600, color: primaryblue),
                    ))
                  ],
                ),
                SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: greencolor),
                    onPressed: () async {
                      pressIndcatorDialog(context);

                      Map<String, dynamic> saveddata = {
                        "flightId": _selectedFlight.flightId,
                        "customizeId": Provider.of<AppData>(context, listen: false)
                            .packagecustomiz
                            .result
                            .customizeId,
                        "sellingCurrency": gencurrency,
                        "language": genlang
                      };
                      var data = jsonEncode(saveddata);
                      try {
                        await AssistantMethods.changeFlight(data);
                        if (!mounted) return;
                        await AssistantMethods.updateThePackage(
                            Provider.of<AppData>(context, listen: false)
                                .packagecustomiz
                                .result
                                .customizeId);
                        if (!mounted) return;

                        await AssistantMethods.updateHotelCheckIn(
                            Provider.of<AppData>(context, listen: false)
                                .packagecustomiz
                                .result
                                .customizeId);
                        if (!mounted) return;

                        await AssistantMethods.updateHotelDetails(
                            Provider.of<AppData>(context, listen: false)
                                .packagecustomiz
                                .result
                                .customizeId,
                            context);
                        if (!mounted) return;

                        if (Provider.of<AppData>(context, listen: false).isPreBookFailed) {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          }
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                CustomizeSlider.idScreen, (route) => false);
                          }
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                CustomizeSlider.idScreen, (route) => false);
                          }
                          displayTostmessage(context, false,
                              message: AppLocalizations.of(context)!.flightHasBeenChange);
                        } else {
                          displayTostmessage(context, false,
                              message: AppLocalizations.of(context)!.flightHasBeenChange);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                        }
                      } catch (e) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.select,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                          fontSize: subtitleFontSize,
                        ),
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.waitingTime} - ${durationToString(itinerary.layover)}',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
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
                Text(
                  '  ${_selectedFlight.carrier.name} - ${itinerary.company.operatingCarrier} ${itinerary.flightNo}',
                  style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.bold),
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
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
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
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    children: [
                      Text(
                        minutesToTimeOfDay(itinerary.flightTime).toString(),
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      Text(
                        itinerary.cabinClass == 'C'
                            ? AppLocalizations.of(context)!.business
                            : AppLocalizations.of(context)!.economic,
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
            child: itinerary.baggageInfo.isNotEmpty
                ? Text(
                    '${AppLocalizations.of(context)!.baggageDetails} : ${itinerary.baggageInfo.join(',')}',
                    style: TextStyle(color: primaryblue, fontSize: detailsFontSize),
                  )
                : const SizedBox(),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );

  String minutesToTimeOfDay(int minutes) {
    Duration duration = Duration(minutes: minutes);
    List<String> parts = duration.toString().split(':');
    var time = "${parts[0]} : ${parts[1]}";
    TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    return time;
  }
}
