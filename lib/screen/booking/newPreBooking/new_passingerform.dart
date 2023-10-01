// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/login/user.dart';
import 'package:lamar_travel_packages/screen/booking/InfomationModel.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/cam_scan.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';

// ignore: must_be_immutable
class NewPassingerForm extends StatefulWidget {
  NewPassingerForm(
      {Key? key,
      required this.numberofpassinger,
      required this.isupdate,
      required this.ontap,
      required this.noFlight,
      required this.isAdult,
      required this.ids})
      : super(key: key);
  bool isupdate = false;
  final String ids;
  bool noFlight = false;
  bool isleaderofPassinger = false;
  final bool isAdult;
  final int numberofpassinger;
  VoidCallback ontap;

  @override
  _NewPassingerFormState createState() => _NewPassingerFormState();
}

class _NewPassingerFormState extends State<NewPassingerForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  var items = [
    'Mr.',
    'Mrs.',
    "Miss.",
    "Mstr.",
  ];

  getTitle() {
    if (widget.isAdult) {
      items = ['Mr.', 'Mrs.'];
    } else {
      items = [
        "Miss.",
        "Mstr.",
      ];
    }
  }

  String countryCode = 'SA';
  String phoneCountryCode = '966';
  List<Passengers> pass = [];

  String dateOFbirth = DateFormat("yyyy-MM-dd").format(DateTime(2000));

  String passportExpirtyDate =
      DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 720)));

  int indOFSelectedTitle = 0;

  int indOfSelectedPassenger = 0;

  final layerLink = LayerLink();

  OverlayEntry? entry;

  Passengers? passingerfromhistory;

  FocusNode seggetions = FocusNode();

  String narionalitycode = '';

  TextEditingController passportexpirydate = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController passportTextController = TextEditingController();
  TextEditingController passportissuedTextController = TextEditingController();
  TextEditingController passportDateTextController = TextEditingController();
  TextEditingController nationalityTextController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  int? passengerId;

  bool showmore = true;
  bool isFromCam = false;

  bool selectedDatechaker(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      return false;
    } else {
      return true;
    }
  }

  late DateTime dateOfBirthUpdateIntial =
      DateTime(widget.isAdult ? DateTime.now().year - 11 : DateTime.now().year - 10);
  DateTime passportDateUpdateIntial = DateTime(DateTime.now().year + 2);

  String? passPortNum;

  void checkingPassingerIsNewOrEdit() {
    if (Provider.of<AppData>(context, listen: false).userinformation != null) {
      Forms? forms = Provider.of<AppData>(context, listen: false).userinformation;
      if (forms != null) {
        emailController.text = context.read<AppData>().holderEmail;
        phoneNumberController.text = context.read<AppData>().preBookPhoneNumber;

        countryCode = context.read<AppData>().preBookPhoneCountryCode;

        passportexpirydate.text = forms.passportexpirydate;
        titleTextController.text = forms.type;
        indOFSelectedTitle = items.indexOf(titleTextController.text);
        if (indOFSelectedTitle >= 2) {
          indOFSelectedTitle = 0;
        }
        nameTextController.text = forms.firstName;
        lastTextController.text = forms.surname;
        dateOfBirthTextController.text = forms.dateofbirth;
        dateOFbirth = forms.dateofbirth;
        passportTextController.text = forms.passportnumber;
        passportissuedTextController.text = forms.passportissuedcountry;
        passportDateTextController.text = forms.passportexpirydate;
        if (forms.passportexpirydate != null) {
          passportExpirtyDate = forms.passportexpirydate;
        }
        nationalityTextController.text = forms.nationality;
        narionalitycode = forms.nationality;
        if (widget.isupdate) {
          try {
            dateOfBirthUpdateIntial = DateFormat("yyyy-MM").parse(dateOfBirthTextController.text);
            passportDateUpdateIntial = DateFormat("yyyy-MM").parse(passportDateTextController.text);
          } catch (e) {
            dateOfBirthUpdateIntial = DateTime.now();
            passportDateUpdateIntial = DateTime(DateTime.now().year + 2);
          }
          dateOfBirthUpdateIntial = DateFormat("yyyy-MM").parse(dateOfBirthTextController.text);
        }
      }
    } else {
      return;
    }
  }

  country(TextEditingController controller) {
    showCountryPicker(
      context: context,

      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        controller.text = country.name;
        narionalitycode = country.countryCode;
      },
    );
  }

  @override
  void dispose() {
    passportexpirydate.dispose();
    titleTextController.dispose();
    nameTextController.dispose();
    lastTextController.dispose();
    dateOfBirthTextController.dispose();
    passportTextController.dispose();
    passportissuedTextController.dispose();
    passportDateTextController.dispose();
    nationalityTextController.dispose();
    phoneNumberController.dispose();
    didChangeDependencies();

    super.dispose();
  }

  @override
  void initState() {
    passportexpirydate.text = passportExpirtyDate;
    dateOfBirthTextController.text = dateOFbirth;
    if (users.data.passengers != null || users.data.passengers!.isNotEmpty) {
      pass = users.data.passengers!;
    }

    Provider.of<AppData>(context, listen: false)
        .getPassingerByIndex(widget.ids + widget.numberofpassinger.toString());
    getTitle();
    checkingPassingerIsNewOrEdit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          namesForm(context),
          SizedBox(
            height: 1.h,
          ),
          widget.numberofpassinger == 1
              ? SizedBox(
                  child: FormBuilderTextField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: const [],
                    controller: emailController,
                    validator: (value) =>
                        EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    style: TextStyle(fontSize: subtitleFontSize),
                    name: 'Email',
                    decoration: InputDecoration(
                      suffixIconConstraints: BoxConstraints(maxWidth: 8.w),

                      hintText: AppLocalizations.of(context)!.email,
                      // labelText: 'First Name',
                      fillColor: Colors.white,
                      //  border:OutlineInputBorder(),
                    ),
                  ),
                )
              : const SizedBox(),
          widget.numberofpassinger == 1
              ? SizedBox(
                  child: _buildPhoneFeild(
                      title: AppLocalizations.of(context)!.phone,
                      data: '  xx xxx xxxx ',
                      keyboard: TextInputType.phone,
                      controller: phoneNumberController),
                )
              : const SizedBox(),
          FormBuilderTextField(
            style: TextStyle(fontSize: subtitleFontSize),
            onTap: () {
              country(nationalityTextController);
            },
            readOnly: true,
            controller: nationalityTextController,
            name: 'Nationality',
            decoration: InputDecoration(
              suffix: const Icon(Icons.keyboard_arrow_down),
              labelText: AppLocalizations.of(context)!.nationality,
              hintText: AppLocalizations.of(context)!.nationality,
              fillColor: Colors.white,
              //   border:OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          _buildDateOfBirth(),
          SizedBox(
            height: 1.h,
          ),
          widget.noFlight
              ? const SizedBox()
              : FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: subtitleFontSize),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  ],
                  controller: passportTextController,
                  validator: widget.noFlight
                      ? null
                      : (v) {
                          if (v == null || v.isEmpty) {
                            return 'this field is required';
                          } else {
                            return null;
                          }
                        },
                  name: 'Passportnumber',
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.passportNumber,
                    hintText: AppLocalizations.of(context)!.passportNumber,
                    fillColor: Colors.white,
                  ),
                ),
          SizedBox(
            height: 1.h,
          ),
          widget.noFlight ? const SizedBox() : _buildPassportExpiryDate(),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    style:
                        OutlinedButton.styleFrom(side: BorderSide(width: 2.0, color: yellowColor)),
                    onPressed: () async {
                      if (!mounted) return;
                      if (true) {
                        Forms? forms = await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CameraPage(isAdult: widget.isAdult)));

                        if (forms != null) {
                          isFromCam = true;
                          if (!mounted) return;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                    content:
                                        Text(AppLocalizations.of(context)!.doubleCheckInformations),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: Text(
                                            AppLocalizations.of(context)!.close,
                                            style: TextStyle(color: primaryblue),
                                          ))
                                    ],
                                  ));

                          // displayTostmessage(context, false,
                          //     message: AppLocalizations.of(context)!.doubleCheckInformations);

                          //      log(forms.toJson().toString());

                          passportexpirydate.text = forms.passportexpirydate;
                          titleTextController.text = forms.type;
                          indOFSelectedTitle = items.indexOf(titleTextController.text);
                          nameTextController.text = forms.firstName;
                          lastTextController.text = forms.surname;
                          dateOfBirthTextController.text = forms.dateofbirth;
                          dateOFbirth = forms.dateofbirth;
                          passportTextController.text = forms.passportnumber;
                          passportissuedTextController.text = forms.passportissuedcountry;
                          passportDateTextController.text = forms.passportexpirydate;
                          passportExpirtyDate = forms.passportexpirydate;
                          nationalityTextController.text = forms.nationality;
                          narionalitycode = forms.nationality;
                          passengerId = forms.id as int?;
                          pasCamID = forms.id as int?;

                          setState(() {});
                        } else {
                          isFromCam = false;
                        }
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.scanUrDoc,
                      style: TextStyle(color: yellowColor),
                    )),
                OutlinedButton(
                    onPressed: () async {
                      _buildsuggetionPassenger(hidePassengerFormListView());
                    },
                    style:
                        OutlinedButton.styleFrom(side: BorderSide(width: 2.0, color: yellowColor)),
                    child: Text(
                      AppLocalizations.of(context)!.chooseFromPassList,
                      style: TextStyle(color: yellowColor, fontSize: subtitleFontSize),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(90.w, 6.h), backgroundColor: yellowColor),
              onPressed: () async {
                final isvald = _formKey.currentState!.validate();
                if (!isvald) return;
                if (widget.numberofpassinger == 1) {
                  context.read<AppData>().getHolderEmail = emailController.text;
                  context.read<AppData>().getHolderPhoneNumber(
                      code: phoneCountryCode, phone: phoneNumberController.text);
                }

                if (Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight ==
                    false) {
                  if (DateFormat('yyyy-MM-dd')
                      .parse(passportExpirtyDate)
                      .isBefore(DateTime.now())) {
                    displayTostmessage(context, true,
                        message: AppLocalizations.of(context)!.thisPassportwasexpiry);
                    return;
                  }

                  if (nameTextController.text.isEmpty ||
                      lastTextController.text.isEmpty ||
                      nationalityTextController.text.isEmpty ||
                      dateOfBirthTextController.text.isEmpty ||
                      passportTextController.text.isEmpty ||
                      passportexpirydate.text.isEmpty) {
                    displayTostmessage(context, true,
                        message: AppLocalizations.of(context)!.fillAllTheField);
                    return;
                  } else {
                    pressIndcatorDialog(context);
                    await getData();
                    widget.ontap();
                  }
                } else {
                  if (nameTextController.text.isEmpty ||
                      lastTextController.text.isEmpty ||
                      nationalityTextController.text.isEmpty ||
                      dateOfBirthTextController.text.isEmpty) {
                    displayTostmessage(context, true,
                        message: AppLocalizations.of(context)!.fillAllTheField);
                    return;
                  } else {
                    pressIndcatorDialog(context);
                    await getData();
                    widget.ontap();
                  }
                }
              },
              child: Text(
                AppLocalizations.of(context)!.next,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ))
        ]));
  }

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toString();
    }
    if (object.value == null) {
      return object.value = '';
    }
    return object;
  }

  int? pasCamID;

  getData() async {
//log(Provider.of<AppData>(context,listen: false).passingerList.toString());

    Map<String, dynamic> informationMap = {};

    _formKey.currentState!.save();

    informationMap.addAll(_formKey.currentState!.value);

    informationMap.putIfAbsent("guestAgeType", () => widget.ids);
    informationMap.putIfAbsent("Dateofbirth", () => dateOFbirth);
    informationMap.putIfAbsent("selected_title", () => items[indOFSelectedTitle]);

    informationMap.putIfAbsent("Passportexpirydate", () => passportExpirtyDate);
    informationMap.putIfAbsent(
        "type", () => widget.numberofpassinger == 1 ? "holder" : "passenger");
    informationMap.putIfAbsent(
        "phone", () => widget.numberofpassinger == 1 ? phoneNumberController.text : "");
    informationMap.putIfAbsent(
        "phone_code", () => widget.numberofpassinger == 1 ? phoneCountryCode : "");

    informationMap.putIfAbsent(
        "email", () => widget.numberofpassinger == 1 ? emailController.text : "");

    informationMap.update('Dateofbirth', (value) => value);
    if (informationMap.containsKey('Passportexpirydate')) {
      informationMap.update('Passportexpirydate', (value) => value);
    } else {
      informationMap.putIfAbsent('Passportexpirydate', () => null);
    }

    informationMap['Nationality'] == null
        ? informationMap.update('Nationality', (value) => narionalitycode)
        : informationMap['Nationality'] = narionalitycode;
    informationMap['Passportissuedcountry'] = narionalitycode;

    final toJson = json.encode(informationMap, toEncodable: myDateSerializer);

    Forms infomation = formsFromJson(toJson);
    //   log(infomation.type);

    getpassid(infomation, users.data.passengers!);
    Provider.of<AppData>(context, listen: false).getPassingerinformation(
      id: '${widget.ids}${widget.numberofpassinger}',
      passingerInformation: infomation..id = widget.numberofpassinger.toString(),
    );

    final filledPassenger =
        Provider.of<AppData>(context, listen: false).passingerList.values.toList();
    if (passengerId == null) {
      final x = filledPassenger
          .where((element) =>
              element.firstName.trim().startsWith(infomation.firstName.toLowerCase().trim()))
          .toList();

      if (x.isNotEmpty) {
        if (users.data.passengers!.isNotEmpty) {
          if (!Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
            final xx = users.data.passengers!
                .where((element) =>
                    element.name.trim().toLowerCase().contains(x[0].firstName.trim().toLowerCase()))
                .toList();
            if (xx.isNotEmpty) {}
          }
        }
      }
    }
    if (isFromCam && pasCamID != null) {
      passengerId = pasCamID;
    }
    //
    // log('\n========================\n' +
    //     '===========${passengerId.toString()}==========\n' +
    //     '========================\n');

    if (passengerId == null) {
      if (isFromCam && pasCamID != null) {
        passengerId = pasCamID;
      }

      Map<String, dynamic> passengerdataInput = {
        "passenger_id": passengerId,
        "title": items[indOFSelectedTitle],
        "first_name": informationMap['FirstName'],
        "last_name": informationMap['Surname'],
        "dob": dateOFbirth,
        "passport_number": informationMap['Passportnumber'],
        "passport_expiry": passportExpirtyDate,
        "nationality": narionalitycode,
        "type": widget.numberofpassinger == 1 ? "holder" : "passenger",
        "email": widget.numberofpassinger == 1 ? emailController.text : "",
        "phone": widget.numberofpassinger == 1 ? phoneNumberController.text : '',
        "phone_code": widget.numberofpassinger == 1 ? phoneCountryCode : ''
      };

      String passengerdata = jsonEncode(passengerdataInput);

      //   if (Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
      await AssistantMethods.editUserpassenger(passengerdata, context,
          isFromForm: true, searchType: context.read<AppData>().searchMode);
      //  }
    } else {
      List<Passengers> isOnPassengerList = [];
      if (Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
        isOnPassengerList = users.data.passengers!
            .where((element) =>
                element.name.toLowerCase().trim() == infomation.firstName.toLowerCase().trim())
            .where((element) =>
                element.surname.toLowerCase().trim() == infomation.surname.toLowerCase().trim())
            .toList();
      } else {
        isOnPassengerList = users.data.passengers!
            .where((element) => element.name.startsWith(infomation.firstName))
            .where((element) => element.surname.startsWith(infomation.surname))
            .toList();
      }
      if (isFromCam && pasCamID != null) {
        passengerId = pasCamID;
      }

      Map<String, dynamic> passengerdataInput = {
        "passenger_id": passengerId,
        "title": items[indOFSelectedTitle],
        "first_name": informationMap['FirstName'],
        "last_name": informationMap['Surname'],
        "dob": dateOFbirth,
        "passport_number": informationMap['Passportnumber'] ??
            (isOnPassengerList[0].passportNumber ?? passPortNum),
        "passport_expiry": passportExpirtyDate,
        "nationality": narionalitycode,
        "type": widget.numberofpassinger == 1 ? "holder" : "passenger",
        "phone": widget.numberofpassinger == 1 ? phoneNumberController.text : "",
        "phone_code": widget.numberofpassinger == 1 ? phoneCountryCode : "",
        "email": widget.numberofpassinger == 1 ? emailController.text : '',
      };

      String passengerdata = jsonEncode(passengerdataInput);
      //if (!Provider.of<AppData>(context, listen: false).packagecustomiz.result.noflight) {
      await AssistantMethods.editUserpassenger(passengerdata, context,
          isFromForm: true, searchType: context.read<AppData>().searchMode);
      // }
    }
    // Navigator.of(context).pop();
  }

  void getPassenger(Passengers passenger) {
    passingerfromhistory = passenger;
    if (passingerfromhistory != null) {
      nameTextController.text = passingerfromhistory!.name;
      lastTextController.text = passingerfromhistory!.surname;

      passportTextController.text = passingerfromhistory!.passportNumber ?? '';
      passportissuedTextController.text = passingerfromhistory!.passportCountryIssued;
      nationalityTextController.text = passingerfromhistory!.nationatily;
      setState(() {
        _formKey.currentState!.save();
        //   print(_formKey.currentState!.value);
      });
    }
  }

  SizedBox namesForm(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        children: [
          SizedBox(width: 15.w, child: _buildPassengerTitle()
              //
              // FormBuilderDropdown(
              //   style: TextStyle(fontSize: 12.sp, color: Colors.black),
              //   initialValue: items[indOFSelectedTitle],
              //   validator: FormBuilderValidators.compose([
              //     FormBuilderValidators.required(context),
              //   ]),
              //   items: items
              //       .map((gender) => DropdownMenuItem(
              //             value: gender,
              //             child: Text(gender),
              //           ))
              //       .toList(),
              //   name: 'type',
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     fillColor: Colors.white,
              //   ),
              // ),
              //
              ),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
            width: 37.w,
            child: CompositedTransformTarget(
              link: layerLink,
              child: SizedBox(
                child: FormBuilderTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                  ],
                  controller: nameTextController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'this field is required';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(fontSize: subtitleFontSize),
                  focusNode: seggetions,
                  name: 'FirstName',
                  decoration: InputDecoration(
                    suffixIconConstraints: BoxConstraints(maxWidth: 8.w),
//                     suffixIcon: users.data.passengers != null
//                         ? IconButton(
//                             onPressed: () {
//                               if (users.data.passengers != null) {
//                                 pass = users.data.passengers!;
//                                 var lst2 =Provider.of<AppData>(context, listen: false).selectedPassingerfromPassList;
// lst2.forEach((element) {
//
//   pass.removeWhere((e) => element.passportnumber.trim().toLowerCase() == e.passportNumber.trim().toLowerCase() );
// });
// setState(() {});
//
//                               _buildsuggetionPassenger();
//                             }
//                               },
//                             icon: Icon(Icons.arrow_drop_down_outlined),
//                           )
//                         : null,
                    hintText: AppLocalizations.of(context)!.firstName,
                    // labelText: 'First Name',
                    fillColor: Colors.white,
                    //  border:OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 36.w,
            child: FormBuilderTextField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(fontSize: subtitleFontSize),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                controller: lastTextController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
                name: 'Surname',
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.surname, fillColor: Colors.white,
                  // border:OutlineInputBorder(),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildDateOfBirth() => InkWell(
        onTap: () async {
          final datetimeOfBirth = await showDatePicker(
              initialDatePickerMode: DatePickerMode.year,
              context: context,
              initialDate: dateOfBirthUpdateIntial,
              firstDate: widget.isAdult ? DateTime(1700) : DateTime(DateTime.now().year - 11, 1, 1),
              lastDate: widget.isAdult ? DateTime(DateTime.now().year - 11, 1, 1) : DateTime.now());

          if (datetimeOfBirth != null) {
            setState(() {
              dateOFbirth = DateFormat("yyyy-MM-dd").format(datetimeOfBirth);
              dateOfBirthTextController.text = dateOFbirth;
            });
          }
        },
        child: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.dOfB,
                style: TextStyle(fontSize: subtitleFontSize - 1, color: Colors.grey),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 2.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.8, color: Colors.grey.shade400),
                )),
                child: Text(dateOFbirth),
              )
            ],
          ),
        ),
      );

  Widget _buildPassportExpiryDate() => InkWell(
        onTap: () async {
          final datetimeOfpassport = await showDatePicker(
            selectableDayPredicate: (date) {
              if (date.isBefore(DateTime.now())) {
                return false;
              } else {
                return true;
              }
            },
            initialDatePickerMode: DatePickerMode.year,
            context: context,
            initialDate: passportDateUpdateIntial,
            firstDate: DateTime(1700),
            lastDate: DateTime(2050),
          );

          if (datetimeOfpassport != null) {
            setState(() {
              passportExpirtyDate = DateFormat("yyyy-MM-dd").format(datetimeOfpassport);
              passportexpirydate.text = passportExpirtyDate;
            });
          }
        },
        child: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.passportExpiry,
                style: TextStyle(fontSize: subtitleFontSize - 1, color: Colors.grey),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 2.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1.8, color: Colors.grey.shade400),
                )),
                child: Text(passportExpirtyDate.toString()),
              )
            ],
          ),
        ),
      );

//   Widget _buildOverlay() {
//     List<Passengers> pass = [];
//     if (users.data.passengers != null) {
//       pass = users.data.passengers!;
//     }
//     if (nameTextController.text.isNotEmpty) {
//       pass = pass.where((element) => element.name.startsWith(nameTextController.text)).toList();
//     }
//
//     return SizedBox(
//       height: 30.h,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Material(
//           color: Colors.white70,
//           elevation: 8,
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               for (var item in pass)
//                 ListTile(
//                   title: Text(
//                     item.name + ' ' + item.surname,
//                     style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
//                   ),
//                   onTap: () {
//                     print(item.personType.toString());
//
//
//                     passengerId = item.id;
// // passportexpirydate          .text= item.passportExpirityDate;
//                     titleTextController.text = item.personType.toString();
//
//                     indOFSelectedTitle = items.indexOf(titleTextController.text);
//
//                     nameTextController.text = item.name;
//                     lastTextController.text = item.surname;
//                     dateOFbirth = DateFormat("yyyy-MM-dd").format(item.birthdate!);
//                     passportTextController.text = item.passportNumber;
//                     passportissuedTextController.text = item.passportCountryIssued;
//                     passportDateTextController.text = item.passportExpirityDate.toString();
//                     nationalityTextController.text = item.nationatily.toString();
//                     narionalitycode = item.nationatily.toString();
//                     if (item.passportExpirityDate != null) {
//                       passportExpirtyDate =
//                           DateFormat("yyyy-MM-dd").format(item.passportExpirityDate!);
//                     }
//                     item.name;
//                     seggetions.unfocus();
//                     setState(() {});
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget _buildPassengerTitle() => InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
            builder: (_) => Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                  width: 100.w,
                  height: 90.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.close,
                                  style: TextStyle(color: primaryblue),
                                )),
                            Text(
                              AppLocalizations.of(context)!.passTitle,
                              style:
                                  TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        height: 48.h,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: items.length,
                            itemBuilder: (context, i) => ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  onTap: () async {
                                    setState(() {
                                      indOFSelectedTitle = i;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  horizontalTitleGap: 0,
                                  minVerticalPadding: 0,
                                  title: Text(localizethetitle(items[i])),
                                  leading: indOFSelectedTitle == i ? const Icon(Icons.check) : const SizedBox(),
                                )),
                      )
                    ],
                  ),
                ));
      },
      child: Text(localizethetitle(items[indOFSelectedTitle])));

  String localizethetitle(String val) {
    switch (val) {
      case "Mr.":
        {
          return AppLocalizations.of(context)!.mr;
        }
      case "Mrs.":
        {
          return AppLocalizations.of(context)!.mrs;
        }
      case "Miss.":
        {
          return AppLocalizations.of(context)!.miss;
        }

      case "Mstr.":
        {
          return AppLocalizations.of(context)!.mstr;
        }
      default:
        {
          return val;
        }
    }
  }

  _buildsuggetionPassenger(List<Passengers> passs) => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      builder: (_) => Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
            width: 100.w,
            height: 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.close,
                            style: TextStyle(color: primaryblue),
                          )),
                      Text(
                        AppLocalizations.of(context)!.passengers,
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 48.h,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: passs.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.sp),
                          onTap: () async {
                            passengerId = passs[i].id;

// passportexpirydate          .text= item.passportExpirityDate;
                            titleTextController.text = passs[i].selectedTitle.toString();

                            indOFSelectedTitle = items.indexOf(passs[i].selectedTitle.toString());
                            if (indOFSelectedTitle >= 2) {
                              indOFSelectedTitle = 0;
                            }
                            //   print('><><>' + pass[i].personType.toString());

                            nameTextController.text = passs[i].name;
                            lastTextController.text = passs[i].surname;
                            dateOFbirth = DateFormat("yyyy-MM-dd").format(passs[i].birthdate!);
                            passportTextController.text = passs[i].passportNumber ?? '';
                            passPortNum = passs[i].passportNumber;
                            passportissuedTextController.text = passs[i].passportCountryIssued;
                            passportDateTextController.text =
                                passs[i].passportExpirityDate.toString();
                            if (widget.numberofpassinger == 1) {
                              emailController.text = passs[i].email;
                              if (passs[i].phoneNumber.isNotEmpty) {
                                phoneNumberController.text = passs[i].phoneNumber;
                              }
                              if (passs[i].phoneCountryCode.isNotEmpty) {
                                phoneCountryCode = passs[i].phoneCountryCode;
                              }
                            }
                            nationalityTextController.text = passs[i].nationatily.toString();
                            narionalitycode = passs[i].nationatily.toString();
                            if (passs[i].passportExpirityDate != null) {
                              passportExpirtyDate =
                                  DateFormat("yyyy-MM-dd").format(passs[i].passportExpirityDate!);
                              setState(() {
                                indOfSelectedPassenger = i;
                              });
                              _formKey.currentState!.validate();
                              Navigator.of(context).pop();
                            }
                          },
                          horizontalTitleGap: 50,
                          minVerticalPadding: 0,
                          title: Text('${passs[i].name} ${passs[i].surname}'),
                        );
                      }),
                )
              ],
            ),
          ));

  getpassid(Forms userInput, List<Passengers> passengerList) {
    int? id;
    final passingerFromTheList = passengerList
        .where((element) =>
            element.name.toLowerCase().trim().startsWith(userInput.firstName.toLowerCase().trim()))
        .where((element) =>
            element.surname.toLowerCase().trim().startsWith(userInput.surname.toLowerCase().trim()))
        .toList();
    if (passingerFromTheList.isNotEmpty) {
      if (passingerFromTheList[0]
              .name
              .startsWith(userInput.firstName.toLowerCase().trim().toLowerCase().trim()) ||
          passingerFromTheList[0]
              .surname
              .toLowerCase()
              .trim()
              .contains(userInput.surname.toLowerCase().trim())) {
        id = passingerFromTheList[0].id;
      }
    }

    passengerId = id;

    return id;
  }

  hidePassengerFormListView() {
    var allPassenger = users.data.passengers;
 

    if (allPassenger != null) {
      allPassenger = allPassenger.where((element) {
        if (widget.isAdult) {
          return element.personType.trim().contains("adults");
        } else {
          return element.personType.trim().contains('children');
        }
      })
          // .where((element) => element.name.contains(e.firstName.trim()) == false)

          .toList();
      Provider.of<AppData>(context, listen: false).selectedPassingerfromPassList.forEach((e) {
        allPassenger = allPassenger!
            .where((element) {
              if (widget.isAdult) {
                return element.personType.trim().contains("adults");
              } else {
                return element.personType.trim().contains('children');
              }
            })
            .where((element) => element.name.contains(e.firstName.trim()) == false)
            .toList();
      });

      // print( allPassenger
      // // .where((element) => element.name.contains(e.firstName.trim()) == false)
      //     .where((element) => widget.isAdult
      //     ? element.personType.trim().contains("adults")
      //     : element.personType.trim().contains('children'))
      //     .toList().length.toString()+'llll');
      // // passengerList = allPassenger!;

      return allPassenger;
      // //   .where((element) => element.name.contains(e.firstName.trim()) == false)
      //       .where((element) => widget.isAdult
      //       ? element.personType.trim().contains("adults")
      //       : element.personType.trim().contains('children'))
      //       .toList();
    }
  }

  Widget _buildPhoneFeild(
          {required String title,
          required String data,
          required TextEditingController controller,
          required TextInputType keyboard}) =>
      SizedBox(
        width: 100.w,
        height: 7.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.5.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        showPhoneCode: false, // optional. Shows phone code before the country name.
                        onSelect: (Country country) {
                          setState(() {
                            phoneCountryCode = country.phoneCode;
                            countryCode = country.countryCode;
                          });
                        });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Text('+$phoneCountryCode'),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              child: SizedBox(
                width: 80.w,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 12,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  controller: controller,
                  keyboardType: keyboard,
                  style: TextStyle(
                      color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    counterText: '',
                    suffix: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              // optional. Shows phone code before the country name.
                              onSelect: (Country country) {
                                setState(() {
                                  phoneCountryCode = country.phoneCode;
                                  countryCode = country.countryCode;
                                });
                              });
                        },
                        child: const Icon(Icons.keyboard_arrow_down)),
                    labelStyle: TextStyle(color: blackTextColor, fontWeight: FontWeight.normal),
                    labelText: title,
                    hintText: data,
                    hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

//
// Forms currentPassenger = Forms(
//     id: isOnPassengerList[0].id,
//     firstName: isOnPassengerList[0].name.contains(informationMap['FirstName'])
//         ? isOnPassengerList[0].name
//         : informationMap['FirstName'],
//     surname: isOnPassengerList[0].surname.contains(informationMap['Surname'])
//         ? isOnPassengerList[0].surname
//         : informationMap['Surname'],
//     nationality: narionalitycode,
//     dateofbirth: dateOFbirth,
//     passportnumber: informationMap['Passportnumber'] != null
//         ? informationMap['Passportnumber']
//         : isOnPassengerList[0].passportNumber != null
//             ? isOnPassengerList[0].passportNumber
//             : passPortNum,
//     passportissuedcountry: narionalitycode,
//     passportexpirydate: passportExpirtyDate,
//     type: items[indOFSelectedTitle],
//     ageType: isOnPassengerList[0].personType);
//
//  log('====>' + infomation['Passportnumber'].passportNumber.toString() + '<======');
// await AssistantMethods.addPassengerToTheList(context, currentPassenger, passengerId);
