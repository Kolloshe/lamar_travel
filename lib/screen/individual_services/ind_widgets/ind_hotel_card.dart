// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_sections/ind_hotel_details.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/widget/googlemap-dialog.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
 import '../../../widget/street_view.dart' as street;

class IndHotelCard extends StatefulWidget {
  const IndHotelCard({Key? key, required this.packageIndv, required this.id}) : super(key: key);
  final PackageIndv packageIndv;
  final String id;

  @override
  State<IndHotelCard> createState() => _IndHotelCardState();
}

class _IndHotelCardState extends State<IndHotelCard> {
  @override
  Widget build(BuildContext context) {
    final data = widget.packageIndv.hotelDetails;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade200, offset: const Offset(3, 3), spreadRadius: 2, blurRadius: 5)
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      width: 100.w,
      height: 40.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            height: 22.h,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: data!.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ImageSpinning(
                  withOpasity: true,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/image.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                    width: 100.w,
                    child: Text(
                      data.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                SizedBox(
                  height: 0.5.h,
                ),
                SizedBox(
                    width: 100.w,
                    child: Text(
                      data.address,
                      style: const TextStyle(color: Colors.grey),
                    )),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 60.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => GoogleMapDialog(
                                      lat: double.parse(data.latitude),
                                      lon: double.parse(data.longitude),
                                    ));
                          },
                          child: Text(
                            AppLocalizations.of(context)?.mapView ?? 'Map view',
                            style: TextStyle(color: primaryblue),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => street.StreetView(
                                      isfromHotel: false,
                                      isFromCus: false,
                                      lat: double.parse(data.latitude),
                                      lon: double.parse(data.longitude),
                                    )));
                          },
                          child: Text(
                            AppLocalizations.of(context)?.streetview ?? 'Street view',
                            style: TextStyle(color: primaryblue),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          AppLocalizations.of(context)?.roomStartingFrom ?? "Starting from",
                          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                        ),
                        Text(
                          '${widget.packageIndv.hotelDetails!.rateFrom} ${localizeCurrency(widget.packageIndv.sellingCurrency)}',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp),
                        )
                      ]),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          AppLocalizations.of(context)?.hotelStars ?? 'Stars',
                          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                        ),
                        Consumer<AppData>(
                            builder: (context, val, child) => IgnorePointer(
                              child: SmoothStarRating(
                                   rating: widget.packageIndv.hotelStar.toDouble(),
                                  size: 15,
                                  color: yellowColor,
                                  borderColor: yellowColor),
                            ))
                      ]),
                      ElevatedButton(
                          onPressed: () async {
                            await AssistantMethods.customizingPackage(
                                context, widget.packageIndv.id);
                            if (!mounted) return;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => IndHotelDetailsScreen(
                                    data: data,
                                    id: widget.id,
                                    price: widget.packageIndv.hotelDetails!.rateFrom,
                                    cusID: context
                                        .read<AppData>()
                                        .packagecustomiz
                                        .result
                                        .customizeId)));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryblue,
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                          child: Text(AppLocalizations.of(context)?.bookNow ?? 'Book Now'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
