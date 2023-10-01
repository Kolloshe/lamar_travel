
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/changehotel.dart' as model;
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config.dart';
import '../../packages_screen.dart';
import '../new-customize/new_customize.dart';

class ChangeRoomFromHotel extends StatefulWidget {
  const ChangeRoomFromHotel(
      {Key? key, required this.hotel, required this.oldHotelID, required this.i})
      : super(key: key);
  final model.ResponseHotel hotel;
  final String oldHotelID;
  final int i;

  @override
  _ChangeRoomFromHotelState createState() => _ChangeRoomFromHotelState();
}

class _ChangeRoomFromHotelState extends State<ChangeRoomFromHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.availableRoom,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
        backgroundColor: cardcolor,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale ==const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: primaryblue,
              size: 30,
            )),
      ),
      body: Padding(
        padding:const EdgeInsets.all(5),
        child: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: widget.hotel.rooms.length,
                    itemBuilder: (context, ind) {
                      return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var i = 0; i < widget.hotel.rooms[ind].length; i++)
                                Container(
                                  height: 230.sp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: cardcolor,
                                  ),
                                  margin:const EdgeInsets.only(bottom: 1),
                                  //    height: size.height*0.10,
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: widget.hotel.image,
                                            height: 230.sp,
                                            width: 40.w,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => const ImageSpinning(
                                              withOpasity: true,
                                            ),
                                            errorWidget: (context, erorr, x) => SvgPicture.asset(
                                                  'images/image-not-available.svg',
                                                  color: Colors.grey,
                                                )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          margin:const EdgeInsets.all(5),
                                          width: 45.w,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.hotel.rooms[ind][i].name,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: subtitleFontSize),
                                                ),
                                                widget.hotel.rooms[ind][i].roomTypeText == null
                                                    ? const SizedBox()
                                                    : SizedBox(height: 0.5.h),
                                                Text(widget.hotel.rooms[ind][i].roomTypeText ??
                                                    ''),
                                                SizedBox(height: 0.5.h),
                                                Text(
                                                  '${widget.hotel.rooms[ind][i].boardName}\n',
                                                  style: TextStyle(fontSize: detailsFontSize),
                                                ),

                                                Text(AppLocalizations.of(context)!
                                                    .hotelFacilities),
                                                Expanded(
                                                  child: ListView(
                                                    children: [
                                                      for (var i = 0;
                                                          i < widget.hotel.facilities.length;
                                                          i++)
                                                        RichText(
                                                          text: TextSpan(
                                                            text: '',
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: subtitleFontSize),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text:
                                                                      widget.hotel.facilities[i],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight.normal,
                                                                      fontSize: detailsFontSize)),
                                                            ],
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),

                                                //  Spacer(),
                                                //            widget.hotel.rooms[ind].length-1 ==i ?
                                                //        widget.hotel.rooms[ind][0].type=='-'?    Container(
                                                //   width: 100.w,
                                                //   alignment: Alignment.centerRight,
                                                //   child: Text(widget.hotel.rooms[ind][0].amountChange
                                                //       .toString()+' '+widget.hotel.rooms[ind][0].sellingCurrency,style: TextStyle(fontSize: subtitleFontSize ,decoration: TextDecoration.lineThrough,
                                                //           decorationColor: Colors.red),),
                                                // ):SizedBox():SizedBox(),
                                                Container(
                                                    alignment: Alignment.centerRight,
                                                    width: 100.w,
                                                    child: widget.hotel.rooms[ind].length - 1 == i
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.end,
                                                            children: [
                                                              Text(
                                                                '${AppLocalizations.of(context)!.packagePriceDifference} : ',
                                                                style: TextStyle(
                                                                    fontSize: subtitleFontSize,
                                                                    color: Colors.grey,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                              Text(
                                                                widget.hotel.rooms[ind][0].type
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: widget
                                                                                .hotel
                                                                                .rooms[ind][0]
                                                                                .type
                                                                                .toString() ==
                                                                            '+'
                                                                        ? Colors.red
                                                                        : greencolor,
                                                                    fontSize: subtitleFontSize,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Text(
                                                                '${widget.hotel.rooms[ind][0]
                                                                        .amountChange}',
                                                                style: TextStyle(
                                                                    color: widget
                                                                                .hotel
                                                                                .rooms[ind][0]
                                                                                .type
                                                                                .toString() ==
                                                                            '+'
                                                                        ? Colors.red
                                                                        : greencolor,
                                                                    fontSize: subtitleFontSize,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              Text(
                                                                ' ${localizeCurrency(widget
                                                                        .hotel
                                                                        .rooms[ind][0]
                                                                        .sellingCurrency
                                                                        .toString())}',
                                                                style: TextStyle(
                                                                    color: widget
                                                                                .hotel
                                                                                .rooms[ind][0]
                                                                                .type
                                                                                .toString() ==
                                                                            '+'
                                                                        ? Colors.red
                                                                        : greencolor,
                                                                    fontSize: subtitleFontSize,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox()),

                                                SizedBox(height: 1.h),
                                                Container(
                                                  width: 65.w,
                                                  alignment: Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                   await AssistantMethods
                                                          .getCancellationPolicyForRoom(context,
                                                              cusID: context
                                                                  .read<AppData>()
                                                                  .packagecustomiz
                                                                  .result
                                                                  .customizeId,
                                                              currency: gencurrency,
                                                              rateKey: widget
                                                                  .hotel.rooms[ind][i].rateKey);
                                                    },
                                                    child: Text(
                                                      'Cancellation policy',
                                                      style: TextStyle(
                                                          fontSize: 12, color: primaryblue),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 1.h),
                                                widget.hotel.rooms[ind].length - 1 == i
                                                    ? ElevatedButton(
                                                        onPressed: () async {
                                                          //  print(Provider.of<AppData>(context,listen: false).packagecustomiz.result.hotels[0].selectedRoom.length);
                                                          pressIndcatorDialog(context);
                                                          final jeybin = widget.hotel.rooms[ind];

                                                          //  selectedroom.addAll(hotles.response[index].rooms[ind]);

                                                          //  print(selectedroom[0].toString());
                                                          model.ResponseHotel selectedHotile =
                                                              widget.hotel;

                                                          // Map<String, dynamic> mohamed = {
                                                            // "id": widget.hotel.id,
                                                            // "selectedRoom": jeybin,
                                                          // };

                                                          //  {
                                                          //     "id": 636463,
                                                          //     "selectedRoom": {
                                                          //     	"rateKey":"20200121|20200124|W|164|8906|LOD.ST|ID_B2B_61|RO|B2C|1~1~0||N@04~~2568d~-816341790~N~~AE59E90AC1504A3157286591552602AASA000016101250014082568d",
                                                          //       "amount": 574,
                                                          //       "amountChange": 56,
                                                          //       "type": "-"
                                                          //     }
                                                          //}
                                                          //  selectedHotile.selectedRoom = selectedroom;
                                                          selectedHotile.selectedRoom = jeybin;

                                                     
                                                          //  print(selectedHotile.selectedRoom?.toJson());
                                                          var w = selectedHotile.toJson();

                                                          List splitHotelsReq = [];

                                                          splitHotelsReq.add(w);

                                                
                                                      
                                                          try {
                                                            Map<String, dynamic>
                                                                changesplithotel = {
                                                              "customizeId": Provider.of<AppData>(
                                                                      context,
                                                                      listen: false)
                                                                  .packagecustomiz
                                                                  .result
                                                                  .customizeId,
                                                              "hotelId":
                                                                  int.parse(widget.oldHotelID),
                                                              "newHotelId": widget.hotel.id,
                                                              "hotelKey": widget.i,
                                                              "selectedRoom": jeybin,
                                                              "currency": gencurrency,
                                                              "language": genlang
                                                            };

                                                            // Map<String, dynamic> saveddata = {
                                                              // "customizeId": Provider.of<AppData>(
                                                                      // context,
                                                                      // listen: false)
                                                                  // .packagecustomiz
                                                                  // .result
                                                                  // .customizeId,
                                                              // "splitHotels": [mohamed],
                                                              // "currency": gencurrency,
                                                              // "language": "en"
                                                            // };

                                                            // String a = jsonEncode(saveddata);

                                                            //   print(changesplithotel);

                                                            await AssistantMethods.newchangehotel(
                                                                context, changesplithotel);

                                                

                                                            if (Provider.of<AppData>(context,
                                                                    listen: false)
                                                                .isPreBookFailed) {
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                              displayTostmessage(context, false,
                                                                  message: AppLocalizations.of(
                                                                          context)!
                                                                      .hotelHasBeenChange);
                                                            } else {
                                                              displayTostmessage(context, false,
                                                                  message: AppLocalizations.of(
                                                                          context)!
                                                                      .hotelHasBeenChange);
                                                              Navigator.of(context)
                                                                  .pushNamedAndRemoveUntil(
                                                                      CustomizeSlider.idScreen,
                                                                      (route) => false);
                                                            }
                                                          } catch (e) {
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            fixedSize: Size(100.w, 10.sp), backgroundColor: yellowColor),
                                                        child: Text(
                                                            AppLocalizations.of(context)!.select),
                                                      )
                                                    : const SizedBox(),
                                              ]),
                                        ),
                                      ]),
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
