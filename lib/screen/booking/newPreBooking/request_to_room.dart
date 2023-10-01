import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';

class RequestToTheRoom extends StatefulWidget {
  const RequestToTheRoom({Key? key, required this.tonextPage, required this.goback}) : super(key: key);
  final VoidCallback tonextPage;
  final VoidCallback goback;

  @override
  // ignore: library_private_types_in_public_api
  _RequestToTheRoomState createState() => _RequestToTheRoomState();
}

class _RequestToTheRoomState extends State<RequestToTheRoom> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _animation;

  bool requireaSmokingRoom = false;
  bool requestRoomonaLowFloor = false;
  bool honeymoonTrip = false;
  bool celebratingBirthday = false;
  bool requireaNonSmokingRoom = false;
  bool requestRoomonaHighFloor = false;
  bool requestforaBabyCot = false;
  bool celebratingAnniversary = false;
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize: 0.75,
          initialChildSize: 0.78,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return NotificationListener(
              onNotification: (OverscrollNotification notification) {
                if (notification.metrics.pixels == -1.0) {}
                return true;
              },
              child: Container(
                  padding: const EdgeInsets.all(15),
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
                        Container(
                          alignment:
                              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          width: 100.w,
                          child: IconButton(
                              onPressed: () {
                                widget.goback();
                                Provider.of<AppData>(context, listen: false).newPreBookTitle(
                                    AppLocalizations.of(context)!.passengersInformation);
                              },
                              icon: Icon(
                                Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                    ? Icons.keyboard_arrow_left
                                    : Icons.keyboard_arrow_right,
                                color: primaryblue,
                                size: 30,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: cardcolor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.0),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: (const Offset(0, 1)),
                                ),
                              ],
                            ),
                            //   height: 40.h,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.rSmokingRoom),
                                      value: requireaSmokingRoom,
                                      onChanged: (v) {
                                        setState(() {
                                          requireaSmokingRoom = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.nSmokingRoom),
                                      value: requireaNonSmokingRoom,
                                      onChanged: (v) {
                                        setState(() {
                                          requireaNonSmokingRoom = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.rLowFloor),
                                      value: requestRoomonaLowFloor,
                                      onChanged: (v) {
                                        setState(() {
                                          requestRoomonaLowFloor = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.rHighFloor),
                                      value: requestRoomonaHighFloor,
                                      onChanged: (v) {
                                        setState(() {
                                          requestRoomonaHighFloor = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.honeymoonTrip),
                                      value: honeymoonTrip,
                                      onChanged: (v) {
                                        setState(() {
                                          honeymoonTrip = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(AppLocalizations.of(context)!.rBabyCot),
                                      value: requestforaBabyCot,
                                      onChanged: (v) {
                                        setState(() {
                                          requestforaBabyCot = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title:
                                          Text(AppLocalizations.of(context)!.celebratingBirthday),
                                      value: celebratingBirthday,
                                      onChanged: (v) {
                                        setState(() {
                                          celebratingBirthday = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    child: CheckboxListTile(
                                      title: Text(
                                          AppLocalizations.of(context)!.celebratingAnniversary),
                                      value: celebratingAnniversary,
                                      onChanged: (v) {
                                        setState(() {
                                          celebratingAnniversary = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      // border: Border.all(color: Colors.grey.shade500, width: 1, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onTap: () {
                                        // scrollController
                                        //     .jumpTo(scrollController.position.maxScrollExtent);
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)!.wUAddComment,
                                          border: InputBorder.none),
                                      controller: commentController,
                                      maxLength: 150,
                                      maxLines: 4,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(90.w, 6.h), backgroundColor: yellowColor),
                            onPressed: () {
                              if (context.read<AppData>().hasQuestions) {
                                context.read<AppData>().newPreBookTitle('Questions');
                              }

                              widget.tonextPage();

                              Provider.of<AppData>(context, listen: false).prebookdata(
                                  requireaSmokingRoom1: requireaSmokingRoom,
                                  requireaNonSmokingRoom1: requireaNonSmokingRoom,
                                  requestRoomonaLowFloor1: requestRoomonaLowFloor,
                                  requestRoomonaHighFloor1: requestRoomonaHighFloor,
                                  honeymoonTrip1: honeymoonTrip,
                                  requestforaBabyCot1: requestforaBabyCot,
                                  celebratingBirthday1: celebratingBirthday,
                                  celebratingAnniversary1: celebratingAnniversary,
                                  other: '');
                            },
                            child: Text(AppLocalizations.of(context)!.next))
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
