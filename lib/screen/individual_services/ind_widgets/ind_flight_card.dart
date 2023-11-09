import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_sections/ind_flights_details.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:sizer/sizer.dart';

import '../../../../config.dart';
import '../../packages_screen.dart';

class IndFlightCard extends StatelessWidget {
  const IndFlightCard({Key? key, required this.data, required this.id, required this.pricing})
      : super(key: key);
  final FlightDetails data;
  final String id;
  final Map<String, dynamic> pricing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IndFlightDetails(
                  details: data,
                  id: id,
                  price: pricing,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(3, 3),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        width: 100.w,
        //    height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   data.from.itinerary.first.departure.city +
            //       ' to ' +
            //       data.from.itinerary.last.arrival.city,
            //   style: TextStyle(fontWeight: FontWeight.w500, color: primaryblue),
            // ),
            // SizedBox(
            //   height: 1.h,
            // ),
            // Text(DateFormat('EEEE,  d MMM y', genlang).format(data.from.departureFdate)),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              width: 100.w,
              //  height: 1.h,
              child: const Divider(
                thickness: 1,
                endIndent: 10,
                indent: 10,
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.flightTime ?? 'Flight Time',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(data.from.travelTime)
                  ],
                ),
                SizedBox(
                    height: 4.h,
                    child: const VerticalDivider(
                      thickness: 2,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.fStops ?? "stops",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(AppLocalizations.of(context)!.flightStop(
                        (data.from.numstops.toInt() == 0 && (data.to?.numstops ?? 0).toInt() == 0)
                            ? 0
                            : 1))
                  ],
                ),
                SizedBox(
                    height: 4.h,
                    child: const VerticalDivider(
                      thickness: 2,
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.flightClass ?? "Class",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(handleFlightClass(data.flightClass, context))
                  ],
                ),
              ]),
            ),
            SizedBox(
              width: 100.w,
              child: const Divider(thickness: 1, endIndent: 10, indent: 10),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 20.w,
                  height: 7.h,
                  child: CachedNetworkImage(
                    imageUrl: data.from.itinerary.first.company.logo,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const ImageSpinning(
                      withOpasity: true,
                    ),
                    errorWidget: (context, url, error) => Image.asset('assets/images/image.jpeg'),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.from.carrierName,
                      style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                    ),
                    Text('${data.from.carrierCode}-${data.from.itinerary.first.flightNo}')
                  ],
                ),
              ],
            ),
            Text(AppLocalizations.of(context)?.yourDepartureFlight ?? 'Departure flight'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Text(
                        data.from.itinerary.first.departure.time,
                        style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                      ),
                      Text(data.from.itinerary.first.departure.locationId)
                    ],
                  ),
                  data.from.numstops > 0
                      ? SizedBox(
                          width: 50.w,
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  height: 1.h,
                                  color: primaryblue,
                                ),
                              ),
                              for (int i = 1; i < data.from.itinerary.length; i++)
                                SizedBox(
                                  width: 10.w,
                                  child: Column(
                                    children: [
                                      Text(
                                        data.from.itinerary[i].departure.time,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, color: blackTextColor),
                                      ),
                                      Text(data.from.itinerary[i].departure.locationId)
                                    ],
                                  ),
                                ),
                              Expanded(
                                child: Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  height: 1.h,
                                  color: primaryblue,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          width: 50.w,
                          child: Divider(
                            indent: 10,
                            endIndent: 10,
                            height: 1.h,
                            color: primaryblue,
                          ),
                        ),
                  Column(
                    children: [
                      Text(
                        data.from.itinerary.last.arrival.time,
                        style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                      ),
                      Text(data.from.itinerary.last.arrival.locationId)
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: primaryblue.withOpacity(0.3)),
            if (data.to != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 20.w,
                    height: 7.h,
                    child: CachedNetworkImage(
                      imageUrl: data.to?.itinerary.first.company.logo ?? '',
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const ImageSpinning(
                        withOpasity: true,
                      ),
                      errorWidget: (context, url, error) => Image.asset('assets/images/image.jpeg'),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.to?.carrierName ?? '',
                        style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                      ),
                      Text(
                          '${data.to?.carrierCode ?? ''}-${(data.to?.itinerary ?? []).first.flightNo}')
                    ],
                  ),
                ],
              ),
              Text(AppLocalizations.of(context)?.yourArrivalFlight ?? 'Return Flight'),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Text(
                          (data.to?.itinerary ?? []).first.departure.time,
                          style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                        ),
                        Text((data.to?.itinerary ?? []).first.departure.locationId)
                      ],
                    ),
                    (data.to?.numstops ?? 0) > 0
                        ? SizedBox(
                            width: 50.w,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    indent: 10,
                                    endIndent: 10,
                                    height: 1.h,
                                    color: primaryblue,
                                  ),
                                ),
                                for (int i = 1; i < (data.to?.itinerary ?? []).length; i++)
                                  SizedBox(
                                    width: 10.w,
                                    child: Column(
                                      children: [
                                        Text(
                                          (data.to?.itinerary ?? [])[i].departure.time,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500, color: blackTextColor),
                                        ),
                                        Text((data.to?.itinerary ?? [])[i].departure.locationId)
                                      ],
                                    ),
                                  ),
                                Expanded(
                                  child: Divider(
                                    indent: 10,
                                    endIndent: 10,
                                    height: 1.h,
                                    color: primaryblue,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            width: 50.w,
                            child: Divider(
                              indent: 10,
                              endIndent: 10,
                              height: 1.h,
                              color: primaryblue,
                            ),
                          ),
                    Column(
                      children: [
                        Text(
                          (data.to?.itinerary ?? []).last.arrival.time,
                          style: TextStyle(fontWeight: FontWeight.w500, color: blackTextColor),
                        ),
                        Text((data.to?.itinerary ?? []).last.arrival.locationId)
                      ],
                    ),
                  ],
                ),
              ),
            ],
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primaryblue.withOpacity(0.5), borderRadius: BorderRadius.circular(5)),
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.from.itinerary.first.baggageInfo.join(',')),
                  Text(
                    '${pricing['price']} ${localizeCurrency(pricing['currency'])}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String handleFlightClass(String flightClass, BuildContext context) {
    switch (flightClass.toLowerCase().trim()) {
      case 'economy':
        {
          return AppLocalizations.of(context)?.economic ?? flightClass;
        }
      case 'business':
        {
          return AppLocalizations.of(context)?.business ?? flightClass;
        }

      default:
        {
          return flightClass;
        }
    }
  }
}
