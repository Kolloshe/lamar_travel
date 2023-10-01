
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/activity_questions.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';

class ShowActivityQuestions extends StatefulWidget {
  const ShowActivityQuestions({Key? key, required this.toNextPage, required this.goback})
      : super(key: key);

  final VoidCallback toNextPage;
  final VoidCallback goback;

  @override
  _ShowActivityQuestionsState createState() => _ShowActivityQuestionsState();
}

class _ShowActivityQuestionsState extends State<ShowActivityQuestions>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  ActivityQuestions? activityQuestions;

  late AnimationController _animationController;

  late Animation<Offset> _animation;
  TextEditingController commentController = TextEditingController();
  bool accept = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    activityQuestions = context.read<AppData>().getActivityQuestions;

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
          maxChildSize: 0.8,
          minChildSize: 0.7,
          initialChildSize: 0.7,
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
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
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
                                  if (context.read<AppData>().searchMode.contains('activity')) {
                                    Provider.of<AppData>(context, listen: false).newPreBookTitle(
                                        AppLocalizations.of(context)!.passengersInformation);
                                  } else {
                                    Provider.of<AppData>(context, listen: false).newPreBookTitle(
                                        AppLocalizations.of(context)!.specialRequest);
                                  }
                                },
                                icon: Icon(
                                  Provider.of<AppData>(context, listen: false).locale ==
                                          const Locale('en')
                                      ? Icons.keyboard_arrow_left
                                      : Icons.keyboard_arrow_right,
                                  color: primaryblue,
                                  size: 30,
                                )),
                          ),
                          Expanded(
                              child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  'Please answer the questions for the activities',
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0; i < activityQuestions!.data!.length; i++)
                                          _buildQuestionsFormWithAnswers(
                                              activityQuestions!.data![i])
                                      ]),
                                ),
                              ],
                            ),
                          )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(90.w, 6.h), backgroundColor: yellowColor),
                              onPressed: () {
                                final valid = _formKey.currentState!.validate();
                                if (valid) {
                                  _formKey.currentState!.save();
                                  widget.toNextPage();
                                }
                              },
                              child: const Text('Next'))
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }

  Widget _buildQuestionsFormWithAnswers(Questions data) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade100, offset: const Offset(1, 1), blurRadius: 5, spreadRadius: 5),
      ]),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${data.activityName} this activity ask for \n'),
          SizedBox(
              width: 100.w,
              child: Text(
                '${data.text}?',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              )),
          TextFormField(
            keyboardType: data.ibhCode.toLowerCase().contains('phone')
                ? TextInputType.phone
                : TextInputType.name,
            decoration: const InputDecoration(
              hintText: 'Answer',
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Please answer this Questions';
              } else {
                return null;
              }
            },
            onSaved: (v) {
              data.answer = v;
            },
          ),
          SizedBox(
            height: 1.h,
          )
        ],
      ),
    );
  }
}
