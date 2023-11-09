// ignore_for_file: import_of_legacy_library_into_null_safe, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/Model/payload.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/core/dialogmanager.dart';

import 'package:lamar_travel_packages/screen/customize/activity/manageActivity.dart';
import 'package:lamar_travel_packages/screen/customize/flightcustomiz.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/change_room.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/hotelcustomize.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/changetransferifremovesection.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/searchTransferIfBoth.dart';
import 'package:lamar_travel_packages/screen/customize/transfer/transferCoustomize.dart';

import 'package:lamar_travel_packages/widget/cliper.dart';
import 'package:lamar_travel_packages/widget/contantsview.dart';
import 'package:lamar_travel_packages/widget/errordialog.dart';
import 'package:lamar_travel_packages/widget/flight_details_from_customize.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import 'package:lamar_travel_packages/widget/press-indcator-widget.dart';
import 'package:lamar_travel_packages/widget/show_roomdetails.dart';
import 'package:lamar_travel_packages/widget/street_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../main_screen1.dart';

class NewCustomizePage extends StatefulWidget {
  const NewCustomizePage({Key? key}) : super(key: key);
  static String idScreen = 'NewCustomizePage';

  @override
  _NewCustomizePageState createState() => _NewCustomizePageState();
}

class _NewCustomizePageState extends State<NewCustomizePage> {
  List<PayloadElement> distnations = [];
  DialogManager dialogManager = DialogManager();
  late Customizpackage _customizpackage;
  List actvitis = [];
  String formatedcheckIn = '';
  String formatedcheckOut = '';
  bool isLogin = false;

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  loadpackageData() {
    _customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;

    try {
      _customizpackage.result.activities.forEach((key, value) {
        actvitis.addAll(value);
      });
    } catch (e) {
      actvitis.add(Activity(
          name: AppLocalizations.of(context)!.errorNoActivities,
          searchId: '0',
          code: '0',
          activityId: '0',
          modalityCode: '0',
          modalityName: '0',
          amountsFrom: [],
          sellingCurrency: 'ADE',
          netAmount: 0.0,
          paybleCurency: "ADE",
          modalityAmount: 0,
          activityDate: DateTime.now(),
          questions: [],
          rateKey: "rateKey",
          day: 0,
          activityDateDisplay: "activityDateDisplay",
          activityDestination: "activityDestination",
          image: "image",
          description: "description",
          prebook: 1,
          images: []));
    }
    if (!_customizpackage.result.nohotels) {
      DateTime checkIn = _customizpackage.result.hotels[0].checkIn;
      DateTime checkOut = _customizpackage.result.hotels[0].checkOut;

      formatedcheckIn = DateFormat('yyyy-MM-dd ').format(checkIn);
      formatedcheckOut = DateFormat('yyyy-MM-dd').format(checkOut);
    }
  }

  @override
  void initState() {
    loadpackageData();
    getlogin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool e = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      primary: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              child: Center(
                child: Container(
                  width: 25.w,
                  height: 1.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), color: primaryblue.withOpacity(0.2)),
                ),
              ),
            ),
            _spacer(0, 1),
            _customizpackage.result.sameCitiy
                ? const SizedBox()
                : Text(
                    AppLocalizations.of(context)!.yourDepartureFlight,
                    style: textStyle(12.sp, black, FontWeight.w600),
                  ),
            _spacer(0, 1),

            _customizpackage.result.sameCitiy
                ? const SizedBox()
                : _buildTicketContainer(
                    child: _customizpackage.result.noflight
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: _buildNoSectionText(AppLocalizations.of(context)!.flight),

                            //  Text('Click on add button to add your flight'),
                          )
                        : _buildFlightSection(
                            flight: _customizpackage.result.flight!.from, state: 'departure'),
                    child2: _customizpackage.result.noflight
                        ? SizedBox(
                            width: 1.w,
                            height: 1.h,
                            child: _buildAddSection(
                              add: () async {
                                pressIndcatorDialog(context);

                                String customizeId = Provider.of<AppData>(context, listen: false)
                                    .packagecustomiz
                                    .result
                                    .customizeId;

                                try {
                                  await AssistantMethods.sectionManager(context,
                                      action: 'add', section: 'flight', cusID: customizeId);
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _customizpackage = Provider.of<AppData>(context, listen: false)
                                        .packagecustomiz;
                                  });
                                } catch (e) {
                                  Navigator.pop(context);
                                  const Errordislog().error(context, e.toString());
                                }
                              },
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildIcons(
                                icon: 'assets/images/iconss/change.png',
                                onTap: () async {
                                  pressIndcatorDialog(context);
                                  String customizeId = Provider.of<AppData>(context, listen: false)
                                      .packagecustomiz
                                      .result
                                      .customizeId;

                                  try {
                                    await AssistantMethods.changeflight(customizeId,
                                        _customizpackage.result.flight!.flightClass, context);
                                    if (!mounted) return;

                                    Navigator.pop(context);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => FlightCustomize(
                                            failedFlightNamed: '',
                                          ),
                                        ),
                                        (route) => false);
                                  } catch (e) {
                                    Navigator.pop(context);
                                    const Errordislog().error(context, e.toString());
                                  }
                                },
                              ),
                              _buildIcons(
                                  icon: 'assets/images/iconss/tickets.png',
                                  onTap: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        FlightDetial.idScreen, (route) => false);
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => FlightDetial()));
                                  }),
                              _buildIcons(
                                icon: 'assets/images/iconss/delete.png',
                                onTap: () async {
                                  bool willdelete = false;
                                  await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text(
                                              AppLocalizations.of(context)!.confirm,
                                              style: TextStyle(fontSize: titleFontSize),
                                            ),
                                            content: Text(
                                              AppLocalizations.of(context)!
                                                  .areUSureToRemoveServices,
                                              style: const TextStyle(),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  willdelete = true;
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!.remove,
                                                  style: const TextStyle(color: Colors.redAccent),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  willdelete = false;
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(AppLocalizations.of(context)!.cancel),
                                              ),
                                            ],
                                          ));

                                  if (!mounted) return;
                                  if (willdelete == false) return;
                                  pressIndcatorDialog(context);

                                  String customizeId = Provider.of<AppData>(context, listen: false)
                                      .packagecustomiz
                                      .result
                                      .customizeId;

                                  try {
                                    await AssistantMethods.sectionManager(context,
                                        action: 'remove', section: 'flight', cusID: customizeId);
                                    if (!mounted) return;

                                    Navigator.of(context).pop();
                                    setState(() {
                                      loadpackageData();
                                      if (_customizpackage.result.noflight) {
                                        displayTostmessage(context, false,
                                            message:
                                                AppLocalizations.of(context)!.flightHasBeenRemoved);
                                      }
                                    });
                                    // if (!_customizpackage.result.notransfer) {
                                    //   if (_customizpackage.result.noflight &&
                                    //       _customizpackage.result.nohotels) {
                                    //     Navigator.of(context).push(MaterialPageRoute(
                                    //         builder: (context) => ChangeTransferIfRemoveSection(
                                    //               searchType: 'airports',
                                    //               cusId: customizeId,
                                    //               isboth: true,
                                    //               isflight: true,
                                    //               ishotel: true,
                                    //               customizpackage: _customizpackage,
                                    //             )));
                                    //   } else {
                                    //     Navigator.of(context).push(MaterialPageRoute(
                                    //         builder: (context) => ChangeTransferIfRemoveSection(
                                    //               searchType: 'airports',
                                    //               cusId: customizeId,
                                    //               isboth: false,
                                    //               isflight: true,
                                    //               ishotel: false,
                                    //               customizpackage: _customizpackage,
                                    //             )));
                                    //   }
                                    // } else {}
                                  } catch (e) {
                                    Navigator.pop(context);
                                    const Errordislog().error(context, e.toString());
                                  }
                                },
                              ),
                            ],
                          ),
                  ),
            _spacer(0, 3),
            Text(
              _customizpackage.result.hotels.length > 1
                  ? AppLocalizations.of(context)!.yourhotels
                  : AppLocalizations.of(context)!.yourhotel,
              style: textStyle(12.sp, black, FontWeight.w600),
            ),
            _spacer(0, 1),
            _customizpackage.result.hotels.isEmpty
                ? _buildTicketContainer(
                    child: _buildNoSectionText(AppLocalizations.of(context)!.yourhotels),
                    child2: _buildAddSection(
                      add: () async {
                        pressIndcatorDialog(context);

                        String customizeId = Provider.of<AppData>(context, listen: false)
                            .packagecustomiz
                            .result
                            .customizeId;

                        try {
                          await AssistantMethods.sectionManager(context,
                              action: 'add', section: 'hotel', cusID: customizeId);
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          setState(() {
                            _customizpackage =
                                Provider.of<AppData>(context, listen: false).packagecustomiz;
                          });
                        } catch (e) {
                          Navigator.pop(context);
                          const Errordislog().error(context, e.toString());
                        }
                      },
                    ))
                : Column(
                    children: [
                      for (var i = 0; i < _customizpackage.result.hotels.length; i++)
                        _buildTicketContainer(
                          child:
                              // _customizpackage.result.nohotels
                              //     ? _buildNoSectionText('Hotel')
                              //:
                              Column(
                            children: [
                              _buildHotelSection(i, hotel: _customizpackage.result.hotels[i]),
                            ],
                          ),
                          child2:

                              //  _customizpackage.result.nohotels
                              //     ?
                              //     _buildAddSection(
                              //         add: () async {
                              //           Navigator.pushNamed(context, MiniLoader.idScreen);
                              //           String customizeId = Provider.of<AppData>(context, listen: false)
                              //               .packagecustomiz
                              //               .result
                              //               .customizeId;
                              //           try {
                              //             await AssistantMethods.sectionManager(context,
                              //                 action: 'add', section: 'hotel', cusID: customizeId);
                              //             Navigator.of(context).pop();
                              //             setState(() {
                              //               _customizpackage =
                              //                   Provider.of<AppData>(context, listen: false).packagecustomiz;
                              //             });
                              //           } catch (e) {
                              //             Navigator.pop(context);
                              //             Errordislog().error(context, e.toString());
                              //           }
                              //         },
                              //       )
                              //     :
                              SizedBox(
                            width: 100.w,
                            // height: 5.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildIcons(
                                  icon: 'assets/images/iconss/hotel.png',
                                  onTap: () async {
                                    pressIndcatorDialog(context);
                                    try {
                                      if (!mounted) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            CustomizeSlider.idScreen, (route) => false);
                                      }
                                      await AssistantMethods.changehotel(context,
                                          customizeId: _customizpackage.result.customizeId,
                                          checkIn: DateFormat('yyyy-MM-dd')
                                              .format(_customizpackage.result.hotels[i].checkIn),
                                          checkOut: DateFormat('yyyy-MM-dd')
                                              .format(_customizpackage.result.hotels[i].checkOut),
                                          hId: _customizpackage.result.hotels[i].id,
                                          star: '');
                                      if (!mounted) return;
                                      if (!mounted) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            CustomizeSlider.idScreen, (route) => false);
                                      }
                                      Provider.of<AppData>(context, listen: false).gethotelindex(i);
                                      if (!mounted) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            CustomizeSlider.idScreen, (route) => false);
                                      }
                                      Navigator.of(context).pop();
                                      if (!mounted) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            CustomizeSlider.idScreen, (route) => false);
                                      }
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => HotelCustomize(
                                                    oldHotelID: _customizpackage.result.hotels[i].id
                                                        .toString(),
                                                    hotelFailedName: '',
                                                  )),
                                          (route) => false);
                                    } catch (e) {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          CustomizeSlider.idScreen, (route) => false);
                                      // log(e.toString());
                                      const Errordislog().error(context, e.toString());
                                    }
                                  },
                                ),
                                _buildIcons(
                                  icon: 'assets/images/iconss/bed.png',
                                  onTap: () async {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => ChangeRoom(
                                                  hotel: _customizpackage.result.hotels,
                                                  index: i,
                                                )),
                                        (route) => false);
                                  },
                                ),
                                _buildIcons(
                                  icon: 'assets/images/iconss/delete.png',
                                  onTap: () async {
                                    if (_customizpackage.result.hotels.length > 1) {
                                      pressIndcatorDialog(context);
                                      await AssistantMethods.removesplitHotels(context,
                                          id: _customizpackage.result.customizeId,
                                          hotelId: _customizpackage.result.hotels[i].id,
                                          hotelIndex: i);
                                      if (!mounted) return;

                                      Navigator.pop(context);
                                      setState(() {
                                        loadpackageData();
                                      });
                                      if (!mounted) return;

                                      displayTostmessage(context, false,
                                          message: AppLocalizations.of(context)!.hotelHasRemoved);
                                    } else {
                                      bool willdelete = false;
                                      await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(AppLocalizations.of(context)!.confirm),
                                                content: Text(
                                                  AppLocalizations.of(context)!
                                                      .areUSureToRemoveServices,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      willdelete = true;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!.remove,
                                                      style:
                                                          const TextStyle(color: Colors.redAccent),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      willdelete = false;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                        Text(AppLocalizations.of(context)!.cancel),
                                                  ),
                                                ],
                                              ));
                                      if (willdelete == false) return;
                                      if (!mounted) return;

                                      pressIndcatorDialog(context);
                                      String customizeId =
                                          Provider.of<AppData>(context, listen: false)
                                              .packagecustomiz
                                              .result
                                              .customizeId;

                                      try {
                                        if (!mounted) return;

                                        await AssistantMethods.sectionManager(context,
                                            action: 'remove', section: 'hotel', cusID: customizeId);
                                        Navigator.of(context).pop();
                                        setState(() {
                                          setState(() {
                                            loadpackageData();
                                            if (_customizpackage.result.nohotels) {
                                              displayTostmessage(context, false,
                                                  message: AppLocalizations.of(context)!
                                                      .hotelBeenRemoved);
                                            }
                                          });
                                        });

                                        if (!_customizpackage.result.notransfer) {
                                          if (!mounted) return;

                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => ChangeTransferIfRemoveSection(
                                                    searchType: 'hotels',
                                                    cusId: customizeId,
                                                    isboth: false,
                                                    isflight: false,
                                                    ishotel: true,
                                                    customizpackage: _customizpackage,
                                                  )));
                                        } else {}
                                      } catch (e) {
                                        if (!mounted) return;
                                        Navigator.pop(context);
                                        const Errordislog().error(context, e.toString());
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),

            _spacer(0, 2),
            Text(
              AppLocalizations.of(context)!.yourActivity,
              style: textStyle(12.sp, black, FontWeight.w600),
            ),
            _spacer(0, 1),
            _buildTicketContainer(
              child: _buildActivitySection(),
              child2: _customizpackage.result.noActivity
                  ? _buildAddSection(
                      add: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const ManageActivity()),
                            (route) => false);
                      },
                    )
                  : SizedBox(
                      width: 100.w,
                      height: 5.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIcons(
                            icon: 'assets/images/iconss/activities.png',
                            onTap: () async {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => const ManageActivity()),
                                  (route) => false);
                            },
                          ),
                          _buildIcons(
                            icon: 'assets/images/iconss/delete.png',
                            onTap: () async {
                              bool willdelete = false;
                              await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(AppLocalizations.of(context)!.confirm),
                                        content: Text(
                                          AppLocalizations.of(context)!.areUSureToRemoveServices,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              willdelete = true;
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!.remove,
                                              style: const TextStyle(color: Colors.redAccent),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              willdelete = false;
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(AppLocalizations.of(context)!.cancel),
                                          ),
                                        ],
                                      ));
                              if (willdelete == false) return;
                              if (!mounted) return;

                              await AssistantMethods.sectionManager(context,
                                  section: 'activities',
                                  cusID: _customizpackage.result.customizeId,
                                  action: 'remove');
                              if (!mounted) return;

                              await AssistantMethods.updateHotelDetails(
                                  _customizpackage.result.customizeId, context);
                              loadpackageData();
                              if (!mounted) return;

                              if (_customizpackage.result.noActivity) {
                                displayTostmessage(context, false,
                                    message: AppLocalizations.of(context)!.activityHasBeenRemoved);

                                actvitis.clear();
                              }

                              setState(() {});
                            },
                          )
                        ],
                      ),
                    ),
            ),
            _spacer(0, 2),
            Text(
              AppLocalizations.of(context)!.yourTransfer,
              style: textStyle(12.sp, black, FontWeight.w600),
            ),
            _spacer(0, 1),
            _buildTicketContainer(
              child: _customizpackage.result.notransfer
                  ? _buildNoSectionText(AppLocalizations.of(context)!.transfer)
                  : _buildTransferSection(),
              child2: _customizpackage.result.notransfer
                  ? _buildAddSection(
                      add: () async {
                        if (_customizpackage.result.noflight && _customizpackage.result.nohotels) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SearchTransferIfBoth(
                                        cusId: _customizpackage.result.customizeId,
                                      )),
                              (route) => false);
                        } else if (_customizpackage.result.noflight) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ChangeTransferIfRemoveSection(
                                        searchType: 'airports',
                                        cusId: _customizpackage.result.customizeId,
                                        isboth: false,
                                        isflight: true,
                                        ishotel: false,
                                        customizpackage: _customizpackage,
                                      )),
                              (route) => false);
                        } else if (_customizpackage.result.nohotels) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => ChangeTransferIfRemoveSection(
                                        searchType: 'hotels',
                                        cusId: _customizpackage.result.customizeId,
                                        isboth: false,
                                        isflight: false,
                                        ishotel: true,
                                        customizpackage: _customizpackage,
                                      )),
                              (route) => false);
                        } else {
                          pressIndcatorDialog(context);

                          await AssistantMethods.updateThePackage(
                              _customizpackage.result.customizeId);
                          if (!mounted) return;
                          await AssistantMethods.updateHotelDetails(
                              _customizpackage.result.customizeId, context);

                          loadpackageData();
                          if (!mounted) return;

                          Navigator.of(context).pop();

                          if (_customizpackage.result.notransfer) {
                            displayTostmessage(context, false,
                                message: AppLocalizations.of(context)!.cantAddTransferFor,
                                isInformation: true);
                          } else {
                            displayTostmessage(context, false,
                                message: AppLocalizations.of(context)!.transferHasBeenAdded);
                          }

                          setState(() {});

                          // Navigator.of(context)
                          //     .pushNamed(MiniLoader.idScreen);
                          // final isTransReady=    await AssistantMethods.changeTransfer(
                          //     _customizpackage.result.customizeId,
                          //     'IN',
                          //     context);
                          // Navigator.of(context).pop();
                          // if(isTransReady){ Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             TransferCustomize()));
                          //
                          // }
                          // else{
                          //   displayTostmessage(context, true, messeage: 'They are no alternative transfer available at this moments');
                          // }
                        }
                      },
                    )
                  : SizedBox(
                      width: 100.w,
                      //  padding: EdgeInsets.symmetric(horizontal: 34, vertical: 10),
                      child: _customizpackage.result.notransfer
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: OutlinedButton(
                                onPressed: () async {
                                  await AssistantMethods.updateThePackage(
                                      _customizpackage.result.customizeId);

                                  if (!mounted) return;

                                  await AssistantMethods.updateHotelDetails(
                                      _customizpackage.result.customizeId, context);

                                  loadpackageData();
                                  if (!mounted) return;

                                  if (_customizpackage.result.notransfer) {
                                    displayTostmessage(context, true,
                                        message: AppLocalizations.of(context)!.cantAddTransferFor);
                                  } else {
                                    displayTostmessage(context, false,
                                        message:
                                            AppLocalizations.of(context)!.transferHasBeenAdded);
                                  }

                                  setState(() {});
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: greencolor,
                                  side: BorderSide(color: greencolor, width: 1),
                                ),
                                child: const Text('Add Transfer'),
                              ),
                            )
                          : SizedBox(
                              width: 100.w,
                              height: 5.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildIcons(
                                    icon: 'assets/images/iconss/transfer.png',
                                    onTap: () async {
                                      pressIndcatorDialog(context);
                                      try {
                                        final isTransReady = await AssistantMethods.changeTransfer(
                                            _customizpackage.result.customizeId, 'IN', context);
                                        if (!mounted) return;

                                        Navigator.of(context).pop();
                                        if (isTransReady) {
                                          Navigator.of(context).pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) => const TransferCustomize()),
                                              (route) => false);
                                        } else {
                                          if (!mounted) return;

                                          displayTostmessage(context, true,
                                              message: AppLocalizations.of(context)!
                                                  .theyAreNoAlternativeTransfer);
                                        }
                                      } catch (e) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                  _buildIcons(
                                    icon: 'assets/images/iconss/delete.png',
                                    onTap: () async {
                                      bool willdelete = false;
                                      await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(AppLocalizations.of(context)!.confirm),
                                                content: Text(
                                                  AppLocalizations.of(context)!
                                                      .areUSureToRemoveServices,
                                                  style: const TextStyle(),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      willdelete = true;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!.remove,
                                                      style:
                                                          const TextStyle(color: Colors.redAccent),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      willdelete = false;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child:
                                                        Text(AppLocalizations.of(context)!.cancel),
                                                  ),
                                                ],
                                              ));
                                      if (willdelete == false) return;
                                      if (!mounted) return;

                                      String customizeId =
                                          Provider.of<AppData>(context, listen: false)
                                              .packagecustomiz
                                              .result
                                              .customizeId;
                                      if (!mounted) return;

                                      await AssistantMethods.sectionManager(context,
                                          section: 'transfer',
                                          cusID: customizeId,
                                          action: 'remove');
                                      if (!mounted) return;
                                      loadpackageData();

                                      if (_customizpackage.result.notransfer) {
                                        displayTostmessage(context, false,
                                            message: AppLocalizations.of(context)!
                                                .transferHasBeenRemoved);
                                      }
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ),
                    ),
            ),
            _spacer(0, 2),
            (!_customizpackage.result.sameCitiy)
                ? Text(
                    AppLocalizations.of(context)!.yourArrivalFlight,
                    style: textStyle(12.sp, black, FontWeight.w600),
                  )
                : const SizedBox(),
            _spacer(0, 1),
            (!_customizpackage.result.sameCitiy)
                ? _customizpackage.result.flight!.to != null
                    ? _buildTicketContainer(
                        child: _customizpackage.result.noflight
                            ? _buildNoSectionText(AppLocalizations.of(context)!.flight)
                            : _buildFlightSection(
                                flight: _customizpackage.result.flight!.to!, state: 'return'),
                        child2: _customizpackage.result.noflight
                            ? _buildAddSection(add: () async {
                                pressIndcatorDialog(context);
                                String customizeId = Provider.of<AppData>(context, listen: false)
                                    .packagecustomiz
                                    .result
                                    .customizeId;

                                try {
                                  await AssistantMethods.sectionManager(context,
                                      action: 'add', section: 'flight', cusID: customizeId);
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _customizpackage = Provider.of<AppData>(context, listen: false)
                                        .packagecustomiz;
                                  });
                                } catch (e) {
                                  Navigator.pop(context);
                                  const Errordislog().error(context, e.toString());
                                }
                              })
                            : Container(
                                width: 100.w,
                                height: 5.h,
                                padding: EdgeInsets.all(1.5.h),
                                child: _buildIcons(
                                    icon: 'assets/images/iconss/tickets.png',
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          FlightDetial.idScreen, (route) => false);
                                    })))
                    : _spacer(0, 0)
                : _spacer(0, 0),
            _spacer(0, 12),

            // Container(
            //   padding: EdgeInsets.all(5),
            //   height: 60,
            //   color: cardcolor,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           if (isLogin) {
            //             Provider.of<AppData>(context, listen: false).newPreBookTitle('Passengers');
            //             Navigator.pushNamed(context, CheckoutInformation.idScreen);
            //           } else {
            //             isFromBooking = true;
            //             Navigator.of(context).pushNamed(LoginScreen.idscreen);
            //           }
            //         },
            //         child: Text(
            //           "Continue To Checkout",
            //           style: TextStyle(
            //               fontSize: 9.sp,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           primary: primaryblue.withOpacity(0.8),
            //           elevation: 0.0
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Container(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               '${_customizpackage.result.sellingCurrency} ${_customizpackage.result.totalAmount}',
            //               style: TextStyle(
            //                   color: greencolor,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 9.sp),
            //             ),
            //             Text(
            //               'TOTAL PACKAGE PRICE',
            //               style: TextStyle(
            //                   color: greencolor,
            //                   fontWeight: FontWeight.normal,
            //                   fontSize:9.sp),
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget popUpAfterDeleting(StateSetter setState,
      {required bool noflight, required bool nohotels}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        width: 80.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: cardcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${AppLocalizations.of(context)!.removeHotelChangeTheTransfer}\n',
              style: TextStyle(fontSize: titleFontSize + 2),
              textAlign: TextAlign.justify,
            ),
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
                width: 100.w,
                child: TextFormField(
                  onChanged: (q) async {
                    await getPlacese(q);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      prefix: SizedBox(
                        width: 5.w,
                      ),
                      suffixIcon: const Icon(CupertinoIcons.search),
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: subtitleFontSize),
                      hintText: noflight
                          ? 'Select your pickUp location'
                          : 'Select your dropoff loacation'),
                )),
            SizedBox(
              height: 1.h,
            ),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                  itemCount: distnations.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() => e = !e);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: cardcolor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [shadow]),
                        height: 10.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 40.sp,
                              height: 40.sp,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.location_on,
                                color: primaryblue,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(
                              width: 65.w,
                              child: Text(
                                distnations[index].cityName,
                                style: TextStyle(
                                    fontSize: titleFontSize - 1, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle(double fontsize, Color color, FontWeight fontWeight) =>
      TextStyle(fontSize: fontsize, color: color, fontWeight: fontWeight);

  Widget _spacer(double w, double h) => SizedBox(
        height: h.h,
        width: w.w,
      );

  Widget _buildTicketContainer({required Widget child, required Widget child2}) => Column(
        children: [
          ClipPath(
            clipper: MyClipperForShadow(),
            child: Container(
              padding: const EdgeInsets.only(right: 1, bottom: 0, top: 1, left: 1),
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipPath(
                  clipper: MyClipper(),
                  child:
                      Container(padding: const EdgeInsets.all(15), color: cardcolor, child: child)),
            ),
          ),
          SizedBox(
            width: 88.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15, bottom: 5),
              child: fullWidthPath,
            ),
          ),
          ClipPath(
            clipper: MyClipper2ForShadow(),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.grey.withOpacity(0.4),
                ),
                padding: const EdgeInsets.only(right: 1, bottom: 1, top: 0, left: 1),
                width: 100.w,
                height: 8.h,
                child: ClipPath(
                    clipper: MyClipper2(), child: Container(color: cardcolor, child: child2))),
            //_spacer(0, 20),
          ),
          SizedBox(height: 1.h)
        ],
      );

  _buildFlightSection({required From flight, required String state}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Your $state flight',
          //   style: textStyle(12.sp, black, FontWeight.w600),
          // ),
          SizedBox(
            height: 1.h,
          ),
          SizedBox(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${_customizpackage.result.fromCity} - ${_customizpackage.result.toCity}'),
                Text(DateFormat('EEEE dd, MMMM yyyy', genlang).format(flight.departureFdate) +
                    DateFormat('').format(flight.departureFdate)),
                Text(loclizeflightClass(_customizpackage.result.flight!.flightClass)),
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl: flight.itinerary[0].company.logo,
            width: 20.w,
            height: 12.h,
            placeholder: (context, url) => const Center(
                child: ImageSpinning(
              withOpasity: true,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            width: 100.w,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      flight.departureTime,
                      style: TextStyle(fontSize: detailsFontSize),
                    ),
                    Text(
                      flight.departure,
                      style: TextStyle(fontSize: detailsFontSize),
                    )
                  ],
                ),
                Expanded(
                  child: flight.numstops == 0
                      ? Divider(
                          color: yellowColor,
                          thickness: 2,
                          endIndent: 5,
                          indent: 5,
                        )
                      : Row(
                          children: [
                            Expanded(
                              //     width: MediaQuery.of(context).size.width * 0.18,
                              child: Divider(
                                color: yellowColor,
                                thickness: 2,
                                endIndent: 0,
                                indent: 1,
                              ),
                            ),
                            _buildFlightstops(flight: flight.itinerary.first),
                            Expanded(
                              //     width: MediaQuery.of(context).size.width * 0.18,
                              child: Divider(
                                color: yellowColor,
                                thickness: 2,
                                endIndent: 0,
                                indent: 2,
                              ),
                            ),
                          ],
                        ),
                ),
                Column(
                  children: [
                    Text(
                      flight.arrivalTime,
                      style: TextStyle(fontSize: detailsFontSize),
                    ),
                    Text(
                      flight.arrival,
                      style: TextStyle(fontSize: detailsFontSize),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context)!.flightStop(flight.stops.length)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/moon.png'),
                    Text(
                      ' ${flight.travelTime} ',
                      style: TextStyle(fontSize: 9.sp),
                    )
                  ],
                ),
                _spacer(0, 1)
              ],
            ),
          ),
        ],
      );

  Widget _buildHotelSection(int i, {required PackageHotels hotel}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // i == 0
          //     ? Text(
          //         'Your hotel',
          //         style: textStyle(12.sp, black, FontWeight.w600),
          //       )
          //     : SizedBox(),

          _spacer(0, 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  hotel.name,
                  style: TextStyle(fontSize: 12.sp),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              // _customizpackage.result.hotels.length == 0
              //  ?

              // i < 1
              //     ? IconButton(
              //         onPressed: () async {
              //           try {
              //             Navigator.of(context).push(
              //                 MaterialPageRoute(builder: (context) => CustomizeWithNewSlider()));
              //           } catch (e) {
              //             print(e);
              //           }
              //         },
              //         icon: Icon(
              //           Icons.cancel,
              //           color: primaryblue,
              //         ))
              //     : SizedBox(),
            ],
          ),
          _spacer(0, 1),
          // Text(hotel.address)

          SizedBox(
            width: 100.w,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: hotel.image,
                  height: 20.h,
                  width: 30.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: ImageSpinning(
                    withOpasity: true,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                _spacer(3, 0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${DateFormat('MMM, dd', genlang).format(hotel.checkIn)}  -  ${DateFormat('MMM, dd', genlang).format(hotel.checkOut)}',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 5),
                    SmoothStarRating(
                      isReadOnly: true,
                      rating: double.parse(hotel.starRating),
                      color: yellowColor,
                      allowHalfRating: false,
                      borderColor: yellowColor,
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ContanintViwe(
                                      d: _customizpackage.result.hotels[0],
                                      body: _customizpackage.result.hotels[0].description,
                                      title: AppLocalizations.of(context)!.hotelDetails,
                                      urlImage: _customizpackage.result.hotels[0].image,
                                    )),
                            (route) => false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.viewHotelDetails,
                        style: TextStyle(
                          color: primaryblue,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => StreetView(
                                      lat: double.parse(hotel.latitude),
                                      lon: double.parse(hotel.longitude),
                                      isFromCus: true,
                                      isfromHotel: false,
                                    )),
                            (route) => false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.streetview,
                        style: TextStyle(color: primaryblue, fontSize: subtitleFontSize),
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => RoomDetails(
                                      hotel: hotel,
                                    )),
                            (route) => false);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.roomDetails,
                        style: TextStyle(
                          color: primaryblue,
                          fontSize: subtitleFontSize,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _spacer(0, 1)
        ],
      );

  Widget _buildActivitySection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Your activity',
          //   style: textStyle(12.sp, black, FontWeight.w600),
          // ),
          _spacer(0, 1),
          SizedBox(
            height: 30.h,
            child: ListView.builder(
              primary: false,
              itemCount: _customizpackage.result.activities.isNotEmpty
                  ? _customizpackage.result.activities.length
                  : 1,
              itemBuilder: (context, index) {
                return _customizpackage.result.activities.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              margin: const EdgeInsets.only(right: 10),
                              // width: 27.w,
                              height: 7.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat(' dd\nMMM ', genlang)
                                        .format(actvitis[index].activityDate),
                                    style: TextStyle(
                                        fontSize: subtitleFontSize,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: actvitis[index].image,
                                    height: 7.h,
                                    width: 16.w,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: ImageSpinning(
                                      withOpasity: true,
                                    )),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/images/image-not-available.png',
                                      height: 200,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${actvitis[index].name}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                    Text(
                                      '${actvitis[index].description}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 100,
                              height: 150,
                              child: Image.asset(
                                'assets/images/image-not-available.png',
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.errorNoActivities,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 3,
                                style: TextStyle(fontSize: titleFontSize),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      );

  Widget _buildTransferSection() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Your transfer',
          //   style: textStyle(12.sp, black, FontWeight.w600),
          // ),
          _spacer(0, 1),
          _customizpackage.result.notransfer || _customizpackage.result.transfer.isEmpty
              ? SizedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    color: cardcolor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Transfer',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(AppLocalizations.of(context)!.theyAreNoTransfer),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: 100.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.toHotel,
                          style: TextStyle(fontSize: titleFontSize)),
                      Row(
                        children: [
                          CachedNetworkImage(
                              imageUrl: _customizpackage.result.transfer[0].image,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                      child: ImageSpinning(
                                    withOpasity: true,
                                  )),
                              errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/image-not-available.png',
                                    height: 150,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )),
                          Container(
                            width: 45.w,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                                ),
                                Text(
                                  "${_customizpackage.result.transfer[0].serviceTypeName} ${_customizpackage.result.transfer[0].vehicleTypeName}",
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dates,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                                ),
                                Text(
                                  _customizpackage.result.transfer[0].date,
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.pickup,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  _customizpackage.result.transfer[0].pickUpLocation,
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dropOff,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  _customizpackage.result.transfer[0].dropOffLocation,
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.50),
                        endIndent: 20,
                        indent: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.toAirport,
                        style: TextStyle(fontSize: titleFontSize),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                              imageUrl: _customizpackage.result.transfer[1].image,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                      child: ImageSpinning(
                                    withOpasity: true,
                                  )),
                              errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/image-not-available.png',
                                    height: 150,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  )),
                          Container(
                            width: 45.w,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                                ),
                                Text(
                                  "${_customizpackage.result.transfer[1].serviceTypeName} ${_customizpackage.result.transfer[1].vehicleTypeName}",
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dates,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: subtitleFontSize),
                                ),
                                Text(
                                  _customizpackage.result.transfer[1].date,
                                  style: TextStyle(fontSize: detailsFontSize),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.pickup,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  _customizpackage.result.transfer[1].pickUpLocation,
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dropOff,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: subtitleFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                Text(
                                  _customizpackage.result.transfer[1].dropOffLocation,
                                  style: TextStyle(
                                    fontSize: detailsFontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: false,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
        ],
      );

  Widget _buildFlightstops({required Itinerary flight}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: _customizpackage.result.flight!.from.stops.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '●',
                          style: TextStyle(
                              color: yellowColor, fontWeight: FontWeight.bold, fontSize: 12.sp),
                        ),
                        Text(
                          flight.arrival.locationId,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryblue,
                            decorationThickness: 0.5,
                          ),
                        ),
                        Text(
                          durationToString(flight.flightTime),
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryblue,
                            decorationThickness: 0.5,
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Divider(
                        color: yellowColor,
                        thickness: 2,
                        endIndent: 0,
                        indent: 0,
                      ),
                    ),
            ),
          ],
        ),
      );

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return ' ${parts[0].padLeft(2, '0')}h ${parts[1].padLeft(2, '0')}m';
  }

  String packagesIncluding(Customizpackage customizePackage) {
    String including = '';
    String flight = '';
    String hotel = '';
    String activity = '';
    String transffer = '';

    if (customizePackage.result.noActivity == false) {
      activity = 'Daily Tours+';
    }
    if (customizePackage.result.noflight == false) {
      flight = 'Flight+';
    }
    if (customizePackage.result.nohotels == false) {
      hotel = 'Hotel+';
    }
    if (customizePackage.result.notransfer == false) {
      hotel = 'transfer+';
    }

    including = hotel + flight + transffer + activity;

    if (including.endsWith('+')) {
      including = including.substring(0, including.length - 1);
    }

    return including;
  }

  Widget get fullWidthPath {
    return DottedBorder(
      customPath: (size) {
        return Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height);
      },
      color: Colors.grey.withOpacity(0.4),
      strokeWidth: 4,
      strokeCap: StrokeCap.round,
      dashPattern: const [0, 10],
      borderType: BorderType.Circle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          height: 0,
          // color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildAddSection({required VoidCallback add}) => InkWell(
        onTap: add,
        child: Container(
            padding: EdgeInsets.all(2.h),
            child: Image.asset(
              'assets/images/iconss/more.png',
              width: 7.sp,
              color: primaryblue,
            )),
      );

  Widget _buildIcons({required String icon, required VoidCallback onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(
            icon,
            width:
                //7.w,

                icon == 'assets/images/iconss/hotel(1).png' ? 8.w : 7.w,
            color: primaryblue,
          ),
        ),
      );

  Widget _buildNoSectionText(String section) => Container(
        width: 100.w,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text('$section ${AppLocalizations.of(context)!.removeSectionMsG} $section'),
        ),
      );

//? FUNCTIONS

  getPlacese(String q) async {
    await AssistantMethods.searchForTransferDistnation(q, context);

    setState(() {
      distnations = Provider.of<AppData>(context, listen: false)
          .distnationfortransfer
          .where((element) => element.cityName.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }

  String loclizeflightClass(String val) {
    switch (val) {
      case "Economy":
        {
          return AppLocalizations.of(context)!.economic;
        }
      case "Business":
        {
          return AppLocalizations.of(context)!.business;
        }
      default:
        {
          return val;
        }
    }
  }
}

Future pressIndcatorDialog(BuildContext context) => showDialog(
    barrierDismissible: false, context: context, builder: (context) => const PressIndcator());
