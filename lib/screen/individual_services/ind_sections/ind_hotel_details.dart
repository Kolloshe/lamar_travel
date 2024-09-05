// ignore_for_file: implementation_imports, import_of_legacy_library_into_null_safe, library_private_types_in_public_api, use_build_context_synchronously, unused_element

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/indv_packages_listing_model.dart';
import 'package:lamar_travel_packages/Model/room_cancellation_policy.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:provider/src/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

 import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../main_screen1.dart';

class IndHotelDetailsScreen extends StatefulWidget {
  const IndHotelDetailsScreen(
      {Key? key, required this.data, required this.id, required this.price, required this.cusID})
      : super(key: key);
  final IndHotelDetails data;
  final String id;
  final num price;
  final String cusID;

  @override
  _IndHotelDetailsScreenState createState() => _IndHotelDetailsScreenState();
}

class _IndHotelDetailsScreenState extends State<IndHotelDetailsScreen> {
  IndHotelDetails? data;
  bool isLogin = false;

  int roomLimit = 1, roomLeft = 1;
  int selectedRoomNum = 0;

  num price = 0;

  List<IndRoom?> defaultSelectedRoom = [];

  Map<String, dynamic> selectedRoomMap = {};

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  @override
  void initState() {
    data = widget.data;
    price = widget.price;
    roomLimit = data?.roomCounts.toInt() ?? 1;
    defaultSelectedRoom = List.generate(roomLimit, (index) => null);
    roomLeft = roomLimit;
    context.read<AppData>().setRoomLeft(roomLimit);
    getlogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        foregroundColor: blackTextColor,
        title: Text(AppLocalizations.of(context)?.hotelDetails ?? 'Hotel details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageView(),
                  SizedBox(height: 1.h),
                  SizedBox(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data!.name,
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
                        ),
                        IgnorePointer(
                          child: SmoothStarRating(
                              rating: double.parse(data?.starRating ?? '0'),
                           
                              borderColor: yellowColor,
                              color: yellowColor,
                              size: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  ReadMoreText(
                    data?.description ?? '',
                    trimLines: 4,
                    style: const TextStyle(),
                    textAlign: TextAlign.justify,
                    colorClickableText: Colors.pink,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  // Text(data?.description ?? '', style: TextStyle(), textAlign: TextAlign.justify),
                  SizedBox(height: 1.h),
                  const Divider(),
                  SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select your ${roomLimit > 1 ? 'Rooms' : 'Room'}',
                              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600)),
                        ],
                      )),
                  SizedBox(height: 1.h),
                  Wrap(
                    children: [
                      for (int i = 0; i < defaultSelectedRoom.length; i++)
                        _buildSelectedRoomCard(defaultSelectedRoom[i], i),
                    ],
                  )
                ])),
      ),
      bottomSheet: Container(
        width: 100.w,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 100.w,
                child: Column(
                  children: [
                    defaultSelectedRoom.contains(null)
                        ? const SizedBox()
                        : Text(!defaultSelectedRoom.contains(null)
                            ? '${AppLocalizations.of(context)!.totalP}: $price ${localizeCurrency(data!.currency)}'
                            : '${AppLocalizations.of(context)!.roomStartingFrom}: $price ${localizeCurrency(data!.currency)}'),
                  ],
                )),
            ElevatedButton(
              onPressed: () async {
                if (defaultSelectedRoom.contains(null)) {
                  displayTostmessage(context, false, message: 'Please select your rooms');
                  return;
                }
                data!.selectedRoom = [...defaultSelectedRoom.map((e) => e!).toList()];
                await makePreBook();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryblue, fixedSize: Size(90.w, 5.h)),
              child: Text(AppLocalizations.of(context)?.bookNow ?? 'Book now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedRoomCard(IndRoom? room, int index) {
    if (room == null) {
      return GestureDetector(
        onTap: () async {
          final selectedData = await showModalBottomSheet(
              context: context, builder: (context) => _buildShowRooms(defaultSelectedRoom[index]));
          if (selectedData != null) {
            defaultSelectedRoom[index] = selectedData as IndRoom;
            if (!defaultSelectedRoom.contains(null)) {
              data!.selectedRoom = [...defaultSelectedRoom.map((e) => e!).toList()];
              if (!mounted) return;
              await AssistantMethods.customizingPackage(context, widget.id);

              //Convert Ind selected Room to json
              final x = data!.selectedRoom.map((e) => e.toMap()).toList();

              //Convert json of ind selected room to old Selected room Object
              final d = List<Room>.from(x.map((x) => Room.fromJson(x)));

              //Make the Request  Object
              if (!mounted) return;
              Map<String, dynamic> selectedRoom = {
                "customizeId": context.read<AppData>().packagecustomiz.result.customizeId,
                "hotelId": context.read<AppData>().packagecustomiz.result.hotels.first.id,
                "hotelKey": 0,
                "selectedRoom": d,
                "currency": gencurrency,
                "language": genlang
              };

              await AssistantMethods.newChangeRoom(context, selectedRoom);
              if (!mounted) return;
              price = context.read<AppData>().packagecustomiz.result.totalAmount;
            }
            setState(() {});
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: primaryblue),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async {
          final selectedData = await showModalBottomSheet(
              context: context, builder: (context) => _buildShowRooms(defaultSelectedRoom[index]));
          if (selectedData != null) {
            defaultSelectedRoom[index] = selectedData as IndRoom;
            if (!defaultSelectedRoom.contains(null)) {
              data!.selectedRoom = [...defaultSelectedRoom.map((e) => e!).toList()];
              if (!mounted) return;
              await AssistantMethods.customizingPackage(context, widget.id);

              //Convert Ind selected Room to json
              final x = data!.selectedRoom.map((e) => e.toMap()).toList();

              //Convert json of ind selected room to old Selected room Object
              final d = List<Room>.from(x.map((x) => Room.fromJson(x)));

              //Make the Request  Object
              if (!mounted) return;
              Map<String, dynamic> selectedRoom = {
                "customizeId": context.read<AppData>().packagecustomiz.result.customizeId,
                "hotelId": context.read<AppData>().packagecustomiz.result.hotels.first.id,
                "hotelKey": 0,
                "selectedRoom": d,
                "currency": gencurrency,
                "language": genlang
              };
              log(d.first.boardName);
              log(d.first.amount.toString());
              await AssistantMethods.newChangeRoom(context, selectedRoom);
              if (!mounted) return;
              price = context.read<AppData>().packagecustomiz.result.totalAmount;
            }
            setState(() {});
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          width: 30.w,
          // height: 25.w,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryblue),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: data!.image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 0.5.h),
              SizedBox(
                child: Text(
                  '${room.name} ${room.boardName}',
                  style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildShowRooms(IndRoom? room) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                height: 1.h,
                width: 20.w,
                decoration: BoxDecoration(
                    color: primaryblue.withOpacity(0.5), borderRadius: BorderRadius.circular(20)),
              )),
          SizedBox(
            height: 1.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.availableRooms,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.sp)),
          ),
          SizedBox(
            height: 1.h,
          ),
          Expanded(
            child: ListView(
              children: [
                for (int i = 0; i < (data?.rooms.length ?? 0); i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(data?.rooms[i]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: room != null
                                  ? data!.rooms[i] == room
                                      ? Colors.green
                                      : Colors.transparent
                                  : Colors.transparent),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(1, 1)),
                          ],
                          borderRadius: BorderRadius.circular(5)),
                      width: 100.w,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 20.w,
                              height: 15.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: data!.image,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, erorr, x) => Image.asset(
                                      'assets/images/image.jpeg',
                                      fit: BoxFit.cover,
                                      width: 100.w,
                                      height: 40.h),
                                ),
                              )),
                          SizedBox(width: 1.h),
                          SizedBox(
                            child: Column(
                              children: [
                                _buildRoomDetailsTitle(AppLocalizations.of(context)!.name,
                                    '${data?.rooms[i].name ?? ''} \n${data?.rooms[i].roomTypeText ?? ''}'),
                                SizedBox(width: 50.w, child: const Divider()),
                                _buildRoomDetailsTitle(AppLocalizations.of(context)!.type,
                                    data?.rooms[i].boardName ?? ''),
                                const Divider(),
                                _buildRoomDetailsTitle(AppLocalizations.of(context)!.price,
                                    '${data?.rooms[i].amount.toString() ?? ''} ${localizeCurrency(data!.rooms[i].sellingCurrency)}'),
                                Container(
                                  width: 65.w,
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    onPressed: () async {
                                      final result =
                                          await AssistantMethods.getCancellationPolicyForRoom(
                                              context,
                                              cusID: context
                                                  .read<AppData>()
                                                  .packagecustomiz
                                                  .result
                                                  .customizeId,
                                              currency: gencurrency,
                                              rateKey: data!.rooms[i].rateKey);
                                      if (result != null) {
                                      } else {
                                        if (!mounted) return;
                                        displayTostmessage(context, false,
                                            message:
                                                "Canclation information is't available right now");
                                      }
                                    },
                                    child: Text(
                                      'Cancellation policy',
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      );

  Widget _buildRoomDetailsTitle(String title, String information) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 15.w,
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 9.sp),
                  )),
              SizedBox(
                  width: 50.w,
                  child: Text(information,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 9.sp)))
            ],
          ),
        ],
      );

  // Widget _buildRoomCard(IndRoom data, int index) => Container(
  //       padding: EdgeInsets.all(15),
  //       width: 100.w,
  //       height: 20.h,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         children: [
  //           _buildRoomDetailsTitle(AppLocalizations.of(context)!.name, data.name),
  //           _buildRoomDetailsTitle(AppLocalizations.of(context)!.roomCategory, data.boardName),
  //           _buildRoomDetailsTitle(AppLocalizations.of(context)!.price,
  //               data.amount.toString() + '' + localizeCurrency(data.sellingCurrency)),
  //           SizedBox(
  //               width: 30.w,
  //               child: InkWell(
  //                 child: Text('Select Room'),
  //                 onTap: () {
  //                   DoAction actions = DoAction.LIMIT;
  //
  //                   int initNum = selectedRoomMap.containsKey(index.toString())
  //                       ? selectedRoomMap[index.toString()]['number']
  //                       : 0;
  //
  //                   showModalBottomSheet(
  //                       context: context,
  //                       enableDrag: false,
  //                       isDismissible: false,
  //                       builder: (context) =>
  //                           StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
  //                             return Column(
  //                               children: [
  //                                 SizedBox(
  //                                   width: 100.w,
  //                                   height: 20.h,
  //                                   child: CachedNetworkImage(
  //                                     imageUrl: this.data!.imgAll[index].src,
  //                                     fit: BoxFit.cover,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   child: Text(data.name),
  //                                 ),
  //                                 SizedBox(
  //                                   child: Text(data.type),
  //                                 ),
  //                                 SizedBox(
  //                                   child: Text(data.amount.toString()),
  //                                 ),
  //                                 SizedBox(
  //                                   child: Text('you have $roomLimit Left'),
  //                                 ),
  //                                 SizedBox(
  //                                     child: MyFinalNumberPicker<int>(
  //                                   step: 1,
  //                                   maxValue: roomLimit,
  //                                   w: 1,
  //                                   onValue: (num v, action) {
  //                                     switch (action) {
  //                                       case DoAction.MINUS:
  //                                         actions = DoAction.MINUS;
  //                                         int roomLeft = this.roomLeft;
  //                                         if (selectedRoomMap.containsKey(index.toString())) {
  //                                           if (selectedRoomMap[index.toString()]['number'] > 1) {
  //                                             selectedRoomMap[index.toString()]['number'] =
  //                                                 v.toInt();
  //                                             roomLimit += 1;
  //                                           } else {
  //                                             selectedRoomMap.removeWhere(
  //                                                 (key, value) => key == index.toString());
  //                                             roomLimit += 1;
  //                                           }
  //                                           final x = selectedRoomMap.containsKey(index.toString())
  //                                               ? selectedRoomMap[index.toString()]['number'] as int
  //                                               : 0;
  //                                           int i = 0;
  //                                           final y = selectedRoomMap.values.toList();
  //                                           y.forEach((element) {
  //                                             i += (element['number'] as int);
  //                                           });
  //                                           roomLeft -= i;
  //                                           print(roomLeft);
  //                                         }
  //                                         break;
  //                                       case DoAction.ADD:
  //                                         actions = DoAction.ADD;
  //                                         selectedRoomMap.update(index.toString(),
  //                                             (value) => {"number": v.toInt(), "Room": data},
  //                                             ifAbsent: () => {"number": v.toInt(), "Room": data});
  //
  //                                         break;
  //                                       case DoAction.LIMIT:
  //                                         actions = DoAction.LIMIT;
  //                                         print('limit');
  //                                         break;
  //                                     }
  //                                     setState(() {});
  //                                     print('room limit =>' + roomLimit.toString());
  //                                     print(selectedRoomMap.toString());
  //                                   },
  //                                   minValue: 0,
  //                                   initialValue: initNum,
  //                                 )),
  //                                 ElevatedButton(
  //                                     onPressed: () {
  //                                       switch (actions) {
  //                                         case DoAction.MINUS:
  //                                           break;
  //                                         case DoAction.ADD:
  //                                           final x = selectedRoomMap.containsKey(index.toString())
  //                                               ? selectedRoomMap[index.toString()]['number'] as int
  //                                               : 0;
  //
  //                                           roomLimit -= x;
  //                                           break;
  //                                         case DoAction.LIMIT:
  //                                           break;
  //                                       }
  //                                       final q = selectedRoomMap.values.toList();
  //                                       final w = q.map((e) => e['number']).toList();
  //
  //                                       print(roomLimit.toString());
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                     child: Text('Select'))
  //                               ],
  //                             );
  //                           }));
  //                 },
  //               )),
  //
  //           //
  //           // GestureDetector(
  //           //   onTap: () async {
  //           //     final selectedRoom = await Navigator.of(context).push(MaterialPageRoute(
  //           //         builder: (context) => IndChangeHotelRoom(
  //           //               data: this.data!.rooms,
  //           //               imageUrl: this.data!.image,
  //           //             )));
  //           //
  //           //     if (selectedRoom != null) {
  //           //       this.data!..selectedRoom[index] = selectedRoom;
  //           //       setState(() {});
  //           //     }
  //           //   },
  //           //   child: Text(AppLocalizations.of(context)?.changeRoom ?? 'Change Room',
  //           //       style: TextStyle(color: primaryblue)),
  //           // ))
  //           //
  //           Divider(),
  //         ],
  //       ),
  //     );

  Widget _buildImageView() => Container(
        margin: const EdgeInsets.all(0),
        child: CarouselSlider(
          items: data!.imgAll
              .map(
                (e) => CachedNetworkImage(
                  imageUrl: e.src.trimLeft(),
                  imageBuilder: (context, url) => Container(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        e.src.trimLeft(),
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 40.h,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const ImageSpinning(
                    withOpasity: true,
                  ),
                  errorWidget: (context, erorr, x) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/images/image.jpeg',
                        fit: BoxFit.cover, width: 100.w, height: 40.h),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 30.h,
            viewportFraction: 0.9,
            aspectRatio: 4 / 3,
            initialPage: 0,
            autoPlay: false,
            // scrollPhysics: ScrollPhysics(parent: )
          ),
        ),
      );

  Future makePreBook() async {
    try {
      pressIndcatorDialog(context);
      if (Provider.of<AppData>(context, listen: false).isFromdeeplink) {
        await Future.delayed(const Duration(seconds: 2), () {
          if (!isLogin) {
            getlogin();
          }
        });
        Navigator.of(context).pop();
      }
      if (isLogin) {
        if (users.data.phone == '') {
          displayTostmessage(context, false,
              message: AppLocalizations.of(context)?.youAccountMissSomeInformation ??
                  "You account miss some information");
          Navigator.of(context)
            ..pop()
            ..push(MaterialPageRoute(
                builder: (context) => UserProfileInfomation(
                      isFromPreBook: true,
                    )));
        } else {
          Provider.of<AppData>(context, listen: false)
              .newPreBookTitle(AppLocalizations.of(context)!.passengersInformation);

          Provider.of<AppData>(context, listen: false).resetSelectedPassingerfromPassList();

          final cusData = await AssistantMethods.customizingPackage(context, widget.id);

          if (cusData == null) {
            Navigator.of(context).pop();
            return;
          }

          //Convert Ind selected Room to json
          final x = data!.selectedRoom.map((e) => e.toMap()).toList();

          //Convert json of ind selected room to old Selected room Object
          final d = List<Room>.from(x.map((x) => Room.fromJson(x)));

          //Make the Request  Object

          Map<String, dynamic> selectedRoom = {
            "customizeId": context.read<AppData>().packagecustomiz.result.customizeId,
            "hotelId": context.read<AppData>().packagecustomiz.result.hotels.first.id,
            "hotelKey": 0,
            "selectedRoom": d,
            "currency": gencurrency,
            "language": genlang
          };

          await AssistantMethods.newChangeRoom(context, selectedRoom);

          Navigator.of(context)
            ..pop()
            ..push(MaterialPageRoute(builder: (context) => PreBookStepper(isFromNavBar: true)));
        }
      } else {
        isFromBooking = true;
        Navigator.of(context).pop();
        await Navigator.of(context).pushNamed(NewLogin.idScreen);
        getlogin();
      }
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  String handleRoomDetailsTile(String title) {
    switch (title.toLowerCase().trim()) {
      case 'name':
        {
          return AppLocalizations.of(context)?.name ?? title;
        }
      case 'room type':
        {
          return AppLocalizations.of(context)?.type ?? title;
        }
      case 'price':
        {
          return AppLocalizations.of(context)?.price ?? title;
        }
      default:
        {
          return title;
        }
    }
  }

  _buildCancellationData(RoomCancellationPolicy result) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Dialog(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).maybePop();
                            },
                            child: Icon(Icons.cancel, color: primaryblue))),
                    Text(
                      'Cancellation Policy',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: primaryblue),
                    ),
                    SizedBox(height: 1.h),
                    for (int k = 0; k < result.data.length; k++)
                      Column(
                        children: [
                          Text(
                            'From ${result.data[k].fromDate} the cancellation amount will be ${result.data[k].amount.toString()} ${result.data[k].currency}',
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ));
  }
}
