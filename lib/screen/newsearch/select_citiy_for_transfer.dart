// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:lamar_travel_packages/Model/payload.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config.dart';

class SelectCityForTransfer extends StatefulWidget {
  const SelectCityForTransfer(
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
  _SelectCityForTransferState createState() => _SelectCityForTransferState();
}

class _SelectCityForTransferState extends State<SelectCityForTransfer>
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
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    _showcurrentLocation = true;
    future = AssistantMethods.searchfrom(citiy, context);
    Future.delayed(const Duration(), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Provider.of<AppData>(context, listen: false).resetApp();
    });

    isEN = Provider.of<AppData>(context, listen: false).locale == const Locale('en') ? true : false;
    super.initState();
  }

  void getInitTransferDataModel() async {
    final location = context.read<AppData>().payloadWhichCityForTransfer!;

    indTransferSearch = await AssistantMethods.getIndTransferSearch(
        'A', location.id, location.airportCode, location.cityName);
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
                                AssistantMethods.searchfrom(citiy, context);

                                Future.delayed(const Duration(seconds: 1), () {
                                  if (mounted) {
                                    setState(() {});
                                  }
                                });
                              },
                              cursorColor: primaryblue,
                              decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.fromWhichCity,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                            ))
                      ],
                    ),
                    const SizedBox(height: 5),
                    _showcurrentLocation
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
                                    if (Provider.of<AppData>(context, listen: false)
                                            .payloadFromlocation ==
                                        null) {
                                      return;
                                    }
                                    context.read<AppData>().getPayloadWhichCityForTransfer(
                                        Provider.of<AppData>(context, listen: false)
                                            .payloadFromlocation!);
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
                                              '${Provider.of<AppData>(context, listen: false)
                                                      .payloadFromlocation!
                                                      .cityName} ${Provider.of<AppData>(context, listen: false)
                                                      .payloadFromlocation!
                                                      .countryName}',
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
                    Expanded(
                      child: FutureBuilder<List<PayloadElement>>(
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
                              child: ListView.separated(
                                separatorBuilder: (context, i) => const Divider(),
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: widget.onTap,
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<AppData>(context, listen: false)
                                            .getPayloadWhichCityForTransfer(
                                                citiyList!.elementAt(index));
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
                                              Text(
                                                citiyList![index].cityName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500, fontSize: 12.sp),
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
