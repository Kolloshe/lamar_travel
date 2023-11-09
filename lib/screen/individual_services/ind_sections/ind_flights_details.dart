// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';
import '../../main_screen1.dart';

class IndFlightDetails extends StatefulWidget {
  const IndFlightDetails({Key? key, required this.details, required this.id, required this.price})
      : super(key: key);
  final Map<String, dynamic> price;
  final FlightDetails details;
  final String id;

  @override
  _IndFlightDetailsState createState() => _IndFlightDetailsState();
}

class _IndFlightDetailsState extends State<IndFlightDetails> {
  FlightDetails? selectedFlight;

  bool isLogin = false;

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  @override
  void initState() {
    getlogin();
    selectedFlight = widget.details;
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
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(4),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DateFormat('EEEE', genlang).format(selectedFlight!.from.departureFdate)}, ${DateFormat('MMMMd', genlang).format(selectedFlight!.from.departureFdate)}',
                                  style: TextStyle(
                                    fontSize: subtitleFontSize,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${selectedFlight!.from.itinerary[0].departure.city}(${selectedFlight!.from.departure}) >  ${selectedFlight?.to != null ? '${(selectedFlight!.to?.itinerary ?? [])[0].departure.city} (${selectedFlight!.from.arrival}' : '${selectedFlight!.from.itinerary.last.arrival.city} (${selectedFlight!.from.itinerary.last.arrival.locationId})'})',
                                  style: TextStyle(
                                    fontSize: subtitleFontSize,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  selectedFlight!.from.travelTime,
                                  style: TextStyle(fontSize: subtitleFontSize),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      for (var i = 0; i < selectedFlight!.from.itinerary.length; i++)
                        filghtcard(selectedFlight!.from, selectedFlight!.from.itinerary[i]),
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
                SizedBox(height: 1.h),

                selectedFlight!.to == null
                    ? const SizedBox()
                    : Container(
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
                                  selectedFlight!.to == null
                                      ? const SizedBox()
                                      : Text(
                                          '${DateFormat('EEEE', genlang).format(selectedFlight!.to!.departureFdate)}, ${DateFormat('MMMMd', genlang).format(selectedFlight!.to!.departureFdate)}',
                                          style: TextStyle(fontSize: 10.sp),
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  selectedFlight?.to == null
                                      ? const SizedBox()
                                      : Text(
                                          '${(selectedFlight!.to?.itinerary ?? []).first.departure.city}(${selectedFlight!.to?.departure ?? ''}) > ${selectedFlight!.to?.itinerary ?? [].last.arrival.city} (${selectedFlight!.to?.arrival ?? []})',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(selectedFlight!.to?.travelTime ?? ''),
                                ],
                              ),
                            ),
                            selectedFlight!.to == null
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (var i = 0;
                                          i < (selectedFlight!.to?.itinerary ?? []).length;
                                          i++)
                                        filghtcard(
                                            selectedFlight!.to!, selectedFlight!.to!.itinerary[i])
                                    ],
                                  )
                          ],
                        ),
                      ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: 100.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '${selectedFlight?.tripStart ?? ''} - ${selectedFlight?.tripEnd ?? ''}   ',
                      style: TextStyle(fontWeight: FontWeight.w600, color: primaryblue),
                    ),
                    Text(
                      '${selectedFlight!.from.departureDate} ${selectedFlight!.to == null ? "" : "-"} ${selectedFlight!.to?.arrivalDate ?? ''}',
                      style: TextStyle(fontWeight: FontWeight.w600, color: primaryblue),
                    )
                  ],
                ),
                SizedBox(
                  child: Text(
                    "${widget.price['price']} ${localizeCurrency(widget.price['currency'])}",
                    style: TextStyle(color: primaryblue, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 100.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                onPressed: () async {
                  await AssistantMethods.customizingPackage(context, widget.id);
                  getlogin();
                  // <=======   Check if it loggedIn then   =======>>>>

                  if (Provider.of<AppData>(context, listen: false).isFromdeeplink) {
                    pressIndcatorDialog(context);
                    await Future.delayed(const Duration(seconds: 2), () {
                      if (!isLogin) {
                        getlogin();
                      }
                    });
                    Navigator.of(context).pop();
                  }
                  if (isLogin) {
                    if (users.data.phone.isEmpty) {
                      displayTostmessage(context, false,
                          message: AppLocalizations.of(context)!.youAccountMissSomeInformation);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserProfileInfomation(
                                isFromPreBook: true,
                              )));
                    } else {
                      Provider.of<AppData>(context, listen: false)
                          .newPreBookTitle(AppLocalizations.of(context)!.passengersInformation);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PreBookStepper(
                                isFromNavBar: true,
                              )));
                      Provider.of<AppData>(context, listen: false)
                          .resetSelectedPassingerfromPassList();
                    }
                  } else {
                    isFromBooking = true;
                    Navigator.of(context).pushNamed(NewLogin.idScreen);
                  }
                },
                child: Text(AppLocalizations.of(context)!.bookNow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return ' ${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }

  Widget filghtcard(From from, Itinerary itinerary) => Container(
      color: Colors.white,
      child: Column(
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
                        '${AppLocalizations.of(context)!.waitingTime} - ${durationToString(itinerary.layover.toInt())}',
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
                        durationToString(itinerary.flightTime.toInt()),
                        style: TextStyle(
                          fontSize: detailsFontSize,
                        ),
                      ),
                      Text(
                        selectedFlight!.flightClass,
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
              '${AppLocalizations.of(context)!.baggageDetails} : ${AppLocalizations.of(context)!.baggageInfo(int.tryParse(itinerary.baggageInfo.isNotEmpty ? itinerary.baggageInfo.first.toString().trim().substring(0, 1) : '0') ?? 0)}',
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
      ));
}
