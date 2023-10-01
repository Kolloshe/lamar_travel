// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../config.dart';
import '../new-customize/new_customize.dart';

class ChangeRoom extends StatefulWidget {
  const ChangeRoom({Key? key, required this.hotel, required this.index}) : super(key: key);

  final List<PackageHotels> hotel;

  final int index;

  @override
  _ChangeRoomState createState() => _ChangeRoomState();
}

class _ChangeRoomState extends State<ChangeRoom> {
  @override
  Widget build(BuildContext context) {
    PackageHotels hotels = widget.hotel[widget.index];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
            },
            child: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              size: 30,
              color: primaryblue,
            )),
        elevation: 1,
        backgroundColor: cardcolor,
        title: Text(
          AppLocalizations.of(context)!.availableRoom,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                // height: 83.h,
                // width: 100.w,
                child: ListView.builder(
                    itemCount: hotels.rooms.length,
                    itemBuilder: (context, ind) {
                      return Card(
                        elevation: 1,
                        shadowColor: Colors.black.withOpacity(0.4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i = 0; i < hotels.rooms[ind].length; i++)
                                Column(
                                  children: [
                                    Container(
                                      height: 155.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: cardcolor,
                                      ),
                                      margin: const EdgeInsets.only(bottom: 1),
                                      //    height: size.height*0.10,
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 35.w,
                                            child: CachedNetworkImage(
                                              imageUrl: hotels.image.trimLeft().trimRight(),
                                              height: 150.sp,
                                              width: 30.w,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => const Center(
                                                  child: ImageSpinning(
                                                withOpasity: true,
                                              )),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            width: 45.w,
                                            height: 180.sp,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  hotels.rooms[ind][i].name,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: subtitleFontSize,
                                                  ),
                                                ),
                                                Text(hotels.rooms[ind][i].roomTypeText ?? ''),
                                                SizedBox(height: 1.h),
                                                Text(
                                                  hotels.rooms[ind][i].boardName,
                                                  style: TextStyle(fontSize: detailsFontSize),
                                                ),
                                                SizedBox(height: 1.h),
                                                hotels.rooms[ind].length - 1 == i
                                                    ? Container(
                                                        width: 80.w,
                                                        alignment: Alignment.centerRight,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              '${AppLocalizations.of(context)!.packagePriceDifference}     ',
                                                              style: TextStyle(
                                                                  fontSize: subtitleFontSize,
                                                                  color: Colors.grey,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                            SizedBox(width: 1.w),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.end,
                                                              children: [
                                                                hotels.rooms[ind][i].amountChange ==
                                                                        0
                                                                    ? const SizedBox()
                                                                    : Text(
                                                                        hotels.rooms[ind][i].type
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color: hotels
                                                                                        .rooms[ind]
                                                                                            [i]
                                                                                        .type
                                                                                        .toString() ==
                                                                                    '+'
                                                                                ? greencolor
                                                                                : Colors.red,
                                                                            fontSize:
                                                                                subtitleFontSize,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                Text(
                                                                  hotels.rooms[ind][i].amountChange
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: hotels.rooms[ind][i]
                                                                                  .type
                                                                                  .toString() ==
                                                                              '+'
                                                                          ? greencolor
                                                                          : Colors.red,
                                                                      fontSize: subtitleFontSize,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                                Text(
                                                                  ' ${localizeCurrency(hotels.rooms[ind][i].sellingCurrency.toString())}',
                                                                  style: TextStyle(
                                                                      color: hotels.rooms[ind][i]
                                                                                  .type
                                                                                  .toString() ==
                                                                              '+'
                                                                          ? greencolor
                                                                          : Colors.red,
                                                                      fontSize: subtitleFontSize,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                hotels.rooms[ind].length - 1 == i
                                                    ? ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            pressIndcatorDialog(context);
                                                            // Navigator.pushNamed(
                                                            //     context, MiniLoader.idScreen);

                                                            String custID = Provider.of<AppData>(
                                                                    context,
                                                                    listen: false)
                                                                .packagecustomiz
                                                                .result
                                                                .customizeId;

                                                            List<Room> selectedroom = [
                                                              hotels.rooms[ind][i]
                                                            ];

                                                            Map<String, dynamic> selectedRoom = {
                                                              "customizeId": custID,
                                                              "hotelId": hotels.id,
                                                              "hotelKey": widget.index,
                                                              "selectedRoom": selectedroom,
                                                              "currency": gencurrency,
                                                              "language": genlang
                                                            };
                                                            //  final x = jsonEncode(selectedRoom);

                                                            await AssistantMethods.newChangeRoom(
                                                                context, selectedRoom);
                                                            if (!mounted) return;
                                                            displayTostmessage(context, false,
                                                                message:
                                                                    AppLocalizations.of(context)!
                                                                        .roomhasBeenChanged);
                                                            Navigator.of(context)
                                                                .pushNamedAndRemoveUntil(
                                                                    CustomizeSlider.idScreen,
                                                                    (route) => false);
                                                          } catch (e) {

                                                            Navigator.of(context)
                                                                .pushNamedAndRemoveUntil(
                                                                    CustomizeSlider.idScreen,
                                                                    (route) => false);
                                                          }

                                                          //   List<Room> selectedroom = [
                                                          //  hotels.rooms[ind][i]
                                                          //   ];
                                                          //   print(selectedroom.toString());

                                                          //   PackageHotels selectedHotile =
                                                          //   hotels;

                                                          //   selectedHotile.selectedRoom =
                                                          //       selectedroom;
                                                          //   //  print(selectedHotile.selectedRoom?.toJson());
                                                          //   var w = selectedHotile.toJson();
                                                          //   List x = [];
                                                          //   x.add(w);

                                                          //   Map<String, dynamic> saveddata = {
                                                          //     "customizeId": Provider.of<AppData>(
                                                          //             context,
                                                          //             listen: false)
                                                          //         .packagecustomiz
                                                          //         .result
                                                          //         .customizeId,
                                                          //     "splitHotels": x,
                                                          //     "currency": "USD",
                                                          //     "language": "en"
                                                          //   };

                                                          //   String a = jsonEncode(saveddata);
                                                          //   // print(Provider.of<AppData>(context, listen: false)
                                                          //   //     .packagecustomiz
                                                          //   //     .result
                                                          //   //     .hotels[0]
                                                          //   //     .name);
                                                          //   await AssistantMethods.saveHotel(
                                                          //       a, context);
                                                          //   // await AssistantMethods.updatethepackage(
                                                          //   //     Provider.of<AppData>(context,
                                                          //   //             listen: false)
                                                          //   //         .packagecustomiz
                                                          //   //         .result
                                                          //   //         .customizeId);
                                                          //   await AssistantMethods.updatehotelDetails(
                                                          //       Provider.of<AppData>(context,
                                                          //               listen: false)
                                                          //           .packagecustomiz
                                                          //           .result
                                                          //           .customizeId,
                                                          //       context);
                                                          //   // print(Provider.of<
                                                          //   //             AppData>(
                                                          //   //         context,
                                                          //   //         listen:
                                                          //   //             false)
                                                          //   //     .packagecustomiz
                                                          //   //     .result
                                                          //   //     .hotels[0]
                                                          //   //     .name);

                                                          //   //   MaterialPageRoute(
                                                          //   //     builder:
                                                          //   //         (context) =>
                                                          //   //             CustomizePackage(),
                                                          //   //   ),
                                                          //   // );
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(100.w, 3.h), backgroundColor: yellowColor),
                                                        child: Text(
                                                          AppLocalizations.of(context)!.select,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: subtitleFontSize),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hotels.rooms[ind].length - 1 == i
                                        ? const SizedBox()
                                        : const Divider(
                                            color: Colors.black26,
                                          )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
