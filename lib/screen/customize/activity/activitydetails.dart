// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/activity_list.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sizer/sizer.dart';

import '../../../config.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final Activity? activity;
  final ActivityListData? activityListData;

  const ActivityDetailsScreen({Key? key, required this.activity, required this.activityListData})
      : super(key: key);

  @override
  _ActivityDetailsScreenState createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  late Activity activity;
  late ActivityListData activityListData;

  @override
  void initState() {
    if (widget.activity != null) {
      activity = widget.activity!;
    }
    if (widget.activityListData != null) {
      activityListData = widget.activityListData!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: cardcolor,
        leading: IconButton(
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            size: 35,
            color: primaryblue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.activity != null ? activity.name : activityListData.name,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: 19.h,
              width: 100.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.activity != null ? activity.image : activityListData.image,
                  placeholder: (context, url) => const Center(
                    child: LoadingWidgetMain(),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/image-not-available.png'),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            SizedBox(
                height: 60.h,
                child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 10),
                  RichText(
                    // textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.activityName} : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blackTextColor,
                        fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                const Locale('en')
                            ? 'Lato'
                            : 'Bhaijaan',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.activity != null
                                ? "${activity.name}\n"
                                : '${activityListData.name}\n',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan',
                            )),
                      ],
                    ),
                  ),
                  widget.activity != null
                      ? RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: '${AppLocalizations.of(context)!.activityDate} : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: blackTextColor,
                              fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan',
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${activity.activityDateDisplay}\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily:
                                        Provider.of<AppData>(context, listen: false).locale ==
                                                const Locale('en')
                                            ? 'Lato'
                                            : 'Bhaijaan',
                                  )),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '${AppLocalizations.of(context)!.description}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blackTextColor,
                        fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                const Locale('en')
                            ? 'Lato'
                            : 'Bhaijaan',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.activity != null
                                ? " ${activity.description}"
                                : "  ${activityListData.content}\n",
                            style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.normal,
                              fontFamily: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? 'Lato'
                                  : 'Bhaijaan',
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h)
                ]))),
          ],
        ),
      ),
    );
  }
}
