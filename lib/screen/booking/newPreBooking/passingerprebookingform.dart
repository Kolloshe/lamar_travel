// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_packages_screen.dart';
import 'package:provider/provider.dart';

import '../../../config.dart';
import 'package:sizer/sizer.dart';

import 'new_passingerform.dart';

class NewPassingerPerBookingForm extends StatefulWidget {
 const NewPassingerPerBookingForm({Key? key, required this.toNextPage, required this.fromIndv})
      : super(key: key);
  final VoidCallback toNextPage;
  final bool fromIndv;

  @override
  _NewPassingerPerBookingFormState createState() => _NewPassingerPerBookingFormState();
}

class _NewPassingerPerBookingFormState extends State<NewPassingerPerBookingForm>
    with SingleTickerProviderStateMixin {
  bool noFlight = false;
  final PageController _controller = PageController();

  late AnimationController _animationController;

  late Animation<Offset> _animation;

  late Customizpackage _customizpackage;

  List<String> passingerId = [];
  int adultCounts = 0;
  getData() {
    _customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;

    noFlight = _customizpackage.result.noflight;

    int adultCount = _customizpackage.result.adults;
    adultCounts = adultCount;
    int childCount = _customizpackage.result.children;

    for (var i = 0; i < adultCount; i++) {
      passingerId.add('adult');
    }
    for (var i = 0; i < childCount; i++) {
      passingerId.add('child');
    }
  }

  @override
  void initState() {
    getData();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    // Provider.of<AppData>(context, listen: false).newSearchTitle('When will you be there');
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SizedBox.expand(
        child: DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.7,
            initialChildSize: 0.8,
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
                          Expanded(
                              child: SingleChildScrollView(
                                  //   controller: scrollController,
                                  child: _buildPassngerFromWithTitle('adult'))),
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }

  Widget _buildPassngerFromWithTitle(String title) => SizedBox(
        height: 90.h,
        child: PageView.builder(
          // key: ,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics:const NeverScrollableScrollPhysics(),
          itemCount: passingerId.length,
          itemBuilder: (context, ind) => Column(
            children: [
              SizedBox(
                width: 100.w,
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (_controller.page == 0.0) {
                            if (widget.fromIndv || context.read<AppData>().searchMode != '') {
                              Navigator.of(context)
                                ..pop()
                                ..pushReplacement(MaterialPageRoute(
                                    builder: (context) =>const IndividualPackagesScreen()));
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  CustomizeSlider.idScreen, (route) => false);
                            }
                          } else {
                            _controller.previousPage(
                                duration: const Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
                          }
                        },
                        icon: Icon(
                          Provider.of<AppData>(context, listen: false).locale ==const Locale('en')
                              ? Icons.keyboard_arrow_left
                              : Icons.keyboard_arrow_right,
                          color: primaryblue,
                        )),
                    Container(
                      width: 70.w,
                      alignment: Alignment.center,
                      child: Text(
                        Provider.of<AppData>(context, listen: false).locale ==const Locale('en')
                            ? passingerId[ind].toLowerCase().startsWith('a')
                                ? _buildpassingername(ind) +
                                    '' +
                                    " ${localizepassengertype(passingerId[ind])}"
                                : _buildpassingername(ind - adultCounts) +
                                    '' +
                                    " ${localizepassengertype(passingerId[ind])}"
                            : passingerId[ind].toLowerCase().startsWith('a')
                                ? " ${localizepassengertype(passingerId[ind])}" " " +
                                    _buildpassingername(ind)
                                : " ${localizepassengertype(passingerId[ind])}" " " +
                                    _buildpassingername(ind - adultCounts)

                        // ${localizepassengertype(passingerId[ind])} +
                        //  ' ' +passingerId[ind].toLowerCase().startsWith('a')?
                        //  _buildpassingername(ind)
                        // : _buildpassingername( ind-adultCounts)
                        ,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              NewPassingerForm(
                isAdult: passingerId[ind] == 'adult' ? true : false,
                numberofpassinger: ind + 1,
                ids: passingerId[ind],
                isupdate: false,
                noFlight: noFlight,
                ontap: () {
                  if (_controller.page == passingerId.length - 1) {
                    if (Provider.of<AppData>(context, listen: false).isFlightFaildFromForm) {
                      Provider.of<AppData>(context, listen: false).resetFlightFromForm(false);
                      Navigator.of(context).pop();
                    } else {
                      Provider.of<AppData>(context, listen: false)
                          .newPreBookTitle(AppLocalizations.of(context)!.specialRequest);
                      widget.toNextPage();
                    }
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                  }
                },
              )
            ],
          ),
        ),
      );

  String _buildpassingername(num i) {
    String name = '';
    switch (i) {
      case 0:
        name = AppLocalizations.of(context)!.first;
        break;
      case 1:
        name = AppLocalizations.of(context)!.second;
        break;
      case 2:
        name = AppLocalizations.of(context)!.third({i + 1}.toString());
        break;

      default:
        name = AppLocalizations.of(context)!
            .lastpass({i + 1}.toString().replaceAll('{', '').replaceAll('}', ''));
    }
    return name;
  }

  String localizepassengertype(String val) {
    switch (val) {
      case "adult":
        {
          return AppLocalizations.of(context)!.adult;
        }
      case "child":
        {
          return AppLocalizations.of(context)!.child;
        }
      default:
        {
          return val;
        }
    }
  }
}
