// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/footer_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:lamar_travel_packages/Model/payload.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config.dart';

class CitiesPayload extends StatefulWidget {
  const CitiesPayload(
      {Key? key,
      required this.x,
      required this.onTap,
      required this.toRechangeCitiy,
      required this.isfromnavbar})
      : super(key: key);
  final String x;
  final void Function() onTap;
  final VoidCallback toRechangeCitiy;
  final VoidCallback isfromnavbar;

  @override
  _CitiesPayloadState createState() => _CitiesPayloadState();
}

class _CitiesPayloadState extends State<CitiesPayload> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _animation;
  final searchController = TextEditingController();
  List<PayloadElement>? citiyList = [];
  String citiy = '';
  IndTransferSearchModel? indTransferSearch;
  bool isSearching = false;
  Holidaysfotter? _holidaysfotter;

  bool isEN = true;

  Future<List<PayloadElement>>? future;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(_animationController);
    future = AssistantMethods.searchfrom(citiy, context);
    _holidaysfotter = Provider.of<AppData>(context, listen: false).holidaysfotter;
    Future.delayed(const Duration(), () => SystemChannels.textInput.invokeMethod('TextInput.hide'));
    isEN = Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? true : false;
    getInitTransferData();
    super.initState();
  }

  void getInitTransferData() async {
    if (context.read<AppData>().searchMode.contains('transfer')) {
      final location = context.read<AppData>().payloadWhichCityForTransfer!;
      indTransferSearch = await AssistantMethods.getIndTransferSearch(
          'A', location.id, location.airportCode, location.cityName);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        maxChildSize: 0.95,
        minChildSize: 0.50,
        initialChildSize: 0.75,
        // expand: true,
        builder: (BuildContext context, ScrollController scrollController) {
          //print(_scrollController.position.minScrollExtent);
          return NotificationListener(
            onNotification: (OverscrollNotification notification) {
              if (notification.metrics.pixels == -1.0) {
                widget.isfromnavbar();
                //  Navigator.of(context).pop();
              }
              return true;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: SlideTransition(
                position: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onPanUpdate: (d) {},
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          primary: false,
                          controller: scrollController,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 8.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                color: primaryblue.withAlpha(100),
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: widget.toRechangeCitiy,
                          child: Icon(
                            isEN ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                            size: 30.sp,
                            color: primaryblue,
                          ),
                        ),
                        SizedBox(
                            width: 80.w,
                            child: TextFormField(
                              autofocus: true,
                              controller: searchController,
                              onChanged: (value) async {
                                if (value.characters.length > 1 &&
                                    searchController.text.isNotEmpty) {
                                  isSearching = true;
                                  citiy = value;
                                  context.read<AppData>().searchMode.contains('transfer')
                                      ? indTransferSearch =
                                          await AssistantMethods.getIndTransferSearch(
                                              citiy,
                                              context
                                                  .read<AppData>()
                                                  .payloadWhichCityForTransfer!
                                                  .countryCode,
                                              context
                                                  .read<AppData>()
                                                  .payloadWhichCityForTransfer!
                                                  .airportCode,
                                              context
                                                  .read<AppData>()
                                                  .payloadWhichCityForTransfer!
                                                  .cityName)
                                      : AssistantMethods.searchfrom(citiy, context);
                                } else {
                                  isSearching = false;
                                }

                                Future.delayed(const Duration(seconds: 1), () {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                });
                              },
                              cursorColor: primaryblue,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.where_Are_You_Going,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                            ))
                      ],
                    ),
                    Expanded(
                      child: isSearching || context.read<AppData>().searchMode.contains('transfer')
                          ? context.read<AppData>().searchMode.contains('transfer')
                              ? ListView(
                                  children: [
                                    for (int i = 0; i < (indTransferSearch?.data.length ?? 0); i++)
                                      GestureDetector(
                                        onTap: widget.onTap,
                                        child: InkWell(
                                            onTap: () {
                                              context.read<AppData>().injectTransferIndPoint(
                                                  'to', indTransferSearch!.data[i]);
                                              widget.onTap();
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5).copyWith(right: 20),
                                                  padding: const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: primaryblue,
                                                      borderRadius: BorderRadius.circular(15)),
                                                  child: const Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 70.w,
                                                      child: Text(
                                                        indTransferSearch?.data[i].label ?? '',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 11.sp),
                                                      ),
                                                    ),
                                                    Text(
                                                      indTransferSearch?.data[i].category ?? '',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 10.sp,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      )
                                  ],
                                )
                              : FutureBuilder<List<PayloadElement>>(
                                  future: future,
                                  //AssistantMethods.searchfrom(citiy, context),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      citiyList = Provider.of<AppData>(context, listen: false)
                                          .cities
                                          .where((element) =>
                                              element.countryName
                                                  .toLowerCase()
                                                  .contains(citiy.toLowerCase().trim()) ||
                                              element.cityName
                                                  .toLowerCase()
                                                  .contains(citiy.toLowerCase().trim()))
                                          .toList();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, i) => const Divider(),
                                        itemBuilder: (context, index) => GestureDetector(
                                          onTap: widget.onTap,
                                          child: GestureDetector(
                                              onTap: () {
                                                Provider.of<AppData>(context, listen: false)
                                                    .getpayloadTo(citiyList!.elementAt(index));
                                                widget.onTap();
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(5).copyWith(right: 20),
                                                    padding: const EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: primaryblue,
                                                        borderRadius: BorderRadius.circular(15)),
                                                    child: const Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        citiyList![index].cityName,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12.sp),
                                                      ),
                                                      Text(
                                                        citiyList![index].countryName,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 10.sp,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        itemCount: citiyList!.length,
                                        controller: scrollController,
                                      ),
                                    );
                                  })
                          : ListView.separated(
                              itemBuilder: (context, index) => _buildsuggeitionList(
                                  _holidaysfotter!.data.sectionOne.data[index]),
                              separatorBuilder: (context, i) => const Divider(),
                              itemCount: _holidaysfotter!.data.sectionOne.data.length),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildsuggeitionList(HolidayData holiday) => GestureDetector(
        onTap: () async {
          final tocode = await AssistantMethods.getPayloadFromLocation(context, holiday.city);
          if (!mounted) return;
          Provider.of<AppData>(context, listen: false).getpayloadTo(tocode);
          widget.onTap();
        },
        child: SizedBox(
          height: 11.h,
          width: 90.w,
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(1, 1),
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.black.withOpacity(0.1)),
                ],
                color: cardcolor),
            child: Row(
              children: [
                SizedBox(
                    width: 25.w,
                    height: 100.h,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: holiday.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child: ImageSpinning(
                          withOpasity: true,
                        )),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/image-not-available.png'),
                      ),

                      //  Image.network(
                      //   holiday.image,
                      //   fit: BoxFit.cover,
                      // ),
                    )),
                SizedBox(
                  width: 3.w,
                ),
                SizedBox(
                  width: 60.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loclaizetrinding(holiday.city),
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        isEN ? holiday.label : "إحجز عطله في ${loclaizetrinding(holiday.city)}",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

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
}

class RechagethefromCitiy extends StatefulWidget {
  const RechagethefromCitiy(
      {Key? key,
      required this.x,
      required this.onTap,
      required this.back,
      required this.toRechangeCitiy,
      required this.isfromnavbar})
      : super(key: key);
  final String x;
  final void Function() onTap;
  final VoidCallback back;
  final VoidCallback toRechangeCitiy;
  final VoidCallback isfromnavbar;

  @override
  _RechagethefromCitiyState createState() => _RechagethefromCitiyState();
}

class _RechagethefromCitiyState extends State<RechagethefromCitiy>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _animation;
  bool _showcurrentLocation = true;
  List<PayloadElement>? citiyList = [];
  String citiy = '';
  bool isEN = true;
  IndTransferSearchModel? indTransferSearch;
  final searchController = TextEditingController();
  FocusNode f = FocusNode();
  Future<List<PayloadElement>>? future;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
        .animate(_animationController);
    _showcurrentLocation = true;
    future = AssistantMethods.searchfrom(citiy, context);
    Future.delayed(const Duration(), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Provider.of<AppData>(context, listen: false).resetApp();
    });

    if (context.read<AppData>().searchMode.contains('transfer')) {
      getInitTransferDataModel();
    }
    isEN = Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? true : false;
    super.initState();
  }

  void getInitTransferDataModel() async {
    indTransferSearch = await AssistantMethods.getIndTransferSearch(
        'AE',
        context.read<AppData>().payloadWhichCityForTransfer!.countryCode,
        context.read<AppData>().payloadWhichCityForTransfer!.airportCode,
        context.read<AppData>().payloadWhichCityForTransfer!.cityName);
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppData>(context, listen: false).title = 'Where From';
    _animationController.forward();
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        maxChildSize: 0.95,
        minChildSize: 0.50,
        initialChildSize: 0.75,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return NotificationListener(
            onNotification: (OverscrollNotification notification) {
              if (notification.metrics.pixels == -1.0) {
                widget.isfromnavbar();
              }
              return true;
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: SlideTransition(
                position: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        primary: false,
                        controller: scrollController,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 8.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              color: primaryblue.withAlpha(100),
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: widget.back,
                          child: Icon(
                            isEN ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
                            size: 30.sp,
                            color: primaryblue,
                          ),
                        ),
                        SizedBox(
                            width: 80.w,
                            child: TextFormField(
                              autofocus: true,
                              showCursor: true,
                              controller: searchController,
                              onChanged: (value) async {
                                setState(() {
                                  if (value.isNotEmpty &&
                                      searchController.text.characters.isNotEmpty) {
                                    _showcurrentLocation = false;
                                  } else {
                                    _showcurrentLocation = true;
                                  }
                                  citiy = value;
                                });
                                context.read<AppData>().searchMode.contains('transfer')
                                    ? indTransferSearch =
                                        await AssistantMethods.getIndTransferSearch(
                                            citiy,
                                            context
                                                .read<AppData>()
                                                .payloadWhichCityForTransfer!
                                                .countryCode,
                                            context
                                                .read<AppData>()
                                                .payloadWhichCityForTransfer!
                                                .airportCode,
                                            context
                                                .read<AppData>()
                                                .payloadWhichCityForTransfer!
                                                .cityName)
                                    : AssistantMethods.searchfrom(citiy, context);

                                Future.delayed(const Duration(seconds: 1), () {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                });
                              },
                              cursorColor: primaryblue,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.where_From,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                            ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    _showcurrentLocation && !context.read<AppData>().searchMode.contains('transfer')
                        ? SizedBox(
                            width: 100.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.your_Current_Location}\n',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<AppData>(context, listen: false).payloadFrom =
                                        Provider.of<AppData>(context, listen: false)
                                            .payloadFromlocation;
                                    if (Provider.of<AppData>(context, listen: false)
                                            .payloadFromlocation ==
                                        null) return;
                                    widget.toRechangeCitiy();
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primaryblue,
                                        ),
                                        child: const Icon(
                                          Icons.my_location,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Provider.of<AppData>(context, listen: false)
                                                  .payloadFromlocation !=
                                              null
                                          ? Text(
                                              '${Provider.of<AppData>(context, listen: false).payloadFromlocation!.cityName} ${Provider.of<AppData>(context, listen: false).payloadFromlocation!.countryName}',
                                              style: TextStyle(
                                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                                            )
                                          : const Text('Add Your Location')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    //   SizedBox(height: 16),
                    Expanded(
                      child: context.read<AppData>().searchMode.contains('transfer')
                          ? ListView(
                              children: [
                                for (int i = 0; i < (indTransferSearch?.data.length ?? 0); i++)
                                  GestureDetector(
                                    onTap: widget.onTap,
                                    child: InkWell(
                                        onTap: () {
                                          context.read<AppData>().injectTransferIndPoint(
                                              'from', indTransferSearch!.data[i]);
                                          widget.onTap();
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(5).copyWith(right: 20),
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: primaryblue,
                                                  borderRadius: BorderRadius.circular(15)),
                                              child: const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 70.w,
                                                  child: Text(
                                                    indTransferSearch?.data[i].label ?? '',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                                Text(
                                                  indTransferSearch?.data[i].category ?? '',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10.sp,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  )
                              ],
                            )
                          : FutureBuilder<List<PayloadElement>>(
                              future: future,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  citiyList = Provider.of<AppData>(context, listen: false)
                                      .cities
                                      .where((element) =>
                                          element.countryName
                                              .toLowerCase()
                                              .contains(citiy.toLowerCase().trim()) ||
                                          element.cityName
                                              .toLowerCase()
                                              .contains(citiy.toLowerCase().trim()))
                                      .toList();

                                  // citiyList = snapshot.data!
                                  //     .where((element) =>
                                  //         element.cityName
                                  //             .trim()
                                  //             .toLowerCase()
                                  //             .contains(citiy.toLowerCase().trim()) ||
                                  //         element.countryName
                                  //             .trim()
                                  //             .toLowerCase()
                                  //             .contains(citiy.toLowerCase().trim()))
                                  //     .toList();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _showcurrentLocation
                                      ? const SizedBox()
                                      : ListView.separated(
                                          separatorBuilder: (context, i) => const Divider(),
                                          itemBuilder: (context, index) => GestureDetector(
                                            onTap: widget.onTap,
                                            child: InkWell(
                                                onTap: () {
                                                  Provider.of<AppData>(context, listen: false)
                                                      .getpayloadFrom(citiyList!.elementAt(index));
                                                  widget.onTap();
                                                },
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.all(5)
                                                          .copyWith(right: 20),
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: primaryblue,
                                                          borderRadius: BorderRadius.circular(15)),
                                                      child: const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          citiyList![index].cityName,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12.sp),
                                                        ),
                                                        Text(
                                                          citiyList![index].countryName,
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 10.sp,
                                                              color: Colors.grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          itemCount: citiyList!.length,
                                          controller: scrollController,
                                        ),
                                );
                              }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
