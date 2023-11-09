// ignore_for_file: library_private_types_in_public_api, unused_local_variable, unnecessary_null_comparison

import 'package:achievement_view/achievement_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/Model/promo_list.dart';
import 'package:lamar_travel_packages/screen/booking/summrey_and_pay.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';

import 'package:lamar_travel_packages/screen/newsearch/new_search.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:lamar_travel_packages/widget/promotion_listview_widget.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Assistants/assistant_methods.dart';
import '../Datahandler/app_data.dart';
import '../Model/footer_model.dart';
import '../Model/payload.dart';
import 'package:sizer/sizer.dart';
import '../widget/individual_products/individual_products.dart';
import 'packages_screen.dart';
import '../setting/setting.dart';
import '../widget/errordialog.dart';

import '../widget/trending_package.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:provider/provider.dart';
import '../config.dart';
import 'package:intl/intl.dart';

import 'dart:async';

class MainScreen extends StatefulWidget {
  static String idScreen = 'home';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  bool view = false;
  List<Color> color = [];
  List<String> image = [
    'assets/images/vectors/1.png',
    'assets/images/vectors/7(1).png',
    'assets/images/vectors/3.png',
    'assets/images/vectors/4.png',
    'assets/images/vectors/7.png',
    'assets/images/vectors/6.png',
    'assets/images/vectors/8.png',
    'assets/images/vectors/9.png',
  ];
  List<String> titles = ['Book', '', '', '', 'Book', '', '', ''];

  List<String> subtitle = [
    "Your Tour Packages",
    "Travel from anywhere to anywhere in the world",
    "With our fully customizable Holiday Packages",
    "Including Flight, Hotel, Transfer and Tours.!",
    "Your Tour Packages",
    "Travel from anywhere to anywhere in the world",
    "With our fully customizable Tour Packages",
    "Including Flight, Hotel, Transfer and Tours.!",
  ];
  List<String> offerTemImage = [
    'assets/images/offer_promotion/1 (1).png',
    'assets/images/offer_promotion/2.png',
    'assets/images/offer_promotion/3.png',
    'assets/images/offer_promotion/4.png',
    'assets/images/offer_promotion/Green Orange Travel Newsroom Limited Offer Travel Package Instagram Post (1).png'
  ];

  CarouselController buttonCarouselController = CarouselController();

  bool chooseHotelAndAirline = false;

  double hotileAirlineContainerHi = 0.0;
  double mainBlueContainerHeight = 360;

  DateTimeRange? dateTimeRange;

  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime _endDate = DateTime.now().add(const Duration(days: 4));

  String searchfrom = 'Where From ?';
  String searchTo = 'Where To ?';
  String flightclass = 'Y';

  String selectedflightname = 'Search for Airline';
  String selectedflightcode = '';
  String selectedhotelname = 'Search for Hotel';
  String selectedhotelcode = '';

  int rooms = 1;
  int adults = 1;
  int children = 0;
  int selectedRadio = 0;
  int maxTotalpassenger = 8;

  bool child1 = false;
  bool child2 = false;
  bool child3 = false;
  bool child4 = false;
  bool child5 = false;
  bool child6 = false;
  bool child7 = false;
  bool chiledDivider = false;
  num childage0 = 1;
  num childage1 = 1;
  num childage2 = 1;
  num childage3 = 1;
  num childage4 = 1;
  num childage5 = 1;
  num childage6 = 1;
  num childage7 = 1;
  num childage8 = 1;

  List<int> chiledAgeLis = [];

  final scrollController = ScrollController();

  List<PromoDataList> promotionDataL = [];

  showHotileAndAirline() {
    if (chooseHotelAndAirline == true) {
      hotileAirlineContainerHi = 60.0;
      mainBlueContainerHeight = MediaQuery.of(context).size.height * 0.70 - 14;
    } else {
      hotileAirlineContainerHi = 0.0;
      mainBlueContainerHeight = 360;
    }
  }

  String firstdate = '';
  String secdate = '';

  bool selectedDatechaker(DateTime dateTime) {
    DateTime now = DateTime.now();

    if (dateTime.isBefore(now)) {
      return false;
    } else {
      return true;
    }
  }

  Future displayDateRangePicker(BuildContext context) async {
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

  late Holidaysfotter holidaysfotter;

  void getRady() async {
    firstdate = DateFormat('dd/MM/y').format(_startDate).toString();
    secdate = DateFormat('dd/MM/y').format(_endDate).toString();
    holidaysfotter = Provider.of<AppData>(context, listen: false).holidaysfotter;
  }

  String cityfromlocation = '';
  late PayloadElement fromCode;
  late PayloadElement tocode;
  String customizeidFromTrinding = '';

  searchfromTrinding(String toCode) async {
    await AssistantMethods.mainSearchpackage(
        context,
        DateFormat('dd/MM/y').format(DateTime.now().add(const Duration(days: 30))).toString(),
        DateFormat('dd/MM/y').format(DateTime.now().add(const Duration(days: 35))).toString(),
        Provider.of<AppData>(context, listen: false).payloadFromlocation!.id,
        toCode,
        '',
        '',
        'Y',
        1,
        1,
        0,
        '',
        '',
        context.read<AppData>().searchMode,'2');
    if (!mounted) return;
    customizeidFromTrinding =
        Provider.of<AppData>(context, listen: false).mainsarchForPackage.data.packages[0].id;
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    FirebaseDynamicLinks.instance.onLink.listen(
        (dynamicLink) async {
          final Uri deepLink = dynamicLink.link;

          if (deepLink != null) {
            pressIndcatorDialog(context);
            await AssistantMethods.customizeingFormDeepLink(deepLink, context);
          } else {
            displayTostmessage(context, false,
                message: AppLocalizations.of(context)!.invalidOrExpiredUrl, isInformation: true);
          }
        },
        onDone: () {},
        onError: (e) {
          displayTostmessage(context, true, message: AppLocalizations.of(context)!.somethingWrong);
        });
    //
    // FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
    //   final Uri? deepLink = dynamicLink?.link;
    //
    //   if (deepLink != null) {
    //     pressIndcatorDialog(this.context);
    //     await AssistantMethods.customizeingFormDeepLink(deepLink, this.context);
    //     print(deepLink);
    //   } else {
    //     displayTostmessage(context, false,
    //         message: AppLocalizations.of(context)!.invalidOrExpiredUrl, isInformation: true);
    //   }
    // }, onError: (OnLinkErrorException e) async {
    //   displayTostmessage(context, true, message: AppLocalizations.of(context)!.somethingWrong);
    // });
  }

  void hasPromoCode() async {
    final promoPopUp = context.read<AppData>().promoPopup;

    if (promoPopUp != null && promoPopUp.data != null && promoPopUp.data!.image != null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      width: 100.w,
                      height: 50.h,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 100.w,
                              height: 50.h,
                              child: CachedNetworkImage(
                                imageUrl: promoPopUp.data!.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: ImageSpinning(
                                  withOpasity: true,
                                )),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/images/image-not-available.png'),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 5,
                              top: 5,
                              child: IconButton(
                                onPressed: () {
                                  context.read<AppData>().promoPopup = null;
                                  Navigator.of(context).maybePop();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: primaryblue,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ));
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<AppData>().searchMode = '';
    context.read<AppData>().hasQuestions = false;
    if (context.read<AppData>().promotionList != null) {
      promotionDataL = context.read<AppData>().promotionList!.data.map((e) => e!).toList();
    }

    getRady();
    initDynamicLinks();
    color = context.read<AppData>().promotionColor;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      hasPromoCode();
    });

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      initDynamicLinks();
    }

    if (SumAndPay.paymentUrlDuration != null) {}

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    buttonCarouselController.stopAutoPlay();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: cardcolor,
        body: Container(
          color: cardcolor,
          child: SafeArea(
            top: false,
            child: CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0.5,
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                pinned: true,
                leading: const SizedBox(),
                flexibleSpace: FlexibleSpaceBar(
                  background: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      disableCenter: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: image
                        .map((e) => _buildImageHeader(
                            loclaizetheImageHeader(titles.elementAt(image.indexOf(e))),
                            loclaizetheImageHeader(subtitle.elementAt(image.indexOf(e))),
                            e,
                            context))
                        .toList(),
                    carouselController: buttonCarouselController,
                  ),
                  title: GestureDetector(
                    onTap: () async {
                      context.read<AppData>().searchMode = '';
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchStepper(
                                searchMode: '',
                                section: -1,
                                isFromNavBar: false,
                              )));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 40,
                      width: 250,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                color: Colors.black.withOpacity(0.10),
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                          //  border: Border.all(),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: primaryblue,
                          ),
                          Text(
                            AppLocalizations.of(context)!.choose_your_holiday,
                            style: const TextStyle(
                                letterSpacing: 0.5,
                                color: Color(0xff37474F),
                                fontSize: 10,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        color: cardcolor,
                        child: Text(
                          AppLocalizations.of(context)!.exploreMore,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                        ),
                      ),

                      SizedBox(
                        width: 100.w,
                        height: 20.5.h,
                        child: ListView(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          scrollDirection: Axis.horizontal,
                          children: const [
                            IndividualProducts(
                              image: 'assets/images/vectors/fullpackage.png',
                              title: 'Holiday packages',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indflight.png',
                              title: 'Flights',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indHoltel.png',
                              title: 'Hotels',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indtransfer.png',
                              title: 'Transfers',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indactivity.png',
                              title: 'Activities',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indJet.png',
                              title: 'Privet jet',
                              subtitle: '',
                            ),
                            IndividualProducts(
                              image: 'assets/images/vectors/indTravelIn.png',
                              title: 'Travel insurance',
                              subtitle: '',
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        color: cardcolor,
                        child: Text(
                          Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                              ? holidaysfotter.data.sectionOne.title
                              : AppLocalizations.of(context)!.bestFamilyPac,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                        ),
                      ),
                      Container(
                        color: cardcolor,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.only(top: 3, bottom: 0, left: 0, right: 0),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                          primary: false,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: holidaysfotter.data.sectionOne.data.isNotEmpty
                              ? holidaysfotter.data.sectionOne.data.length
                              : 0,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                // Navigator.pushNamed(context, LoadingWidgetMain.idScreen);

                                pressIndcatorDialog(context);
                                context.read<AppData>().searchMode = '';

                                try {
                                  final noerror = await AssistantMethods.mainSearchFromTrending(
                                      context,
                                      '${holidaysfotter.data.sectionOne.data[index].searchUrl}&language=$genlang&currency=$gencurrency');
                                  if (!mounted) return;
                                  tocode = await AssistantMethods.getPayloadFromLocation(
                                      context, holidaysfotter.data.sectionOne.data[index].city);
                                  if (!mounted) return;
                                  Provider.of<AppData>(context, listen: false).getpayloadTo(tocode);
                                  PickerDateRange pickerDateRange = PickerDateRange(
                                      DateTime.parse(holidaysfotter.data.packageStart),
                                      DateTime.parse(holidaysfotter.data.packageEnd));
                                  Provider.of<AppData>(context, listen: false)
                                      .newsearchdateRange(pickerDateRange);

                                  Provider.of<AppData>(context, listen: false).getdatesfromCal(
                                      DateTime.parse(holidaysfotter.data.packageStart),
                                      DateTime.parse(holidaysfotter.data.packageEnd));

                                  if (noerror) {
                                    Navigator.of(context).popAndPushNamed(
                                      PackagesScreen.idScreen,
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                } catch (e) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Trending(
                                cityName: loclaizetrinding(
                                    holidaysfotter.data.sectionOne.data[index].city),
                                image: holidaysfotter.data.sectionOne.data[index].image,
                                label: loclaizetrinding(
                                    holidaysfotter.data.sectionOne.data[index].city),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        color: cardcolor,
                        child: Text(
                          AppLocalizations.of(context)!.offerAndPromotions,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                        ),
                      ),

                      promotionDataL.isEmpty
                          ? Column(children: [
                              SizedBox(
                                width: 100.w,
                                height: 25.h,
                                child: CarouselSlider.builder(
                                  carouselController: _controller,
                                  itemCount: promotionDataL.length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex, int pageViewIndex) {
                                    return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                        width: 100.w,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor: Colors.transparent,
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) => Container(
                                                          decoration: const BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(10),
                                                                topLeft: Radius.circular(10),
                                                              )),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 100.w,
                                                                      height: 100.h,
                                                                      child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: promotionDataL[
                                                                                  itemIndex]
                                                                              .image!,
                                                                          fit: BoxFit.cover,
                                                                          placeholder: (context,
                                                                                  url) =>
                                                                              const Center(
                                                                                  child:
                                                                                      ImageSpinning(
                                                                            withOpasity: true,
                                                                          )),
                                                                          errorWidget: (context,
                                                                                  url, error) =>
                                                                              Image.asset(
                                                                                  'assets/images/image-not-available.png'),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                        right: 0,
                                                                        top: 0,
                                                                        child: IconButton(
                                                                            onPressed: () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                            },
                                                                            icon: Icon(
                                                                              Icons.cancel_outlined,
                                                                              color: primaryblue,
                                                                            )))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                              },
                                              child: Stack(children: [
                                                Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right: 0,
                                                    bottom: 0,
                                                    child: Image.asset(offerTemImage[itemIndex],
                                                        fit: BoxFit.fill)),
                                                CachedNetworkImage(
                                                  height: 100.h,
                                                  imageUrl: promotionDataL[itemIndex].image!,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) => const Center(
                                                      child: ImageSpinning(
                                                    withOpasity: true,
                                                  )),
                                                  errorWidget: (context, url, error) => Image.asset(
                                                    'assets/images/image-not-available.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ])),
                                        ));
                                  },
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      aspectRatio: 0.6,
                                      enlargeCenterPage: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: offerTemImage.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () => _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context).brightness == Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)
                                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ])
                          : SizedBox(
                              height: 150.sp,
                              width: 100.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 120.sp,
                                      width: 100.w,
                                      child: CarouselSlider.builder(
                                        carouselController: _controller,
                                        itemCount: promotionDataL.length,
                                        itemBuilder: (BuildContext context, int itemIndex,
                                                int pageViewIndex) =>
                                            PromotionWidget(data: promotionDataL[itemIndex]),
                                        options: CarouselOptions(
                                            viewportFraction: 1,
                                            disableCenter: true,
                                            aspectRatio: 16.0 / 9.0,
                                            enlargeCenterPage: true,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            }),
                                        //            ListView(
                                        //   scrollDirection: Axis.horizontal,
                                        //   children: [
                                        //   for(int i = 0 ; i < promotionDataL.length ;i++)
                                        //             PromotionWidget(data:promotionDataL[i])
                                        //   ],
                                        // ),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: promotionDataL.asMap().entries.map((entry) {
                                      return GestureDetector(
                                        onTap: () => _controller.animateToPage(entry.key),
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context).brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        color: cardcolor,
                        child: Text(
                          AppLocalizations.of(context)!.topTrendingHPack,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                        ),
                      ),

                      Container(
                        color: cardcolor,
                        padding: const EdgeInsets.only(top: 3, bottom: 0, left: 3, right: 3),
                        child: Column(children: [
                          for (var index = 0;
                              index < holidaysfotter.data.sectionTwo.data.length;
                              index++)
                            GestureDetector(
                              onTap: () async {
                                pressIndcatorDialog(context);
                                //     Navigator.pushNamed(context, LoadingWidgetMain.idScreen);
                                context.read<AppData>().searchMode = '';
                                try {
                                  final noError = await AssistantMethods.mainSearchFromTrending(
                                      context,
                                      holidaysfotter.data.sectionTwo.data[index].searchUrl);
                                  if (!mounted) return;
                                  tocode = await AssistantMethods.getPayloadFromLocation(
                                      context, holidaysfotter.data.sectionTwo.data[index].city);
                                  if (!mounted) return;
                                  Provider.of<AppData>(context, listen: false).getpayloadTo(tocode);
                                  PickerDateRange pickerDateRange = PickerDateRange(
                                      DateTime.parse(holidaysfotter.data.packageStart),
                                      DateTime.parse(holidaysfotter.data.packageEnd));
                                  Provider.of<AppData>(context, listen: false)
                                      .newsearchdateRange(pickerDateRange);

                                  Provider.of<AppData>(context, listen: false).getdatesfromCal(
                                      DateTime.parse(holidaysfotter.data.packageStart),
                                      DateTime.parse(holidaysfotter.data.packageEnd));
                                  if (noError) {
                                    Navigator.of(context).popAndPushNamed(
                                      PackagesScreen.idScreen,
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                } catch (e) {
                                  Navigator.of(context).pop();
                                  const Errordislog()
                                      .error(context, 'No Trending package available now');
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: BudgetTravelpackages(
                                  cityName:
                                      localizeTop(holidaysfotter.data.sectionTwo.data[index].city),
                                  image: holidaysfotter.data.sectionTwo.data[index].image,
                                  label: holidaysfotter.data.sectionTwo.data[index].label,
                                ),
                              ),
                            )
                        ]),
                      ),
                      //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Slide SHOW End +++++++++++++++++++++++++++++++++++++++++++++++++++
                      const SizedBox(height: 16),

                      // //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++SUBSCRIBE FOR DISCOUNT END +++++++++++++++++++++++++++++++++++++++++++++++++++
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  String localizeTop(String val) {
    switch (val) {
      case 'Dubai':
        {
          return AppLocalizations.of(context)!.dubai;
        }
      case 'London':
        {
          return AppLocalizations.of(context)!.london;
        }
      case 'Cancun':
        {
          return AppLocalizations.of(context)!.cancun;
        }
      case 'Crete':
        {
          return AppLocalizations.of(context)!.crete;
        }
      case 'Rome':
        {
          return AppLocalizations.of(context)!.rome;
        }
      case 'Baku':
        {
          return AppLocalizations.of(context)!.baku;
        }
      case 'Tbilisi':
        {
          return AppLocalizations.of(context)!.tbilisi;
        }
      case 'Belgrade':
        {
          return AppLocalizations.of(context)!.belgrade;
        }
      case 'Tirana':
        {
          return AppLocalizations.of(context)!.tirana;
        }
      case 'Hurghada':
        {
          return AppLocalizations.of(context)!.hurghada;
        }

      default:
        {
          return val;
        }
    }
  }

  String loclaizetrinding(String val) {
    switch (val) {
      case 'Colombo':
        {
          return AppLocalizations.of(context)!.colombo;
        }
      case 'Male':
        {
          return AppLocalizations.of(context)!.male;
        }
      case 'Paris':
        {
          return AppLocalizations.of(context)!.paris;
        }
      case 'Miami Beach':
        {
          return AppLocalizations.of(context)!.miamiBeach;
        }
      case 'Helsinki':
        {
          return AppLocalizations.of(context)!.helsinki;
        }
      case 'Dubrovnik':
        {
          return AppLocalizations.of(context)!.dubrovnik;
        }
      case 'Madrid':
        {
          return AppLocalizations.of(context)!.madrid;
        }
      case 'Gothenburg':
        {
          return AppLocalizations.of(context)!.gothenburg;
        }
      case 'Copenhagen':
        {
          return AppLocalizations.of(context)!.copenhagen;
        }
      case 'San Salvador':
        {
          return AppLocalizations.of(context)!.sanSalvador;
        }

      default:
        {
          return val;
        }
    }
  }

  String loclaizetheImageHeader(String val) {
    switch (val) {
      case "Your Holiday Packages":
        {
          return AppLocalizations.of(context)!.yourHolidayPackages;
        }
      case "Travel from anywhere to anywhere in the world":
        {
          return AppLocalizations.of(context)!.travelFromAnywhereToAnywhereInTheWorld;
        }
      case "With our fully customizable Holiday Packages":
        {
          return AppLocalizations.of(context)!.customizableHolidayPackages;
        }
      case "Including Flight, Hotel, Transfer and Tours.!":
        {
          return AppLocalizations.of(context)!.includingServices;
        }
      case "Book":
        {
          return AppLocalizations.of(context)!.book;
        }
      default:
        {
          return val;
        }
    }
  }

  Widget _buildImageHeader(String? title, String subtitle, String image, BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Image(
            image: AssetImage(image),
            gaplessPlayback: true,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 80,
            child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.84,
                child: RichText(
                  text: TextSpan(
                    text: '$title \n',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                const Locale('en')
                            ? 'Lato'
                            : 'Bhaijaan'),
                    children: <TextSpan>[
                      TextSpan(
                          text: subtitle,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan')),
                    ],
                  ),
                ))),
      ],
    );
  }
}

AppBar appbar(BuildContext context, String id) {
  return AppBar(
    elevation: 0.0,
    leading: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (id == MainScreen.idScreen) {
            return;
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TabPage(),
            ),
          );
        },
        child: Image.asset(
          'assets/images/mascot+logo1.png',
          width: 72,
          height: 50,
        ),
      ),
    ),
    backgroundColor: Colors.white,
    centerTitle: false,
    actions: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: Provider.of<AppData>(context, listen: false).image != null
            ? FileImage(Provider.of<AppData>(context, listen: false).image!)
            : null,
        child: Provider.of<AppData>(context, listen: false).image != null
            ? null
            : Image.asset(
                'assets/images/vectors/Vector.png',
                fit: BoxFit.cover,
              ),
      ),
      IconButton(
        onPressed: () {
          bool page = false;
          if (id == MainScreen.idScreen) {
            page = true;
          } else {
            page = false;
          }

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setting(page)));
        },
        icon: Icon(
          Icons.menu,
          size: 30.51,
          color: black,
        ),
      ),
    ],
  );
}

Widget customAdd() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: Container(
      color: primaryblue,
      child: Center(
          child: Icon(
        MdiIcons.plus,
        color: cardcolor,
      )),
    ),
  );
}

Widget customMinus() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: Container(
      color: primaryblue,
      //  width: MediaQuery.of(context).size.width * 0.07,
      child: Center(
          child: Icon(
        MdiIcons.minus,
        color: cardcolor,
      )),
    ),
  );
}

displayTostmessage(BuildContext context, bool isError,
    {required String message, bool isInformation = false}) {
  isInformation
      ? AchievementView(
          title: '',
          subTitle: message,
          icon: const Icon(
            Icons.info_outline,
            color: Color(0xffC3A13D),
          ),

          color: const Color(0xffFFF7DF),
          //textStyleTitle: TextStyle(),

          textStyleSubTitle:
              const TextStyle(color: Color(0xffC3A13D), letterSpacing: 0.5, fontSize: 14),
          alignment: Alignment.topCenter,
          duration: const Duration(seconds: 3),
          isCircle: false,
        )
      : !isError
          ? AchievementView(
              title: '',
              subTitle: message,
              icon: const Icon(
                Icons.done_outline,
                color: Colors.green,
                size: 12,
              ),
              color: const Color(0xffdff6ea),
              textStyleSubTitle:
                  const TextStyle(color: Color(0xff1F9255), letterSpacing: 0.5, fontSize: 14),
              alignment: Alignment.topCenter,
              duration: const Duration(seconds: 3),
              isCircle: false,
            )
          : AchievementView(
              title: "",
              subTitle: message,
              icon: const Icon(
                Icons.cancel,
                color: Color(0xffA54A49),
              ),
              color: const Color(0xfffcedea),
              textStyleSubTitle:
                  const TextStyle(color: Color(0xffA54A49), letterSpacing: 0.5, fontSize: 14),
              alignment: Alignment.topCenter,
              duration: const Duration(seconds: 3),
              isCircle: false,
            ).show(context);
}
