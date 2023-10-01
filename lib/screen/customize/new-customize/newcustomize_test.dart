// import 'dart:ui';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:lamar_travel_packages/Datahandler/app_data.dart';
// import 'package:lamar_travel_packages/Model/customizpackage.dart';
// import 'package:lamar_travel_packages/config.dart';
// import 'package:lamar_travel_packages/screen/auth/login.dart';
// import 'package:lamar_travel_packages/screen/booking/checkout_information.dart';
// import 'package:lamar_travel_packages/widget/image-spinnig.dart';
// import 'package:lamar_travel_packages/widget/pakageimage.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import 'new-customize.dart';

// class CustomizeWithNewSlider extends StatefulWidget {
//   const CustomizeWithNewSlider({Key? key}) : super(key: key);

//   @override
//   _CustomizeWithNewSliderState createState() => _CustomizeWithNewSliderState();
// }

// class _CustomizeWithNewSliderState extends State<CustomizeWithNewSlider> {
//   bool isLogin = false;

//   getlogin() {
//     if (fullName == '') {
//       isLogin = false;
//     } else {
//       isLogin = true;
//     }
//   }

//   late Customizpackage _customizpackage;

//   CarouselController buttonCarouselController = CarouselController();

//   ScrollController _controller = ScrollController();

//   void _scrollListener() {
//     final percent = _controller.position.pixels / MediaQuery.of(context).size.height;
//   }

//   @override
//   void initState() {
//     getlogin();
//     _customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;

//     _controller.addListener(_scrollListener);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_scrollListener);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double h = 100.h;
//     double w = 100.w;
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
           
//               SliverPersistentHeader(
//                   pinned: true,
//                   delegate: CustmizeHederDelegate(
//                     max: h - (kBottomNavigationBarHeight + 200),
//                     min: h / 7,
//                     builder: (percent) {
//                       final topPadding = MediaQuery.of(context).padding.top;
//                       final bottomPercent = (percent / .6).clamp(0.0, 1.0);

//                       final topPercent = ((1 - percent) / .9).clamp(0.0, 1.0);
//                       return Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           HeaderWidget(
//                               w: w,
//                               topPadding: topPadding,
//                               bottomPercent: bottomPercent,
//                               customizpackage: _customizpackage,
//                               buttonCarouselController: buttonCarouselController),
//                           Positioned(
//                             top: topPadding,
//                             left: -60 * (1 - bottomPercent),
//                             child: const BackButton(
//                               color: Colors.white,
//                             ),
//                           ),
//                           Positioned(
//                             top: lerpDouble(-100, 140, topPercent)!.clamp(topPadding + 10, 140),
//                             left: lerpDouble(100, 20, topPercent)!.clamp(20.0, 50.0),
//                             right: 20,
//                             child: AnimatedOpacity(
//                               duration: kThemeAnimationDuration,
//                               opacity: bottomPercent < 1 ? 0 : 1,
//                               child: Text(
//                                 _customizpackage.result.packageName,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: lerpDouble(0, 40, topPercent)!.clamp(20.0, 40.0),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   )),
            
            
//               SliverToBoxAdapter(
//                   child: Container(
//                 decoration:
//                     BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
//                 width: 100.w,
//                 child: Material(borderRadius: BorderRadius.circular(20), child: NewCustomizePage()),
//               ))
           
//             ],
//           )
//         ],
//       ),
//       bottomSheet: Container(
//         decoration: BoxDecoration(color: cardcolor, boxShadow: [shadow]),
//         padding: EdgeInsets.all(5),
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 if (isLogin) {
//                   Provider.of<AppData>(context, listen: false).newPreBookTitle('Passengers');
//                   Navigator.pushNamed(context, CheckoutInformation.idScreen);
//                 } else {
//                   isFromBooking = true;
//                   Navigator.of(context).pushNamed(LoginScreen.idscreen);
//                 }
//               },
//               child: Text(
//                 "Continue To Checkout",
//                 style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               style:
//                   ElevatedButton.styleFrom(primary: primaryblue.withOpacity(0.8), elevation: 0.0),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//               child: Consumer<AppData>(
//                 builder: (context, value, child) => Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '${value.packagecustomiz.result.sellingCurrency} ${value.packagecustomiz.result.totalAmount}',
//                       style:
//                           TextStyle(color: greencolor, fontWeight: FontWeight.bold, fontSize: 9.sp),
//                     ),
//                     Text(
//                       'TOTAL PACKAGE PRICE',
//                       style: TextStyle(
//                           color: greencolor, fontWeight: FontWeight.normal, fontSize: 9.sp),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HeaderWidget extends StatelessWidget {
//   const HeaderWidget({
//     Key? key,
//     required this.w,
//     required this.topPadding,
//     required this.bottomPercent,
//     required Customizpackage customizpackage,
//     required this.buttonCarouselController,
//   })  : _customizpackage = customizpackage,
//         super(key: key);

//   final double w;
//   final double topPadding;
//   final double bottomPercent;
//   final Customizpackage _customizpackage;
//   final CarouselController buttonCarouselController;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: w,

//       child: Padding(
//         padding: EdgeInsets.only(
//           top: (10 + topPadding) * (1 - bottomPercent),
//           bottom: 0,
//         ),
//         child: Transform.scale(
//           scale: lerpDouble(1, 1.3, bottomPercent)!,
//           child: _customizpackage.result.nohotels
//               ? ClipRRect(
//                   child: Image.asset(
//                     'assets/images/iconss/top.png',
//                     fit: BoxFit.cover,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 )
//               : ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: PlaceImagesPageView(
//                     imagesUrl: _customizpackage.result.hotels[0].imgAll.map((e) => e.src).toList(),
//                   )

//                   //  CachedNetworkImage(
//                   //   imageUrl: e.src.trimLeft(),
//                   //   fit: BoxFit.cover,
//                   //   placeholder: (context, url) => Container(
//                   //       child: ImageSpinning(
//                   //     withOpasity: true,
//                   //   )),
//                   //   errorWidget: (context, erorr, x) => Image.asset(
//                   //     'assets/images/image-not-available.png',
//                   //     fit: BoxFit.cover,
//                   //   ),
//                   // ),

//                   ),
//         ),
//       ),

//       //       Image.network(_customizpackage.result.hotels[0].image,fit: BoxFit.cover,),
//     );
//   }
// }

// class CustmizeHederDelegate extends SliverPersistentHeaderDelegate {
//   final double max;
//   final double min;
//   final Widget Function(double percent) builder;

//   CustmizeHederDelegate({
//     required this.max,
//     required this.min,
//     required this.builder,
//   });
//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return builder(shrinkOffset / max);
//   }

//   @override
//   double get maxExtent => max;

//   @override
//   double get minExtent => min;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
// }
