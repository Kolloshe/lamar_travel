// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/individual_products/ind_user_input_field.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../config.dart';

class PrivetJetInformation extends StatefulWidget {
  const PrivetJetInformation({Key? key, required this.next, required this.onTapBack})
      : super(key: key);
  final VoidCallback next;

  final VoidCallback onTapBack;

  @override
  _PrivetJetInformationState createState() => _PrivetJetInformationState();
}

class _PrivetJetInformationState extends State<PrivetJetInformation>
    with SingleTickerProviderStateMixin {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalityController = TextEditingController();

  late AnimationController _animationController;

  late Animation<Offset> _animation;

  final _formKey = GlobalKey<FormState>();
  String nationality = 'AE';
  String countryCode = 'UAE';
  String phoneCountryCode = '971';
  String fullCName = '';
  bool isPrivetJet = true;
  static const List<String> titles = ['MR', 'MRS', 'MISS'];

  @override
  void initState() {
    final preData = context.read<AppData>();
    isPrivetJet = preData.searchMode.contains('privet jet');

    final holderDetails = preData.holderDetails;
    if (holderDetails.isNotEmpty) {
      nationality = holderDetails["nationality"] ?? 'AE';
      firstNameController.text = holderDetails['first_name'] ?? '';
      lastNameController.text = holderDetails['last_name'] ?? '';
      middleNameController.text = holderDetails['middle_name'] ?? '';
      title = holderDetails['title'] ?? 'MR';
      dateOfBirthController.text = holderDetails['birth_date'] ?? '';
      emailController.text = holderDetails['email'] ?? '';
      phoneController.text = holderDetails['phone']['number'] ?? '';
      nationalityController.text = holderDetails['nationalityCountryName'] ?? '';
      phoneCountryCode = holderDetails['phone']['prefix'] ?? '+971';
    }

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(_animationController);
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    middleNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nationalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize: 0.65,
          initialChildSize: 0.85,
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
                                    onTap: widget.onTapBack,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.h),
                                SizedBox(
                                  width: 100.w,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 9.w,
                                        height: 7.h,
                                        child: Align(
                                            alignment: Alignment.center, child: _buildPrefix()),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        height: 7.h,
                                        child: UserInputField(
                                            title: AppLocalizations.of(context)!.firstName,
                                            validator: (val) {
                                              if (val != null && val.isNotEmpty) {
                                                return null;
                                              } else {
                                                return AppLocalizations.of(context)!
                                                    .thisFiledIsRequired;
                                              }
                                            },
                                            controller: firstNameController),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 1.5.h),
                                !isPrivetJet
                                    ? UserInputField(
                                        title: AppLocalizations.of(context)!.middleName,
                                        validator: (val) {
                                          if (val != null && val.isNotEmpty) {
                                            return null;
                                          } else {
                                            return AppLocalizations.of(context)!
                                                .thisFiledIsRequired;
                                          }
                                        },
                                        controller: middleNameController)
                                    : const SizedBox(),
                                SizedBox(height: 1.5.h),
                                UserInputField(
                                    title: AppLocalizations.of(context)!.surname,
                                    validator: (val) {
                                      if (val != null && val.isNotEmpty) {
                                        return null;
                                      } else {
                                        return AppLocalizations.of(context)!.thisFiledIsRequired;
                                      }
                                    },
                                    controller: lastNameController),
                                SizedBox(height: 1.5.h),
                                UserInputField(
                                    title: AppLocalizations.of(context)!.email,
                                    validator: (val) {
                                      if (val != null && EmailValidator.validate(val)) {
                                        return null;
                                      } else {
                                        return AppLocalizations.of(context)!.plzEmail;
                                      }
                                    },
                                    controller: emailController),
                                SizedBox(height: 1.5.h),

                                SizedBox(
                                    width: 100.w,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {
                                              country();
                                            },
                                            child: Text(
                                              '+$phoneCountryCode',
                                              style: TextStyle(fontSize: 10.sp),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 75.w,
                                          height: 10.h,
                                          child: TextFormField(
                                            maxLength: 10,
                                            validator: (v) {
                                              if (v == null || v.isEmpty) {
                                                return AppLocalizations.of(context)!.plzPhoneNumber;
                                              }
                                              return null;
                                            },
                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                            cursorColor: primaryblue,
                                            decoration: InputDecoration(
                                              // suffix: InkWell(
                                              //   onTap: () {
                                              //     country();
                                              //   },
                                              //   focusColor: Colors.red,),
                                              labelStyle:
                                                  TextStyle(color: blackTextColor, fontSize: 10.sp),
                                              filled: true,
                                              helperMaxLines: 1,
                                              labelText: AppLocalizations.of(context)!.phone,
                                              helperText: '',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),

                                //
                                // Container(
                                //   height: 10.h,
                                //   child: TextFormField(
                                //     maxLength: 10,
                                //     validator: (v) {
                                //       if (v == null || v.isEmpty) {
                                //         return AppLocalizations.of(context)!.plzPhoneNumber;
                                //       }
                                //       return null;
                                //     },
                                //     controller: phoneController,
                                //     keyboardType: TextInputType.phone,
                                //     cursorColor: primaryblue,
                                //     decoration: InputDecoration(
                                //       prefix: GestureDetector(
                                //         onTap: () {
                                //           country();
                                //         },
                                //         child: Container(
                                //           // padding: EdgeInsets.all(3),
                                //           child: Text(
                                //             '+' + phoneCountryCode+' | ',
                                //             style: TextStyle(fontSize: 10.sp),
                                //           ),
                                //         ),
                                //       ),
                                //       // suffix: InkWell(
                                //       //   onTap: () {
                                //       //     country();
                                //       //   },
                                //       //   focusColor: Colors.red,),
                                //       labelStyle: TextStyle(color: blackTextColor, fontSize: 10.sp),
                                //       filled: true,
                                //       helperMaxLines: 1,
                                //       labelText: AppLocalizations.of(context)!.phone,
                                //       helperText: '',
                                //       border: InputBorder.none,
                                //     ),
                                //   ),
                                // ),
                                //
                                UserInputField(
                                    redOnly: true,
                                    onTap: () {
                                      showCountryPicker(
                                          context: context,
                                          onSelect: (c) {
                                            nationalityController.text = c.name;

                                            nationality = c.countryCode;
                                            setState(() {});
                                          });
                                    },
                                    title: AppLocalizations.of(context)!.nationality,
                                    validator: (val) {
                                      if (val != null && val.isNotEmpty) {
                                        return null;
                                      } else {
                                        return AppLocalizations.of(context)!.thisFiledIsRequired;
                                      }
                                    },
                                    controller: nationalityController),
                                SizedBox(height: 1.5.h),
                                UserInputField(
                                    title: AppLocalizations.of(context)!.dOfB,
                                    onTap: () async {
                                      final userDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now().subtract(const Duration(days: 1)),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now());

                                      if (userDate != null) {
                                        bool isValidAge =
                                            isAdult(DateFormat('dd-MM-yyyy').format(userDate));

                                        if (isValidAge) {
                                          dateOfBirthController.text =
                                              DateFormat('y-MM-dd').format(userDate);
                                          setState(() {});
                                        } else {
                                             if (!mounted) return;
                                          displayTostmessage(context, false,
                                              isInformation: true,
                                              message: 'Holder must be an adult');
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
                                    controller: dateOfBirthController)
                              ],
                            ),
                          ),
                        )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment:
                              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(30.w, 6.h), backgroundColor: primaryblue),
                            onPressed: () {
                              context.read<AppData>().searchMode.contains('privet jet')
                                  ? _sendToPrivetJet()
                                  : _sendToTravelInsurance();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.next,
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  String title = 'MR';

  String localizePassTitle(String val) {
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
                            child: Text(localizePassTitle(titles[ind])),
                          ),
                        ),
                      )));
            },
            child: Text(localizePassTitle(title))));
  }

  ////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  /////////////////////////  FUNCTIONS ///////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////
  _sendToPrivetJet() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || !isValid) return;

    Map<String, dynamic> holder = {
      "title": title,
      "first_name": firstNameController.text,
      "middle_name": middleNameController.text,
      "last_name": lastNameController.text,
      "nationality": nationality,
      "nationalityCountryName": nationalityController.text,
      "birth_date": dateOfBirthController.text,
      "email": emailController.text,
      "phone": {"prefix": phoneCountryCode, "number": phoneController.text}
    };

    context.read<AppData>().setHolderDetail(holder);
    holder.remove("nationalityCountryName");
    final paxSum = context.read<AppData>().paxCount;

    if (paxSum > 1) {
      widget.next();
    } else {
      pressIndcatorDialog(context);
      final preData = context.read<AppData>();

      Map<String, dynamic> privetJetRequestData = {};
      switch (preData.privetJetDateInformation['tripType']) {
        case "round":
          {
            privetJetRequestData = {
              "search_type": preData.privetJetDateInformation['tripType'],
              "from": preData.payloadFrom!.id,
              "to": preData.payloadto.id,
              "departure": preData.privetJetDateInformation['departure'],
              "return": preData.privetJetDateInformation['return'],
              "category_id": preData.minCategory,
              "pax": preData.getPax,
              "holder": holder,
            };
            break;
          }
        case "one":
          {
            privetJetRequestData = {
              "search_type": preData.privetJetDateInformation['tripType'],
              "from": preData.payloadFrom!.id,
              "to": preData.payloadto.id,
              "departure": preData.privetJetDateInformation['departure'],
              "category_id": preData.minCategory,
              "pax": preData.getPax,
              "holder": holder
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
      final res = await AssistantMethods.sendPrivetJet(context, req);
      Navigator.of(context).pop();
      if (res) {
        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: AppLocalizations.of(context)!.successToFormattingTravelIn,
            title: AppLocalizations.of(context)!.hurray,
            lottieBuilder: Lottie.asset(
              'assets/images/loading/done.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(MainScreen.idScreen, (route) => false);
                },
                text: 'Close',
                color: Colors.blue,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ]);
      } else {
       context.read<AppData>().getPrivetJetResponse;

        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: AppLocalizations.of(context)!.failedToFormatTravelIN,
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

  country() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          phoneCountryCode = country.phoneCode;
          countryCode = country.countryCode;
          fullCName = country.name;
        });
      },
    );
  }

  _sendToTravelInsurance() async {
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || !isValid) return;

    Map<String, dynamic> holder = {
      "title": title,
      "first_name": firstNameController.text,
      "middle_name": middleNameController.text,
      "last_name": lastNameController.text,
      "nationality": nationality,
      "birth_date": dateOfBirthController.text,
      "nationalityCountryName": nationalityController.text,
      "email": emailController.text,
      "phone": {"prefix": phoneCountryCode, "number": phoneController.text}
    };

    context.read<AppData>().setHolderDetail(holder);
    holder.remove("nationalityCountryName");
    final paxSum = context.read<AppData>().allPaxSum;

    if (paxSum > 1) {
      widget.next();
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TravelInsuranceForms()));
    } else {
      final preData = context.read<AppData>();

      final data = <String, dynamic>{
        "from": preData.payloadFrom!.countryCode,
        "to": preData.payloadto.countryCode,
        "departure": {
          "date": DateFormat('yyyy-MM-dd').format(preData.newSearchFirstDate!),
          "time": null
        },
        "return": {
          "date": DateFormat('yyyy-MM-dd').format(preData.newSearchsecoundDate!),
          "time": null
        },
        "category_id": null,
        "holder": holder,
        "beneficiaries": ""
      };

      final req = jsonEncode(data);
      log(req);
      pressIndcatorDialog(context);
      final res = await AssistantMethods.sendTravelInsurance(req);
      Navigator.of(context).pop();
      if (res) {
        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: AppLocalizations.of(context)!.successToFormattingTravelIn,
            title: AppLocalizations.of(context)!.hurray,
            lottieBuilder: Lottie.asset(
              'assets/images/loading/done.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(MainScreen.idScreen, (route) => false);
                },
                text: AppLocalizations.of(context)!.close,
                color: primaryblue,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ]);
      } else {
        Dialogs.materialDialog(
            barrierDismissible: false,
            context: context,
            color: Colors.white,
            msg: AppLocalizations.of(context)!.failedToFormatTravelIN,
            title: AppLocalizations.of(context)!.errorHappened,
            lottieBuilder: Lottie.asset('assets/images/loading/failed.json', fit: BoxFit.contain),
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

  bool isAdult(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 16 || yearDiff == 16 && monthDiff >= 0 && dayDiff >= 0;
  }
}
