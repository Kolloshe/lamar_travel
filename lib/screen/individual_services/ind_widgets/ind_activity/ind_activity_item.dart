// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/adaptive_texts_size.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/screen/customize/activity/activitydetails.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_widgets/ind_activity/ind_activity_list.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/widget/errordialog.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../config.dart';

class IndActivityItems extends StatefulWidget {
  const IndActivityItems({
    Key? key,
    required this.activityDay,
    required this.activitys,
    required this.index,
    required this.list,
  }) : super(key: key);
  final String activityDay;
  final Customizpackage activitys;
  final int index;
  final List<Activity?> list;

  @override
  _IndActivityItemsState createState() => _IndActivityItemsState();
}

class _IndActivityItemsState extends State<IndActivityItems> {
  List<dynamic> activityList = [];
  String text = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.all(10),
                    width: size.width / 2.4,
                    height: size.height * 0.05,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          //topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${widget.activityDay} ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 20),
                          ),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 24),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
             
              width: size.width,
              color: cardcolor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // +++++++++++++++++++++++++++IMAGE++++++++++++++++++++++++
                  Container(
                    margin: const EdgeInsets.only(right: 0),
                    decoration: const BoxDecoration(),
                    child: widget.list[widget.index]?.image != 'image'
                        ? CachedNetworkImage(
                            imageUrl: widget.list[widget.index]!.image,
                            fit: BoxFit.cover,
                            width: size.width / 2.4,
                            height: activityList.length == 1 ? 20.h : 25.h,
                            placeholder: (context, url) => const Center(
                              child: ImageSpinning(
                                withOpasity: true,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/image-not-available.png'),
                          )
                        : Image.asset(
                            'assets/images/image-not-available.png',
                            // fit: BoxFit.cover,
                            width: size.width * 0.4,
                            height: size.height * 0.25,
                          ),
                  ),
                  //++++++++++++++++++++++++++++++v+++++++Details+++++++++++++++++++++++++++++++++++
                  Container(
                    padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width / 2.4,
                          child: Text(
                            widget.list[widget.index]!.name == 'No Avtivity'
                                ? AppLocalizations.of(context)!.pressAddActivityButtonToAddActivity
                                : widget.list[widget.index]!.name,

                            // widget.index == 0
                            //     ? checkFirstDay()
                            //     : widget.index == widget.list.indexOf(widget.list.last)
                            //     ? checkLastDay()
                            //     : widget.list[widget.index]!.name == 'No Avtivity'
                            //     ? AppLocalizations.of(context)!
                            //     . wouldYouLikeToBookAnyActivity
                            //     : widget.list[widget.index]!.name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 5,
                            style:
                                TextStyle(fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        widget.index == 0
                            ? checkFirstDayAvalabelty()
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : widget.list[widget.index]!.name != 'No Avtivity'
                                    ? Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => ActivityDetailsScreen(
                                                        activity: widget.list[widget.index],
                                                        activityListData: null,
                                                      )));
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.viewDetails,
                                              style: const TextStyle(
                                                  decoration: TextDecoration.underline),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              pressIndcatorDialog(context);

                                              // Navigator.of(context)
                                              //     .pushNamed(MiniLoader.idScreen);
                                              Provider.of<AppData>(context, listen: false)
                                                  .getActivityDat(widget.list[widget.index]!.day);
                                              await AssistantMethods.getActivityList(context,
                                                  searchId: widget.activitys.result.searchId,
                                                  customizeId: widget.activitys.result.customizeId,
                                                  activityDay: widget.list[widget.index]!.day,
                                                  currency: gencurrency);
                                              Navigator.of(context)
                                                ..pop()
                                                ..push(MaterialPageRoute(
                                                    builder: (context) => IndActivityList(
                                                          faildActivity: '',
                                                          fromChange: true,
                                                        )));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: yellowColor,
                                            ),
                                            child: Text(
                                                AppLocalizations.of(context)!.changeActivity,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal)),
                                          ),
                                          activityList.length == 1
                                              ? ElevatedButton(
                                                  onPressed: () async {
                                                    String date = DateFormat('yyyy-MM-dd', genlang)
                                                        .format(widget
                                                            .list[widget.index]!.activityDate);

                                                    await AssistantMethods.removeOneActivity(
                                                        context,
                                                        widget.activitys.result.customizeId,
                                                        widget.list[widget.index]!.activityId,
                                                        date);
                                                    widget.list[widget.index] = Activity(
                                                        name: 'No Avtivity',
                                                        searchId: '0',
                                                        code: '0',
                                                        activityId: '0',
                                                        modalityCode: '0',
                                                        modalityName: '0',
                                                        amountsFrom: [],
                                                        sellingCurrency: gencurrency,
                                                        netAmount: 0.0,
                                                        paybleCurency: "ADE",
                                                        modalityAmount: 0,
                                                        activityDate: DateTime.now(),
                                                        questions: [],
                                                        rateKey: "rateKey",
                                                        day: widget.index,
                                                        activityDateDisplay: '',
                                                        activityDestination: "activityDestination",
                                                        image: "image",
                                                        description: "description",
                                                        prebook: 1,
                                                        images: []);
                                                    setState(() {});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: yellowColor,
                                                  ),
                                                  child: Text(
                                                      AppLocalizations.of(context)!.removeActivity,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.normal)),
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          pressIndcatorDialog(context);

                                          //   Navigator.of(context).pushNamed(MiniLoader.idScreen);
                                          Provider.of<AppData>(context, listen: false)
                                              .getActivityDat(widget.list[widget.index]!.day);

                                          await AssistantMethods.getActivityList(context,
                                              searchId: widget.activitys.result.searchId,
                                              customizeId: widget.activitys.result.customizeId,
                                              activityDay: widget.list[widget.index]!.day,
                                              currency: gencurrency);

                                          Navigator.of(context)
                                            ..pop()
                                            ..push(MaterialPageRoute(
                                                builder: (context) => IndActivityList(
                                                      faildActivity: '',
                                                      fromChange: true,
                                                    )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: yellowColor,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.addActivity,
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      )
                            : widget.list[widget.index]!.name != 'No Avtivity'
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (kDebugMode) {
                                            print(widget.list[widget.index]!.day);
                                          }

                                          // showDialog(
                                          //   context: context,
                                          //   builder: (context) => Dialog(
                                          //     child: Container(
                                          //         padding:
                                          //             EdgeInsets.all(10),
                                          //         child: Column(
                                          //           children: [
                                          //             GestureDetector(
                                          //                 onTap: () {
                                          //                   Navigator.of(
                                          //                           context)
                                          //                       .pop();
                                          //                 },
                                          //                 child: Container(
                                          //                   alignment:
                                          //                       Alignment
                                          //                           .topRight,
                                          //                   child: Icon(
                                          //                     Icons.cancel,
                                          //                     color:
                                          //                         primaryblue,
                                          //                   ),
                                          //                 )),
                                          //             SizedBox(
                                          //               height:
                                          //                   size.height *
                                          //                       0.8,
                                          //               child:
                                          //                   SingleChildScrollView(
                                          //                 child: Text(
                                          //                   widget
                                          //                       .list[widget
                                          //                           .index]
                                          //                       .description,
                                          //                   style: TextStyle(
                                          //                       height:
                                          //                           1.5),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         )),
                                          //   ),
                                          // );

                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ActivityDetailsScreen(
                                                    activity: widget.list[widget.index],
                                                    activityListData: null,
                                                  )));
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.viewDetails,
                                          style:
                                              const TextStyle(decoration: TextDecoration.underline),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Provider.of<AppData>(context, listen: false)
                                              .getActivityDat(widget.list[widget.index]!.day);
                                          pressIndcatorDialog(context);

                                          //   Navigator.pushNamed(context, MiniLoader.idScreen);

                                          try {
                                            await AssistantMethods.getActivityList(context,
                                                searchId: widget.activitys.result.searchId,
                                                customizeId: widget.activitys.result.customizeId,
                                                activityDay: widget.list[widget.index]!.day,
                                                currency: gencurrency);
                                            Navigator.pop(context);
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => IndActivityList(
                                                      faildActivity: '',
                                                      fromChange: true,
                                                    )));
                                          } catch (e) {
                                            Navigator.pop(context);
                                            if (kDebugMode) {
                                              print(e.toString());
                                            }
                                            showDialog(
                                                context: context,
                                                builder: (context) => const Errordislog().error(
                                                    context,
                                                    AppLocalizations.of(context)!.errorHappened));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: yellowColor,
                                        ),
                                        child: Text(AppLocalizations.of(context)!.changeActivity,
                                            style: TextStyle(
                                                color: Colors.black.withAlpha(195),
                                                fontWeight: FontWeight.normal)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          pressIndcatorDialog(context);
                                          String date = DateFormat('yyyy-MM-dd', genlang)
                                              .format(widget.list[widget.index]!.activityDate);

                                          final isActivityRemoved =
                                              await AssistantMethods.removeOneActivity(
                                                  context,
                                                  widget.activitys.result.customizeId,
                                                  widget.list[widget.index]!.activityId,
                                                  widget.list[widget.index]!.activityDate
                                                      .toString());
                                          if (isActivityRemoved) {
                                            widget.list[widget.index] = Activity(
                                                name: 'No Avtivity',
                                                searchId: '0',
                                                code: '0',
                                                activityId: '0',
                                                modalityCode: '0',
                                                modalityName: '0',
                                                amountsFrom: [],
                                                sellingCurrency: gencurrency,
                                                netAmount: 0.0,
                                                paybleCurency: "ADE",
                                                modalityAmount: 0,
                                                activityDate: DateTime.now(),
                                                questions: [],
                                                rateKey: "rateKey",
                                                day: widget.index,
                                                activityDateDisplay: '',
                                                activityDestination: "activityDestination",
                                                image: "image",
                                                description: "description",
                                                prebook: 1,
                                                images: []);

                                            displayTostmessage(context, false,
                                                message: AppLocalizations.of(context)!
                                                    .activityHasBeenRemoved);
                                          }
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: yellowColor,
                                        ),
                                        child: Text(AppLocalizations.of(context)!.removeActivity,
                                            style: TextStyle(
                                                color: Colors.black.withAlpha(195),
                                                fontWeight: FontWeight.normal)),
                                      ),
                                    ],
                                  )
                                : widget.index == widget.list.indexOf(widget.list.last)
                                    ? checkLastDayAvilabelty()
                                        ? const SizedBox(
                                            height: 0,
                                          )
                                        : checkLastDayAvilabelty()
                                            ? const SizedBox(
                                                height: 0,
                                              )
                                            : ElevatedButton(
                                                onPressed: () async {
                                                  Provider.of<AppData>(context, listen: false)
                                                      .getActivityDat(
                                                          widget.list[widget.index]!.day);
                                                  await AssistantMethods.getActivityList(context,
                                                      searchId: widget.activitys.result.searchId,
                                                      customizeId:
                                                          widget.activitys.result.customizeId,
                                                      activityDay: widget.index,
                                                      currency: gencurrency);
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => IndActivityList(
                                                            faildActivity: '',
                                                            fromChange: true,
                                                          )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: yellowColor,
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(context)!.addActivity,
                                                  style:
                                                      TextStyle(color: Colors.black.withAlpha(195)),
                                                ),
                                              )
                                    : ElevatedButton(
                                        onPressed: () async {
                                          pressIndcatorDialog(context);

                                          //   Navigator.of(context).pushNamed(MiniLoader.idScreen);
                                          Provider.of<AppData>(context, listen: false)
                                              .getActivityDat(widget.list[widget.index]!.day);
                                          await AssistantMethods.getActivityList(context,
                                              searchId: widget.activitys.result.searchId,
                                              customizeId: widget.activitys.result.customizeId,
                                              activityDay: widget.index,
                                              currency: gencurrency);

                                          Navigator.of(context)
                                            ..pop()
                                            ..push(MaterialPageRoute(
                                                builder: (context) => IndActivityList(
                                                      faildActivity: '',
                                                      fromChange: true,
                                                    )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: yellowColor,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.addActivity,
                                          style: TextStyle(color: Colors.black.withAlpha(195)),
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
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  bool checkFirstDayAvalabelty() {
    //  checkingText();
    if (Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
      return false;
    } else if (widget.activitys.result.flight != null) {
      int maxAllowedDate = 12;
      int time = int.parse(widget.activitys.result.flight!.from.arrivalTime.substring(0, 2));

      if (widget.activitys.result.flight!.from.arrivalFdate ==
              widget.activitys.result.flight!.from.departureFdate &&
          time < maxAllowedDate) {
        text =
            'Your estimated arrival time is on ${widget.activitys.result.flight!.from.arrivalDate} ${widget.activitys.result.flight!.from.arrivalTime} Hrs Would you like to book any activity on that day?';
        return false;
      } else {
        text = 'Would you like to book any activity on that day?';
        return true;
      }
    } else {
      return true;
    }
  }

  String checkFirstDay() {
    //  checkingText();

    if (Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
      text = AppLocalizations.of(context)!.wouldYouLikeToBookAnyActivity;
      return text;
    } else if (widget.activitys.result.flight != null) {
      int maxAllowedDate = 12;
      int time = int.parse(widget.activitys.result.flight!.from.arrivalTime.substring(0, 2));

      if (widget.activitys.result.flight!.from.arrivalFdate
          .isAfter(widget.activitys.result.flight!.from.departureFdate)) {
        text =
            "${AppLocalizations.of(context)!.estimatedArrivalTime} ${widget.activitys.result.flight!.from.arrivalDate} ${widget.activitys.result.flight!.from.arrivalTime} ${AppLocalizations.of(context)!.nextDayNoActivity}";

        return text;
      }

      if (widget.activitys.result.flight!.from.arrivalFdate ==
              widget.activitys.result.flight!.from.departureFdate &&
          time < maxAllowedDate) {
        if (widget.list[0]!.name == 'No Avtivity') {
          text =
              '${AppLocalizations.of(context)!.estimatedArrivalTime} ${widget.activitys.result.flight!.from.arrivalDate} ${widget.activitys.result.flight!.from.arrivalTime}  ${AppLocalizations.of(context)!.wouldYouLikeToBookAnyActivity}';
        } else {
          text = widget.list[0]!.name;
        }

        return text;
      } else {
        text =
            "${AppLocalizations.of(context)!.estimatedArrivalTime} ${widget.activitys.result.flight!.from.arrivalDate} ${widget.activitys.result.flight!.from.arrivalTime}, ${AppLocalizations.of(context)!.youWonBeAbleAnyActivityDay}";
        return text;
      }
    } else {
      text =
          '${AppLocalizations.of(context)!.estimatedArrivalTime} ${widget.activitys.result.packageStart} ${AppLocalizations.of(context)!.wouldYouLikeToBookAnyActivity}';
      return text;
    }
  }

  bool checkLastDayAvilabelty() {
    if (widget.activitys.result.flight != null) {
      int maxAllowedtime = 17;

      int time =
          int.parse(widget.activitys.result.flight!.to?.departureTime ?? '00'.substring(0, 2));
      if (time < maxAllowedtime) {
        text =
            "${AppLocalizations.of(context)!.estimatedDepartureTime} ${widget.activitys.result.flight!.to?.departureTime ?? 0}  Hrs  ${AppLocalizations.of(context)!.wouldYouLikeToBookAnyActivity}  ";
        return true;
      } else {
        text =
            "${AppLocalizations.of(context)!.estimatedDepartureTime}  ${widget.activitys.result.flight!.to?.departureTime ?? 0}   Hrs ${AppLocalizations.of(context)!.youWonBeAbleAnyActivityDay} ";
        return false;
      }
    } else {
      text =
          "${AppLocalizations.of(context)!.estimatedDepartureTime}  ${widget.activitys.result.packageEnd}  Hrs ${AppLocalizations.of(context)!.wouldYouLikeToBookAnyActivity} ";
      return false;
    }
  }

  String checkLastDay() {
    if (widget.activitys.result.flight != null) {
      int maxAllowedtime = 16;

      int time =
          int.parse(widget.activitys.result.flight!.to?.departureTime ?? "00".substring(0, 2));
      if (time > maxAllowedtime) {
        if (widget.list.last!.name == 'No Avtivity') {
          text =
              'Your estimated arrival time is on ${widget.activitys.result.flight!.from.arrivalDate} ${widget.activitys.result.flight!.from.arrivalTime}  Would you like to book any activity on that day?';
        } else {
          text = widget.list.last!.name;
        }
        text =
            "Your estimated departure time is on ${widget.activitys.result.flight!.to?.departureTime ?? "00"}  Hrs Would you like to book any activity on that day? ";
        return text;
      } else {
        text =
            "Your estimated departure time is on ${widget.activitys.result.flight!.to?.departureTime ?? '0'}   Hrs You won't be able to book any activity on that day.";
        return text;
      }
    } else {
      text = AppLocalizations.of(context)!.weCannotEstimate;

      return text;
    }
  }
}
