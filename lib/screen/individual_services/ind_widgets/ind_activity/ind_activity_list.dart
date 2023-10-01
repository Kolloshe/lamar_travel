// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/adaptive_texts_size.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/activity_list.dart';
import 'package:lamar_travel_packages/screen/customize/activity/activitydetails.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config.dart';
import '../../../../tab_screen_controller.dart';
import '../../../customize/new-customize/new_customize.dart';
import '../../../main_screen1.dart';
import '../../../packages_screen.dart';
import '../../ind_packages_screen.dart';

class IndActivityList extends StatefulWidget {
  IndActivityList({Key? key, required this.faildActivity, required this.fromChange})
      : super(key: key);
  static String idScreen = 'ActivityList';
  String faildActivity = '';
  bool fromChange = false;

  @override
  _IndActivityListState createState() => _IndActivityListState();
}

class _IndActivityListState extends State<IndActivityList> {
  late AcivityList acivityList;
  List<ActivityListData> genActivityList = [];
  bool isOneDayActivity = false;

  loadActivityList() {
    isOneDayActivity = (context.read<AppData>().newSearchFirstDate != null) &&
            (context.read<AppData>().newSearchsecoundDate == null) ||
        (context
            .read<AppData>()
            .newSearchFirstDate!
            .isAtSameMomentAs(context.read<AppData>().newSearchsecoundDate!));
    if (kDebugMode) {
      print(isOneDayActivity);
    }

    acivityList = Provider.of<AppData>(context, listen: false).acivityList;
    genActivityList = acivityList.data.map((e) => e).toList();
    acivityList.data.sort(
        (a, b) => double.tryParse(a.activityAmount)!.compareTo(double.tryParse(b.activityAmount)!));
  }

  double searchHeight = 0.0;

  int preSearchLen = 0;

  bool isSearchShown = false;

  final searchController = TextEditingController();

  showSearchCus(bool show) {
    if (show) {
      searchHeight = 7.h;
    } else {
      searchHeight = 0.0;
      searchController.text = '';
      acivityList.data = genActivityList.map((e) => e).toList();
      preSearchLen = 0;
    }

    setState(() {});
  }

  @override
  void initState() {
    loadActivityList();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool sortDES = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        '${AppLocalizations.of(context)!.sortByPrice} ${AppLocalizations.of(context)!.ascending}',
                                        style: TextStyle(
                                            color: primaryblue, fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        acivityList.data.sort((a, b) =>
                                            double.parse(a.activityAmount)
                                                .compareTo(double.tryParse(b.activityAmount)!));
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '${AppLocalizations.of(context)!.sortByPrice} ${AppLocalizations.of(context)!.descending}',
                                        style: TextStyle(
                                            color: primaryblue, fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        acivityList.data.sort((a, b) =>
                                            double.parse(b.activityAmount)
                                                .compareTo(double.tryParse(a.activityAmount)!));
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '${AppLocalizations.of(context)!.sortByName} ${AppLocalizations.of(context)!.ascending}',
                                        style: TextStyle(
                                            color: primaryblue, fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        acivityList.data.sort((a, b) => a.name.compareTo(b.name));
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                        '${AppLocalizations.of(context)!.sortByName} ${AppLocalizations.of(context)!.descending}',
                                        style: TextStyle(
                                            color: primaryblue, fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () {
                                        acivityList.data.sort((a, b) => b.name.compareTo(a.name));
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              )
                            ]));
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.sort,
                    color: primaryblue,
                  )),
              IconButton(
                  onPressed: () {
                    isSearchShown = !isSearchShown;
                    showSearchCus(isSearchShown);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  icon: Icon(
                    isSearchShown ? Icons.close : Icons.search,
                    color: primaryblue,
                  ))
            ],
            title: Text(
              AppLocalizations.of(context)!.availableActivity,
              style: TextStyle(color: Colors.black, fontSize: titleFontSize),
            ),
            centerTitle: true,
            backgroundColor: cardcolor,
            elevation: 0.1,
            leading: IconButton(
                onPressed: () {
                  if (Provider.of<AppData>(context, listen: false).isPreBookFailed) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text(AppLocalizations.of(context)!.sureToCancelTheBooking),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                      Provider.of<AppData>(context, listen: false)
                                          .changePrebookFaildStatus(false);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: const TextStyle(color: Colors.redAccent),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.contin,
                                      style: const TextStyle(color: Colors.green),
                                    )),
                              ],
                            ));
                  } else {
                    if (widget.fromChange) {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const TabPage()), (route) => false);
                      }
                    } else {
                      Provider.of<AppData>(context, listen: false).makeresarchResearchCurr(false);
                      Provider.of<AppData>(context, listen: false).hundletheloading(false);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const TabPage()), (route) => false);
                    }
                  }
                },
                icon: Icon(
                  Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  color: primaryblue,
                  size: 30,
                )),
          ),

          //appbar(context, ''),
          body: Container(
            width: size.width,
            height: size.height,
            color: background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    height: searchHeight,
                    duration: const Duration(milliseconds: 300),
                    child: Visibility(
                      visible: isSearchShown,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.transparent)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.transparent)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade300)),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: TextStyle(fontSize: 10.sp)),
                        controller: searchController,
                        onChanged: (v) {
                          if (v.length - preSearchLen >= 3) {
                            final timp = genActivityList.map((e) => e).toList();
                            final filter1 = timp
                                .where((e) => e.name.toLowerCase().trim().contains(v.toLowerCase()))
                                .toList();

                            acivityList.data = filter1.map((e) => e).toList();
                            preSearchLen = v.length;
                            setState(() {});
                          } else if (v.isEmpty) {
                            acivityList.data = genActivityList.map((e) => e).toList();
                            preSearchLen = 0;
                            setState(() {});
                          }
                        },
                      ),
                    )),
                Provider.of<AppData>(context, listen: false).isPreBookFailed
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: cardcolor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.activityFailedToBooking} :',
                              style: TextStyle(fontSize: titleFontSize - 1),
                            ),
                            Text(
                              widget.faildActivity,
                              style: TextStyle(
                                fontSize: titleFontSize - 1,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () async {
                                  final x = await AssistantMethods.removeOneActivity(
                                      context,
                                      Provider.of<AppData>(context, listen: false)
                                          .packagecustomiz
                                          .result
                                          .customizeId,
                                      Provider.of<AppData>(context, listen: false).failedActivityID,
                                      Provider.of<AppData>(context, listen: false)
                                          .activityDateString
                                          .toString());
                                  if (x) {
                                       if (!mounted) return;
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.removeActivity,
                                  style: const TextStyle(),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: Provider.of<AppData>(context, listen: false).isPreBookFailed
                          ? size.height * 0.67
                          : size.height * 0.82,
                      child: ListView.builder(
                          itemCount: acivityList.data.isNotEmpty ? acivityList.data.length : 1,
                          itemBuilder: (context, index) {
                            return acivityList.data.isNotEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: cardcolor,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 0.5),
                                            spreadRadius: 0.5),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              topLeft: Radius.circular(5)),
                                          child: CachedNetworkImage(
                                            imageUrl: acivityList.data[index].image,
                                            fit: BoxFit.cover,
                                            width: size.width * 0.4,
                                            height: size.height * 0.24,
                                            placeholder: (context, url) => const Center(
                                              child: ImageSpinning(
                                                withOpasity: true,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Image.asset(
                                              'assets/images/image-not-available.png',
                                              width: size.width * 0.4,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.25,
                                          width: size.width * 0.52,
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  log(jsonEncode(acivityList.toJson()));
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ActivityDetailsScreen(
                                                          activity: null,
                                                          activityListData:
                                                              acivityList.data[index])));
                                                },
                                                child: SizedBox(
                                                  height: size.height * 0.13,
                                                  width: size.width * 0.55,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          acivityList.data[index].name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          acivityList.data[index].content,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(context)!.viewDetails,
                                                          style: TextStyle(color: primaryblue),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                widthFactor: size.width,
                                                alignment: Alignment.centerRight,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      isOneDayActivity
                                                          ? acivityList.data[index].activityAmount
                                                              .toString()
                                                          : acivityList.data[index].modalityAmount
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: const AdaptiveTextSize()
                                                              .getadaptiveTextSize(context, 28),
                                                          color: greencolor),
                                                    ),
                                                    Text(
                                                      ' ${localizeCurrency(
                                                              acivityList.data[index].currency)} ',
                                                      style: TextStyle(
                                                          fontSize: const AdaptiveTextSize()
                                                              .getadaptiveTextSize(context, 28),
                                                          color: greencolor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: yellowColor,
                                                    fixedSize:
                                                        Size(size.width, size.height * 0.05)),
                                                onPressed: () async {
                                                                                    pressIndcatorDialog(context);

                                                  // Navigator.pushNamed(
                                                  //     context, MiniLoader.idScreen);

                                                  List<String> selectedActivityList = [];

                                                  selectedActivityList
                                                      .add(acivityList.data[index].activityId);

                                                  try {
                                                    Map<String, dynamic> saveddata = {
                                                      "customizeId": Provider.of<AppData>(context,
                                                              listen: false)
                                                          .packagecustomiz
                                                          .result
                                                          .customizeId,
                                                      "activityIds": selectedActivityList,
                                                      "activityDay": Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .isPreBookFailed
                                                          ? Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .failedActivityDayNum
                                                          : Provider.of<AppData>(context,
                                                                  listen: false)
                                                              .activityDay,
                                                      "currency": gencurrency,
                                                      "language": genlang
                                                    };
                                                    var data = jsonEncode(saveddata);

                                                    final isActivityNotAdded =
                                                        await AssistantMethods.updateActivity(
                                                            data);
                                                    if (isActivityNotAdded == true) {
                                                         if (!mounted) return;
                                                      if (Navigator.canPop(context)) {
                                                        Navigator.pop(context);
                                                      } else {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const IndividualPackagesScreen()));
                                                      }

                                                      displayTostmessage(context, true,
                                                          isInformation: true,
                                                          message: AppLocalizations.of(context)!
                                                              .cantAddThisActivityAtThisMoments);
                                                      return;
                                                    }
                                                       if (!mounted) return;
                                                    await AssistantMethods.updateHotelDetails(
                                                        Provider.of<AppData>(context,
                                                                listen: false)
                                                            .packagecustomiz
                                                            .result
                                                            .customizeId,
                                                        context);
                                                           if (!mounted) return;
                                                    if (Navigator.canPop(context)) {
                                                      Navigator.pop(context);
                                                    }

                                                    if (Provider.of<AppData>(context,
                                                            listen: false)
                                                        .isPreBookFailed) {
                                                      displayTostmessage(context, false,
                                                          message: AppLocalizations.of(context)!
                                                              .activityHasChange);
                                                      if (Navigator.canPop(context)) {
                                                        Navigator.of(context).pop();
                                                      } else {
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const IndividualPackagesScreen()));
                                                      }
                                                    } else {
                                                      if (widget.fromChange) {
                                                        displayTostmessage(context, false,
                                                            message: AppLocalizations.of(context)!
                                                                .activityHasChange);
                                                      }
                                                      if (Navigator.canPop(context)) {
                                                        Navigator.of(context)
                                                          ..pop()
                                                          ..pushReplacement(MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const IndividualPackagesScreen()));
                                                      } else {
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const IndividualPackagesScreen()));
                                                      }
                                                    }
                                                  } catch (e) {
                                                    if (Navigator.canPop(context)) {
                                                      Navigator.of(context).pop();
                                                    }
                                                  }
                                                },
                                                child: Text(AppLocalizations.of(context)!.select),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: size.height * 0.8,
                                    child: Center(
                                      child: Text(AppLocalizations.of(context)!
                                          .noActivitiesAvailableAtThisTime),
                                    ));
                          }),
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
}
