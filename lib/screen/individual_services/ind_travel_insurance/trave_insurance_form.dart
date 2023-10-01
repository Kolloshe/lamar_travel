// ignore_for_file: implementation_imports, library_private_types_in_public_api, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/travel_insurance_pax_details_data.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/individual_products/ind_user_input_field.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class TravelInsuranceForms extends StatefulWidget {
  const TravelInsuranceForms({Key? key, required this.next, required this.onTapBack})
      : super(key: key);
  final VoidCallback next;

  final VoidCallback onTapBack;

  @override
  _TravelInsuranceFormsState createState() => _TravelInsuranceFormsState();
}

class _TravelInsuranceFormsState extends State<TravelInsuranceForms>
    with SingleTickerProviderStateMixin {
  int adultCount = 1;
  int olderCount = 0;
  int childCount = 0;
  int pax = 1;

  bool isLastPax = false;

  final _formKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final nationality = TextEditingController();
  final middleName = TextEditingController();
  final _controller = PageController();
  late AnimationController _animationController;

  late Animation<Offset> _animation;
  List<TravelInsurancePaxDetailsData?> paxData = [];

  Map paxMap = {};

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    _animationController.forward();

    final data = context.read<AppData>().allPax;
    if (data.isNotEmpty) {
      adultCount = data['adult'];
      olderCount = data['old'];
      childCount = data['child'];

      pax = (adultCount - 1) + olderCount + childCount;
    }
    final preList = context.read<AppData>().travelInsurancePaxDetailsList;
    if (preList.isEmpty) {
      paxData = List.generate(pax, (index) => null);
    } else {
      if (preList.length == pax) {
        paxData = preList;
      } else {
        final newLen = pax - preList.length;
        final newEmptyList = List.generate(newLen, (index) => null);
        paxData = [...preList, ...newEmptyList];
      }
    }

    for (int i = 0; i < pax; i++) {
      if ((i + 1) < adultCount) {
        paxMap.putIfAbsent(i, () => 'adult');
      }
      if ((i + 1) - adultCount < childCount) {
        paxMap.putIfAbsent(i, () => 'child');
      }
      if ((i + 1) - (adultCount + childCount) < olderCount) {
        paxMap.putIfAbsent(i, () => 'senior Traveller');
      }
    }

    log(paxMap.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize: 0.65,
          initialChildSize: 0.8,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return NotificationListener(
              onNotification: (OverscrollNotification notification) {
                if (notification.metrics.pixels == -1.0) {
                  // widget.isfromnavbar();
                }
                return true;
              },
              child: Container(
                  padding: const EdgeInsets.all(20).copyWith(top: 10),
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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            SizedBox(
                                width: 6.w,
                                child: InkWell(
                                    onTap: () {
                                      if (_controller.page!.toInt() == 0) {
                                        widget.onTapBack();
                                      } else {
                                        _controller.previousPage(
                                            duration: const Duration(milliseconds: 250),
                                            curve: Curves.fastOutSlowIn);
                                      }
                                    },
                                    child: Icon(
                                      Provider.of<AppData>(context, listen: false).locale ==
                                              const Locale('en')
                                          ? Icons.keyboard_arrow_left
                                          : Icons.keyboard_arrow_right,
                                      color: primaryblue,
                                      size: 30.sp,
                                    ))),
                            SizedBox(
                              width: 80.w,
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    Provider.of<AppData>(context, listen: false).title,
                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: 80.h,
                              width: 100.w,
                              child: PageView.builder(
                                controller: _controller,
                                itemCount: pax,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => TravelINDForm(
                                  index: index,
                                  paxId: paxMap[index],
                                  total: pax,
                                  onTapNext: () async {
                                    if (pax > index + 1) {
                                      _controller.animateToPage((_controller.page! + 1).toInt(),
                                          duration: const Duration(milliseconds: 250),
                                          curve: Curves.ease);
                                    } else if (pax > index + 1) {
                                      return;
                                    } else {
                                      final searchMode = context.read<AppData>().searchMode;


                                      final preData = context.read<AppData>();
                                      var holder = preData.holderDetails;

                                      holder.remove('nationalityCountryName');
                                      final beneficiaries = preData.travelInsurancePaxDetailsList
                                          .map((e) => e!.toJson())
                                          .toList();

                                      if (searchMode.contains('privet jet')) {
                                        pressIndcatorDialog(context);

                                        final preData = context.read<AppData>();

                                        Map<String, dynamic> privetJetRequestData = {};
                                        switch (preData.privetJetDateInformation['tripType']) {
                                          case "round":
                                            {
                                              privetJetRequestData = {
                                                "search_type":
                                                    preData.privetJetDateInformation['tripType'],
                                                "from": preData.payloadFrom!.id,
                                                "to": preData.payloadto.id,
                                                "departure":
                                                    preData.privetJetDateInformation['departure'],
                                                "return":
                                                    preData.privetJetDateInformation['return'],
                                                "category_id": preData.minCategory,
                                                "pax": preData.getPax,
                                                "holder": holder,
                                                "beneficiaries": beneficiaries
                                              };
                                              break;
                                            }
                                          case "one":
                                            {
                                              privetJetRequestData = {
                                                "search_type":
                                                    preData.privetJetDateInformation['tripType'],
                                                "from": preData.payloadFrom!.id,
                                                "to": preData.payloadto.id,
                                                "departure":
                                                    preData.privetJetDateInformation['departure'],
                                                "category_id": preData.minCategory,
                                                "pax": preData.getPax,
                                                "holder": holder,
                                                "beneficiaries": beneficiaries,
                                              };
                                              break;
                                            }
                                          default:
                                            {
                                              displayTostmessage(context, true, message: 'Error');
                                              return;
                                            }
                                        }
                                        final req = jsonEncode(privetJetRequestData);
                                        log(req);
                                        final res =
                                            await AssistantMethods.sendPrivetJet(context, req);
                                               if (!mounted) return;
                                        Navigator.of(context).pop();
                                        if (res) {
                                          Dialogs.materialDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              color: Colors.white,
                                              msg: AppLocalizations.of(context)!
                                                  .successToFormattingTravelIn,
                                              title: AppLocalizations.of(context)!.hurray,
                                              lottieBuilder: Lottie.asset(
                                                'assets/images/loading/done.json',
                                                fit: BoxFit.contain,
                                              ),
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                        MainScreen.idScreen, (route) => false);
                                                  },
                                                  text: AppLocalizations.of(context)!.close,
                                                  color: primaryblue,
                                                  textStyle: const TextStyle(color: Colors.white),
                                                ),
                                              ]);
                                        } else {
                                      
                                              context.read<AppData>().getPrivetJetResponse;

                                          Dialogs.materialDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              color: Colors.white,
                                              msg: AppLocalizations.of(context)!
                                                  .failedToFormatTravelIN,
                                              title: AppLocalizations.of(context)!.errorHappened,
                                              lottieBuilder: Lottie.asset(
                                                'assets/images/loading/failed.json',
                                                fit: BoxFit.contain,
                                              ),
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  text: AppLocalizations.of(context)!.cancel,
                                                  color: primaryblue,
                                                  textStyle: const TextStyle(color: Colors.white),
                                                ),
                                              ]);
                                        }
                                      } else {
                                        pressIndcatorDialog(context);

                                        Map<String, dynamic> req = {
                                          "from": preData.payloadFrom!.countryCode,
                                          "to": preData.payloadto.countryCode,
                                          "departure": {
                                            "date": DateFormat('yyyy-MM-dd')
                                                .format(preData.newSearchFirstDate!),
                                            "time": null
                                          },
                                          "return": {
                                            "date": DateFormat('yyyy-MM-dd')
                                                .format(preData.newSearchsecoundDate!),
                                            "time": null
                                          },
                                          "category_id": null,
                                          "holder": holder,
                                          "beneficiaries": beneficiaries
                                        };
                                        final res = await AssistantMethods.sendTravelInsurance(
                                            json.encode(req));
                                               if (!mounted) return;
                                        Navigator.of(context).pop();
                                        if (res) {
                                          Dialogs.materialDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              color: Colors.white,
                                              msg: AppLocalizations.of(context)!
                                                  .successToFormattingTravelIn,
                                              title: AppLocalizations.of(context)!.hurray,
                                              lottieBuilder: Lottie.asset(
                                                'assets/images/loading/done.json',
                                                fit: BoxFit.contain,
                                              ),
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                                        MainScreen.idScreen, (route) => false);
                                                  },
                                                  text: 'Close',
                                                  color: primaryblue,
                                                  textStyle: const TextStyle(color: Colors.white),
                                                ),
                                              ]);
                                        } else {
                                          Dialogs.materialDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              color: Colors.white,
                                              msg: AppLocalizations.of(context)!
                                                  .failedToFormatTravelIN,
                                              title: AppLocalizations.of(context)!.errorHappened,
                                              lottieBuilder: Lottie.asset(
                                                'assets/images/loading/failed.json',
                                                fit: BoxFit.contain,
                                              ),
                                              actions: [
                                                IconsButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  text: AppLocalizations.of(context)!.cancel,
                                                  color: primaryblue,
                                                  textStyle: const TextStyle(color: Colors.white),
                                                ),
                                              ]);
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        )),
                        isLastPax
                            ? Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Provider.of<AppData>(context, listen: false).locale ==
                                        const Locale('en')
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(30.w, 6.h), backgroundColor: primaryblue),
                                  onPressed: () {},
                                  child: const Text(
                                    'Send',
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}

class TravelINDForm extends StatefulWidget {
  const TravelINDForm(
      {Key? key,
      required this.index,
      required this.onTapNext,
      required this.total,
      required this.paxId})
      : super(key: key);

  final int index;
  final VoidCallback onTapNext;
  final String paxId;
  final int total;

  @override
  State<TravelINDForm> createState() => _TravelINDFormState();
}

class _TravelINDFormState extends State<TravelINDForm> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dateOfBirth = TextEditingController();
  final nationality = TextEditingController();
  final middleName = TextEditingController();

  String title = 'MR';

  String nationalityText = 'AE';

  static const List<String> titles = ['MR', 'MRS', 'MISS'];

  final _key = GlobalKey<FormState>();
  TravelInsurancePaxDetailsData? data;

  @override
  void initState() {
    final preList = context.read<AppData>().travelInsurancePaxDetailsList;
    if (preList.isEmpty) {
      data = null;
    } else {
      data = preList[widget.index];
    }
    if (data != null) {
      firstName.text = data?.firstName ?? '';
      lastName.text = data?.lastname ?? '';
      nationalityText = data?.nationalityText ?? 'AE';
      title = data?.title ?? 'MR';
      middleName.text = data?.middleName ?? '';
      dateOfBirth.text = DateFormat('y-MM-dd').format(data!.dateOfBirth);
      nationality.text = data!.nationality;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.w,
              child: context.read<AppData>().searchMode.contains('privet jet')
                  ? Text(
                      Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                          ? '${localizePassengerIndex((widget.index + 2))} ${AppLocalizations.of(context)!.onePassenger}'
                          : '${AppLocalizations.of(context)!.onePassenger} ${localizePassengerIndex((widget.index + 2))}',
                      style: TextStyle(fontSize: titleFontSize.sp),
                    )
                  : Text(
                      context.read<AppData>().searchMode.contains('privet jet')
                          ? '${localizePassengerIndex((widget.index + 2))} ${localizeTitle(widget.paxId)}'
                          : '${localizeTitle(widget.paxId)} ${localizePassengerIndex((widget.index + 2))}',
                      style: TextStyle(fontSize: titleFontSize.sp),
                    ),
            ),
            SizedBox(height: 1.5.h),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 9.w,
                    height: 7.h,
                    child: Align(alignment: Alignment.center, child: _buildPrefix()),
                  ),
                  SizedBox(
                    width: 78.w,
                    height: 7.h,
                    child: UserInputField(
                        title: AppLocalizations.of(context)!.firstName,
                        prefix: _buildPrefix(),
                        validator: (val) {
                          if (val != null && val.isNotEmpty) {
                            return null;
                          } else {
                            return AppLocalizations.of(context)!.thisFiledIsRequired;
                          }
                        },
                        controller: firstName),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            UserInputField(
                title: AppLocalizations.of(context)!.middleName,
                validator: (val) {
                  if (val != null && val.isNotEmpty) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)!.thisFiledIsRequired;
                  }
                },
                controller: middleName),
            SizedBox(height: 1.h),
            UserInputField(
                title: AppLocalizations.of(context)!.surname,
                validator: (val) {
                  if (val != null && val.isNotEmpty) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)!.thisFiledIsRequired;
                  }
                },
                controller: lastName),
            SizedBox(height: 1.h),
            UserInputField(
                title: AppLocalizations.of(context)!.nationality,
                redOnly: true,
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (c) {
                        nationality.text = c.name;
                        nationalityText = c.countryCode;
                        setState(() {});
                      });
                },
                validator: (val) {
                  if (val != null && val.isNotEmpty) {
                    return null;
                  } else {
                    return AppLocalizations.of(context)!.thisFiledIsRequired;
                  }
                },
                controller: nationality),
            SizedBox(height: 1.h),
            InkWell(
              onTap: () async {
                final x = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(1900));

              },
              child: UserInputField(
                  title: AppLocalizations.of(context)!.dOfB,
                  onTap: () async {
                    final x = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 1)),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (x != null) {
                      bool isValidAge = isAdult(DateFormat('dd-MM-yyyy').format(x), widget.paxId);
                         if (!mounted) return;
                      if (context.read<AppData>().searchMode.contains('privet jet')) {
                        isValidAge = true;
                      }
                      if (isValidAge) {
                        dateOfBirth.text = DateFormat('y-MM-dd').format(x);
                        setState(() {});
                      } else {
                        displayTostmessage(context, false,
                            isInformation: true, message: 'This passenger must be ${widget.paxId}');
                      }
                    }
                  },
                  redOnly: true,
                  validator: (val) {
                    if (val != null && val.isNotEmpty) {
                      return null;
                    } else {
                      return AppLocalizations.of(context)!.thisFiledIsRequired;
                    }
                  },
                  controller: dateOfBirth),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
                onPressed: () {
                  final isValid = _key.currentState!.validate();
                  if (isValid) {
                    context.read<AppData>().setTravelInsurancePaxDetailsList(
                        TravelInsurancePaxDetailsData(
                            title: title,
                            nationality: nationality.text,
                            nationalityText: nationalityText,
                            firstName: firstName.text,
                            middleName: middleName.text,
                            lastname: lastName.text,
                            dateOfBirth: DateFormat('y-MM-dd').parse(dateOfBirth.text)),
                        widget.index);
                    widget.onTapNext();
                  } else {
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: primaryblue,
                    fixedSize: Size(100.w, 5.h)),
                child: Text(widget.index + 1 == widget.total
                    ? AppLocalizations.of(context)!.send
                    : AppLocalizations.of(context)!.next))
          ],
        ),
      ),
    );
  }

  String localizePassengerIndex(num i) {
    String name = '';
    switch (i - 1) {
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

  String localizeTitle(String title) {
    switch (title.toLowerCase().trim()) {
      case "senior traveller":
        {
          return AppLocalizations.of(context)!.seniorTravelers;
        }
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
          return title;
        }
    }
  }

  Widget _buildPrefix() {
    return SizedBox(
        width: 10.w,
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                          child: ListView.builder(
                        itemCount: titles.length,
                        itemBuilder: (context, ind) => GestureDetector(
                          onTap: () {
                            title = titles[ind];
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 100.w,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            child: Text(localizeTheTitle(titles[ind])),
                          ),
                        ),
                      )));
            },
            child: Text(localizeTheTitle(title))));
  }

  String localizeTheTitle(String val) {
    switch (val) {
      case "MR":
        {
          return AppLocalizations.of(context)!.mr;
        }
      case "MRS":
        {
          return AppLocalizations.of(context)!.mrs;
        }
      case "MISS":
        {
          return AppLocalizations.of(context)!.miss;
        }

      default:
        {
          return val;
        }
    }
  }

  bool isAdult(String birthDateString, String pax) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;
    if (pax.toLowerCase().trim().contains('child')) {
      return yearDiff < 16 || yearDiff == 16 && monthDiff >= 0 && dayDiff >= 0;
    } else if (pax.toLowerCase().trim().contains('adult')) {
      return yearDiff > 16 || yearDiff == 16 && monthDiff >= 0 && dayDiff >= 0;
    } else {
      return yearDiff > 65 && yearDiff < 70 || yearDiff == 65 && monthDiff >= 0 && dayDiff >= 0;
    }
  }
}
