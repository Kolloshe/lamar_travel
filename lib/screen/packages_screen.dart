// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'package:lamar_travel_packages/screen/customize/filtter_screen.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../Assistants/assistant_methods.dart';

import '../Datahandler/adaptive_texts_size.dart';
import '../Datahandler/app_data.dart';
import '../Model/mainsearch.dart';

import '../config.dart';

import '../widget/googlemap-dialog.dart';
import '../widget/image_spinnig.dart';
import '../widget/street_view.dart' as street;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:sizer/sizer.dart';
import 'main_screen1.dart';
import '../widget/errordialog.dart';

import '../widget/searchfrom.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'pacage_image_view.dart';

PageStorageBucket bucket = PageStorageBucket();
bool resetBucket = false;

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);
  static String idScreen = 'packages';

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> with SingleTickerProviderStateMixin {
  late MainSarchForPackage packages;

  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Animation<Offset> _animation2;
  bool isScrollingup = false;

  bool isload = false;
  List<Package> x = [];

  double sortContainerHeight = 30.0;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool check6 = false;
  bool check7 = false;
  bool check8 = false;
  bool check9 = false;
  bool check10 = false;

  bool vswitch = false;
  bool vs = true;

  String searchfrom = 'Where From ?';
  String searchTo = 'Where To ?';

  int selectedRadio = 0;
  int maxTotalpassenger = 8;
  bool chooseHotelAndAirline = false;
  bool child1 = false;
  bool child2 = false;
  bool child3 = false;
  bool child4 = false;
  bool child5 = false;
  bool child6 = false;
  bool child7 = false;
  bool chiledDivider = false;
  int childage0 = 1;
  int childage1 = 1;
  int childage2 = 1;
  int childage3 = 1;
  int childage4 = 1;
  int childage5 = 1;
  int childage6 = 1;
  int childage7 = 1;
  int childage8 = 1;
  String flightclass = 'Y';

  String selectedflightname = 'Search for Airline';
  String selectedflightcode = '';
  String selectedhotelname = 'Search for Hotel';
  String selectedhotelcode = '';

  List<int> chiledAgeLis = [];
  int rooms = 1;
  int adults = 1;
  int children = 0;

  bool isTopOfList = false;

  List<Package> packagesList = [];

  void resetbuckets() {
    resetBucket = true;
  }

  String claculateTheDiscount() {
    final num discount;
    final coins = Provider.of<AppData>(context, listen: false).userCollectedPoint * 10;
    switch (gencurrency.toLowerCase()) {
      case 'usd':
        discount = (coins / 3.67).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      //    'Congrats! You’ve got $discount $gencurrency ... discount! :)';
      case 'eur':
        discount = (coins / 4.03).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      case 'inr':
        discount = (coins * 20).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      case 'gbp':
        discount = (coins / 4.83).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      case 'kwd':
        discount = (coins / 12.09).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      case 'omr':
        discount = (coins / 9.55).round();
        return AppLocalizations.of(context)!.congratsYouVeGot(discount.toString(), gencurrency);
      default:
        return AppLocalizations.of(context)!.congratsYouVeGot(coins.toString(), gencurrency);
    }
  }

  void loadPackages() {
    // Provider.of<AppData>(context, listen: false).filter();

    packages = Provider.of<AppData>(context, listen: false).mainsarchForPackage;
    if (Provider.of<AppData>(context, listen: false).isMakeBudgetTuning) {
      packages.data.packages = packages.data.packages
          .where((element) =>
              element.total > 0 &&
              element.total <= Provider.of<AppData>(context, listen: false).maxBudget)
          .toList();
    }

    Provider.of<AppData>(context, listen: false).getsliderLimit(
        mins: packages.data.priceRange.min.toDouble(),
        maxs: packages.data.priceRange.max.toDouble());

    packagesList = Provider.of<AppData>(context, listen: false).ismakefilter
        ? Provider.of<AppData>(context, listen: false).packagefilter
        : packages.data.packages;

    try {
      _startDate = Provider.of<AppData>(context, listen: false).first;
      _endDate = Provider.of<AppData>(context, listen: false).sec;
    } catch (e) {
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(const Duration(days: 4));
    }
    firstdate = DateFormat('dd/MM/y').format(_startDate).toString();
    secdate = DateFormat('dd/MM/y').format(_endDate).toString();
    rooms = Provider.of<AppData>(context, listen: false).rooms;
    adults = Provider.of<AppData>(context, listen: false).adults;
    children = Provider.of<AppData>(context, listen: false).childrens;
  }

  double searchContainerheigth = 50;

  // double searchdetailsgeight = 80;
  double keepSizebetween = 0.0;
  final _scrollController = ScrollController();
  Timer? _timer;
  bool isloadedonce = false;

  int seclectedcurrncy = currencyapi.indexOf(gencurrency);

  Widget buidChangeCurrncy() => Container(
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: 100.w,
        height: 90.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 60.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.close,
                        style: TextStyle(color: primaryblue),
                      )),
                  Text(
                    AppLocalizations.of(context)!.currency,
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100.w,
              height: 48.h,
              child: ListView.separated(
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: false,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: currencyapi.length,
                  itemBuilder: (context, i) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () async {
                          gencurrency = currencyapi[i];
                          try {
                            pressIndcatorDialog(context);

                            // Navigator.pushNamed(context, MiniLoader.idScreen);
                            await AssistantMethods.changeCurranceylanguage(
                                context, {"currency": gencurrency}, 'currency');
                            if (!mounted) return;
                            await AssistantMethods.updatePakagewithcurruncy(
                                Provider.of<AppData>(context, listen: false)
                                    .mainsarchForPackage
                                    .data
                                    .packageId,
                                context);
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed(PackagesScreen.idScreen);
                          } catch (e) {
                            pressIndcatorDialog(context);
                            pressIndcatorDialog(context);

                            //   Navigator.pushNamed(context, MiniLoader.idScreen);
                            await AssistantMethods.updatePakagewithcurruncy(
                                Provider.of<AppData>(context, listen: false)
                                    .mainsarchForPackage
                                    .data
                                    .packageId,
                                context);

                            if (!mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            setState(() {
                              loadPackages();
                            });
                            setState(() {
                              seclectedcurrncy = i;
                            });
                          }
                        },
                        horizontalTitleGap: 0,
                        minVerticalPadding: 0,
                        title: Text(localizeCurrency(currencyapi[i])),
                        leading: seclectedcurrncy == i ? const Icon(Icons.check) : const SizedBox(),
                      )),
            )
          ],
        ),
      );

  // Widget buildOverlay() => Material(
  //       color: Colors.transparent,
  //       shadowColor: Colors.transparent,
  //       elevation: 0.0,
  //       child: Container(
  //           padding: EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //               boxShadow: [shadow],
  //               borderRadius:
  //                   BorderRadius.all(Radius.circular(15)).copyWith(topRight: Radius.circular(0)),
  //               color: cardcolor),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'change selling currency : ',
  //                 style: TextStyle(fontSize: titleFontSize),
  //               ),
  //               DropdownButton<String>(
  //                 isDense: true,
  //                 value: gencurrency,
  //                 icon: const Icon(Icons.keyboard_arrow_down),
  //                 elevation: 16,
  //                 style: TextStyle(color: primaryblue),
  //                 underline: SizedBox(),
  //                 onChanged: (String? newValue) async {
  //                   setState(() {
  //                     gencurrency = newValue!;
  //                   });
  //
  //                   try {
  //                     await AssistantMethods.changeCurranceylanguage(
  //                         context, {"currency": gencurrency}, 'currency');
  //
  //                     Navigator.of(context).pushNamed(LoadingWidgetMain.idScreen);
  //                     await AssistantMethods.updatePakagewithcurruncy(
  //                         Provider.of<AppData>(context, listen: false)
  //                             .mainsarchForPackage
  //                             .data
  //                             .packageId,
  //                         context);
  //                     Navigator.of(context).pop();
  //                     Navigator.of(context).pop();
  //                   } catch (e) {
  //                     Navigator.of(context).pushNamed(LoadingWidgetMain.idScreen);
  //                     await AssistantMethods.updatePakagewithcurruncy(
  //                         Provider.of<AppData>(context, listen: false)
  //                             .mainsarchForPackage
  //                             .data
  //                             .packageId,
  //                         context);
  //
  //                     Navigator.of(context).pop();
  //                     Navigator.of(context).pop();
  //
  //                     setState(() {
  //                       packages = Provider.of<AppData>(context, listen: false).mainsarchForPackage;
  //                       packagesList = packages.data.packages;
  //                     });
  //
  //                     //    hideOverlay();
  //                   }
  //                 },
  //                 items: currencyapi.map<DropdownMenuItem<String>>((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value),
  //                   );
  //                 }).toList(),
  //               ),
  //             ],
  //           )),
  //     );

  @override
  void initState() {
    context.read<AppData>().hasQuestions = false;

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    _animation2 = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 60) {
        setState(() {
          isScrollingup = false;
        });
      } else {
        setState(() {
          isScrollingup = true;
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Provider.of<AppData>(context, listen: false).userCollectedPoint > 0 &&
          Provider.of<AppData>(context, listen: false).isDiscountDialog == false) {
        showgamediscound();
      }
    });
    loadPackages();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }

    _scrollController.dispose();
    super.dispose();
  }

  showgamediscound() {
    Provider.of<AppData>(context, listen: false).gundletheDisountDialog(true);
    return Dialogs.materialDialog(
        barrierDismissible: true,
        context: context,
        color: Colors.white,
        msg: claculateTheDiscount(),
        title: AppLocalizations.of(context)!.congrats,
        //'You collected ${Provider.of<AppData>(context, listen: false).userCollectedPoint} Coin',
        titleStyle: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.normal),
        customView: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Image.asset(
            'assets/images/lamarlogo/logo_with_text.png',
            width: 30.w,
          ),
        ),
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: '${AppLocalizations.of(context)!.hurray} 🎉',
            color: primaryblue,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ]);

    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //         child: Container(
    //           padding: EdgeInsets.all(25),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(10)),
    //           ),
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.all(30),
    //                 height: 20.h,
    //                 width: 80.w,
    //                 child: Image.asset(
    //                   'assets/images/loader-aiwa.png',
    //                   width: 10.w,
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               SizedBox(
    //                 child: Center(
    //                   child: Text(
    //                     'You collected ${Provider.of<AppData>(context, listen: false).userCollectedPoint} Coin\n\n'
    //                     'You will get a discount on the booking phase',
    //                     style:
    //                         TextStyle(fontSize: titleFontSize + 3, fontWeight: FontWeight.w600),
    //                     textAlign: TextAlign.center,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    packagesList = Provider.of<AppData>(context, listen: false).ismakefilter
        ? Provider.of<AppData>(context, listen: false).packagefilter
        : packages.data.packages;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainScreen()));
        Provider.of<AppData>(context, listen: false).hundletheloading(false);
        return Future.value(true);
      },
      child: Sizer(
        builder: (context, orientation, deviceType) => Container(
          color: cardcolor,
          child: Scaffold(
            //  appBar: appbar(context, ''),
            body: Stack(
              children: [
                NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    if (notification.direction == ScrollDirection.forward &&
                        notification.metrics.pixels < 2) {
                      setState(() {
                        isScrollingup = false;
                        _animationController.forward();
                      });
                    } else if (notification.direction == ScrollDirection.reverse) {
                      setState(() {
                        isScrollingup = true;
                        _animationController.reverse();
                      });
                    }

                    return true;
                  },
                  child: PageStorage(
                    bucket: resetBucket ? PageStorageBucket() : bucket,
                    child:
                        // SmartRefresher(
                        //   enablePullUp: !Provider.of<AppData>(context, listen: false).isloadedonce,
                        //   enablePullDown: false,
                        //   controller: refreshController,
                        //   onRefresh: () {
                        //     refreshController.refreshCompleted();
                        //   },
                        //   onLoading: () async {
                        //     if (!Provider.of<AppData>(context, listen: false).isloadedonce) {
                        //       await Future.doWhile(() => Future.delayed(Duration(seconds: 2), () {
                        //             return AssistantMethods.getpackagesfromlisting(
                        //                 packages.data.listingUrl, context);
                        //           }));
                        //
                        //       setState(() {
                        //         packages =
                        //             Provider.of<AppData>(context, listen: false).mainsarchForPackage;
                        //         packagesList = packages.data.packages;
                        //       });
                        //     }
                        //     print(Provider.of<AppData>(context, listen: false).isloadedonce);
                        //     refreshController.loadComplete();
                        //   },
                        //   child:
                        Consumer<AppData>(
                      builder: (context, data, child) => ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          addRepaintBoundaries: false,
                          addAutomaticKeepAlives: false,
                          key: const PageStorageKey<String>('packageskey'),
                          primary: false,
                          padding: EdgeInsets.only(
                              top: data.locale == const Locale('en') ? 220.sp : 235.sp,
                              bottom: 20.sp),
                          controller: _scrollController,
                          itemCount: packagesList.isNotEmpty ? packagesList.length : 0,
                          //todo >>>>>>>>
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: packagesList[index].oldPrice.toInt() == 0 ? 210.sp : 220.sp,
                              color: cardcolor,
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      // margin: EdgeInsets.all(3),
                                      width: size.width * 0.35,
                                      // height:31.h,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.40,
                                            height: 36.h,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                        PackageImageView(
                                                            hotelImages:
                                                                packagesList[index].hotelImages)));
                                                // log(packagesList[index].hotelImage);
                                                // CarouselController buttonCarouselController =
                                                //     CarouselController();
                                                // showDialog(
                                                //     context: context,
                                                //     builder: (context) => Dialog(
                                                //           child: Container(
                                                //             width: size.width,
                                                //             height: size.height * 0.5,
                                                //             child: Stack(
                                                //               children: [
                                                //                 CarouselSlider(
                                                //                   items: packagesList[index]
                                                //                       .hotelImages
                                                //                       .map(
                                                //                         (e) => ClipRect(
                                                //                           child: Stack(
                                                //                             fit:
                                                //                                 StackFit.expand,
                                                //                             children: [
                                                //                               CachedNetworkImage(
                                                //                                 imageUrl: e.src
                                                //                                     .trimLeft(),
                                                //                                 imageBuilder:
                                                //                                     (context,
                                                //                                             url) =>
                                                //                                         Container(
                                                //                                   padding:
                                                //                                       EdgeInsets
                                                //                                           .all(
                                                //                                               5),
                                                //                                   child: Image
                                                //                                       .network(
                                                //                                     e.src
                                                //                                         .trimLeft(),
                                                //                                     fit: BoxFit
                                                //                                         .cover,
                                                //                                     width: size
                                                //                                         .width,
                                                //                                     height:
                                                //                                         size.height *
                                                //                                             0.4,
                                                //                                   ),
                                                //                                 ),
                                                //                                 placeholder: (context,
                                                //                                         url) =>
                                                //                                     Container(
                                                //                                         child:
                                                //                                             ImageSpinning(
                                                //                                   withOpasity:
                                                //                                       true,
                                                //                                 )),
                                                //                                 errorWidget: (context,
                                                //                                         erorr,
                                                //                                         x) =>
                                                //                                     Image.asset(
                                                //                                   'assets/images/image.jpeg',
                                                //                                   fit: BoxFit
                                                //                                       .cover,
                                                //                                   width: size
                                                //                                       .width,
                                                //                                   height:
                                                //                                       size.height *
                                                //                                           0.4,
                                                //                                 ),
                                                //                               ),
                                                //                             ],
                                                //                           ),
                                                //                         ),
                                                //                       )
                                                //                       .toList(),
                                                //                   carouselController:
                                                //                       buttonCarouselController,
                                                //                   options: CarouselOptions(
                                                //                     height: size.height * 0.5,
                                                //                     initialPage: 0,
                                                //                     autoPlay: false,
                                                //                     // scrollPhysics: ScrollPhysics(parent: )
                                                //                   ),
                                                //                 ),
                                                //                 Positioned(
                                                //                   right: 10,
                                                //                   bottom: size.height / 5,
                                                //                   child: Container(
                                                //                     color: primaryblue
                                                //                         .withOpacity(0.50),
                                                //                     child: IconButton(
                                                //                       onPressed: () =>
                                                //                           buttonCarouselController
                                                //                               .nextPage(
                                                //                                   duration: Duration(
                                                //                                       milliseconds:
                                                //                                           300),
                                                //                                   curve: Curves
                                                //                                       .linear),
                                                //                       icon: Icon(
                                                //                         Icons
                                                //                             .keyboard_arrow_right,
                                                //                       ),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //                 Positioned(
                                                //                   left: 10,
                                                //                   bottom: size.height / 5,
                                                //                   child: Container(
                                                //                     color: primaryblue
                                                //                         .withOpacity(0.50),
                                                //                     child: IconButton(
                                                //                       onPressed: () =>
                                                //                           buttonCarouselController
                                                //                               .previousPage(
                                                //                                   duration: Duration(
                                                //                                       milliseconds:
                                                //                                           300),
                                                //                                   curve: Curves
                                                //                                       .linear),
                                                //                       icon: Icon(
                                                //                         Icons
                                                //                             .keyboard_arrow_left_rounded,
                                                //                       ),
                                                //                     ),
                                                //                   ),
                                                //                 ),
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         ));
                                              },
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: packagesList[index].hotelImage,
                                                placeholder: (context, url) => const ImageSpinning(
                                                  withOpasity: true,
                                                ),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset('assets/images/image.jpeg'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5)
                                          .copyWith(bottom: 4),
                                      height: MediaQuery.of(context).size.height,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5),
                                            width: size.width * 0.54,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      pressIndcatorDialog(context);

                                                      // Navigator.of(context)
                                                      //     .pushNamed(MiniLoader.idScreen);
                                                      resetBucket = false;
                                                      Provider.of<AppData>(context, listen: false)
                                                          .hundletheloading(false);

                                                      Provider.of<AppData>(context, listen: false)
                                                          .getselectedpackageid(
                                                              packages.data.packages[index].id);

                                                      final x =
                                                          await AssistantMethods.customizingPackage(
                                                              context, packagesList[index].id);
                                                      // _timer!.cancel();
                                                      if (!mounted) return;
                                                      if (x != null) {
                                                        Navigator.of(context).pop();
                                                        Navigator.of(context)
                                                            .pushNamed(CustomizeSlider.idScreen);
                                                      } else {
                                                        displayTostmessage(context, true,
                                                            message: AppLocalizations.of(context)!
                                                                .tryAgainLater);
                                                        if (Navigator.of(context).canPop()) {
                                                          Navigator.of(context).pop();
                                                        } else {
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      const PackagesScreen()),
                                                              (route) => false);
                                                        }
                                                      }
                                                      // Navigator.of(context)
                                                      //     .pushNamed(CustomizeSlider.idScreen);
                                                    } catch (e) {
                                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                                          PackagesScreen.idScreen,
                                                          (route) => false);
                                                      displayTostmessage(context, true,
                                                          message: AppLocalizations.of(context)!
                                                              .pleaseSelectOtherOne);
                                                    }
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.symmetric(horizontal: 0),
                                                    width: MediaQuery.of(context).size.width * 0.49,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(context).size.width *
                                                              0.40,
                                                          child: Text(
                                                            packagesList[index].packageName,
                                                            style: TextStyle(
                                                              // color: greencolor,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: const AdaptiveTextSize()
                                                                  .getadaptiveTextSize(context, 30),
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                            softWrap: false,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 3),
                                                        packagesList[index].hotelName != ''
                                                            ? SmoothStarRating(
                                                                isReadOnly: true,
                                                                borderColor: yellowColor,
                                                                allowHalfRating: true,
                                                                starCount: 5,
                                                                size: 16,
                                                                filledIconData: Icons.star_rate,
                                                                defaultIconData: Icons.star_outline,
                                                                color: yellowColor,
                                                                rating: packagesList[index]
                                                                    .hotelStar
                                                                    .toDouble(),
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(height: 3),
                                                        packagesList[index].hotelName != ''
                                                            ? Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons.place,
                                                                    size: 18,
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets.symmetric(
                                                                            horizontal: 2),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        Navigator.of(context).push(
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    street
                                                                                        .StreetView(
                                                                                      isfromHotel:
                                                                                          false,
                                                                                      isFromCus:
                                                                                          false,
                                                                                      lat: double.parse(
                                                                                          packagesList[
                                                                                                  index]
                                                                                              .latitude),
                                                                                      lon: double.parse(
                                                                                          packagesList[
                                                                                                  index]
                                                                                              .longitude),
                                                                                    )));
                                                                      },
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                                context)!
                                                                            .streetview,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                subtitleFontSize,
                                                                            color: primaryblue,
                                                                            decoration:
                                                                                TextDecoration
                                                                                    .underline),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets.symmetric(
                                                                            horizontal: 2),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        showDialog(
                                                                            context: context,
                                                                            builder: (context) =>
                                                                                GoogleMapDialog(
                                                                                  lat: double.parse(
                                                                                      packagesList[
                                                                                              index]
                                                                                          .latitude),
                                                                                  lon: double.parse(
                                                                                      packagesList[
                                                                                              index]
                                                                                          .longitude),
                                                                                ));
                                                                      },
                                                                      child: Text(
                                                                        AppLocalizations.of(
                                                                                context)!
                                                                            .mapView,
                                                                        style: TextStyle(
                                                                          color: primaryblue,
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          fontSize:
                                                                              subtitleFontSize,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(height: 3),
                                                        packagesList[index].hotelName != ''
                                                            ? SizedBox(
                                                                width: size.width * 0.5,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.start,
                                                                  children: [
                                                                    const Icon(Icons.hotel,
                                                                        size: 18),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(horizontal: 5),
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.41,
                                                                      child: Text(
                                                                        packagesList[index]
                                                                            .hotelName,
                                                                        softWrap: false,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                const AdaptiveTextSize()
                                                                                    .getadaptiveTextSize(
                                                                                        context,
                                                                                        24)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(height: 3),
                                                        packagesList[index].flights != null
                                                            ? Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons.airplanemode_active,
                                                                      size: 18),
                                                                  const SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Text(
                                                                    ' ${packagesList[index].flights!.name}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            const AdaptiveTextSize()
                                                                                .getadaptiveTextSize(
                                                                                    context, 24)),
                                                                    maxLines: 1,
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(height: 3),
                                                        packagesList[index].activities.isNotEmpty ||
                                                                packagesList[index].responseFrom ==
                                                                    'inital_request'
                                                            ? Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  packagesList[index]
                                                                          .activities
                                                                          .isNotEmpty
                                                                      ? const Icon(
                                                                          Icons.directions_walk,
                                                                          size: 18)
                                                                      : packagesList[index]
                                                                                  .responseFrom ==
                                                                              'inital_request'
                                                                          ? const Icon(
                                                                              Icons.directions_walk,
                                                                              size: 18)
                                                                          : const SizedBox(),
                                                                  const SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.40,
                                                                    child: Text(
                                                                      packages.data.packages[index]
                                                                              .activities.isNotEmpty
                                                                          ? packagesList[index]
                                                                              .activities[0]
                                                                              .name
                                                                          : packagesList[index]
                                                                                      .responseFrom ==
                                                                                  'inital_request'
                                                                              ? 'Activities may be available at the time of customization'
                                                                              : '',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            const AdaptiveTextSize()
                                                                                .getadaptiveTextSize(
                                                                                    context, 24),
                                                                      ),
                                                                      softWrap: false,
                                                                      maxLines: 2,
                                                                      overflow:
                                                                          TextOverflow.ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SizedBox(),
                                                        const SizedBox(height: 3),
                                                        Row(
                                                          children: [
                                                            packagesList[index].transfer.isNotEmpty
                                                                ? const Icon(MdiIcons.car, size: 18)
                                                                : packagesList[index]
                                                                            .responseFrom ==
                                                                        'inital_request'
                                                                    ? const Icon(MdiIcons.car,
                                                                        size: 18)
                                                                    : const SizedBox(),
                                                            const SizedBox(width: 2),
                                                            SizedBox(
                                                              width: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.40,
                                                              child: Text(
                                                                packagesList[index]
                                                                        .transfer
                                                                        .isNotEmpty
                                                                    ? ' ${packagesList[index].transfer[0].content.category.name}'
                                                                    : packagesList[index]
                                                                                .responseFrom ==
                                                                            'inital_request'
                                                                        ? 'Transfer may be available at the time of customization'
                                                                        : '',
                                                                style: TextStyle(
                                                                  fontSize: const AdaptiveTextSize()
                                                                      .getadaptiveTextSize(
                                                                          context, 24),
                                                                ),
                                                                softWrap: false,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          pressIndcatorDialog(context);
                                                          final shareUrl = await AssistantMethods
                                                              .sharePackageDeepLink(
                                                                  packagesList[index].id,
                                                                  'packageId');
                                                          if (!mounted) return;
                                                          Navigator.of(context).pop();
                                                          if (shareUrl.isNotEmpty) {
                                                            Share.share(shareUrl,
                                                                subject: packagesList[index]
                                                                    .packageName);
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.share,
                                                          color: Colors.grey,
                                                          size: 14.sp,
                                                        ),
                                                        padding: const EdgeInsets.all(0),
                                                        alignment: Alignment.topCenter,
                                                      ),
                                                      IconButton(
                                                        padding: const EdgeInsets.all(0),
                                                        alignment: Alignment.bottomCenter,
                                                        icon: Icon(
                                                          Provider.of<AppData>(context,
                                                                          listen: false)
                                                                      .locale ==
                                                                  const Locale('en')
                                                              ? Icons.keyboard_arrow_right_rounded
                                                              : Icons.keyboard_arrow_left_rounded,
                                                          size: 25.sp,
                                                          color: Colors.grey.shade400,
                                                        ),
                                                        onPressed: () async {
                                                          resetBucket = false;
                                                          // try {
                                                          pressIndcatorDialog(context);

                                                          // Navigator.pushNamed(
                                                          //     context, MiniLoader.idScreen);

                                                          Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .getselectedpackageid(
                                                                  packages.data.packages[index].id);

                                                          final x = await AssistantMethods
                                                              .customizingPackage(
                                                                  context, packagesList[index].id);

                                                          if (!mounted) return;
                                                          //  Navigator.of(context).pop();
                                                          if (x != null) {
                                                            Navigator.of(context).popAndPushNamed(
                                                                CustomizeSlider.idScreen);
                                                          } else {
                                                            displayTostmessage(context, true,
                                                                message:
                                                                    AppLocalizations.of(context)!
                                                                        .tryAgainLater);
                                                            if (Navigator.of(context).canPop()) {
                                                              Navigator.of(context).pop();
                                                            } else {
                                                              Navigator.of(context)
                                                                  .pushAndRemoveUntil(
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const PackagesScreen()),
                                                                      (route) => false);
                                                            }
                                                          }

                                                          // Navigator.of(context).pushNamed(
                                                          //     CustomizeSlider.idScreen);
                                                          //   } catch (e) {

                                                          //     Navigator.of(context)
                                                          //         .pushNamedAndRemoveUntil(
                                                          //             PackagesScreen.idScreen,
                                                          //             (route) => false);
                                                          //     displayTostmessage(context, true,
                                                          //         message:
                                                          //             AppLocalizations.of(context)!
                                                          //                 .pleaseSelectOtherOne);
                                                          //   }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.55,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                packagesList[index].oldPrice.toInt() == 0
                                                    ? const SizedBox()
                                                    : Text(
                                                        ' ${localizeCurrency(packagesList[index].sellingCurrency)} ${packagesList[index].oldPrice.toInt()}',
                                                        style: TextStyle(
                                                            decorationThickness: 2,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: const AdaptiveTextSize()
                                                                .getadaptiveTextSize(context, 24),
                                                            decoration: TextDecoration.lineThrough,
                                                            decorationColor: Colors.red),
                                                      ),
                                                SizedBox(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "  ${AppLocalizations.of(context)!.totalP}",
                                                        style: TextStyle(
                                                            fontSize: titleFontSize,
                                                            color: Colors.grey[700]),
                                                      ),
                                                      Text(
                                                        Provider.of<AppData>(context, listen: false)
                                                                    .locale ==
                                                                const Locale("en")
                                                            ? '${localizeCurrency(packagesList[index].sellingCurrency)} ${packagesList[index].total}'
                                                            : ' ${packagesList[index].total} ${localizeCurrency(packagesList[index].sellingCurrency)}',
                                                        style: TextStyle(
                                                          // color: greencolor,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: subtitleFontSize,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.clip,
                                                        softWrap: false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                packagesList[index].oldPrice.toInt() == 0
                                                    ? const SizedBox()
                                                    : Text(
                                                        '${AppLocalizations.of(context)!.uSaving} ${packagesList[index].total - packagesList[index].oldPrice.toInt()}',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 9.sp,
                                                            color: greencolor),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                !isScrollingup
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        height: 17.h,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                            ),
                          ),
                        ),
                      ),
                Positioned(
                  top: 5.h,

                  // height: searchContainerheigth,

                  //padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 100.w,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 4,
                                  color: Colors.black.withOpacity(0.10),
                                  offset: const Offset(1, 1),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: AnimatedCrossFade(
                              sizeCurve: Curves.fastOutSlowIn,
                              firstChild: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: cardcolor, borderRadius: BorderRadius.circular(15)),
                                width: 100.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                resetbuckets();
                                                Provider.of<AppData>(context, listen: false)
                                                    .makeresarchResearchCurr(false);
                                                Provider.of<AppData>(context, listen: false)
                                                    .hundletheloading(false);
                                                Provider.of<AppData>(context, listen: false)
                                                    .restTheFilter();
                                                Navigator.of(context).pushNamedAndRemoveUntil(
                                                    TabPage.idScreen, (route) => false);
                                              },
                                              icon: Icon(
                                                Provider.of<AppData>(context, listen: false)
                                                            .locale ==
                                                        const Locale('en')
                                                    ? Icons.keyboard_arrow_left
                                                    : Icons.keyboard_arrow_right,
                                              )),
                                          InkWell(
                                            onTap: () {
                                              //  displayTostmessage(context, true, messeage: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy');
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(15),
                                                          topLeft: Radius.circular(15))),
                                                  builder: (_) => buidChangeCurrncy());
                                            },
                                            child: Image.asset(
                                              'assets/images/dollar.png',
                                              width: 5.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.destination,
                                      style: TextStyle(
                                          fontSize: subtitleFontSize, color: Colors.grey.shade500),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        resetbuckets();
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => SearchStepper(
                                                  isFromNavBar: false,
                                                  section: 0,
                                                  searchMode: '',
                                                )));
                                        // final result = await showSearch<String>(
                                        //   context: context,
                                        //   delegate: Searchto(),
                                        // );
                                        // print(result);

                                        // setState(() {
                                        //   searchTo = result!;
                                        // });
                                      },
                                      child: Container(
                                        width: 100.w,
                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                        padding: const EdgeInsets.all(10).copyWith(left: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: Text(
                                          searchTo == 'Where To ?'
                                              ? Provider.of<AppData>(context).payloadto.cityName
                                              : searchTo,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      color: Colors.black.withOpacity(0.25),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => SearchStepper(
                                                  section: -1,
                                                  isFromNavBar: false,
                                                  searchMode: '',
                                                )));
                                      },
                                      child: SizedBox(
                                        width: 100.w,
                                        // padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                //  await displayDateRangePicker(context);
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => SearchStepper(
                                                            section: 1,
                                                            isFromNavBar: false,
                                                            searchMode: '',
                                                          )));
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context)!.dates,
                                                      style: TextStyle(
                                                          fontSize: subtitleFontSize,
                                                          color: Colors.grey.shade500),
                                                    ),
                                                    Text(
                                                      '${DateFormat("MMM dd", genlang).format(DateFormat("dd/MM/yyyy").parse(packages.data.searchData.packageStart))}-${DateFormat("MMM dd", genlang).format(DateFormat("dd/MM/yyyy").parse(packages.data.searchData.packageEnd))}',
                                                      style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight: FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => SearchStepper(
                                                            section: 2,
                                                            isFromNavBar: false,
                                                            searchMode: '',
                                                          )));
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context)!.room,
                                                      style: TextStyle(
                                                          fontSize: subtitleFontSize,
                                                          color: Colors.grey.shade500),
                                                    ),
                                                    Text(
                                                      ' ${AppLocalizations.of(context)!.passenger(packages.data.searchData.totalPassengers)} , ${AppLocalizations.of(context)!.roomCount(packages.data.searchData.roomsCount)}',
                                                      style: TextStyle(
                                                          fontSize: 8.sp,
                                                          fontWeight: FontWeight.w600),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      color: Colors.black.withOpacity(0.25),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => const FillterScreen()));
                                            // await filterListbottomSeet();
                                            setState(() {});
                                          },
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/filter.png',
                                                  color: primaryblue,
                                                  width: 6.w,
                                                ),
                                                //  Icon(Icons.filter_list, color: primaryblue),
                                                Text(
                                                  "  ${AppLocalizations.of(context)!.filters}",
                                                  style: TextStyle(color: primaryblue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: showSorting,
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Icon(Icons.sort, color: primaryblue),
                                                Text("  ${AppLocalizations.of(context)!.sort}",
                                                    style: TextStyle(color: primaryblue))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              secondChild: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: cardcolor, borderRadius: BorderRadius.circular(15)),
                                width: 100.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: SlideTransition(
                                            position: _animation,
                                            child: IconButton(
                                                onPressed: () {
                                                  resetbuckets();
                                                  Provider.of<AppData>(context, listen: false)
                                                      .makeresarchResearchCurr(false);
                                                  Provider.of<AppData>(context, listen: false)
                                                      .hundletheloading(false);
                                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                                      TabPage.idScreen, (route) => false);
                                                },
                                                icon: Icon(
                                                  Provider.of<AppData>(context, listen: false)
                                                              .locale ==
                                                          const Locale('en')
                                                      ? Icons.keyboard_arrow_left
                                                      : Icons.keyboard_arrow_right,
                                                )),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => SearchStepper(
                                                      section: -1,
                                                      isFromNavBar: false,
                                                      searchMode: '',
                                                    )));
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SlideTransition(
                                                position: _animation2,
                                                child: SizedBox(
                                                  width: 65.w,
                                                  child: Text(
                                                    packages.data.searchData.arrivalName,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w600),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              SlideTransition(
                                                  position: _animation,
                                                  child: Text(
                                                      '${DateFormat("MMM dd", genlang).format(DateFormat("dd/MM/yyyy").parse(packages.data.searchData.packageStart))}-${DateFormat("MMM dd", genlang).format(DateFormat("dd/MM/yyyy").parse(packages.data.searchData.packageEnd))}  ${AppLocalizations.of(context)!.passenger(packages.data.searchData.totalPassengers)}'
                                                      //packages.data.searchData.totalPassengers
                                                      )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      indent: 15,
                                      endIndent: 15,
                                      color: Colors.black.withOpacity(0.25),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => const FillterScreen()));
                                            // await filterListbottomSeet();
                                            // setState(() {});
                                          },
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/filter.png',
                                                  color: primaryblue,
                                                  width: 6.w,
                                                ),
                                                // Icon(Icons.filter_list, color: primaryblue),
                                                Text(
                                                  "  ${AppLocalizations.of(context)!.filters}",
                                                  style: TextStyle(color: primaryblue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: showSorting,
                                          child: SizedBox(
                                            child: Row(
                                              children: [
                                                Icon(Icons.sort, color: primaryblue),
                                                Text(
                                                  "  ${AppLocalizations.of(context)!.sort}",
                                                  style: TextStyle(color: primaryblue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              duration: const Duration(milliseconds: 300),
                              crossFadeState: isScrollingup
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SnackBar snack(BuildContext context) {
    return SnackBar(
      content: Text(
        'Filterd',
        style: TextStyle(
          fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24),
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: primaryblue,
    );
  }

  late DateTime _startDate;

  // = DateTime.now().add(Duration(days: 1));
  late DateTime _endDate;

  // =
  // DateTime.now().add(Duration(days: 4));
  bool selectedDatechaker(DateTime dateTime) {
    DateTime now = DateTime.now();

    if (dateTime.isBefore(now)) {
      return false;
    } else {
      return true;
    }
  }

  DateTimeRange? dateTimeRange;

  String firstdate = '';
  String secdate = '';

  bool cheackchange({
    required String fday,
    required String lastday,
    required String fcity,
    required String secCity,
    required String fclass,
    required String adult,
    required String child,
    required String room,
  }) {
    String city1 = Provider.of<AppData>(context, listen: false).firstcity;
    String city2 = Provider.of<AppData>(context, listen: false).seccity;
    String day1 = Provider.of<AppData>(context, listen: false).firstday;
    String day2 = Provider.of<AppData>(context, listen: false).lastday;
    String roomcunt = Provider.of<AppData>(context, listen: false).roomcunt.toString();
    String adultscunt = Provider.of<AppData>(context, listen: false).adultcounts;
    String childcunt = Provider.of<AppData>(context, listen: false).childs.toString();
    String flightclass = Provider.of<AppData>(context, listen: false).flightclass;

    if (fday == day1 &&
        lastday == day2 &&
        fcity == city1 &&
        secCity == city2 &&
        fclass == flightclass &&
        adult == adultscunt &&
        child == childcunt &&
        room == roomcunt) {
      displayTostmessage(context, true, message: 'please change something to make new search');
      return true;
    } else {
      return false;
    }
  }

  Future displayDateRangePicker(BuildContext context) async {
    try {
      dateTimeRange = DateTimeRange(start: _startDate, end: _endDate);
    } catch (e) {
      dateTimeRange = null;
    }

    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(
        const Duration(days: 3),
      ),
    );
    final newDateRange = await showDateRangePicker(
      saveText: 'Search',
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateTimeRange ?? initialDateRange,
    );
    if (newDateRange == null) return;

    setState(() {
      dateTimeRange = newDateRange;
      _startDate = dateTimeRange!.start;
      _endDate = dateTimeRange!.end;
      if (_startDate == _endDate) {
        displayTostmessage(context, true, message: 'minimum period 3 days');
        _endDate = _startDate.add(
          const Duration(days: 3),
        );
      }
      firstdate = DateFormat('dd/MM/y').format(_startDate).toString();
      secdate = DateFormat('dd/MM/y').format(_endDate).toString();
    });
  }

//++++++++++++++++++++++++++++++++++++++++++++++++++++++ SEARCH START ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Widget resarch() {
    return AnimatedContainer(
      padding: const EdgeInsets.all(5),
      duration: const Duration(milliseconds: 600),
      // height: MediaQuery.of(context).size.height*0.5,
      decoration: BoxDecoration(
          color: cardcolor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
      height: 40.h,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.all(2).copyWith(bottom: 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      vs = true;

                      if (vs == true) {
                        setState(() {
                          searchContainerheigth = 80;
                          //      searchdetailsgeight =
                          //   MediaQuery.of(context).size.height * 0.08;
                        });
                      } else {
                        setState(() {
                          searchContainerheigth = MediaQuery.of(context).size.height * 0.500;
                          //     searchdetailsgeight = 0.0;
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: primaryblue,
                  ),
                ),
              ),
            ),

            ///////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////
            ////////////////////////////search///////////////////////////////
            //////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: InkWell(
                      onTap: () async {
                        final result = await showSearch<String>(
                          context: context,
                          delegate: SearchFrom(),
                        );

                        setState(() {
                          searchfrom = result!;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 50,
                        width: 100.w,
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: inCardColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                searchfrom == 'Where From ?'
                                    ? Provider.of<AppData>(context).payloadFrom!.cityName
                                    : searchfrom,
                                style: TextStyle(
                                    fontSize:
                                        const AdaptiveTextSize().getadaptiveTextSize(context, 22),
                                    fontWeight: FontWeight.w500,
                                    color:
                                        searchfrom == 'Where From ?' ? Colors.grey : Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Card(
              child: InkWell(
                onTap: () async {
                  final result = await showSearch<String>(
                    context: context,
                    delegate: Searchto(),
                  );
                  // from.text = result.toString();

                  setState(() {
                    searchTo = result!;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 50,
                  width: 100.w,
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: inCardColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          searchTo == 'Where To ?'
                              ? Provider.of<AppData>(context).payloadto.cityName
                              : searchTo,
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 22),
                              fontWeight: FontWeight.w500,
                              color: searchTo == 'Where To ?' ? Colors.grey : Colors.black),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///////////////////////////////////////////////
            ///////////////////////////////////////////////
            //////////////////////////التاريخ///////////////
            ///////////////////////////////////////////////
            ///
            SizedBox(
              width: 100.w + 10,
              //      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: InkWell(
                onTap: () async {
                  await displayDateRangePicker(context);
                },
                child: SizedBox(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: MediaQuery.of(context).size.width / 2.10,
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          // Text(
                          //   ' Departure',
                          //   style: TextStyle(
                          //       color: blackTextColor,
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: AdaptiveTextSize()
                          //           .getadaptiveTextSize(context, 24)),
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            ' ${DateFormat('EEE, dd/MM/y').format(_startDate)} ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    const AdaptiveTextSize().getadaptiveTextSize(context, 24)),
                          ),
                          Text(
                            '${DateFormat('EEE, dd/MM/y').format(_endDate)} ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    const AdaptiveTextSize().getadaptiveTextSize(context, 24)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
//! dsdasdasda
            Card(
              color: cardcolor,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setstate) => Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 10),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Room',
                                          style: TextStyle(
                                              fontSize: const AdaptiveTextSize()
                                                  .getadaptiveTextSize(context, 28),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setstate(() {
                                                      if (rooms > 1) {
                                                        rooms--;
                                                      }
                                                    });
                                                  },
                                                  icon: customMinus()),
                                              Text(rooms.toString()),
                                              SizedBox(
                                                child: IconButton(
                                                    onPressed: () {
                                                      setstate(() {
                                                        if (rooms < 9) {
                                                          rooms++;
                                                        }
                                                      });
                                                    },
                                                    icon: customAdd()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Adults',
                                          style: TextStyle(
                                              fontSize: const AdaptiveTextSize()
                                                  .getadaptiveTextSize(context, 28),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setstate(() {
                                                      if (adults > 1) {
                                                        adults--;
                                                        if (maxTotalpassenger < 9) {
                                                          maxTotalpassenger++;
                                                        }
                                                      }
                                                    });
                                                  },
                                                  icon: customMinus()),
                                              Text(adults.toString()),
                                              SizedBox(
                                                child: IconButton(
                                                    onPressed: () {
                                                      setstate(() {
                                                        if (maxTotalpassenger > 0) {
                                                          if (adults < 9) {
                                                            adults++;
                                                            maxTotalpassenger--;
                                                          }
                                                        }
                                                      });
                                                    },
                                                    icon: customAdd()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Child',
                                          style: TextStyle(
                                              fontSize: const AdaptiveTextSize()
                                                  .getadaptiveTextSize(context, 28),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setstate(() {
                                                      if (children > 0) {
                                                        children--;
                                                        if (maxTotalpassenger < 9) {
                                                          maxTotalpassenger++;
                                                        }
                                                      }
                                                      if (children == 0) {
                                                        chiledDivider = false;
                                                      }
                                                    });
                                                  },
                                                  icon: customMinus()),
                                              Text(children.toString()),
                                              IconButton(
                                                  onPressed: () {
                                                    setstate(() {
                                                      if (maxTotalpassenger > 0) {
                                                        if (children < 9) {
                                                          children++;
                                                          maxTotalpassenger--;
                                                        } else {
                                                          displayTostmessage(context, true,
                                                              message:
                                                                  'No. of infants should be less than adults');
                                                        }
                                                      }
                                                      if (children > 0) {
                                                        chiledDivider = true;
                                                      }
                                                    });
                                                  },
                                                  icon: customAdd()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  chiledDivider
                                      ? const Divider(
                                          color: Colors.black,
                                          indent: 25,
                                          endIndent: 25,
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ),
                                  Wrap(
                                    direction: Axis.vertical,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      for (var i = 0; i < children; i++)
                                        Row(children: [
                                          Text(
                                            'Child age: ${i + 1}',
                                            style: TextStyle(
                                                fontSize: const AdaptiveTextSize()
                                                    .getadaptiveTextSize(context, 24),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          CustomNumberPicker(
                                            w: 20.w,
                                            valueTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: const AdaptiveTextSize()
                                                    .getadaptiveTextSize(context, 20)),
                                            customAddButton: customAdd(),
                                            customMinusButton: customMinus(),
                                            step: 1,
                                            initialValue: 1,
                                            maxValue: 11,
                                            minValue: 1,
                                            onValue: (val) {
                                              if (i == 0) {
                                                setState(() {
                                                  childage0 = val;
                                                });
                                              }
                                              if (i == 1) {
                                                childage1 = val;
                                              }
                                              if (i == 2) {
                                                childage2 = val;
                                              }
                                              if (i == 3) {
                                                childage3 = val;
                                              }
                                              if (i == 4) {
                                                childage4 = val;
                                              }
                                              if (i == 5) {
                                                childage5 = val;
                                              }
                                              if (i == 6) {
                                                childage6 = val;
                                              }
                                              if (i == 7) {
                                                childage7 = val;
                                              }
                                              if (i == 8) {
                                                childage8 = val;
                                              }

                                              // print(childage0);
                                            },
                                          ),
                                        ])
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    indent: 25,
                                    endIndent: 25,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (rooms > adults) {
                                          displayTostmessage(context, true,
                                              message: 'Each room need atleast one adult');
                                        } else if (adults + children > 9) {
                                          displayTostmessage(context, true,
                                              message: 'Maximum allowed passengers are 9');
                                        } else {
                                          Navigator.pop(context);
                                        }

                                        setState(() {});
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: primaryblue),
                                      child: const Text('Done'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //ROOM
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          Text(
                            " $adults",
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Adults',
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 22),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      //ADULTS
                      Row(
                        children: [
                          const Icon(
                            Icons.house,
                            color: Colors.grey,
                          ),
                          Text(
                            '${rooms.toString()} Room',
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 22),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      //CHILD
                      Row(
                        children: [
                          const Icon(
                            MdiIcons.humanFemaleBoy,
                            color: Colors.grey,
                          ),
                          Text(
                            " $children",
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Child',
                            style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 22),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 52,
                width: 100.w + 10,
                // padding: EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_startDate == Provider.of<AppData>(context, listen: false).first) {
                      selectedRadio == 1 ? flightclass = 'C' : flightclass = 'Y';
                    }

                    String childage = '';

                    switch (children) {
                      case 1:
                        childage = 'childAge[1][1]=$childage0';
                        break;
                      case 2:
                        childage = 'childAge[1][1]=$childage0&childAge[1][2]=$childage1';
                        break;
                      case 3:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2';
                        break;
                      case 4:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage4';
                        break;
                      case 5:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4';
                        break;
                      case 6:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5';
                        break;
                      case 7:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5&childAge[1][7]=$childage6';
                        break;
                      case 8:
                        childage =
                            'childAge[1][1]=$childage0&childAge[1][2]=$childage1&childAge[1][3]=$childage2&childAge[1][4]=$childage3&childAge[1][5]=$childage4&childAge[1][6]=$childage5&childAge[1][7]=$childage6&childAge[1][8]=$childage7';
                        break;
                      default:
                    }

                    /////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////اعمل سيرش من الاول و استعين بل قديم في الفنكشينس///////
                    ///////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////

                    Provider.of<AppData>(context, listen: false).getdates(firstdate, secdate);
                    Provider.of<AppData>(context, listen: false)
                        .getRoomAndChildrenDetails(rooms, adults, children);
                    Provider.of<AppData>(context, listen: false)
                        .getdatesfromCal(_startDate, _endDate);
                    // print('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');
                    // print(firstdate);
                    // print(secdate);
                    // print(Provider.of<AppData>(context, listen: false)
                    //     .payloadFrom
                    //     .id);
                    // print(Provider.of<AppData>(context, listen: false)
                    //     .payloadto
                    //     .id);
                    // print(selectedhotelcode);
                    // print(selectedflightcode);
                    // print(rooms);
                    // print(adults);
                    // print(children);
                    // print(childage);
                    // print('>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<');

                    bool iscanresarch = cheackchange(
                      fday: firstdate,
                      lastday: secdate,
                      fcity: Provider.of<AppData>(context, listen: false).payloadFrom!.cityName,
                      secCity: Provider.of<AppData>(context, listen: false).payloadto.cityName,
                      adult: adults.toString(),
                      child: children.toString(),
                      room: rooms.toString(),
                      fclass: flightclass,
                    );

                    if (iscanresarch == true) return;

                    //  Navigator.pushNamed(context, LoadingWidgetMain.idScreen);
                    pressIndcatorDialog(context);
                    await AssistantMethods.mainSearchpackage(
                        context,
                        firstdate,
                        secdate,
                        Provider.of<AppData>(context, listen: false).payloadFrom!.id,
                        Provider.of<AppData>(context, listen: false).payloadto.id,
                        selectedhotelcode,
                        selectedflightcode,
                        flightclass,
                        rooms,
                        adults,
                        children,
                        childage,
                        '',
                        context.read<AppData>().searchMode,
                        '2');
                    if (!mounted) return;
                    Provider.of<AppData>(context, listen: false).cheakResarh(
                        fday: firstdate,
                        secday: secdate,
                        fcity: Provider.of<AppData>(context, listen: false).payloadFrom!.cityName,
                        secCity: Provider.of<AppData>(context, listen: false).payloadto.cityName,
                        room: rooms.toString(),
                        child: children.toString(),
                        adult: adults.toString(),
                        fclass: flightclass);

                    try {
                      // await AssistantMethods.getPackages(context, mainPackageId);
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(PackagesScreen.idScreen);
                    } catch (e) {
                      Navigator.of(context).pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => const Errordislog().error(context, e.toString()));
                    }
                    // //}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                  ),
                  child: Text(
                    'Search',
                    style:
                        TextStyle(color: blackTextColor, fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  filterListbottomSeet() {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setstate) => Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: primaryblue,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Your budget',
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check1 = filtercontroller(1000, 0, check1);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check1 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check1 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            '${localizeCurrency(packages.data.packages[0].sellingCurrency)} 0 - ${localizeCurrency(packages.data.packages[0].sellingCurrency)} 1000 '),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check2 = filtercontroller(3000, 1000, check2);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check2 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check2 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            '${localizeCurrency(packages.data.packages[0].sellingCurrency)} 1000 - ${localizeCurrency(packages.data.packages[0].sellingCurrency)} 3000 '),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check3 = filtercontroller(5000, 4000, check3);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check3 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check3 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            '${localizeCurrency(packages.data.packages[0].sellingCurrency)} 3000 - ${localizeCurrency(packages.data.packages[0].sellingCurrency)} 5000 '),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check4 = filtercontrollerlast(5000, check4);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check4 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check4 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            'more than ${localizeCurrency(packages.data.packages[0].sellingCurrency)} 3000 '),
                      ),
                    ),

                    ////////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////Flight Stops////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////////

                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Flight Stops',
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check5 = filtercontrollerFlight(1, check5);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check5 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check5 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('direct flights'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check6 = filtercontrollerFlight(3, check6);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check6 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check6 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('multiple stops'),
                      ),
                    ),

                    ////////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////Hotel stars/////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////////////
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Star Rating',
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check7 = filtercontrollerstar(3, check7);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check7 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check7 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('★★★'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check8 = filtercontrollerstar(4, check8);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check8 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check8 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('★★★★'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setstate(() {
                          check9 = filtercontrollerstar(5, check9);
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: check9 ? primaryblue.withOpacity(0.20) : Colors.transparent,
                            border: Border.all(
                                style: BorderStyle.solid,
                                width: 1.5,
                                color: check9 ? primaryblue : Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('★★★★★'),
                      ),
                    ),

                    InkWell(
                      child: TextButton(
                        child: const Text('Clear Filter'),
                        onPressed: () {
                          check1 = false;
                          check2 = false;
                          check3 = false;
                          check4 = false;
                          check5 = false;
                          check6 = false;
                          check7 = false;
                          check8 = false;
                          check9 = false;
                          check10 = false;
                          setState(() {
                            packagesList = packages.data.packages;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////Control the Filters/////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
  filtercontroller(int max, int min, bool check) {
    List<Package> filter = packages.data.packages;
    filter = filter.where((element) => element.total > min && element.total < max).toList();
    if (!check) {
      if (filter.isNotEmpty) {
        check = true;

        packagesList = filter;
        displayTostmessage(context, false, message: 'Done');
        return true;
      } else {
        check = false;
        displayTostmessage(context, false, message: 'the lowest prise is more than $max');
        return false;
      }
    } else {
      filter = packages.data.packages;
      setState(() {
        packagesList = packages.data.packages;
      });

      check = false;
      return false;
    }
  }

  filtercontrollerlast(int min, bool check) {
    List<Package> filter = packages.data.packages;
    filter = packages.data.packages.where((element) => element.total > min).toList();
    if (!check) {
      if (filter.isNotEmpty) {
        check = true;

        packagesList = filter;
        displayTostmessage(context, false, message: 'Done');
        return true;
      } else {
        check = false;
        displayTostmessage(context, true, message: 'the are no pakcages');
        packagesList = packages.data.packages;
        return false;
      }
    } else {
      filter = packages.data.packages;
      setState(() {
        packagesList = packages.data.packages;
      });
      check = false;
      return false;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////Control the Filter Flight///////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

  filtercontrollerFlight(int stop, bool check) {
    List<Package> filter = packages.data.packages;
    filter = packages.data.packages.where((element) => element.flightStop < stop).toList();
    if (!check) {
      if (filter.isNotEmpty) {
        check = true;

        packagesList = filter;
        displayTostmessage(context, false, message: 'Done');
        return true;
      } else {
        check = false;
        displayTostmessage(context, true, message: 'They are No one Go Flight ');
        packagesList = packages.data.packages;
        return false;
      }
    } else {
      filter = packages.data.packages;
      setState(() {
        packagesList = packages.data.packages;
      });
      check = false;
      return false;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////Control the Hotel star???///////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

  filtercontrollerstar(int star, bool check) {
    List<Package> filter = packages.data.packages;
    filter = packages.data.packages.where((element) => element.hotelStar == star).toList();
    if (!check) {
      if (filter.isNotEmpty) {
        check = true;

        packagesList = filter;
        displayTostmessage(context, false, message: 'Done');
        return true;
      } else {
        check = false;
        displayTostmessage(context, true, message: 'They are No one Go Flight ');
        return false;
      }
    } else {
      filter = packages.data.packages;
      setState(() {
        packagesList = packages.data.packages;
      });
      check = false;
      return false;
    }
  }

  showSorting() => showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setstate) => Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sort,
                              style: TextStyle(
                                fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 32),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: primaryblue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                packagesList.sort((a, b) => b.total.compareTo(a.total));
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.highestToLowest,
                              style: TextStyle(
                                  fontSize:
                                      const AdaptiveTextSize().getadaptiveTextSize(context, 30)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                packagesList.sort((a, b) => a.total.compareTo(b.total));
                              });
                              Navigator.pop(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.lowestToHighest,
                              style: TextStyle(
                                  fontSize:
                                      const AdaptiveTextSize().getadaptiveTextSize(context, 30)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
      });
}

class CurrencyElement extends StatefulWidget {
  CurrencyElement({Key? key, required this.title, required this.isSelected}) : super(key: key);
  final String title;
  bool isSelected = false;

  @override
  _CurrencyElementState createState() => _CurrencyElementState();
}

class _CurrencyElementState extends State<CurrencyElement> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
        });
      },
      leading: widget.isSelected ? const Icon(Icons.check) : const SizedBox(),
      title: Text(widget.title),
    );
  }
}

String localizeCurrency(String val) {
  if (genlang.toLowerCase() == 'en') {
    return val;
  } else {
    switch (val.toLowerCase()) {
      case "aed":
        {
          return "درهم";
        }
      case "usd":
        {
          return "دولار";
        }
      case "sar":
        {
          return "ر.س";
        }
      case "eur":
        {
          return "يورو";
        }
      case "gbp":
        {
          return "ج.إ";
        }
      case "qar":
        {
          return "ر.ق";
        }
      case "kwd":
        {
          return "د.ك";
        }
      case "omr":
        {
          return "ر.ع";
        }
      case "inr":
        {
          return "روبيه";
        }
      default:
        {
          return val;
        }
    }
  }
}
