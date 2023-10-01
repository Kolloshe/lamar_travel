// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/customize/activity/activitydetails.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../Assistants/assistant_methods.dart';
import '../../../Datahandler/adaptive_texts_size.dart';
import '../../../Datahandler/app_data.dart';
import '../../../Model/activity_list.dart';
import '../../../config.dart';
import '../../main_screen1.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widget/image_spinnig.dart';

import 'package:provider/provider.dart';

import '../../packages_screen.dart';
import '../new-customize/new_customize.dart';
import 'manageActivity.dart';

class ActivityList extends StatefulWidget {
  ActivityList({Key? key, required this.faildActivity}) : super(key: key);
  static String idScreen = 'ActivityList';
  String faildActivity = '';

  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  late AcivityList acivityList;

  loadActivityList() {
    acivityList = Provider.of<AppData>(context, listen: false).acivityList;
  }

  @override
  void initState() {
    loadActivityList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: cardcolor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
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
                                      Provider.of<AppData>(context, listen: false)
                                          .changePrebookFaildStatus(false);
                                      if (context.read<AppData>().searchMode == '' &&
                                          context.read<AppData>().searchMode.isEmpty) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            CustomizeSlider.idScreen, (route) => false);
                                      } else {
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const IndividualPackagesScreen()),
                                            (route) => false);
                                      }
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
                    Navigator.of(context).pop();
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

                                  if (!mounted) return;
                                  if (x) {
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.removeActivity,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: Provider.of<AppData>(context, listen: false).isPreBookFailed
                        ? size.height * 0.67
                        : size.height * 0.81,
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
                                                      SizedBox(height: 1.h),
                                                      Text(
                                                        acivityList.data[index].content,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
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
                                                    acivityList.data[index].modalityAmount
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: const AdaptiveTextSize()
                                                            .getadaptiveTextSize(context, 28),
                                                        color: greencolor),
                                                  ),
                                                  Text(
                                                    ' ${localizeCurrency(acivityList.data[index].currency)} ',
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
                                                  fixedSize: Size(size.width, size.height * 0.05)),
                                              onPressed: () async {
                                                pressIndcatorDialog(context);
                                                List<String> selectedActivityList = [];

                                                selectedActivityList
                                                    .add(acivityList.data[index].activityId);

                                                try {
                                                  Map<String, dynamic> saveddata = {
                                                    "customizeId":
                                                        Provider.of<AppData>(context, listen: false)
                                                            .packagecustomiz
                                                            .result
                                                            .customizeId,
                                                    "activityIds": selectedActivityList,
                                                    "activityDay":
                                                        Provider.of<AppData>(context, listen: false)
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
                                                      await AssistantMethods.updateActivity(data);
                                                  if (!mounted) return;
                                                  if (isActivityNotAdded == true) {
                                                    Navigator.pop(context);

                                                    displayTostmessage(context, true,
                                                        isInformation: true,
                                                        message: AppLocalizations.of(context)!
                                                            .cantAddThisActivityAtThisMoments);
                                                    return;
                                                  }
                                                  await AssistantMethods.updateHotelDetails(
                                                      Provider.of<AppData>(context, listen: false)
                                                          .packagecustomiz
                                                          .result
                                                          .customizeId,
                                                      context);
                                                  if (!mounted) return;

                                                  Navigator.pop(context);
                                                  if (Provider.of<AppData>(context, listen: false)
                                                      .isPreBookFailed) {
                                                    displayTostmessage(context, false,
                                                        message: AppLocalizations.of(context)!
                                                            .activityHasChange);

                                                    Navigator.of(context).pop();
                                                  } else {
                                                    displayTostmessage(context, false,
                                                        message: AppLocalizations.of(context)!
                                                            .activityHasChange);
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const ManageActivity()),
                                                        (route) => false);
                                                  }
                                                } catch (e) {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).canPop()
                                                      ? Navigator.of(context).pop()
                                                      : Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ManageActivity()),
                                                          (route) => false);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
