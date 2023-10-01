// import 'package:flutter/material.dart';
// import 'package:lamar_travel_packages/tabScreenController.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import '../Datahandler/adaptive_texts_size.dart';
// import '../config.dart';
// import '../screen/booking/checkout_information.dart';
// import '../screen/customize/activity/manageActivity.dart';
// import '../screen/customize/customizepackageScreen.dart';
// import '../screen/packages_screen.dart';

// Container currentState(String current, BuildContext context, String idScreen) {
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       // mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           onTap: () {
//             if (idScreen == 'packagecustomize') {
//               // pagenum = 1;
//               // tabController.jumpToTab(0);
//               // pushNewScreenWithRouteSettings(
//               //   context,
//               //   settings: RouteSettings(name: TabPage.idScreen),
//               //   screen: TabPage(),
//               //   withNavBar: true,
//               //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
//               // );
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   PackagesScreen.idScreen, (Route<dynamic> route) => false);
//             } else if (idScreen == 'HotelCustomize') {
//               Navigator.of(context).pushNamed(CustomizePackage.idScreen);
//             } else if (idScreen == 'FlightCustomize') {
//               Navigator.of(context).pushNamed(CustomizePackage.idScreen);
//             } else if (idScreen == 'ManageActivity') {
//               Navigator.of(context).pushNamed(CustomizePackage.idScreen);
//             } else if (idScreen == 'TransferCustomize') {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   CustomizePackage.idScreen, (Route<dynamic> route) => false);
//             } else if (idScreen == 'ActivityList') {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   ManageActivity.idScreen, (Route<dynamic> route) => false);
//             } else if (idScreen == 'CheckoutInformation') {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   CustomizePackage.idScreen, (Route<dynamic> route) => false);
//             } else if (idScreen == 'SumAndPay') {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   CheckoutInformation.idScreen, (Route<dynamic> route) => false);
//             } else if (idScreen == 'PdfScreen') {
//               Navigator.of(context).pop();
//             }
//             print(idScreen);
//           },
//           child: Container(
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.keyboard_arrow_left,
//                   color: primaryblue,
//                 ),
//                 Text(
//                   'Back',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: primaryblue,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//      idScreen=='packagecustomize'
//      ?SizedBox()
//      :   Container(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushNamedAndRemoveUntil(PackagesScreen.idScreen, (route) => false);
//                 },
//                 child: Container(
//                   child: Text(
//                     'Search',
//                     style: TextStyle(
//                         fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
//                         fontWeight: current == 'Search' ? FontWeight.bold : FontWeight.normal,
//                         decoration:
//                             current == 'Search' ? TextDecoration.underline : TextDecoration.none),
//                   ),
//                 ),
//               ),
//               Icon(Icons.keyboard_arrow_right),
//               Text(
//                 'Customize',
//                 style: TextStyle(
//                     fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
//                     fontWeight: current == 'Customize' ? FontWeight.bold : FontWeight.normal,
//                     decoration:
//                         current == 'Customize' ? TextDecoration.underline : TextDecoration.none,
//                     color: yellowColor),
//               ),
//               Icon(Icons.keyboard_arrow_right),
//               Text(
//                 'Book',
//                 style: TextStyle(
//                     fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
//                     fontWeight: current == 'Book' ? FontWeight.bold : FontWeight.normal,
//                     decoration: current == 'Book' ? TextDecoration.underline : TextDecoration.none),
//               ),
//               Icon(Icons.keyboard_arrow_right),
//               Text(
//                 'Checkout',
//                 style: TextStyle(
//                     fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20),
//                     fontWeight: current == 'Checkout' ? FontWeight.bold : FontWeight.normal,
//                     decoration:
//                         current == 'Checkout' ? TextDecoration.underline : TextDecoration.none),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
