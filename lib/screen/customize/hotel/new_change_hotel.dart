// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Model/newchangehotel.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/new_change_room.dart';

import 'package:sizer/sizer.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../Assistants/assistant_methods.dart';
import '../../../Datahandler/app_data.dart';
import '../../../config.dart';

import '../../../widget/googlemap-dialog.dart';
import '../../../widget/image_spinnig.dart';

import '../../../widget/street_view.dart';
import 'package:provider/provider.dart';

import '../new-customize/new_customize.dart';

class NewHotelCustomize extends StatefulWidget {
  const NewHotelCustomize({Key? key, required this.oldHotelID}) : super(key: key);
  static String idScreen = 'HotelCustomize';
  final String oldHotelID;

  @override
  _NewHotelCustomizeState createState() => _NewHotelCustomizeState();
}

class _NewHotelCustomizeState extends State<NewHotelCustomize> {
  String dropdownValue = '3 stars';
  // Completer<GoogleMapController> _controller = Completer();
  late NewChangeHotel hotles;
  List<HotelNewChange> filtring = [];

  late NewChangeHotel nameSearchHotile;

  List<NewRoomChanHotel> selectedroom = [];

  bool namesort = true;
  bool pricesort = true;
  bool starsort = true;

  lodeHotel() async {
    if (Provider.of<AppData>(context, listen: false).newChangeHotel != null) {
      hotles = Provider.of<AppData>(context, listen: false).newChangeHotel!;
      filtring = hotles.data.hotels;

      nameSearchHotile = Provider.of<AppData>(context, listen: false).newChangeHotel!;
      dropdownValue = Provider.of<AppData>(context, listen: false).hotelStarfilter;
    }
    
  }

  @override
  void initState() {
    lodeHotel();
    // initPlatformState();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.1,
            backgroundColor: cardcolor,
            title: Text(
              'Choose your new hotel',
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 35,
                color: primaryblue,
              ),
            ),
          ),
          backgroundColor: background,
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    color: cardcolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                              width: size.width * 0.7,
                              color: cardcolor,
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                onChanged: (name) {
                                  //   setState(() {
                                  //   filtring = Provider.of<AppData>(context, listen: false)
                                  //       .searchonHotelList(name);
                                  // });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search by Hotel Name',
                                ),
                              )),
                        ),
                        VerticalDivider(
                          color: Colors.black.withOpacity(0.25),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.all(15),
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sort by name',
                                            style: TextStyle(fontSize: titleFontSize),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.05,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtring.sort((a, b) => a.name
                                                          .toLowerCase()
                                                          .compareTo(b.name.toLowerCase()));
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.4,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text(
                                                        'A to Z',
                                                        style:
                                                            TextStyle(fontSize: subtitleFontSize),
                                                      ))),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      filtring.sort((a, b) => b.name
                                                          .toLowerCase()
                                                          .compareTo(a.name.toLowerCase()));
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.4,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text(
                                                        'Z to A',
                                                        style:
                                                            TextStyle(fontSize: subtitleFontSize),
                                                      ))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),

                                          Text(
                                            'Sort by price',
                                            style: TextStyle(fontSize: titleFontSize),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.05,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   filtring.sort((a, b) => int.parse(a
                                                    //       .rooms[0][0].type
                                                    //       .toString() +
                                                    //       a.rooms[0][0].amountChange.toString())
                                                    //       .compareTo(int.parse(
                                                    //       b.rooms[0][0].type.toString() +
                                                    //           b.rooms[0][0].amountChange
                                                    //               .toString())));
                                                    // });
                                                    // Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.4,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text(
                                                        'Lowest to hightest',
                                                        style:
                                                            TextStyle(fontSize: subtitleFontSize),
                                                      ))),
                                              InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   filtring.sort((a, b) => int.parse(b
                                                    //       .rooms[0][0].type
                                                    //       .toString() +
                                                    //       b.rooms[0][0].amountChange.toString())
                                                    //       .compareTo(int.parse(
                                                    //       a.rooms[0][0].type.toString() +
                                                    //           a.rooms[0][0].amountChange
                                                    //               .toString())));
                                                    // });
                                                    // Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.4,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text('Hightest to lowest ',
                                                          style: TextStyle(
                                                              fontSize: subtitleFontSize)))),
                                            ],
                                          ),

                                          // hotles.response[index].rooms[0][0].amountChange

                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),

                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Stars',
                                                  style: TextStyle(fontSize: titleFontSize),
                                                ),
                                                // SizedBox(
                                                //   width: size.width * 0.05,
                                                // ),
                                                // Padding(
                                                //   padding: const EdgeInsets.all(8.0),
                                                //   child: DropdownButton<String>(
                                                //     value: dropdownValue,
                                                //     underline: SizedBox(),
                                                //     icon: SizedBox(),
                                                //     // Container(
                                                //     //   height: 6.h,
                                                //     //       padding: EdgeInsets.all(6),
                                                //     //       decoration: BoxDecoration(boxShadow: [shadow],color: cardcolor),

                                                //     //       child: Icon(
                                                //     //   Icons.keyboard_arrow_down,
                                                //     //   size: 18,
                                                //     // ),),

                                                //     elevation: 1,
                                                //     style: TextStyle(color: yellowColor,fontSize: subtitleFontSize),
                                                //     onChanged: (String? newValue) async {
                                                //       Navigator.push(
                                                //           context,
                                                //           MaterialPageRoute(
                                                //               builder: (context) => MiniLoader()));
                                                //       final _customizpackage =
                                                //           Provider.of<AppData>(context, listen: false)
                                                //               .packagecustomiz;
                                                //       //    print(newValue!.substring(0,1));
                                                //       await AssistantMethods.changehotel(context,
                                                //           customizeId:
                                                //               _customizpackage.result.customizeId,
                                                //           checkIn: DateFormat('yyyy-MM-dd').format(
                                                //               _customizpackage
                                                //                   .result.hotels[0].checkIn),
                                                //           checkOut: DateFormat('yyyy-MM-dd').format(
                                                //               _customizpackage
                                                //                   .result.hotels[0].checkOut),
                                                //           hId: _customizpackage.result.hotels[0].id,
                                                //           star: newValue!.substring(0, 1));
                                                //       Provider.of<AppData>(context, listen: false)
                                                //           .gethotelstarefilter(newValue);
                                                //       setState(() {
                                                //         dropdownValue = newValue;
                                                //         // filtring = Provider.of<AppData>(context,
                                                //         //         listen: false)
                                                //         //     .changehotel
                                                //         //     .response;
                                                //       });
                                                //       Navigator.of(context).pushNamedAndRemoveUntil(
                                                //           HotelCustomize.idScreen, (route) => false);
                                                //     },
                                                //     items: <String>[
                                                //       '3 stars',
                                                //       '4 stars',
                                                //       '5 stars'
                                                //     ].map<DropdownMenuItem<String>>((String value) {
                                                //       return DropdownMenuItem<String>(
                                                //         value: value,
                                                //         child: Container(

                                                //           alignment: Alignment.center,
                                                //           height: 6.h,
                                                //           padding: EdgeInsets.all(2),
                                                //          // decoration: BoxDecoration(boxShadow: [shadow],color: cardcolor),

                                                //           child: Text(value,style: TextStyle(fontSize: subtitleFontSize),)),
                                                //       );
                                                //     }).toList(),
                                                //   ),
                                                // )
                                              ]),
                                          SizedBox(
                                            height: size.height * 0.05,
                                          ),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                                                      pressIndcatorDialog(context);

                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => MiniLoader()));
                                                    final customizpackage =
                                                        Provider.of<AppData>(context, listen: false)
                                                            .packagecustomiz;
                                                    //    print(newValue!.substring(0,1));
                                                    await AssistantMethods.changehotel(context,
                                                        customizeId:
                                                            customizpackage.result.customizeId,
                                                        checkIn: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkIn),
                                                        checkOut: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkOut),
                                                        hId: customizpackage.result.hotels[0].id,
                                                        star: "3");
                                                    Provider.of<AppData>(context, listen: false)
                                                        .gethotelstarefilter("3");

                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                        NewHotelCustomize.idScreen,
                                                        (route) => false);
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.25,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text(
                                                        '3 Stars',
                                                        style:
                                                            TextStyle(fontSize: subtitleFontSize),
                                                      ))),
                                              InkWell(
                                                  onTap: () async {
                                                                                      pressIndcatorDialog(context);

                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => MiniLoader()));
                                                    final customizpackage =
                                                        Provider.of<AppData>(context, listen: false)
                                                            .packagecustomiz;
                                                    //    print(newValue!.substring(0,1));
                                                    await AssistantMethods.changehotel(context,
                                                        customizeId:
                                                            customizpackage.result.customizeId,
                                                        checkIn: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkIn),
                                                        checkOut: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkOut),
                                                        hId: customizpackage.result.hotels[0].id,
                                                        star: "4");
                                                    Provider.of<AppData>(context, listen: false)
                                                        .gethotelstarefilter("4");

                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                        NewHotelCustomize.idScreen,
                                                        (route) => false);
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.25,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text('4 Stars',
                                                          style: TextStyle(
                                                              fontSize: subtitleFontSize)))),
                                              InkWell(
                                                  onTap: () async {
                                                                                      pressIndcatorDialog(context);

                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => MiniLoader()));
                                                    final customizpackage =
                                                        Provider.of<AppData>(context, listen: false)
                                                            .packagecustomiz;
                                                    //    print(newValue!.substring(0,1));
                                                    await AssistantMethods.changehotel(context,
                                                        customizeId:
                                                            customizpackage.result.customizeId,
                                                        checkIn: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkIn),
                                                        checkOut: DateFormat('yyyy-MM-dd').format(
                                                            customizpackage
                                                                .result.hotels[0].checkOut),
                                                        hId: customizpackage.result.hotels[0].id,
                                                        star: "5");
                                                    Provider.of<AppData>(context, listen: false)
                                                        .gethotelstarefilter("5");

                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                        NewHotelCustomize.idScreen,
                                                        (route) => false);
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      width: size.width * 0.25,
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: cardcolor, boxShadow: [shadow]),
                                                      child: Text('5 Stars',
                                                          style: TextStyle(
                                                              fontSize: subtitleFontSize)))),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Container(
                            color: cardcolor,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(Icons.sort),
                                Text(
                                  ' Sort',
                                  style: TextStyle(fontSize: titleFontSize),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: size.width,
                    height: size.height * 0.79,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 5),
                      shrinkWrap: true,
                      itemCount: filtring.isEmpty ? 1 : filtring.length,
                      itemBuilder: (context, index) {
                        return filtring.isEmpty
                            ? SizedBox(
                                width: size.width,
                                height: size.height * 0.60,
                                child: Center(
                                  child: Text(
                                    'They are no hotel matched with this name',
                                    style: TextStyle(fontSize: titleFontSize),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: cardcolor, borderRadius: BorderRadius.circular(10)),
                                height: 180.sp,
                                width: size.width,
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.40,
                                      margin: const EdgeInsets.symmetric(horizontal: 1),
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: filtring[index].image,
                                            height: 180.sp,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => const Center(
                                                child: ImageSpinning(
                                              withOpasity: true,
                                            )),
                                            errorWidget: (context, url, error) => Image.asset(
                                              'assets/images/image-not-available.png',
                                              height: 60,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0.0,
                                            right: 0.0,
                                            child: InkWell(
                                              onTap: () {
                                                CarouselController buttonCarouselController =
                                                    CarouselController();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => Dialog(
                                                          child: SizedBox(
                                                            width: size.width,
                                                            height: size.height * 0.5,
                                                            child: Stack(
                                                              children: [
                                                                CarouselSlider(
                                                                  items: filtring[index]
                                                                      .imgAll
                                                                      .map(
                                                                        (e) => ClipRect(
                                                                          child: Stack(
                                                                            fit: StackFit.expand,
                                                                            children: [
                                                                              CachedNetworkImage(
                                                                                imageUrl: e.src
                                                                                    .trimLeft(),
                                                                                fit: BoxFit.cover,
                                                                                width: size.width,
                                                                                height:
                                                                                    size.height *
                                                                                        0.5,
                                                                                placeholder:
                                                                                    (context,
                                                                                            url) =>
                                                                                        const Center(
                                                                                  child:
                                                                                      ImageSpinning(
                                                                                    withOpasity:
                                                                                        true,
                                                                                  ),
                                                                                ),
                                                                                errorWidget:
                                                                                    (context, url,
                                                                                            error) =>
                                                                                        Image.asset(
                                                                                  'assets/images/image-not-available.png',
                                                                                  fit: BoxFit.cover,
                                                                                  width: size.width,
                                                                                  height:
                                                                                      size.height *
                                                                                          0.5,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                      .toList(),
                                                                  carouselController:
                                                                      buttonCarouselController,
                                                                  options: CarouselOptions(
                                                                    height: size.height * 0.5,
                                                                    initialPage: 0,
                                                                    autoPlay: false,
                                                                    // scrollPhysics: ScrollPhysics(parent: )
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  right: 10,
                                                                  bottom: size.height / 5,
                                                                  child: Container(
                                                                    color: primaryblue
                                                                        .withOpacity(0.50),
                                                                    child: IconButton(
                                                                      onPressed: () =>
                                                                          buttonCarouselController
                                                                              .nextPage(
                                                                                  duration: const Duration(
                                                                                      milliseconds:
                                                                                          300),
                                                                                  curve: Curves
                                                                                      .linear),
                                                                      icon: const Icon(
                                                                        Icons.keyboard_arrow_right,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 10,
                                                                  bottom: size.height / 5,
                                                                  child: Container(
                                                                    color: primaryblue
                                                                        .withOpacity(0.50),
                                                                    child: IconButton(
                                                                      onPressed: () =>
                                                                          buttonCarouselController
                                                                              .previousPage(
                                                                                  duration: const Duration(
                                                                                      milliseconds:
                                                                                          300),
                                                                                  curve: Curves
                                                                                      .linear),
                                                                      icon: const Icon(
                                                                        Icons
                                                                            .keyboard_arrow_left_rounded,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    right: 3,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Icon(
                                                                        Icons.cancel,
                                                                        color: primaryblue,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                              },
                                              child: const Icon(
                                                Icons.switch_camera,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.5,
                                            child: Text(
                                              filtring[index].name,
                                              style: TextStyle(
                                                  fontSize: subtitleFontSize,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SmoothStarRating(
                                            isReadOnly: true,
                                            allowHalfRating: false,
                                            rating: double.parse(filtring[index].starRating),
                                            borderColor: yellowColor,
                                            color: yellowColor,
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 18,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      filtring[index].address,
                                                      style: TextStyle(
                                                        fontSize: detailsFontSize,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => GoogleMapDialog(
                                                        lat: double.parse(
                                                            filtring[index].latitude),
                                                        lon: double.parse(
                                                            filtring[index].longitude),
                                                      ));
                                            },
                                            child: Text(
                                              'Map View',
                                              style: TextStyle(
                                                color: primaryblue,
                                                decoration: TextDecoration.underline,
                                                fontSize: detailsFontSize,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => StreetView(
                                                        lat: double.parse(filtring[index].latitude),
                                                        lon:
                                                            double.parse(filtring[index].longitude),
                                                        isFromCus: null,
                                                        isfromHotel: true,
                                                      )));
                                            },
                                            child: Text(
                                              'Street View',
                                              style: TextStyle(
                                                  color: primaryblue,
                                                  fontSize: detailsFontSize,
                                                  decoration: TextDecoration.underline),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.99,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${filtring[index].currency} ${filtring[index].rooms[0][0].type}${filtring[index]
                                                          .rooms[0][0]
                                                          .amountChange}',
                                                  style: TextStyle(
                                                      color: filtring[index].rooms[0][0].type == '-'
                                                          ? greencolor
                                                          : Colors.redAccent,
                                                      fontSize: subtitleFontSize,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  'Package Price Difference',
                                                  style: TextStyle(
                                                      color: footerbuttoncolor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: detailsFontSize),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      fixedSize: const Size(170, 45), backgroundColor: yellowColor),
                                                  onPressed: () async {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => NewChangeRoomFomSplit(
                                                              hotel: filtring[index],
                                                              i: Provider.of<AppData>(context,
                                                                      listen: false)
                                                                  .hotelindex,
                                                            )));
                                                    //   showRooms(size: size, index: index);
                                                  },
                                                  child: Text(
                                                    'Choose Hotel',
                                                    style: TextStyle(
                                                      fontSize: subtitleFontSize,
                                                      color: cardcolor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  //Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void showRooms({required Size size, required int index}) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => Dialog(
  //         backgroundColor: cardcolor,
  //         child: Container(
  //           height: 500,
  //           padding: EdgeInsets.all(5),
  //           child: Column(
  //             children: [
  //               Container(
  //                 color: cardcolor,
  //                 padding: EdgeInsets.all(20),
  //                 width: size.width,
  //                 child: Text(
  //                   'Available Room',
  //                   style: TextStyle(
  //                       fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 24),
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Container(
  //                 padding: EdgeInsets.all(10),
  //                 height: 400,
  //                 child: ListView.builder(
  //                     itemCount: filtring[index].rooms.length,
  //                     itemBuilder: (context, ind) {
  //                       return Container(
  //                         child: Card(
  //                           elevation: 2,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               for (var i = 0; i < filtring[index].rooms[ind].length; i++)
  //                                 Container(
  //                                     decoration: BoxDecoration(
  //                                       borderRadius: BorderRadius.circular(15),
  //                                       color: cardcolor,
  //                                     ),
  //                                     margin: EdgeInsets.only(bottom: 5),
  //                                     //    height: size.height*0.10,
  //                                     alignment: Alignment.topLeft,
  //                                     child: Row(
  //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                         crossAxisAlignment: CrossAxisAlignment.start,
  //                                         children: [
  //                                           CachedNetworkImage(
  //                                               imageUrl: filtring[index].image,
  //                                               height: size.height * 0.10,
  //                                               width: 100,
  //                                               placeholder: (context, url) => Container(
  //                                                 child: LoadingWidgetMain(),
  //                                               ),
  //                                               errorWidget: (context, erorr, x) =>
  //                                                   SvgPicture.asset(
  //                                                     'images/image-not-available.svg',
  //                                                     color: Colors.grey,
  //                                                   )),
  //                                           Container(
  //                                               margin: EdgeInsets.all(5),
  //                                               width: 140,
  //                                               child: Column(
  //                                                   crossAxisAlignment:
  //                                                   CrossAxisAlignment.start,
  //                                                   children: [
  //                                                     Text(
  //                                                       filtring[index].rooms[ind][i].name,
  //                                                       overflow: TextOverflow.ellipsis,
  //                                                       maxLines: 3,
  //                                                       style: TextStyle(
  //                                                           fontWeight: FontWeight.bold,
  //                                                           fontSize: AdaptiveTextSize()
  //                                                               .getadaptiveTextSize(
  //                                                               context, 20)),
  //                                                     ),
  //                                                     Text(filtring[index]
  //                                                         .rooms[ind][i]
  //                                                         .boardName +
  //                                                         '\n\n'),
  //                                                     //   Text('\n\n'+hotles.response[index].rooms[ind][0].rateKey+'\n\n'),
  //                                                   ]))
  //                                         ])),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Container(
  //                                     child: Row(
  //                                       children: [
  //                                         SizedBox(
  //                                           width: size.width * 0.30,
  //                                           child: Row(
  //                                             mainAxisAlignment: MainAxisAlignment.center,
  //                                             crossAxisAlignment: CrossAxisAlignment.center,
  //                                             children: [
  //                                               Text(
  //                                                 filtring[index].rooms[ind][0].type.toString(),
  //                                                 style: TextStyle(
  //                                                     color: filtring[index]
  //                                                         .rooms[ind][0]
  //                                                         .type
  //                                                         .toString() ==
  //                                                         '+'
  //                                                         ? greencolor
  //                                                         : Colors.red,
  //                                                     fontSize: AdaptiveTextSize()
  //                                                         .getadaptiveTextSize(context, 24),
  //                                                     fontWeight: FontWeight.bold),
  //                                               ),
  //                                               Text(
  //                                                 ' ' +
  //                                                     filtring[index]
  //                                                         .rooms[ind][0]
  //                                                         .amountChange
  //                                                         .toString(),
  //                                                 style: TextStyle(
  //                                                     color: filtring[index]
  //                                                         .rooms[ind][0]
  //                                                         .type
  //                                                         .toString() ==
  //                                                         '+'
  //                                                         ? greencolor
  //                                                         : Colors.red,
  //                                                     fontSize: AdaptiveTextSize()
  //                                                         .getadaptiveTextSize(context, 24),
  //                                                     fontWeight: FontWeight.bold),
  //                                               ),
  //                                               Text(
  //                                                 filtring[index]
  //                                                     .rooms[ind][0]
  //                                                     .sellingCurrency
  //                                                     .toString(),
  //                                                 style: TextStyle(
  //                                                     color: filtring[index]
  //                                                         .rooms[ind][0]
  //                                                         .type
  //                                                         .toString() ==
  //                                                         '+'
  //                                                         ? greencolor
  //                                                         : Colors.red,
  //                                                     fontSize: AdaptiveTextSize()
  //                                                         .getadaptiveTextSize(context, 24),
  //                                                     fontWeight: FontWeight.bold),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   ElevatedButton(
  //                                     onPressed: () async {
  //                                       //  print(Provider.of<AppData>(context,listen: false).packagecustomiz.result.hotels[0].selectedRoom.length);
  //                                       Navigator.pushNamed(context, MiniLoader.idScreen);
  //                                       //  for (var i = 0; i < Provider.of<AppData>(context,listen: false).packagecustomiz.result.hotels[0].selectedRoom.length; i++) {
  //
  //                                       final jeybin = filtring[index].rooms[ind];
  //
  //                                       //  selectedroom.addAll(hotles.response[index].rooms[ind]);
  //
  //                                       //  print(selectedroom[0].toString());
  //                                      final selectedHotile =
  //                                       filtring[index];
  //
  //                                       //  selectedHotile.selectedRoom = selectedroom;
  //                                       selectedHotile.rooms = [jeybin];
  //
  //                                       selectedHotile.rooms.forEach((element) {});
  //                                       //  print(selectedHotile.selectedRoom?.toJson());
  //                                       var w = selectedHotile.toJson();
  //                                       List x = [];
  //                                       x.add(w);
  //                                       x.forEach((element) {});
  //                                       Map<String, dynamic> saveddata = {
  //                                         "customizeId":
  //                                         Provider.of<AppData>(context, listen: false)
  //                                             .packagecustomiz
  //                                             .result
  //                                             .customizeId,
  //                                         "splitHotels": x,
  //                                         "currency": gencurrency,
  //                                         "language": "en"
  //                                       };
  //
  //                                       String a = jsonEncode(saveddata);
  //                                       print(Provider.of<AppData>(context, listen: false)
  //                                           .packagecustomiz
  //                                           .result
  //                                           .hotels[0]
  //                                           .name);
  //                                       await AssistantMethods.saveHotel(a, context);
  //                                       // await AssistantMethods.updatethepackage(
  //                                       //     Provider.of<AppData>(context, listen: false)
  //                                       //         .packagecustomiz
  //                                       //         .result
  //                                       //         .customizeId);
  //                                       await AssistantMethods.updatehotelDetails(
  //                                           Provider.of<AppData>(context, listen: false)
  //                                               .packagecustomiz
  //                                               .result
  //                                               .customizeId,
  //                                           context);
  //                                       print(Provider.of<AppData>(context, listen: false)
  //                                           .packagecustomiz
  //                                           .result
  //                                           .hotels[0]
  //                                           .name);
  //                                       // Navigator.of(context).push(
  //                                       //   MaterialPageRoute(
  //                                       //     builder: (context) => CustomizePackage(),
  //                                       //   ),
  //                                       // );
  //                                     },
  //                                     child: Text('Select'),
  //                                     style: ElevatedButton.styleFrom(
  //                                         fixedSize: Size(160, 45), primary: yellowColor),
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     }),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ));
  // }

  hundlerimj(int index) {
    filtring.removeAt(index);
    setState(() {});
  }
}
