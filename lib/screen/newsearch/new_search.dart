// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_travel_insurance/trave_insurance_form.dart';
import 'package:lamar_travel_packages/screen/individual_services/privet_jet_information.dart';

import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/newsearch/advance_search.dart';
import 'package:lamar_travel_packages/screen/newsearch/select_citiy_for_transfer.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'newSearch-datePicker.dart';
import 'new_search_citiy_payload.dart';
import 'new_search_room_passinger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<String> images = [
  'assets/images/vectors/from.png',
  'assets/images/vectors/from.png',
  'assets/images/vectors/to.png',
  'assets/images/vectors/dates.png',
  'assets/images/vectors/pax.png',
  'assets/images/vectors/pref.png',
  'assets/images/vectors/pref.png',
  'assets/images/vectors/pref.png'
];

class SearchStepper extends StatefulWidget {
  static String idScreen = 'SearchStepper';

  SearchStepper({Key? key, required this.isFromNavBar, required this.section, this.searchMode})
      : super(key: key);
  bool isFromNavBar = false;
  int section = -1;
  final String? searchMode;

  @override
  _SearchStepperState createState() => _SearchStepperState();
}

class _SearchStepperState extends State<SearchStepper> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late Animation<double> _animation;
  String x = 'dd';
  int i = -1;

  @override
  void initState() {
    // i = -1;
    i = widget.section;
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: 100.w,
                child: FadeTransition(
                    opacity: _animation,
                    child: Image.asset(
                      images[i + 2],
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Builder(builder: (context) {
              switch (i) {
                case -2:
                  {
                    if (animate) {
                      _controller.forward();

                      if (_controller.isCompleted) {
                        _controller
                          ..reset()
                          ..forward();
                      }
                      animate = false;
                    }

                    return SelectCityForTransfer(
                      onTap: () {
                        animate = true;
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                        setState(() {
                          i = -1;
                        });
                      },
                      back: () {
                        if (widget.isFromNavBar) {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      toRechangeCitiy: () {
                        animate = true;
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_Are_You_Going);
                        setState(() {
                          i = -1;
                        });
                      },
                      isfromnavbar: () {
                        if (widget.isFromNavBar) {
                          Provider.of<AppData>(context, listen: false)
                              .newSearchTitle(AppLocalizations.of(context)!.where_From);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                        } else {
                          Navigator.of(context).pop();
                          Provider.of<AppData>(context, listen: false)
                              .newSearchTitle(AppLocalizations.of(context)!.where_From);
                        }
                      },
                      x: '',
                    );
                  }

                case -1:
                  if (animate) {
                    _controller.forward();

                    if (_controller.isCompleted) {
                      _controller
                        ..reset()
                        ..forward();
                    }
                    animate = false;
                  }

                  return RechagethefromCitiy(
                      isfromnavbar: () {
                        if (widget.isFromNavBar) {
                          Provider.of<AppData>(context, listen: false)
                              .newSearchTitle(AppLocalizations.of(context)!.where_From);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                        } else {
                          Navigator.of(context).pop();
                          Provider.of<AppData>(context, listen: false)
                              .newSearchTitle(AppLocalizations.of(context)!.where_From);
                        }
                      },
                      toRechangeCitiy: () {
                        animate = true;
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_Are_You_Going);
                        setState(() {
                          i = 0;
                        });
                      },
                      back: () {
                        if (context.read<AppData>().searchMode.contains('transfer')) {
                          i = -2;
                          setState(() {});
                        } else {
                          if (widget.isFromNavBar) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      x: '',
                      onTap: () {
                        animate = true;
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                        setState(() {
                          i = 0;
                        });
                      });
                case 0:
                  if (animate) {
                    _controller.forward();
                    if (_controller.isCompleted) {
                      _controller
                        ..reset()
                        ..forward();
                    }
                    animate = false;
                  }

                  //  Provider.of<AppData>(context, listen: false).title = 'Where To';

                  return CitiesPayload(
                    isfromnavbar: () {
                      if (widget.isFromNavBar) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                      } else {
                        Navigator.of(context).pop();
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                      }
                    },
                    x: '',
                    toRechangeCitiy: () {
                      animate = true;
                      if (context.read<AppData>().searchMode.toLowerCase().trim() != 'hotel' &&
                          context.read<AppData>().searchMode.toLowerCase().trim() != 'activity') {
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                        setState(() {
                          i = -1;
                        });
                      } else {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                      }
                    },
                    onTap: () {
                      animate = true;
                      if (Provider.of<AppData>(context, listen: false).payloadFrom != null) {
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.when_will_you_be_there);
                        setState(() {
                          i = 1;
                        });
                      } else {
                        displayTostmessage(context, true,
                            message: AppLocalizations.of(context)!.errorAddYorCurrentLocation);
                      }
                    },
                  );

                case 1:
                  _controller.forward();

                  if (animate) {
                    _controller.forward();

                    if (_controller.isCompleted) {
                      _controller
                        ..reset()
                        ..forward();
                    }
                    animate = false;
                  }

                  return DateRangePickers(
                    isfromnavbar: () {
                      if (widget.isFromNavBar) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                      } else {
                        Navigator.of(context).pop();
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.where_From);
                      }
                    },
                    next: () {
                      animate = true;
                      setState(() {
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.who_Coming);
                        i = 2;
                      });
                    },
                    ontap: () {
                      animate = true;
                      Provider.of<AppData>(context, listen: false)
                          .newSearchTitle(AppLocalizations.of(context)!.where_Are_You_Going);
                      setState(() {
                        i = 0;
                      });
                    },
                  );

                case 2:
                  if (animate) {
                    _controller.forward();

                    if (_controller.isCompleted) {
                      _controller
                        ..reset()
                        ..forward();
                    }
                    animate = false;
                  }

                  return NewSearchRoomAndPassinger(isfromnavbar: () {
                    if (widget.isFromNavBar) {
                      Provider.of<AppData>(context, listen: false)
                          .newSearchTitle(AppLocalizations.of(context)!.where_From);
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(TabPage.idScreen, (route) => false);
                    } else {
                      Navigator.of(context).pop();
                      Provider.of<AppData>(context, listen: false)
                          .newSearchTitle(AppLocalizations.of(context)!.where_From);
                    }
                  }, next: () {
                    Provider.of<AppData>(context, listen: false)
                        .newSearchTitle(AppLocalizations.of(context)!.travelerDetails);
                    i = 4;

                    setState(() {});
                  }, ontap: () {
                    animate = true;
                    Provider.of<AppData>(context, listen: false)
                        .newSearchTitle(AppLocalizations.of(context)!.when_will_you_be_there);
                    setState(() {
                      i = 1;
                    });
                  });

                case 3:
                  _controller.forward();

                  if (animate) {
                    _controller.forward();

                    if (_controller.isCompleted) {
                      _controller
                        ..reset()
                        ..forward();
                    }
                    animate = false;
                  }

                  return AdvanceSearchOption(
                      next: () {},
                      ontap: () {
                        animate = true;
                        Provider.of<AppData>(context, listen: false)
                            .newSearchTitle(AppLocalizations.of(context)!.who_Coming);
                        setState(() {
                          i = 2;
                        });
                      });

                case 4:
                  {
                    _controller.forward();

                    if (animate) {
                      _controller.forward();

                      if (_controller.isCompleted) {
                        _controller
                          ..reset()
                          ..forward();
                      }
                      animate = false;
                    }
                    return PrivetJetInformation(next: () {
                      i = 5;
                      setState(() {});
                    }, onTapBack: () {
                      i = 2;
                      setState(() {});
                    });
                  }
                case 5:
                  {
                    _controller.forward();

                    if (animate) {
                      _controller.forward();

                      if (_controller.isCompleted) {
                        _controller
                          ..reset()
                          ..forward();
                      }
                      animate = false;
                    }
                    return TravelInsuranceForms(
                      onTapBack: () {
                        i = 4;
                        setState(() {});
                      },
                      next: () {},
                    );
                  }

                default:
                  return Container();
              }
            }),
          ],
        ));
  }
}
