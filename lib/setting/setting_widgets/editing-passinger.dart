// ignore_for_file: file_names, must_be_immutable, library_private_types_in_public_api, unnecessary_null_comparison, body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lamar_travel_packages/Model/login/user.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditingPassenger extends StatefulWidget {
  EditingPassenger({Key? key, required this.passengers}) : super(key: key);
  Passengers passengers;

  @override
  _EditingPassengerState createState() => _EditingPassengerState();
}

class _EditingPassengerState extends State<EditingPassenger> {
  final titlecontroller = TextEditingController();
  final firstNamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final dOFbcontroller = TextEditingController();
  final passportcontroller = TextEditingController();
  final passportdatecontroller = TextEditingController();
  final nationalitycontroller = TextEditingController();
  final countryController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  String nationalitytext = '';

  DateTime initialDatepassport = DateTime.now();

  DateTime firstDatePassport = DateTime(2000);

  DateTime lastDatePassport = DateTime(DateTime.now().year + 20);

  String passportEXDateText = '';

  DateTime initialDofB = DateTime.now();

  DateTime firstDateDofB = DateTime(1900);

  DateTime lastDateDofB = DateTime(DateTime.now().year + 20);

  String dOfBText = '';

  String passingerTitle = '';

  List<String> titleList = ['Mr.', 'Mrs.', 'Ms.', 'Miss.', 'Mstr.'];

  String phoneCode = '971';

  getpassingerdata() {
    log(widget.passengers.toJson().toString());
    try {
      if (widget.passengers.type == null) {
        passingerTitle = 'Mr.';
      } else if (widget.passengers.selectedTitle != null) {
        titlecontroller.text = widget.passengers.personType;
        passingerTitle = widget.passengers.selectedTitle;
      } else {
        passingerTitle = 'Mr.';
      }
      firstNamecontroller.text = widget.passengers.name;

      lastnamecontroller.text = widget.passengers.surname;
      if (widget.passengers.birthdate != null) {
        dOFbcontroller.text = DateFormat().format(widget.passengers.birthdate!);
        initialDofB = widget.passengers.birthdate!;
        dOfBText = DateFormat('y-MM-dd').format(widget.passengers.birthdate!);
      }
      if (widget.passengers.passportNumber != null) {
        passportcontroller.text = widget.passengers.passportNumber!;
      }
      if (widget.passengers.email.isNotEmpty) {
        emailController.text = widget.passengers.email;
      }
      if (widget.passengers.phoneNumber.isNotEmpty) {
        phoneController.text = widget.passengers.phoneNumber;
        phoneCode = widget.passengers.phoneCountryCode;
      }

      if (widget.passengers.passportExpirityDate != null) {
        passportdatecontroller.text = DateFormat().format(widget.passengers.passportExpirityDate!);
        initialDatepassport = widget.passengers.passportExpirityDate!;
        passportEXDateText = DateFormat('y-MM-dd').format(widget.passengers.passportExpirityDate!);
      }
      if (widget.passengers.nationatily != null) {
        nationalitycontroller.text = widget.passengers.nationatily;
        nationalitytext = widget.passengers.nationatily;
      }
      if (widget.passengers.passportCountryIssued != null) {
        countryController.text = widget.passengers.passportCountryIssued;
      }
    } catch (e) {
      return;
    }
  }

  @override
  void initState() {
    getpassingerdata();
    super.initState();
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    firstNamecontroller.dispose();
    lastnamecontroller.dispose();
    dOFbcontroller.dispose();
    passportcontroller.dispose();
    passportdatecontroller.dispose();
    nationalitycontroller.dispose();
    countryController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          AppLocalizations.of(context)!.passengers,
          style: TextStyle(color: Colors.black, fontSize: titleFontSize),
        ),
        centerTitle: true,
        backgroundColor: cardcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: primaryblue,
              size: 30.sp,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: kToolbarHeight),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPassingertitle(),
                // _buildformWithTitle('Title', titlecontroller),
                _buildformWithTitle(AppLocalizations.of(context)!.firstName, firstNamecontroller,
                    (v) {
                  if (v == null || v == '') {
                    return 'this field are required';
                  } else {
                    return null;
                  }
                }, false),
                _buildformWithTitle(AppLocalizations.of(context)!.surname, lastnamecontroller, (v) {
                  if (v == null || v == '') {
                    return 'this field are required';
                  } else {
                    return null;
                  }
                }, false),

                widget.passengers.email.isEmpty
                    ? const SizedBox()
                    : _buildformWithTitle(AppLocalizations.of(context)!.email, emailController,
                        (v) {
                        if (v == null || v == '') {
                          return 'this field are required';
                        } else {
                          return null;
                        }
                      }, false),

                widget.passengers.phoneNumber.isEmpty
                    ? const SizedBox()
                    : _buildFormWithTitleForPhone(AppLocalizations.of(context)!.phone,
                        phoneController, (v) {}, true, TextInputType.phone),

                _buildDofB(),
                _buildformWithTitle(
                    AppLocalizations.of(context)!.passportNumber, passportcontroller, (v) {
                  if (v == null || v == '') {
                    return 'this field are required';
                  } else {
                    return null;
                  }
                }, true),
                _buildpassportexpiry(),
                Text(
                  AppLocalizations.of(context)!.nationality,
                  style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 100.w,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(left: 10),
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                    child: TextFormField(
                      controller: nationalitycontroller,
                      readOnly: true,
                      validator: (v) {
                        if (v == null || v == '') {
                          return 'this field are required';
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        country(nationalitycontroller);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        width: 100.w,
        child: ElevatedButton(
          onPressed: collectUserData,
          style: ElevatedButton.styleFrom(backgroundColor: primaryblue, fixedSize: Size(90.w, 7.h)),
          child: Text(
            AppLocalizations.of(context)!.update,
            style: TextStyle(fontSize: titleFontSize),
          ),
        ),
      ),
    );
  }

  _buildformWithTitle(String title, TextEditingController controller,
      String? Function(String?)? validator, bool isPassportNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 100.w,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            width: 100.w,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
            child: TextFormField(
              validator: validator,
              controller: controller,
              onChanged: (value) {
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildFormWithTitleForPhone(String title, TextEditingController controller,
      String? Function(String?)? validator, bool isPassportNumber, TextInputType key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 100.w,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.only(left: 10),
            width: 100.w,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false, // optional. Shows phone code before the country name.
                      onSelect: (country) {
                        setState(() {
                          phoneCode = country.phoneCode;
                        });
                      },
                    );
                  },
                  child: SizedBox(
                    child: Text('+$phoneCode '),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: TextFormField(
                    keyboardType: key,
                    validator: validator,
                    controller: controller,
                    onChanged: (value) {
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  country(TextEditingController controller) {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (country) {
        setState(() {
          controller.text = country.name;
          nationalitytext = country.countryCode;
        });
      },
    );
  }

  Widget _buildpassportexpiry() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.passportExpiry,
            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 100.w,
            child: InkWell(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDatePickerMode: DatePickerMode.year,
                  context: context,
                  initialDate: initialDatepassport,
                  firstDate: firstDatePassport,
                  lastDate: lastDatePassport,
                  selectableDayPredicate: (day) {
                    final av = day.isBefore(DateTime.now());
                    if (av) {
                      return true;
                    } else {
                      return true;
                    }
                  },
                );

                if (selectedDate != null) {
                  setState(() {
                    passportEXDateText = DateFormat('y-MM-dd').format(selectedDate);
                  });
                } else {
                  return;
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15).copyWith(left: 10),
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Text(passportEXDateText),
              ),
            ),
          ),
        ],
      );

  Widget _buildDofB() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.dOfB,
            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 100.w,
            child: InkWell(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDate: initialDofB,
                  firstDate: firstDateDofB,
                  lastDate: lastDateDofB,
                  selectableDayPredicate: (day) {
                    final av = day.isBefore(DateTime.now());
                    if (av) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                );

                if (selectedDate != null) {
                  setState(() {
                    dOfBText = DateFormat('y-MM-dd').format(selectedDate);
                  });
                } else {
                  return;
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15).copyWith(left: 10),
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Text(dOfBText),
              ),
            ),
          ),
        ],
      );

  Widget _buildPassingertitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.passTitle,
            style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 100.w,
            child: InkWell(
              onTap: () async {},
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(2).copyWith(left: 10),
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localizeTheTitle(passingerTitle)),
                    DropdownButton<String>(
                      hint: const SizedBox(),
                      disabledHint: const SizedBox(),
                      value: passingerTitle,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: TextStyle(color: primaryblue),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) async {
                        if (newValue != null) {
                          setState(() {
                            passingerTitle = newValue;
                          });
                        }
                      },
                      items: titleList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(localizeTheTitle(value)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////
//! /////////////  FUNCTIONS  ///////////////////

  void collectUserData() async {
    final isvalidData = _formKey.currentState!.validate();

    if (isvalidData) {
      Map<String, dynamic> passengerdataInput = {
        "passenger_id": widget.passengers.id,
        "title": passingerTitle,
        "first_name": firstNamecontroller.text,
        "last_name": lastnamecontroller.text,
        "dob": dOfBText,
        "passport_number": passportcontroller.text,
        "passport_expiry": passportEXDateText,
        "nationality": nationalitytext
      };

      String passengerdata = jsonEncode(passengerdataInput);
      await AssistantMethods.editUserpassenger(passengerdata, context, searchType: '');
    } else {
      return;
    }
  }

  String localizeTheTitle(String val) {
    switch (val) {
      case "Mr.":
        {
          return AppLocalizations.of(context)!.mr;
        }
      case "Mrs.":
        {
          return AppLocalizations.of(context)!.mrs;
        }
      case "Ms.":
        {
          return AppLocalizations.of(context)!.miss;
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
}
