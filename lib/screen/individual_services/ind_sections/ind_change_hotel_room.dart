// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:sizer/sizer.dart';

class IndChangeHotelRoom extends StatefulWidget {
  const IndChangeHotelRoom({Key? key, required this.data, required this.imageUrl})
      : super(key: key);
  final List<IndRoom> data;
  final String imageUrl;

  @override
  _IndChangeHotelRoomState createState() => _IndChangeHotelRoomState();
}

class _IndChangeHotelRoomState extends State<IndChangeHotelRoom> {
  List<IndRoom> data = [];

  @override
  void initState() {
    data = widget.data.map((e) => e).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        foregroundColor: blackTextColor,
        title: Text(
          AppLocalizations.of(context)!.availableRoom,
          style: TextStyle(
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [for (int i = 0; i < data.length; i++) _buildRoomCard(data[i])],
        ),
      ),
    );
  }

  Widget _buildRoomCard(IndRoom data) {
    return Container(
      height: 19.h,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            height: 17.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ImageSpinning(
                        withOpasity: true,
                      ),
                  errorWidget: (context, erorr, x) => Image.asset('assets/images/image.jpeg')),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildRoomDetailsTitle(AppLocalizations.of(context)!.name, data.name),
              _buildRoomDetailsTitle(AppLocalizations.of(context)!.roomCategory, data.boardName),
              _buildRoomDetailsTitle(AppLocalizations.of(context)!.price,
                  '${data.amount} ${localizeCurrency(data.sellingCurrency)}'),
              // SizedBox(height: 2.h),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primaryblue, fixedSize: Size(50.w, 3.h)),
                  onPressed: () {
                    displayTostmessage(context, false,
                        message: AppLocalizations.of(context)!.roomhasBeenChanged);
                    Navigator.of(context).pop(data);
                  },
                  child: Text(AppLocalizations.of(context)!.select))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoomDetailsTitle(String title, String information) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 20.w,
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
          SizedBox(width: 30.w, child: Text(information))
        ],
      );
}
