// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Datahandler/adaptive_texts_size.dart';
import '../../Datahandler/app_data.dart';
import '../../Model/login/user.dart';

import 'checkout_information.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';

import '../../config.dart';
import 'InfomationModel.dart';

var items = ['Mr', 'Mrs'];

class Passingerfiled extends StatefulWidget {
  //  static String idscreen = 'Passingerfiled';

  Passingerfiled(
    this.isupdate, {
    required this.numberofpassinger,
    required this.isChild,
    required this.ids,
    Key? key,
  }) : super(key: key);
  bool isupdate = false;
  final bool isChild;
  final int numberofpassinger;
  final String ids;

  @override
  _PassingerfiledState createState() => _PassingerfiledState();
}

class _PassingerfiledState extends State<Passingerfiled> {
  final _formKey = GlobalKey<FormBuilderState>();
  final GlobalKey _scaffold = GlobalKey();

  final layerLink = LayerLink();

  OverlayEntry? entry;

  Passengers? passingerfromhistory;

  FocusNode seggetions = FocusNode();

  TextEditingController passportexpirydate = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController lastTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController passportTextController = TextEditingController();
  TextEditingController passportissuedTextController = TextEditingController();
  TextEditingController passportDateTextController = TextEditingController();
  TextEditingController nationalityTextController = TextEditingController();

  bool showmore = true;

  bool selectedDatechaker(DateTime dateTime) {
    DateTime now = DateTime.now();
    if (dateTime.isBefore(now)) {
      return false;
    } else {
      return true;
    }
  }

  DateTime dateOfBirthUpdateIntial = DateTime(2000);
  DateTime passportDateUpdateIntial = DateTime(DateTime.now().year + 2);
  void checkingPassingerIsNewOrEdit(bool isUpdate) {
    if (isUpdate) {
      Forms? forms = Provider.of<AppData>(context, listen: false).userinformation;

      if (forms != null) {
        passportexpirydate.text = forms.passportexpirydate;
        titleTextController.text = forms.type;
        nameTextController.text = forms.firstName;
        lastTextController.text = forms.surname;
        dateOfBirthTextController.text = forms.dateofbirth;
        passportTextController.text = forms.passportnumber;
        passportissuedTextController.text = forms.passportissuedcountry;
        passportDateTextController.text = forms.passportexpirydate;
        nationalityTextController.text = forms.nationality;
        if (widget.isupdate) {
          try {
            dateOfBirthUpdateIntial = DateFormat("yyyy-MM").parse(dateOfBirthTextController.text);
            passportDateUpdateIntial = DateFormat("yyyy-MM").parse(passportDateTextController.text);
          } catch (e) {
            dateOfBirthUpdateIntial = DateTime.now();
            passportDateUpdateIntial = DateTime(DateTime.now().year + 2);
          }
        }
      }
    } else {
      return;
    }
  }

  void showOverlay() {
    final overlay = Overlay.of(context);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          offset: const Offset(150, 50),
          link: layerLink,
          showWhenUnlinked: false,
          child: users.data.passengers != null ? _buildOverlay() : null,
        ),
      ),
    );

    overlay.insert(entry!);
  }

  country(TextEditingController controller) {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        controller.text = country.name;
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
    didChangeDependencies();

    super.dispose();
  }

  @override
  void initState() {
    if (widget.isupdate) checkingPassingerIsNewOrEdit(widget.isupdate);

    seggetions.addListener(() {
      if (seggetions.hasFocus) {
        showOverlay();
      } else {
        hideOverlay();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CheckoutInformation(),
          ),
        );
        return Future.value(true);
      },
      child: Container(
        color: cardcolor,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0.1,
                title: Text(
                  'Passenger',
                  style: TextStyle(color: black),
                ),
                centerTitle: true,
                backgroundColor: cardcolor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(CheckoutInformation.idScreen, (route) => false);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                    color: primaryblue,
                  ),
                ),
              ),
              // appbar(context,''),
              key: _scaffold,
              resizeToAvoidBottomInset: true,
              body: Container(
                width: size.width,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //    HolidayHeder(idscreen: CheckoutInformation.idScreen),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        ' Passinger ${widget.numberofpassinger} ${widget.ids}',
                        style: TextStyle(
                            fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 32),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.03,
                              width: size.width,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                    child: Checkbox(
                                      value: showmore,
                                      onChanged: (v) {
                                        setState(() {
                                          showmore = v!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    !showmore
                                        ? '   Show additional fields'
                                        : '   Hide additional fields',
                                    style: TextStyle(
                                      fontSize:
                                          const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////Title/////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: size.height * 0.1,
                              child: FormBuilderDropdown(
                                initialValue: items[0],
                                validator: (v) {
                                  if (v == null) {
                                    return 'this field is required';
                                  } else if (v.isEmpty) {
                                    return 'this field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                items: items
                                    .map((gender) => DropdownMenuItem(
                                          value: gender,
                                          child: Text(gender),
                                        ))
                                    .toList(),
                                name: 'type',
                                decoration: InputDecoration(
                                  labelText: "Title",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: primaryblue),
                                  ),
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////First Name//////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////

                            CompositedTransformTarget(
                              link: layerLink,
                              child: SizedBox(
                                height: size.height * 0.07,
                                child: FormBuilderTextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                                  ],
                                  controller: nameTextController,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return 'this field is required';
                                    }
                                    return null;
                                  },
                                  focusNode: seggetions,
                                  name: 'FirstName',
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(color: primaryblue),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////Surname/////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: size.height * 0.07,
                              child: FormBuilderTextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
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
                                  labelText: 'Surname',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: primaryblue),
                                  ),
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////Date of birth////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: size.height * 0.07,
                              child: FormBuilderDateTimePicker(
                                controller: dateOfBirthTextController,
                                validator: (v) {
                                  if (v == null) {
                                    return 'this field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                initialValue: dateOfBirthUpdateIntial,

                                name: 'Dateofbirth',

                                inputType: InputType.date,

                                initialDatePickerMode: DatePickerMode.year,
                                initialDate: widget.isupdate ? dateOfBirthUpdateIntial : null,
                                format: DateFormat("yyyy-MM-dd"),
                                decoration: InputDecoration(
                                  labelText: 'Date of birth',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: primaryblue),
                                  ),
                                ),

                                // initialValue: DateTime.now(),
                                // enabled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /////////////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////Passport number////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            SizedBox(
                              height: size.height * 0.07,
                              child: FormBuilderTextField(
                                controller: passportTextController,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'this field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                name: 'Passportnumber',
                                decoration: InputDecoration(
                                  labelText: 'Passport number',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: primaryblue),
                                  ),
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////Passport expiry date///////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////

                            SizedBox(
                              height: size.height * 0.07,
                              child: FormBuilderDateTimePicker(
                                controller: passportexpirydate,
                                validator: (v) {
                                  if (v == null) {
                                    return 'this field is required';
                                  } else {
                                    return null;
                                  }
                                },
                                initialValue: passportDateUpdateIntial,
                                name: 'Passportexpirydate',
                                selectableDayPredicate: selectedDatechaker,
                                inputType: InputType.date,
                                initialDatePickerMode: DatePickerMode.year,
                                format: DateFormat("yyyy-MM-dd"),
                                decoration: InputDecoration(
                                  labelText: 'Passport expiry date',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: primaryblue),
                                  ),
                                  //fillColor: Colors.green
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////Passport issued country/////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////

                            Visibility(
                              visible: showmore,
                              child: SizedBox(
                                height: size.height * 0.07,
                                child: FormBuilderTextField(
                                  onTap: () {
                                    country(passportissuedTextController);
                                  },
                                  controller: passportissuedTextController,
                                  readOnly: true,

                                  //  validator: FormBuilderValidators.compose([]),
                                  // initialValue: '',
                                  name: 'Passportissuedcountry',
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: () {
                                        country(passportissuedTextController);
                                      },
                                      child: const Icon(Icons.keyboard_arrow_down),
                                    ),
                                    labelText: 'Passport issued country',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(color: primaryblue),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: showmore ? 10 : 0,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////Nationality////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////

                            Visibility(
                              visible: showmore,
                              child: SizedBox(
                                height: size.height * 0.07,
                                child: FormBuilderTextField(
                                  onTap: () {
                                    country(nationalityTextController);
                                  },
                                  readOnly: true,
                                  controller: nationalityTextController,
                                  name: 'Nationality',
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                        onTap: () {
                                          country(nationalityTextController);
                                        },
                                        child: const Icon(Icons.keyboard_arrow_down)),

                                    labelText: 'Nationality',
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: BorderSide(color: primaryblue),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            /////////////////////////////////////////////////////////////////////////////////
                            //////////////////////////////////////////////////////////////////////////////////
                            /////////////////////////////BUTTON////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////
                            ///////////////////////////////////////////////////////////////////////////////

                            SizedBox(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryblue,
                                      fixedSize: Size(size.width, size.height * 0.06)),
                                  onPressed: () {
                                    _formKey.currentState!.validate();

                                    if (_formKey.currentState!.validate() == false) {
                                      return;
                                    } else {
                                      getData();
                                      Provider.of<AppData>(context, listen: false).checkfilling(
                                          ind: widget.numberofpassinger - 1, fill: true);
                                      Navigator.pushNamed(context, CheckoutInformation.idScreen);
                                    }
                                  },
                                  child: Text(
                                    'submit',
                                    style: TextStyle(
                                      // ignore: prefer_const_constructors
                                      fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 30),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
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

  getData() {
    Map<String, dynamic> informationMap = {};

    _formKey.currentState!.save();


    informationMap.addAll(_formKey.currentState!.value);
    informationMap.putIfAbsent("guestAgeType", () => widget.ids);
    informationMap.update('Dateofbirth', (value) => DateFormat("yyyy-MM-dd").format(value));
    informationMap.update('Passportexpirydate', (value) => DateFormat("yyyy-MM-dd").format(value));
    informationMap['Nationality'] == null
        ? informationMap.update('Nationality', (value) => '')
        : informationMap['Nationality'] = informationMap['Nationality'];
    informationMap['Passportissuedcountry'] == null
        ? informationMap.update('Passportissuedcountry', (value) => '')
        : informationMap['Passportissuedcountry'] = informationMap['Passportissuedcountry'];

    //print(informationMap.toString());

    final toJson = json.encode(informationMap, toEncodable: myDateSerializer);

    Forms infomation = formsFromJson(toJson);

    Provider.of<AppData>(context, listen: false).getPassingerinformation(
        id: '${widget.ids}${widget.numberofpassinger}', passingerInformation: infomation);

    Provider.of<AppData>(context, listen: false).passingerList.forEach((key, value) {
    });
  }

  Widget _buildOverlay() {
    List<Passengers> pass = [];
    if (users.data.passengers != null) {
      pass = users.data.passengers!;
    }

    // setState(() {
    if (nameTextController.text.isNotEmpty) {
      pass = pass.where((element) => element.name.startsWith(nameTextController.text)).toList();
    }
    //     });
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        color: Colors.white70,
        elevation: 8,
        child: Column(
          children: [
            for (var item in pass)
              ListTile(
                title: Text(
                  '${item.name} ${item.surname}',
                  style: TextStyle(
                      fontSize: const AdaptiveTextSize().getadaptiveTextSize(context, 30),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  hideOverlay();
                  getpassinger(item);
                  seggetions.unfocus();
                },
              ),
          ],
        ),
      ),
    );
  }

  void getpassinger(Passengers passinger) {
    passingerfromhistory = passinger;
    if (passingerfromhistory != null) {
      nameTextController.text = passingerfromhistory!.name;
      lastTextController.text = passingerfromhistory!.surname;

      passportTextController.text = passingerfromhistory!.passportNumber ?? '';
      passportissuedTextController.text = passingerfromhistory!.passportCountryIssued;
      nationalityTextController.text = passingerfromhistory!.nationatily;
      setState(() {
        _formKey.currentState!.save();
      });
    }
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }
}
