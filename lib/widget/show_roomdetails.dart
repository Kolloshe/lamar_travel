// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoomDetails extends StatefulWidget {
  static String idScreen = 'RoomDetails';
  final PackageHotels hotel;

  const RoomDetails({Key? key, required this.hotel}) : super(key: key);

  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: cardcolor,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
            },
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: primaryblue,
              size: 30,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.roomDetails,
            style: TextStyle(color: Colors.black, fontSize: titleFontSize),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: size.height * 0.8,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: widget.hotel.selectedRoom.length,
            itemBuilder: (context, index) => RoomCard(
              size: size,
              hotel: widget.hotel,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  const RoomCard({Key? key, required this.size, required this.hotel, required this.index})
      : super(key: key);

  final Size size;
  final PackageHotels hotel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: SizedBox(
        width: 100.w,
        // height: 200.sp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: 35.w,
              height: 180.sp,
              fit: BoxFit.cover,
              imageUrl: hotel.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: 50.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.yourhotel} : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily:
                              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan'),
                      children: <TextSpan>[
                        TextSpan(
                            text: hotel.name,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: subtitleFontSize,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.021,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.room} : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily:
                              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan'),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${hotel.selectedRoom[index].name}\n${hotel.selectedRoom[index].roomTypeText ?? ''}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: subtitleFontSize,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.021,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.roomCategory} :',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize,
                          fontFamily:
                              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan'),
                      children: <TextSpan>[
                        TextSpan(
                            text: hotel.selectedRoom[index].boardName,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: subtitleFontSize,
                                fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan')),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.021,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.hotelFacilities} :',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                    ? 'Lato'
                                    : 'Bhaijaan'),
                      ),
                      for (var i = 0; i < hotel.facilities.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(hotel.facilities[i],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: subtitleFontSize,
                                  fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                          const Locale('en')
                                      ? 'Lato'
                                      : 'Bhaijaan')),
                        ),
                    ],
                  ),

                  SizedBox(height: 1.h),
                  Container(
                    width: 65.w,
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () async {
                         await AssistantMethods.getCancellationPolicyForRoom(context,
                            cusID: context.read<AppData>().packagecustomiz.result.customizeId,
                            currency: gencurrency,
                            rateKey: hotel.selectedRoom[index].rateKey);
                      },
                      child: Text(
                        'Cancellation policy',
                        style: TextStyle(fontSize: 12, color: primaryblue),
                      ),
                    ),
                  ),

                  // Wrap(
                  //   children: [

                  //     for (var i = 0; i < hotel.facilities.length; i++)
                  //       RichText(
                  //         text: TextSpan(
                  //           text: 'Facilities: ',
                  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  //           children: <TextSpan>[
                  //             TextSpan(
                  //                 text: hotel.facilities[i] + '\n',
                  //                 style: TextStyle(fontWeight: FontWeight.normal)),
                  //           ],
                  //         ),
                  //       ),
                  //   ],
                  // ),
                  //  ElevatedButton(onPressed: (){}, child: Text('Change the room'),style: ElevatedButton.styleFrom(primary: yellowColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
