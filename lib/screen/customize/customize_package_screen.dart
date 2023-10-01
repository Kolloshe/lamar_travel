// // ignore_for_file: avoid_print, avoid_unnecessary_containers, file_names

// import 'dart:convert';
// import 'dart:developer';

// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// import 'package:lamar_travel_packages/Assistants/assistantMethods.dart';
// import 'package:lamar_travel_packages/Datahandler/adaptive_texts_size.dart';
// import 'package:lamar_travel_packages/Datahandler/app_data.dart';
// import 'package:lamar_travel_packages/Model/cancelation-model.dart';

// import 'package:lamar_travel_packages/Model/customizpackage.dart';
// import 'package:lamar_travel_packages/config.dart';
// import 'package:lamar_travel_packages/screen/auth/login.dart';
// import 'package:lamar_travel_packages/screen/booking/checkout_information.dart';
// import 'package:lamar_travel_packages/screen/customize/activity/manageActivity.dart';
// import 'package:lamar_travel_packages/screen/customize/hotel/change-room.dart';
// import 'package:lamar_travel_packages/screen/customize/hotel/hotelcustomize.dart';
// import 'package:lamar_travel_packages/screen/customize/new-customize/new-customize-slider.dart';
// import 'package:lamar_travel_packages/screen/customize/new-customize/new-customize.dart';
// import 'package:lamar_travel_packages/screen/customize/transfer/transferCoustomize.dart';

// import 'package:lamar_travel_packages/screen/packages_screen.dart';
// import 'package:lamar_travel_packages/widget/contantsview.dart';
// import 'package:lamar_travel_packages/widget/currentstatebanar.dart';
// import 'package:lamar_travel_packages/widget/errordialog.dart';
// import 'package:lamar_travel_packages/widget/flight_details_from_customize.dart';
// import 'package:lamar_travel_packages/widget/footer.dart';

// import 'package:lamar_travel_packages/widget/image-spinnig.dart';

// import 'package:lamar_travel_packages/widget/mini-loader-widget.dart';
// import 'package:lamar_travel_packages/widget/show-roomdetails.dart';
// import 'package:lamar_travel_packages/widget/street-view.dart';
// import 'package:intl/intl.dart';
// import 'package:lamar_travel_packages/Model/customizpackage.dart' as room;

// import 'package:provider/provider.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// import '../main_screen1.dart';
// import 'flightcustomiz.dart';

// class CustomizePackage extends StatefulWidget {
//   const CustomizePackage({Key? key}) : super(key: key);
//   static String idScreen = 'packagecustomize';

//   @override
//   _CustomizePackageState createState() => _CustomizePackageState();
// }

// class _CustomizePackageState extends State<CustomizePackage> {
//   List actvitis = [];
//   String formatedcheckIn = '';
//   String formatedcheckOut = '';
//   late Customizpackage _customizpackage;
//   void loadcustompackage() async {
//     // print("loaded");
//     _customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;
//     // print(_customizpackage.result.hotels[0].name);
//     try {
//       _customizpackage.result.activities.forEach((key, value) {
//         actvitis.addAll(value);
//       });
//     } catch (e) {
//       actvitis.add(Activity(
//           name:
//               'There are no activities in your holiday package, please click + button to add activities.',
//           searchId: '0',
//           code: '0',
//           activityId: '0',
//           modalityCode: '0',
//           modalityName: '0',
//           amountsFrom: [],
//           sellingCurrency: 'ADE',
//           netAmount: 0.0,
//           paybleCurency: "ADE",
//           modalityAmount: 0,
//           activityDate: DateTime.now(),
//           questions: [],
//           rateKey: "rateKey",
//           day: 0,
//           activityDateDisplay: "activityDateDisplay",
//           activityDestination: "activityDestination",
//           image: "image",
//           description: "description",
//           prebook: 1,
//           images: []));
//     }

//     print(actvitis.length);

//     DateTime checkIn = _customizpackage.result.hotels[0].checkIn;
//     DateTime checkOut = _customizpackage.result.hotels[0].checkOut;

//     formatedcheckIn = DateFormat('yyyy-MM-dd').format(checkIn);
//     formatedcheckOut = DateFormat('yyyy-MM-dd').format(checkOut);

//     // print(formatedcheckIn);
//     // print(formatedcheckOut);
//   }

//   bool isLogin = false;

//   getlogin() {
//     if (fullName == '') {
//       isLogin = false;
//     } else {
//       isLogin = true;
//     }
//   }

//   @override
//   void initState() {
//     loadcustompackage();
//     getlogin();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => PackagesScreen()));
//         return Future.value(true);
//       },
//       child: Container(
//         color: cardcolor,
//         child: SafeArea(
//           child: Scaffold(
//             appBar: AppBar(
//               leading: GestureDetector(
//                   onTap: () {
//                     Navigator.of(context)
//                         .pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
//                   },
//                   child: Icon(
//                     Icons.keyboard_arrow_left,
//                     size: 35,
//                     color: primaryblue,
//                   )),
//               title: Text(
//                 'Plan your trip To ${_customizpackage.result.toCity}\n${_customizpackage.result.packageName}',
//                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//               ),
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) => CustomizeSlider()));
//                     },
//                     icon: Icon(Icons.ac_unit)),
//               ],
//               backgroundColor: cardcolor,
//               centerTitle: true,
//               elevation: 1.0,
//             ),
//             // appbar(context, ''),
//             backgroundColor: background,
//             body: SingleChildScrollView(
//               child: Container(
//                 color: background,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Row(children: [
//                     //   SizedBox(child: Row(children: [
//                     //     Icon(Icons.keyboard_arrow_left,size: 25,color: primaryblue,),
//                     //     Text('Back',style: TextStyle(color: primaryblue,fontWeight: FontWeight.w600), ),
//                     //   ],),),
//                     //   SizedBox(width: 2,),
//                     //   Padding(
//                     //   padding: const EdgeInsets.all(8.0),
//                     //   child: Text(
//                     //     'Plan your trip To ${_customizpackage.result.toCity}',
//                     //     textAlign: TextAlign.justify ,
//                     //     style: TextStyle(

//                     //       fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 35),fontWeight: FontWeight.bold
//                     //     ),
//                     //   ),
//                     // ),
//                     // ],),

//                     //   currentState('Customize', context, CustomizePackage.idScreen),

//                     // Padding(
//                     //   padding: const EdgeInsets.all(8.0),
//                     //   child: Text(
//                     //     '${_customizpackage.result.toCity}',
//                     //     style: TextStyle(
//                     //       fontSize: 18,
//                     //     ),
//                     //   ),
//                     // ),

//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       color: cardcolor,
//                       child: _customizpackage.result.noflight == true
//                           ? Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                     padding: EdgeInsets.all(10),
//                                     child: Text(
//                                       'Flights',
//                                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                     )),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.95,
//                                     child: OutlinedButton(
//                                       onPressed: () async {
//                                         Navigator.pushNamed(context, MiniLoader.idScreen);

//                                         String customizeId =
//                                             Provider.of<AppData>(context, listen: false)
//                                                 .packagecustomiz
//                                                 .result
//                                                 .customizeId;

//                                         try {
//                                           await AssistantMethods.sectionManager(context,
//                                               action: 'add', section: 'flight', cusID: customizeId);
//                                           Navigator.of(context).pop();
//                                           setState(() {
//                                             _customizpackage =
//                                                 Provider.of<AppData>(context, listen: false)
//                                                     .packagecustomiz;
//                                           });
//                                         } catch (e) {
//                                           Navigator.pop(context);
//                                           Errordislog().error(context, e.toString());
//                                         }
//                                       },
//                                       child: Text('Add Flight'),
//                                       style: OutlinedButton.styleFrom(
//                                           primary: greencolor,
//                                           side: BorderSide(color: greencolor, width: 1)),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//                           : Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text(
//                                     'Flights',
//                                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     '${DateFormat('EEEE').format(_customizpackage.result.flight!.from.departureFdate)}, ${_customizpackage.result.flight!.from.departureDate}',
//                                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   child: Row(
//                                     children: [
//                                       CachedNetworkImage(
//                                         imageUrl: _customizpackage
//                                             .result.flight!.from.itinerary[0].company.logo,
//                                         height: 60,
//                                         width: 100,
//                                         fit: BoxFit.cover,
//                                         placeholder: (context, url) => Center(
//                                             child: ImageSpinning(
//                                           withOpasity: true,
//                                         )),
//                                         errorWidget: (context, url, error) => Image.asset(
//                                           'assets/images/image-not-available.png',
//                                           height: 60,
//                                           width: 100,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Text(
//                                         '  ${_customizpackage.result.flight!.from.carrierName}, ${_customizpackage.result.flight!.flightClass}',
//                                         style: TextStyle(
//                                             fontSize:
//                                                 AdaptiveTextSize().getadaptiveTextSize(context, 24),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.only(bottom: 20),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 '${_customizpackage.result.flight!.from.departureTime}',
//                                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                                             Text(
//                                               '${_customizpackage.result.flight!.from.departure}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         //  width: MediaQuery.of(context).size.width * 0.10,
//                                         child: Divider(
//                                           color: yellowColor,
//                                           thickness: 2,
//                                           endIndent: 0,
//                                           indent: 5,
//                                         ),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.topCenter,
//                                         child: _customizpackage.result.flight!.from.stops.isNotEmpty
//                                             ? Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   for (var i = 0;
//                                                       i <
//                                                           _customizpackage
//                                                               .result.flight!.to.stops.length;
//                                                       i++)
//                                                     _buildStops(
//                                                         flight: _customizpackage
//                                                             .result.flight!.from.itinerary[i])

//                                                   // Text(
//                                                   //   '●',
//                                                   //   style: TextStyle(
//                                                   //       color: yellowColor,
//                                                   //       fontWeight: FontWeight.bold,
//                                                   //       fontSize: 18),
//                                                   // ),
//                                                   // Text(
//                                                   //   _customizpackage
//                                                   //           .result.flight!.from.stops.isEmpty
//                                                   //       ? "0"
//                                                   //       : '${_customizpackage.result.flight!.from.stops[0]}',
//                                                   //   style: TextStyle(
//                                                   //     fontSize: 16,
//                                                   //     color: primaryblue,
//                                                   //     decorationThickness: 0.5,
//                                                   //   ),
//                                                   // ),
//                                                   // Text(
//                                                   //   _customizpackage.result.flight!.from.travelTime,
//                                                   //   style: TextStyle(
//                                                   //     fontSize: 16,
//                                                   //     color: primaryblue,
//                                                   //     decorationThickness: 0.5,
//                                                   //   ),
//                                                   // ),
//                                                 ],
//                                               )
//                                             : Container(
//                                                 width: MediaQuery.of(context).size.width * 0.18,
//                                                 child: Divider(
//                                                   color: yellowColor,
//                                                   thickness: 2,
//                                                   endIndent: 0,
//                                                   indent: 0,
//                                                 ),
//                                               ),
//                                       ),
//                                       Expanded(
//                                         // width: MediaQuery.of(context).size.width * 0.10,
//                                         child: Divider(
//                                           color: yellowColor,
//                                           thickness: 2,
//                                           endIndent: 10,
//                                           indent: 0,
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(bottom: 20),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 '${_customizpackage.result.flight!.from.arrivalTime}',
//                                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                                             Text(
//                                               '${_customizpackage.result.flight!.from.arrival}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(left: 5),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               '${_customizpackage.result.flight!.from.itinerary[0].numstops} stop',
//                                               style: TextStyle(
//                                                   fontSize: AdaptiveTextSize()
//                                                       .getadaptiveTextSize(context, 20)),
//                                             ),
//                                             Container(
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset('assets/images/moon.png'),
//                                                   Text(
//                                                     '${_customizpackage.result.flight!.from.travelTime}',
//                                                     style: TextStyle(
//                                                         fontSize: AdaptiveTextSize()
//                                                             .getadaptiveTextSize(context, 20)),
//                                                   )
//                                                 ],
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   child: Center(
//                                     child: Divider(
//                                       color: Colors.black,
//                                       indent: 30,
//                                       endIndent: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     '${DateFormat('EEEE').format(_customizpackage.result.flight!.to.departureFdate)}, ${_customizpackage.result.flight!.to.arrivalDate}',
//                                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   child: Row(
//                                     children: [
//                                       CachedNetworkImage(
//                                         imageUrl: _customizpackage
//                                             .result.flight!.to.itinerary[0].company.logo,
//                                         height: 60,
//                                         width: 100,
//                                         fit: BoxFit.cover,
//                                         placeholder: (context, url) => Center(
//                                             child: ImageSpinning(
//                                           withOpasity: true,
//                                         )),
//                                         errorWidget: (context, url, error) => Image.asset(
//                                           'assets/images/image-not-available.png',
//                                           height: 60,
//                                           width: 100,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                       Text(
//                                         '  ${_customizpackage.result.flight!.to.carrierName}, ${_customizpackage.result.flight!.flightClass}',
//                                         style: TextStyle(
//                                             fontSize:
//                                                 AdaptiveTextSize().getadaptiveTextSize(context, 24),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 5),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.only(bottom: 20),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 '${_customizpackage.result.flight!.to.departureTime}',
//                                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                                             Text(
//                                               ' ${_customizpackage.result.flight!.to.departure}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         //     width: MediaQuery.of(context).size.width * 0.18,
//                                         child: Divider(
//                                           color: yellowColor,
//                                           thickness: 2,
//                                           endIndent: 0,
//                                           indent: 5,
//                                         ),
//                                       ),
//                                       Container(
//                                         child: _customizpackage.result.flight!.to.stops.isNotEmpty
//                                             ? Row(
//                                                 mainAxisAlignment: MainAxisAlignment.end,
//                                                 children: [
//                                                   for (var i = 0;
//                                                       i <
//                                                           _customizpackage
//                                                               .result.flight!.to.stops.length;
//                                                       i++)
//                                                     _buildStops(
//                                                         flight: _customizpackage
//                                                             .result.flight!.to.itinerary[i])
//                                                   // Text(
//                                                   //   '●',
//                                                   //   style: TextStyle(
//                                                   //       color: yellowColor,
//                                                   //       fontWeight: FontWeight.bold,
//                                                   //       fontSize: 18),
//                                                   // ),
//                                                   // Text(
//                                                   //   '${_customizpackage.result.flight!.to.stops[0]}',
//                                                   //   style: TextStyle(
//                                                   //     fontSize: 16,
//                                                   //     color: primaryblue,
//                                                   //     decorationThickness: 0.5,
//                                                   //   ),
//                                                   // ),
//                                                   // Text(
//                                                   //   _customizpackage.result.flight!.to.travelTime,
//                                                   //   style: TextStyle(
//                                                   //     fontSize: 16,
//                                                   //     color: primaryblue,
//                                                   //     decorationThickness: 0.5,
//                                                   //   ),
//                                                   // ),
//                                                 ],
//                                               )
//                                             : Container(
//                                                 width: MediaQuery.of(context).size.width * 0.18,
//                                                 child: Divider(
//                                                   color: yellowColor,
//                                                   thickness: 2,
//                                                   endIndent: 0,
//                                                   indent: 0,
//                                                 ),
//                                               ),
//                                       ),
//                                       Expanded(
//                                         //       width: MediaQuery.of(context).size.width * 0.18,
//                                         child: Divider(
//                                           color: yellowColor,
//                                           thickness: 2,
//                                           endIndent: 10,
//                                           indent: 0,
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(bottom: 20),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 '${_customizpackage.result.flight!.to.arrivalTime}',
//                                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                                             Text(
//                                               '${_customizpackage.result.flight!.to.arrival}',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(left: 5),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               '${_customizpackage.result.flight!.to.itinerary[0].numstops} stop',
//                                               style: TextStyle(
//                                                   fontSize: AdaptiveTextSize()
//                                                       .getadaptiveTextSize(context, 20)),
//                                             ),
//                                             Container(
//                                               child: Row(
//                                                 children: [
//                                                   Image.asset('assets/images/moon.png'),
//                                                   Text(
//                                                     '${_customizpackage.result.flight!.to.travelTime}',
//                                                     style: TextStyle(
//                                                         fontSize: AdaptiveTextSize()
//                                                             .getadaptiveTextSize(context, 20)),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Row(
//                                     children: [

//                                       OutlinedButton(
//                                         child: Text('Change Flight'),
//                                         onPressed: () async {
//                                           Navigator.pushNamed(context, MiniLoader.idScreen);

//                                           String customizeId =
//                                               Provider.of<AppData>(context, listen: false)
//                                                   .packagecustomiz
//                                                   .result
//                                                   .customizeId;
//                                           String flightclass =
//                                               Provider.of<AppData>(context, listen: false)
//                                                   .packagecustomiz
//                                                   .result
//                                                   .flight!
//                                                   .flightClass;
//                                           try {
//                                             await AssistantMethods.changeflight(
//                                                 customizeId,
//                                                 _customizpackage.result.flight!.flightClass,
//                                                 context);
//                                             Navigator.pop(context);
//                                             Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                 builder: (context) => FlightCustomize(),
//                                               ),
//                                             );
//                                           } catch (e) {
//                                             Navigator.pop(context);
//                                             Errordislog().error(context, e.toString());
//                                           }
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           primary: primaryblue,
//                                           side: BorderSide(color: primaryblue, width: 1),
//                                         ),
//                                       ),
//                                       VerticalDivider(
//                                         color: Colors.black,
//                                         indent: 8,
//                                         endIndent: 8,
//                                       ),
//                                       OutlinedButton(
//                                         child: Text('Flight Details'),
//                                         onPressed: () {
//                                           Navigator.of(context).pushNamed(FlightDetial.idScreen);
//                                           // Navigator.of(context).push(MaterialPageRoute(
//                                           //     builder: (context) => FlightDetial()));
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           primary: primaryblue,
//                                           side: BorderSide(color: primaryblue, width: 1),
//                                         ),
//                                       ),
                                
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   alignment: Alignment.center,
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.95,
//                                     child: OutlinedButton(
//                                       child: Text('Remove Flight'),
//                                       onPressed: () 
//                                       async {
//                                         bool willdelete = false;
//                                         await showDialog(
//                                             barrierDismissible: false,
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                                   title: Text('Confirm'),
//                                                   content: Text(
//                                                     'Are you sure you want to remove this service?',
//                                                     style: TextStyle(),
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = true;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text(
//                                                         'Remove',
//                                                         style: TextStyle(color: Colors.redAccent),
//                                                       ),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = false;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text('Cancel'),
//                                                     ),
//                                                   ],
//                                                 ));
//                                         if (willdelete == false) return;
//                                         Navigator.pushNamed(context, MiniLoader.idScreen);

//                                         String customizeId =
//                                             Provider.of<AppData>(context, listen: false)
//                                                 .packagecustomiz
//                                                 .result
//                                                 .customizeId;

//                                         try {
//                                           await AssistantMethods.sectionManager(context,
//                                               action: 'remove',
//                                               section: 'flight',
//                                               cusID: customizeId);
//                                           Navigator.of(context).pop();
//                                           setState(() {
//                                             _customizpackage =
//                                                 Provider.of<AppData>(context, listen: false)
//                                                     .packagecustomiz;
//                                           });
//                                         } catch (e) {
//                                           Navigator.pop(context);
//                                           Errordislog().error(context, e.toString());
//                                         }
//                                       },
//                                       style: OutlinedButton.styleFrom(
//                                         primary: Colors.redAccent,
//                                         side: BorderSide(color: Colors.redAccent, width: 1),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),

//                     //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++HOTEL++++++++++++++++++++++++++++++++++++++++++++++++++++++

//                     Container(
//                       color: cardcolor,
//                       padding: EdgeInsets.all(8),
//                       child: _customizpackage.result.nohotels == true
//                           ? Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                     padding: EdgeInsets.all(10),
//                                     child: Text(
//                                       'Hotel',
//                                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                     )),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.95,
//                                     child: OutlinedButton(
//                                       onPressed: () 
                                      
//                                       async {
//                                         Navigator.pushNamed(context, MiniLoader.idScreen);

//                                         String customizeId =
//                                             Provider.of<AppData>(context, listen: false)
//                                                 .packagecustomiz
//                                                 .result
//                                                 .customizeId;

//                                         try {
//                                           await AssistantMethods.sectionManager(context,
//                                               action: 'add', section: 'hotel', cusID: customizeId);
//                                           Navigator.of(context).pop();
//                                           setState(() {
//                                             _customizpackage =
//                                                 Provider.of<AppData>(context, listen: false)
//                                                     .packagecustomiz;
//                                           });
//                                         } catch (e) {
//                                           Navigator.pop(context);
//                                           Errordislog().error(context, e.toString());
//                                         }
//                                       },
//                                       child: Text('Add Hotel'),
//                                       style: OutlinedButton.styleFrom(
//                                           primary: greencolor,
//                                           side: BorderSide(color: greencolor, width: 1)),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )
//                           : Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Hotel',
//                                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       CachedNetworkImage(
//                                           imageUrl: _customizpackage.result.hotels[0].image,
//                                           height: 150,
//                                           width: 150,
//                                           fit: BoxFit.cover,
//                                           placeholder: (context, url) => Center(
//                                                 child: ImageSpinning(
//                                                   withOpasity: true,
//                                                 ),
//                                               ),
//                                           errorWidget: (context, url, error) => Image.asset(
//                                                 'assets/images/image-not-available.png',
//                                                 height: 200,
//                                                 width: 150,
//                                                 fit: BoxFit.cover,
//                                               )),

//                                       // CachedNetworkImage(
//                                       //   imageUrl:
//                                       //       _customizpackage.result.hotels[0].image,
//                                       //   height: 200,
//                                       //   width: 150,
//                                       //   fit: BoxFit.cover,
//                                       //   imageBuilder: (context, url) => Container(
//                                       //     child: Image.network(
//                                       //       _customizpackage.result.hotels[0].image,
//                                       //       fit: BoxFit.cover,
//                                       //       height: 200,
//                                       //       width: 150,
//                                       //       errorBuilder: (BuildContext context,
//                                       //           Object exception,
//                                       //           StackTrace? stackTrace) {
//                                       //         return Image.asset(
//                                       //           'images/image-not-available.png',
//                                       //           height: 200,
//                                       //           width: 150,
//                                       //           fit: BoxFit.cover,
//                                       //         );
//                                       //       },
//                                       //     ),
//                                       //   ),
//                                       //   placeholder: (context, url) => Container(
//                                       //     child: CircularProgressIndicator(),
//                                       //   ),
//                                       // ),

//                                       // Image.asset(
//                                       //   'images/image.png',
//                                       //   height: 200,
//                                       //   width: 150,
//                                       //   fit: BoxFit.cover,
//                                       // ),
//                                       Container(
//                                         margin: EdgeInsets.all(10),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               width: MediaQuery.of(context).size.width * 0.45,
//                                               child: Text(
//                                                 '${_customizpackage.result.hotels[0].name}',
//                                                 style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 28),
//                                                     fontWeight: FontWeight.bold),
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 2,
//                                                 softWrap: false,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             Text(
//                                               '${_customizpackage.result.hotels[0].checkInText}, ${_customizpackage.result.hotels[0].checkOutText}',
//                                               style: TextStyle(
//                                                 fontSize: AdaptiveTextSize()
//                                                     .getadaptiveTextSize(context, 24),
//                                               ),
//                                               overflow: TextOverflow.ellipsis,
//                                               softWrap: false,
//                                               maxLines: 5,
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             SmoothStarRating(
//                                               rating: double.parse(
//                                                   _customizpackage.result.hotels[0].starRating),
//                                               isReadOnly: true,
//                                               color: yellowColor,
//                                               allowHalfRating: false,
//                                               borderColor: yellowColor,
//                                             ),
//                                             SizedBox(
//                                               height: 5,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 Navigator.of(context).push(MaterialPageRoute(
//                                                     builder: (context) => ContanintViwe(
//                                                           d: _customizpackage.result.hotels[0],
//                                                           body: _customizpackage
//                                                               .result.hotels[0].description,
//                                                           title: 'Hotel Details',
//                                                           urlImage: _customizpackage
//                                                               .result.hotels[0].image,
//                                                         )));
                                               
//                                               },
//                                               child: Text(
//                                                 'View Hotel Details',
//                                                 style: TextStyle(
//                                                   color: primaryblue,
//                                                   fontSize: AdaptiveTextSize()
//                                                       .getadaptiveTextSize(context, 24),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 Navigator.of(context).push(MaterialPageRoute(
//                                                     builder: (context) => StreetView(
//                                                           lat: double.parse(_customizpackage
//                                                               .result.hotels[0].latitude),
//                                                           lon: double.parse(_customizpackage
//                                                               .result.hotels[0].longitude),
//                                                         )));
//                                               },
//                                               child: Text(
//                                                 'Street View',
//                                                 style: TextStyle(
//                                                     color: primaryblue,
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 24)),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 4,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 // showModalBottomSheet<void>(
//                                                 //   context: context,
//                                                 //   builder:
//                                                 //       (BuildContext context) {
//                                                 //     return Container(
//                                                 //       height: 200,
//                                                 //       color: Colors.white,
//                                                 //       child: Center(
//                                                 //         child: Column(
//                                                 //           mainAxisAlignment:
//                                                 //               MainAxisAlignment
//                                                 //                   .start,
//                                                 //           mainAxisSize:
//                                                 //               MainAxisSize.min,
//                                                 //           children: <Widget>[
//                                                 //             Container(
//                                                 //               padding:
//                                                 //                   EdgeInsets
//                                                 //                       .all(3),
//                                                 //               height: 30,
//                                                 //               alignment:
//                                                 //                   Alignment
//                                                 //                       .topRight,
//                                                 //               child:
//                                                 //                   GestureDetector(
//                                                 //                       onTap:
//                                                 //                           () {
//                                                 //                         Navigator.pop(
//                                                 //                             context);
//                                                 //                       },
//                                                 //                       child:
//                                                 //                           Icon(
//                                                 //                         Icons
//                                                 //                             .cancel,
//                                                 //                         color:
//                                                 //                             primaryblue,
//                                                 //                       )),
//                                                 //             ),
//                                                 //             Padding(
//                                                 //               padding:
//                                                 //                   const EdgeInsets
//                                                 //                       .all(8.0),
//                                                 //               child: Row(
//                                                 //                 mainAxisAlignment:
//                                                 //                     MainAxisAlignment
//                                                 //                         .start,
//                                                 //                 crossAxisAlignment:
//                                                 //                     CrossAxisAlignment
//                                                 //                         .start,
//                                                 //                 children: [
//                                                 //                   ClipRRect(
//                                                 //                     borderRadius:
//                                                 //                         BorderRadius.circular(
//                                                 //                             15),
//                                                 //                     child:
//                                                 //                         CachedNetworkImage(
//                                                 //                       fit: BoxFit
//                                                 //                           .cover,
//                                                 //                       width:
//                                                 //                           100,
//                                                 //                       height:
//                                                 //                           150,
//                                                 //                       imageUrl: _customizpackage
//                                                 //                           .result
//                                                 //                           .hotels[
//                                                 //                               0]
//                                                 //                           .image,
//                                                 //                       placeholder:
//                                                 //                           (context, url) =>
//                                                 //                               ImageSpinning(
//                                                 //                         withOpasity:
//                                                 //                             true,
//                                                 //                       ),
//                                                 //                       errorWidget: (context,
//                                                 //                               url,
//                                                 //                               error) =>
//                                                 //                           Icon(Icons
//                                                 //                               .error),
//                                                 //                     ),
//                                                 //                   ),
//                                                 //                   Column(
//                                                 //                     mainAxisAlignment:
//                                                 //                         MainAxisAlignment
//                                                 //                             .start,
//                                                 //                     crossAxisAlignment:
//                                                 //                         CrossAxisAlignment
//                                                 //                             .start,
//                                                 //                     children: [
//                                                 //                       Row(
//                                                 //                         crossAxisAlignment:
//                                                 //                             CrossAxisAlignment.start,
//                                                 //                         children: [
//                                                 //                           Text(
//                                                 //                             ' Hotel: ',
//                                                 //                             style:
//                                                 //                                 TextStyle(fontWeight: FontWeight.bold, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 28)),
//                                                 //                           ),
//                                                 //                           SizedBox(
//                                                 //                             width:
//                                                 //                                 MediaQuery.of(context).size.width * 0.50,
//                                                 //                             child:
//                                                 //                                 Text(
//                                                 //                               _customizpackage.result.hotels[0].name,
//                                                 //                               style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30)),
//                                                 //                             ),
//                                                 //                           ),
//                                                 //                         ],
//                                                 //                       ),
//                                                 //                       SizedBox(
//                                                 //                         height:
//                                                 //                             3,
//                                                 //                       ),
//                                                 //                       Row(
//                                                 //                         crossAxisAlignment:
//                                                 //                             CrossAxisAlignment.start,
//                                                 //                         mainAxisAlignment:
//                                                 //                             MainAxisAlignment.start,
//                                                 //                         children: [
//                                                 //                           Text(
//                                                 //                             ' Room discrption: ',
//                                                 //                             style:
//                                                 //                                 TextStyle(fontWeight: FontWeight.bold, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 28)),
//                                                 //                           ),
//                                                 //                           SizedBox(
//                                                 //                             width:
//                                                 //                                 MediaQuery.of(context).size.width * 0.4,
//                                                 //                             child:
//                                                 //                                 Text(
//                                                 //                               _customizpackage.result.hotels[0].selectedRoom[0].name + '\n' + _customizpackage.result.hotels[0].selectedRoom[0].boardName,
//                                                 //                               style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30)),
//                                                 //                             ),
//                                                 //                           ),
//                                                 //                         ],
//                                                 //                       ),
//                                                 //                       SizedBox(
//                                                 //                         height:
//                                                 //                             2,
//                                                 //                       ),
//                                                 //                       // Text(' '+_customizpackage
//                                                 //                       //     .result
//                                                 //                       //     .hotels[0]
//                                                 //                       //     .selectedRoom
//                                                 //                       //     .boardName,style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30)),),
//                                                 //                     ],
//                                                 //                   ),
//                                                 //                 ],
//                                                 //               ),
//                                                 //             ),
//                                                 //           ],
//                                                 //         ),
//                                                 //       ),
//                                                 //     );
//                                                 //   },
//                                                 // );

//                                                 Navigator.of(context).push(MaterialPageRoute(
//                                                     builder: (context) => RoomDetails(
//                                                           hotel: _customizpackage.result.hotels[0],
//                                                         )));
//                                               },
//                                               child: Text(
//                                                 'Rooming Details',
//                                                 style: TextStyle(
//                                                   color: primaryblue,
//                                                   fontSize: AdaptiveTextSize()
//                                                       .getadaptiveTextSize(context, 24),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   child:
                                  
//                                    Row(
//                                     children: [
//                                       OutlinedButton(
//                                         child: Text('Change Hotel'),
//                                         onPressed: () async {
//                                           // print(formatedcheckIn);
//                                           // print(formatedcheckOut);
//                                           // print(_customizpackage.result.hotels[0].id);
//                                           // print(_customizpackage.result.hotels[0].starRating);
//                                           // print(_customizpackage.result.hotels[0].id);
//                                           // print(_customizpackage.result.customizeId);
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => MiniLoader()));

//                                           try {
//                                             await AssistantMethods.changehotel(context,
//                                                 customizeId: _customizpackage.result.customizeId,
//                                                 checkIn: formatedcheckIn,
//                                                 checkOut: formatedcheckOut,
//                                                 hId: _customizpackage.result.hotels[0].id,
//                                                 star: _customizpackage.result.hotels[0].starRating);
//                                             Navigator.of(context).pop();

//                                             Navigator.of(context)
//                                                 .pushNamed(HotelCustomize.idScreen);
//                                           } catch (e) {
//                                             Navigator.of(context).pop();
//                                             log(e.toString());
//                                             Errordislog().error(context, e.toString());
//                                           }
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           primary: primaryblue,
//                                           side: BorderSide(color: primaryblue, width: 1),
//                                         ),
//                                       ),
//                                       VerticalDivider(
//                                         color: Colors.black,
//                                         indent: 8,
//                                         endIndent: 8,
//                                       ),
//                                       OutlinedButton(
//                                         child: Text('Change Room'),
//                                         onPressed: () async {
//                                           Navigator.of(context).push(MaterialPageRoute(
//                                               builder: (context) => ChangeRoom(
//                                                     hotels: _customizpackage.result.hotels[0], index: i,
//                                                   )));
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////

//                                           // await showDialog(
//                                           //     context: context,
//                                           //     builder: (context) => Dialog(
//                                           //           backgroundColor: background,
//                                           //           child: Container(
//                                           //             padding: EdgeInsets.all(5),
//                                           //             child: Column(
//                                           //               children: [
//                                           //                 Container(
//                                           //                   color: cardcolor,
//                                           //                   width:
//                                           //                       MediaQuery.of(context).size.width,
//                                           //                   padding: EdgeInsets.all(20),
//                                           //                   child: Text(
//                                           //                     'Available Room',
//                                           //                     style: TextStyle(
//                                           //                         fontSize: AdaptiveTextSize()
//                                           //                             .getadaptiveTextSize(
//                                           //                                 context, 24),
//                                           //                         fontWeight: FontWeight.w700),
//                                           //                   ),
//                                           //                 ),
//                                           //                 Container(
//                                           //                   color: cardcolor,
//                                           //                   height:
//                                           //                       MediaQuery.of(context).size.height -
//                                           //                           200,
//                                           //                   child:

//                                           //                    ListView.builder(
//                                           //                       itemCount: _customizpackage
//                                           //                           .result.hotels[0].rooms.length,
//                                           //                       itemBuilder: (context, ind) {
//                                           //                         return Container(
//                                           //                           padding: EdgeInsets.all(5),
//                                           //                           child: Card(
//                                           //                             elevation: 2,
//                                           //                             child: Column(
//                                           //                               crossAxisAlignment:
//                                           //                                   CrossAxisAlignment
//                                           //                                       .start,
//                                           //                               mainAxisAlignment:
//                                           //                                   MainAxisAlignment
//                                           //                                       .center,
//                                           //                               children: [
//                                           //                                 Container(
//                                           //                                   alignment:
//                                           //                                       Alignment.topLeft,
//                                           //                                   child: Row(
//                                           //                                     mainAxisAlignment:
//                                           //                                         MainAxisAlignment
//                                           //                                             .spaceBetween,
//                                           //                                     crossAxisAlignment:
//                                           //                                         CrossAxisAlignment
//                                           //                                             .start,
//                                           //                                     children: [
//                                           //                                       Image.network(
//                                           //                                         _customizpackage
//                                           //                                             .result
//                                           //                                             .hotels[0]
//                                           //                                             .image,
//                                           //                                         width: 100,
//                                           //                                         height: 100,
//                                           //                                         fit: BoxFit.cover,
//                                           //                                       ),
//                                           //                                       Container(
//                                           //                                         margin: EdgeInsets
//                                           //                                             .all(5),
//                                           //                                         width: 140,
//                                           //                                         child: Column(
//                                           //                                           children: [
//                                           //                                             Text(
//                                           //                                               _customizpackage
//                                           //                                                   .result
//                                           //                                                   .hotels[
//                                           //                                                       0]
//                                           //                                                   .rooms[
//                                           //                                                       ind]
//                                           //                                                   .name,
//                                           //                                               overflow:
//                                           //                                                   TextOverflow
//                                           //                                                       .ellipsis,
//                                           //                                               maxLines: 3,
//                                           //                                               style: TextStyle(
//                                           //                                                   fontWeight:
//                                           //                                                       FontWeight
//                                           //                                                           .bold,
//                                           //                                                   fontSize: AdaptiveTextSize().getadaptiveTextSize(
//                                           //                                                       context,
//                                           //                                                       24)),
//                                           //                                             ),
//                                           //                                             Text(_customizpackage
//                                           //                                                 .result
//                                           //                                                 .hotels[0]
//                                           //                                                 .rooms[
//                                           //                                                     ind]
//                                           //                                                 .boardName),
//                                           //                                           ],
//                                           //                                         ),
//                                           //                                       ),
//                                           //                                     ],
//                                           //                                   ),
//                                           //                                 ),
//                                           //                                 Row(
//                                           //                                   mainAxisAlignment:
//                                           //                                       MainAxisAlignment
//                                           //                                           .spaceBetween,
//                                           //                                   children: [
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////
//                                           //                                     //////////////////////////////////////////////////////////////////////////////

//                                           //                                     ElevatedButton(
//                                           //                                       onPressed:
//                                           //                                           () async {
//                                           //                                         // Navigator.pushNamed(
//                                           //                                         //     context,
//                                           //                                         //     MiniLoader
//                                           //                                         //         .idScreen);

//                                           //                                         List<room.Room>
//                                           //                                             selectedroom =
//                                           //                                             [
//                                           //                                           _customizpackage
//                                           //                                               .result
//                                           //                                               .hotels[0]
//                                           //                                               .rooms[ind]
//                                           //                                         ];
//                                           //                                         print(selectedroom.toString());

//                                           //                                         PackageHotels
//                                           //                                             selectedHotile =
//                                           //                                             _customizpackage
//                                           //                                                 .result
//                                           //                                                 .hotels[0];

//                                           //                                         selectedHotile
//                                           //                                                 .selectedRoom =
//                                           //                                             selectedroom;
//                                           //                                         //  print(selectedHotile.selectedRoom?.toJson());
//                                           //                                         var w =
//                                           //                                             selectedHotile
//                                           //                                                 .toJson();
//                                           //                                         List x = [];
//                                           //                                         x.add(w);

//                                           //                                         Map<String,
//                                           //                                                 dynamic>
//                                           //                                             saveddata = {
//                                           //                                           "customizeId": Provider.of<
//                                           //                                                       AppData>(
//                                           //                                                   context,
//                                           //                                                   listen:
//                                           //                                                       false)
//                                           //                                               .packagecustomiz
//                                           //                                               .result
//                                           //                                               .customizeId,
//                                           //                                           "splitHotels":
//                                           //                                               x,
//                                           //                                           "currency":
//                                           //                                               "USD",
//                                           //                                           "language": "en"
//                                           //                                         };

//                                           //                                         String a =
//                                           //                                             jsonEncode(
//                                           //                                                 saveddata);
//                                           //                                         print(Provider.of<
//                                           //                                                     AppData>(
//                                           //                                                 context,
//                                           //                                                 listen:
//                                           //                                                     false)
//                                           //                                             .packagecustomiz
//                                           //                                             .result
//                                           //                                             .hotels[0]
//                                           //                                             .name);
//                                           //                                         await AssistantMethods
//                                           //                                             .saveHotel(a);
//                                           //                                         await AssistantMethods.updatethepackage(Provider.of<
//                                           //                                                     AppData>(
//                                           //                                                 context,
//                                           //                                                 listen:
//                                           //                                                     false)
//                                           //                                             .packagecustomiz
//                                           //                                             .result
//                                           //                                             .customizeId);
//                                           //                                         await AssistantMethods.updatehotelDetails(
//                                           //                                             Provider.of<AppData>(
//                                           //                                                     context,
//                                           //                                                     listen:
//                                           //                                                         false)
//                                           //                                                 .packagecustomiz
//                                           //                                                 .result
//                                           //                                                 .customizeId,
//                                           //                                             context);
//                                           //                                         // print(Provider.of<
//                                           //                                         //             AppData>(
//                                           //                                         //         context,
//                                           //                                         //         listen:
//                                           //                                         //             false)
//                                           //                                         //     .packagecustomiz
//                                           //                                         //     .result
//                                           //                                         //     .hotels[0]
//                                           //                                         //     .name);
//                                           //                                         // Navigator.of(
//                                           //                                         //         context)
//                                           //                                         //     .push(
//                                           //                                         //   MaterialPageRoute(
//                                           //                                         //     builder:
//                                           //                                         //         (context) =>
//                                           //                                         //             CustomizePackage(),
//                                           //                                         //   ),
//                                           //                                         // );
//                                           //                                       },
//                                           //                                       child:
//                                           //                                           Text('Select'),
//                                           //                                       style: ElevatedButton
//                                           //                                           .styleFrom(
//                                           //                                               fixedSize:
//                                           //                                                   Size(
//                                           //                                                       160,
//                                           //                                                       45),
//                                           //                                               primary:
//                                           //                                                   yellowColor),
//                                           //                                     ),
//                                           //                                     Container(
//                                           //                                       child: Row(
//                                           //                                         mainAxisAlignment:
//                                           //                                             MainAxisAlignment
//                                           //                                                 .end,
//                                           //                                         crossAxisAlignment:
//                                           //                                             CrossAxisAlignment
//                                           //                                                 .end,
//                                           //                                         children: [
//                                           //                                           Text(
//                                           //                                             _customizpackage
//                                           //                                                 .result
//                                           //                                                 .hotels[0]
//                                           //                                                 .rooms[
//                                           //                                                     ind]
//                                           //                                                 .type
//                                           //                                                 .toString(),
//                                           //                                             style: TextStyle(
//                                           //                                                 color: _customizpackage.result.hotels[0].rooms[ind].type
//                                           //                                                             .toString() ==
//                                           //                                                         '+'
//                                           //                                                     ? greencolor
//                                           //                                                     : Colors
//                                           //                                                         .red,
//                                           //                                                 fontSize:
//                                           //                                                     16,
//                                           //                                                 fontWeight:
//                                           //                                                     FontWeight
//                                           //                                                         .bold),
//                                           //                                           ),
//                                           //                                           Text(
//                                           //                                             ' ' +
//                                           //                                                 _customizpackage
//                                           //                                                     .result
//                                           //                                                     .hotels[
//                                           //                                                         0]
//                                           //                                                     .rooms[
//                                           //                                                         ind]
//                                           //                                                     .amountChange
//                                           //                                                     .toString(),
//                                           //                                             style: TextStyle(
//                                           //                                                 color: _customizpackage.result.hotels[0].rooms[ind].type
//                                           //                                                             .toString() ==
//                                           //                                                         '+'
//                                           //                                                     ? greencolor
//                                           //                                                     : Colors
//                                           //                                                         .red,
//                                           //                                                 fontSize:
//                                           //                                                     16,
//                                           //                                                 fontWeight:
//                                           //                                                     FontWeight
//                                           //                                                         .bold),
//                                           //                                           ),
//                                           //                                           Text(
//                                           //                                             _customizpackage
//                                           //                                                 .result
//                                           //                                                 .hotels[0]
//                                           //                                                 .rooms[
//                                           //                                                     ind]
//                                           //                                                 .sellingCurrency
//                                           //                                                 .toString(),
//                                           //                                             style: TextStyle(
//                                           //                                                 color: _customizpackage.result.hotels[0].rooms[ind].type
//                                           //                                                             .toString() ==
//                                           //                                                         '+'
//                                           //                                                     ? greencolor
//                                           //                                                     : Colors
//                                           //                                                         .red,
//                                           //                                                 fontSize:
//                                           //                                                     16,
//                                           //                                                 fontWeight:
//                                           //                                                     FontWeight
//                                           //                                                         .bold),
//                                           //                                           ),
//                                           //                                         ],
//                                           //                                       ),
//                                           //                                     ),
//                                           //                                   ],
//                                           //                                 )
//                                           //                               ],
//                                           //                             ),
//                                           //                           ),
//                                           //                         );
//                                           //                       }),

//                                           //                 ),
//                                           //               ],
//                                           //             ),
//                                           //           ),
//                                           //         ));

//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////
//                                           ///////////////////////////////////////////////////////////////////////////////////

//                                           print(_customizpackage.result.hotels[0].rooms.length);
//                                         },
//                                         style: OutlinedButton.styleFrom(
//                                           primary: primaryblue,
//                                           side: BorderSide(color: primaryblue, width: 1),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
                               
//                                 ),

//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   alignment: Alignment.center,
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.95,
//                                     child: OutlinedButton(
//                                       child: Text('Remove Hotel'),
//                                       onPressed: () 
                                      
//                                       async {
//                                         bool willdelete = false;
//                                         await showDialog(
//                                             barrierDismissible: false,
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                                   title: Text('Confirm'),
//                                                   content: Text(
//                                                     'Are you sure you want to remove this service?',
//                                                     style: TextStyle(),
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = true;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text(
//                                                         'Remove',
//                                                         style: TextStyle(color: Colors.redAccent),
//                                                       ),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = false;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text('Cancel'),
//                                                     ),
//                                                   ],
//                                                 ));
//                                         if (willdelete == false) return;
//                                         Navigator.pushNamed(context, MiniLoader.idScreen);

//                                         String customizeId =
//                                             Provider.of<AppData>(context, listen: false)
//                                                 .packagecustomiz
//                                                 .result
//                                                 .customizeId;

//                                         try {
//                                           await AssistantMethods.sectionManager(context,
//                                               action: 'remove',
//                                               section: 'hotel',
//                                               cusID: customizeId);
//                                           Navigator.of(context).pop();
//                                           setState(() {
//                                             _customizpackage =
//                                                 Provider.of<AppData>(context, listen: false)
//                                                     .packagecustomiz;
//                                           });
//                                         } catch (e) {
//                                           Navigator.pop(context);
//                                           Errordislog().error(context, e.toString());
//                                         }
//                                       },
//                                       style: OutlinedButton.styleFrom(
//                                         primary: Colors.redAccent,
//                                         side: BorderSide(color: Colors.redAccent, width: 1),
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                     ),

//                     //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++HOTEL END+++++++++++++++++++++++++++++++++++++++++++
//                     SizedBox(
//                       height: 15,
//                     ),
//                     //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ACTIVITY START+++++++++++++++++++++++++++++++

//                     Container(
//                       padding: EdgeInsets.all(8),
//                       color: cardcolor,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Activity',
//                             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.24,
//                             child: ListView.builder(
//                               itemCount: _customizpackage.result.activities.isNotEmpty
//                                   ? _customizpackage.result.activities.length
//                                   : 1,
//                               itemBuilder: (context, index) {
//                                 return _customizpackage.result.activities.isNotEmpty
//                                     ? Container(
//                                         margin: EdgeInsets.only(bottom: 5),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(right: 10),
//                                               width: 100,
//                                               height: 100,
//                                               child: CachedNetworkImage(
//                                                 imageUrl: actvitis[index].image,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) => Center(
//                                                     child: ImageSpinning(
//                                                   withOpasity: true,
//                                                 )),
//                                                 errorWidget: (context, url, error) => Image.asset(
//                                                   'assets/images/image-not-available.png',
//                                                   height: 200,
//                                                   width: 150,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),

//                                               //  CachedNetworkImage(
//                                               //   imageUrl: actvitis[index].image,
//                                               //   imageBuilder: (context, url) =>
//                                               //       Container(
//                                               //     child: Image.network(
//                                               //       actvitis[index].image,
//                                               //       fit: BoxFit.cover,
//                                               //       errorBuilder:
//                                               //           (BuildContext context,
//                                               //               Object exception,
//                                               //               StackTrace?
//                                               //                   stackTrace) {
//                                               //         return SvgPicture.asset(
//                                               //           'images/image-not-available.svg',
//                                               //         );

//                                               //         // Image.asset(
//                                               //         //   'images/image-not-available.svg',
//                                               //         //   fit: BoxFit.cover,
//                                               //         //   width: size.width * 0.4,
//                                               //         //   height: size.height * 0.3,
//                                               //         // );
//                                               //       },
//                                               //     ),
//                                               //   ),
//                                               //   placeholder: (context, url) =>
//                                               //       Container(
//                                               //     child: LoadingWidget(),
//                                               //   ),
//                                               //   errorWidget:
//                                               //       (context, erorr, x) =>
//                                               //           InkWell(
//                                               //     child: Container(
//                                               //       child: SvgPicture.asset(
//                                               //         'images/image-not-available.svg',
//                                               //         color: Colors.grey,
//                                               //       ),
//                                               //     ),
//                                               //   ),
//                                               // ),

//                                               // Image.network(
//                                               //   actvitis[index].image,
//                                               //   fit: BoxFit.cover,
//                                               //   errorBuilder: (BuildContext
//                                               //           context,
//                                               //       Object exception,
//                                               //       StackTrace? stackTrace) {
//                                               //     return SvgPicture.asset(
//                                               //       'images/image-not-available.svg',
//                                               //       color: Colors.grey,
//                                               //     );
//                                               //   },
//                                               // ),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 '${actvitis[index].name}',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 softWrap: false,
//                                                 maxLines: 3,
//                                                 style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 25)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     : Container(
//                                         margin: EdgeInsets.only(bottom: 5),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(right: 10),
//                                               width: 100,
//                                               height: 150,
//                                               child: Image.asset(
//                                                 'assets/images/image-not-available.png',
//                                                 color: Colors.grey,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Text(
//                                                 'There are no activities in your holiday package, please click + button to add activities.',
//                                                 overflow: TextOverflow.ellipsis,
//                                                 softWrap: false,
//                                                 maxLines: 3,
//                                                 style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 24)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                               },
//                             ),
//                           ),
//                           Container(
//                             color: cardcolor,
//                             child: Container(
//                               padding: EdgeInsets.all(8.0),
//                               child:
//                                Row(
//                                 children: [
//                                   OutlinedButton(
//                                     child: Text('Manage Activities'),
//                                     onPressed: () async {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (context) => ManageActivity()));

//                                       print('Tapped Manage Activities');
//                                     },
//                                     style: OutlinedButton.styleFrom(
//                                       primary: primaryblue,
//                                       side: BorderSide(color: primaryblue, width: 1),
//                                     ),
//                                   ),
//                                   VerticalDivider(
//                                     color: Colors.black,
//                                     indent: 8,
//                                     endIndent: 8,
//                                   ),

//                                   //Todo  ????/
//                                 ],
//                               ),
                            
//                             ),
//                           ),
//                           _customizpackage.result.activities.isNotEmpty
//                               ? Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   alignment: Alignment.center,
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width * 0.95,
//                                     child: 
//                                     OutlinedButton(
//                                       child: Text('Remove Activity'),
//                                       onPressed: ()
                                      
//                                        async {
//                                         bool willdelete = false;
//                                         await showDialog(
//                                             barrierDismissible: false,
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                                   title: Text('Confirm'),
//                                                   content: Text(
//                                                     'Are you sure you want to remove this service?',
//                                                     style: TextStyle(),
//                                                   ),
//                                                   actions: [
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = true;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text(
//                                                         'Remove',
//                                                         style: TextStyle(color: Colors.redAccent),
//                                                       ),
//                                                     ),
//                                                     TextButton(
//                                                       onPressed: () {
//                                                         willdelete = false;
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       child: Text('Cancel'),
//                                                     ),
//                                                   ],
//                                                 ));
//                                         if (willdelete == false) return;

//                                         await AssistantMethods.removeAllActivites(
//                                             _customizpackage.result.customizeId);
//                                         await AssistantMethods.updatehotelDetails(
//                                             _customizpackage.result.customizeId, context);
//                                         // print(_customizpackage.result.activities
//                                         //     .toString());
//                                         actvitis.clear();
//                                         setState(() {
//                                           loadcustompackage();
//                                         });
//                                       },
//                                       style: OutlinedButton.styleFrom(
//                                         primary: Colors.redAccent,
//                                         side: BorderSide(color: Colors.redAccent, width: 1),
//                                       ),
//                                     ),
                               
//                                   ),
//                                 )
//                               : SizedBox(),
//                         ],
//                       ),
//                     ),

//                     // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ AVTIVITY END +++++++++++++++++++++++++++++
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRANSFER START +++++++++++++++++++++++++++++
//                     _customizpackage.result.transfer.isNotEmpty
//                         ? Container(
//                             width: MediaQuery.of(context).size.width,
//                             padding: EdgeInsets.all(10),
//                             color: cardcolor,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Transfer',
//                                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),

//                                 // ++++++++++++++++++++++++++++++++++++++++TO HOTEL+++++++++++++++++++++++++++
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           'To hotel',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               fontSize: AdaptiveTextSize()
//                                                   .getadaptiveTextSize(context, 25)),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                         child:
                                        
//                                          Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             CachedNetworkImage(
//                                                 imageUrl: _customizpackage.result.transfer[0].image,
//                                                 height: 120,
//                                                 width: 120,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) => Center(
//                                                         child: ImageSpinning(
//                                                       withOpasity: true,
//                                                     )),
//                                                 errorWidget: (context, url, error) => Image.asset(
//                                                       'assets/images/image-not-available.png',
//                                                       height: 150,
//                                                       width: 120,
//                                                       fit: BoxFit.cover,
//                                                     )),

                                 
//                                             Container(
//                                               width: MediaQuery.of(context).size.width * 0.58,
//                                               padding: EdgeInsets.all(5),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     'Date',
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight.w600,
//                                                         fontSize: AdaptiveTextSize()
//                                                             .getadaptiveTextSize(context, 25)),
//                                                   ),
//                                                   Text(
//                                                     _customizpackage.result.transfer[0].date,
//                                                     style: TextStyle(
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 23),
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 3,
//                                                     softWrap: false,
//                                                   ),
//                                                   Text(
//                                                     'Pick-Up',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.w600,
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 25),
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 3,
//                                                     softWrap: false,
//                                                   ),
//                                                   Text(
//                                                     _customizpackage
//                                                         .result.transfer[0].pickUpLocation,
//                                                     style: TextStyle(
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 23),
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 3,
//                                                     softWrap: false,
//                                                   ),
//                                                   Text(
//                                                     'Drop-off',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.w600,
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 25),
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 3,
//                                                     softWrap: false,
//                                                   ),
//                                                   Text(
//                                                     _customizpackage
//                                                         .result.transfer[0].dropOffLocation,
//                                                     style: TextStyle(
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 23),
//                                                     ),
//                                                     overflow: TextOverflow.ellipsis,
//                                                     maxLines: 3,
//                                                     softWrap: false,
//                                                   ),
//                                                   SizedBox(
//                                                     height: 20,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
                                   
                                   
//                                       ),
//                                       Container(
//                                         width: MediaQuery.of(context).size.width,
//                                         padding: EdgeInsets.symmetric(horizontal: 10),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             OutlinedButton(
//                                               child: Text('Change Car'),
//                                               onPressed: () async {
//                                                 Navigator.of(context)
//                                                     .pushNamed(MiniLoader.idScreen);
//                                                 await AssistantMethods.changeTransfer(
//                                                     _customizpackage.result.customizeId,
//                                                     'IN',
//                                                     context);
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).push(MaterialPageRoute(
//                                                     builder: (context) => TransferCustomize()));
//                                               },
//                                               style: OutlinedButton.styleFrom(
//                                                 primary: primaryblue,
//                                                 side: BorderSide(color: primaryblue, width: 1),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Divider(
//                                   color: Colors.black.withOpacity(0.50),
//                                   endIndent: 20,
//                                   indent: 20,
//                                 ),
//                                 // ++++++++++++++++++++++++++++++++++++++++TO AIRPORT+++++++++++++++++++++++++++
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'To airport',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: AdaptiveTextSize()
//                                                 .getadaptiveTextSize(context, 25)),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Container(
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [

//                                           CachedNetworkImage(
//                                               imageUrl: _customizpackage.result.transfer[1].image,
//                                               height: 120,
//                                               width: 120,
//                                               fit: BoxFit.cover,
//                                               placeholder: (context, url) => Center(
//                                                       child: ImageSpinning(
//                                                     withOpasity: true,
//                                                   )),
//                                               errorWidget: (context, url, error) => Image.asset(
//                                                     'assets/images/image-not-available.png',
//                                                     height: 150,
//                                                     width: 120,
//                                                     fit: BoxFit.cover,
//                                                   )),

                                          
//                                           Container(
//                                             width: MediaQuery.of(context).size.width * 0.58,
//                                             padding: EdgeInsets.all(10),
//                                             child: Column(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   'Date',
//                                                   style: TextStyle(
//                                                       fontWeight: FontWeight.w600,
//                                                       fontSize: AdaptiveTextSize()
//                                                           .getadaptiveTextSize(context, 25)),
//                                                 ),
//                                                 Text(
//                                                   _customizpackage.result.transfer[1].date,
//                                                   style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 23),
//                                                   ),
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 3,
//                                                   softWrap: false,
//                                                 ),
//                                                 Text(
//                                                   'Pick-Up',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 25),
//                                                   ),
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 3,
//                                                   softWrap: false,
//                                                 ),
//                                                 Text(
//                                                   _customizpackage
//                                                       .result.transfer[1].pickUpLocation,
//                                                   style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 23),
//                                                   ),
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 3,
//                                                   softWrap: false,
//                                                 ),
//                                                 Text(
//                                                   'Drop-off',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 25),
//                                                   ),
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 3,
//                                                   softWrap: false,
//                                                 ),
//                                                 Text(
//                                                   _customizpackage
//                                                       .result.transfer[1].dropOffLocation,
//                                                   style: TextStyle(
//                                                     fontSize: AdaptiveTextSize()
//                                                         .getadaptiveTextSize(context, 23),
//                                                   ),
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 3,
//                                                   softWrap: false,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 20,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
                                     
                                     
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width,
//                                       padding: EdgeInsets.symmetric(horizontal: 10),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           OutlinedButton(
//                                             child: Text('Change Car'),
//                                             onPressed: () async {
//                                               Navigator.of(context).pushNamed(MiniLoader.idScreen);
//                                               await AssistantMethods.changeTransfer(
//                                                   _customizpackage.result.customizeId,
//                                                   'OUT',
//                                                   context);
//                                               Navigator.of(context).pop();
//                                               Navigator.of(context).push(MaterialPageRoute(
//                                                   builder: (context) => TransferCustomize()));
//                                             },
//                                             style: OutlinedButton.styleFrom(
//                                               primary: primaryblue,
//                                               side: BorderSide(color: primaryblue, width: 1),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(
//                                   color: Colors.black.withOpacity(0.50),
//                                   endIndent: 20,
//                                   indent: 20,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: OutlinedButton(
//                                     child: Text('Remove Transfers'),
//                                     onPressed: ()
                                    
//                                      async {
//                                       Map<String, dynamic> saveddata = {
//                                         "customizeId": Provider.of<AppData>(context, listen: false)
//                                             .packagecustomiz
//                                             .result
//                                             .customizeId,
//                                         "transferType": 'out',
//                                         "sellingCurrency":
//                                             Provider.of<AppData>(context, listen: false)
//                                                 .packagecustomiz
//                                                 .result
//                                                 .sellingCurrency
//                                       };

//                                       var data = jsonEncode(saveddata);

//                                       await AssistantMethods.removeTransfer(data);

//                                       print(_customizpackage.result.customizeId);
//                                       await AssistantMethods.updatehotelDetails(
//                                           _customizpackage.result.customizeId, context);

//                                       loadcustompackage();
//                                       setState(() {});
//                                       print(_customizpackage.result.transfer.toString());
//                                     },
//                                     style: OutlinedButton.styleFrom(
//                                       primary: Colors.redAccent,
//                                       side: BorderSide(color: Colors.red.shade400, width: 1),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : Container(
//                             width: MediaQuery.of(context).size.width,
//                             padding: EdgeInsets.all(10),
//                             color: cardcolor,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Transfer',
//                                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: OutlinedButton(
//                                     child: Text('Add Transfer'),
//                                     onPressed: () 
                                    
//                                     async {
//                                       await AssistantMethods.updatethepackage(
//                                           _customizpackage.result.customizeId);
//                                       await AssistantMethods.updatehotelDetails(
//                                           _customizpackage.result.customizeId, context);

//                                       loadcustompackage();

//                                       if (_customizpackage.result.notransfer) {
//                                         displayTostmessage(context,true,
//                                             messeage: "We can,t add transfer to this package");
//                                       } else {
//                                         displayTostmessage(context,false,
//                                             messeage: "Transfer has been added");
//                                       }

//                                       setState(() {});
//                                     },
//                                     style: OutlinedButton.styleFrom(
//                                       primary: greencolor,
//                                       side: BorderSide(color: greencolor, width: 1),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
                   
//                     // +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ TRANSFER END +++++++++++++++++++++++++++++
//                     SizedBox(
//                       height: 10,
//                     ),

//                     //+++++++++++++++++++++++++++++++++++++++++++++++++++++GENARAL DETAILS START+++++++++++++++++++++++++++++++++++++++++++++++++++++
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding: EdgeInsets.all(10),
//                       color: cardcolor,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             '${_customizpackage.result.fromCity} to ${_customizpackage.result.toCity}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 35),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${_customizpackage.result.packageStart.day}.${_customizpackage.result.packageStart.month}.${_customizpackage.result.packageStart.year} - ${_customizpackage.result.packageEnd.day}.${_customizpackage.result.packageEnd.month}.${_customizpackage.result.packageEnd.year}',
//                             style: TextStyle(
//                                 fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             'Price for up to : ${_customizpackage.result.adults} adult',
//                             style: TextStyle(
//                                 fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                           ),
//                           TextButton(
//                             onPressed: () async {
//                               Canceliation? canceliation =
//                                   await AssistantMethods.getCancelationPrice(
//                                       currency: _customizpackage.result.sellingCurrency,
//                                       custoizeId: _customizpackage.result.customizeId,
//                                       packageId: _customizpackage.result.packageId);
//                               showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                         title: Text(
//                                             'Current cancellation amount is AED ${canceliation!.data.total}'),
//                                         content: Text(
//                                             'Above cancellation charge is applicable now and it may vary depending on the time of cancellation.'),
//                                         actions: [
//                                           TextButton(
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Text('close'))
//                                         ],
//                                       ));
//                             },
//                             child: Text(
//                               'Cancellation Policy',
//                               style: TextStyle(
//                                   fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                             ),
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               text: 'Price for :',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                               children: [
//                                 TextSpan(
//                                   text: '${_customizpackage.result.packageDays - 1} night',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize:
//                                           AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             '${_customizpackage.result.sellingCurrency} ${_customizpackage.result.totalAmount}',
//                             style: TextStyle(
//                                 color: greencolor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25)),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             'including: ${packagesIncluding(_customizpackage)}',
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 25),
//                                 wordSpacing: 1.5,
//                                 letterSpacing: 1),
//                           )
//                         ],
//                       ),
//                     ),
//                     //+++++++++++++++++++++++++++++++++++++++++++++++++++++GENARAL DETAILS END+++++++++++++++++++++++++++++++++++++++++++++++++++++
//                     SizedBox(
//                       height: 10,
//                     ),
//                     // Container(
//                     //     width: MediaQuery.of(context).size.width,
//                     //     // height: MediaQuery.of(context).size.height * 0.25,
//                     //     child: Footer()),
//                     SizedBox(
//                       height: 60,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             bottomSheet: 
            
            
//             Container(
//               padding: EdgeInsets.all(5),
//               height: 60,
//               color: cardcolor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       if (isLogin) {
//                         Provider.of<AppData>(context, listen: false).newPreBookTitle('Passengers');
//                         Navigator.pushNamed(context, CheckoutInformation.idScreen);
//                       } else {
//                         isFromBooking = true;
//                         Navigator.of(context).pushNamed(LoginScreen.idscreen);
//                       }
//                     },
//                     child: Text(
//                       "Continue To Checkout",
//                       style: TextStyle(
//                           fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: yellowColor,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           '${_customizpackage.result.sellingCurrency} ${_customizpackage.result.totalAmount}',
//                           style: TextStyle(
//                               color: greencolor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20)),
//                         ),
//                         Text(
//                           'TOTAL PACKAGE PRICE',
//                           style: TextStyle(
//                               color: greencolor,
//                               fontWeight: FontWeight.normal,
//                               fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20)),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
        
        
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStops({required Itinerary flight}) => Container(
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               alignment: Alignment.topCenter,
//               child: _customizpackage.result.flight!.from.stops.isNotEmpty
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           '●',
//                           style: TextStyle(
//                               color: yellowColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 40)),
//                         ),
//                         Text(
//                           '${flight.arrival.locationId}',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: primaryblue,
//                             decorationThickness: 0.5,
//                           ),
//                         ),
//                         Text(
//                           durationToString(flight.flightTime),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: primaryblue,
//                             decorationThickness: 0.5,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Container(
//                       width: MediaQuery.of(context).size.width * 0.18,
//                       child: Divider(
//                         color: yellowColor,
//                         thickness: 2,
//                         endIndent: 0,
//                         indent: 0,
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       );

//   String durationToString(int minutes) {
//     var d = Duration(minutes: minutes);
//     List<String> parts = d.toString().split(':');
//     return ' ${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
//   }

//   String packagesIncluding(Customizpackage customizePackage) {
//     String including = '';
//     String flight = '';
//     String hotel = '';
//     String activity = '';
//     String transffer = '';

//     if (customizePackage.result.noActivity == false) {
//       activity = 'Daily Tours+';
//     }
//     if (customizePackage.result.noflight == false) {
//       flight = 'Flight+';
//     }
//     if (customizePackage.result.nohotels == false) {
//       hotel = 'Hotel+';
//     }
//     if (customizePackage.result.notransfer == false) {
//       hotel = 'transfer+';
//     }

//     including = hotel + flight + transffer + activity;

//     if (including.endsWith('+')) {
//       including = including.substring(0, including.length - 1);
//     }

//     return including;
//   }
// }






// //{
// //"customizeId":"6120b74235d82e3f63477c73",
// //"transferType":"IN",
// //"currency":"AED"
// //}