// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/widget/errordialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config.dart';
import '../../tab_screen_controller.dart';
import '../customize/new-customize/new_customize.dart';

class NewRegistration extends StatefulWidget {
  const NewRegistration({Key? key}) : super(key: key);

  @override
  _NewRegistrationState createState() => _NewRegistrationState();
}

class _NewRegistrationState extends State<NewRegistration> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassWord = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPassword = TextEditingController();
  TextEditingController regConfirmPass = TextEditingController();
  TextEditingController regName = TextEditingController();
  TextEditingController regLastName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginEmail.dispose();
    loginPassWord.dispose();
    regEmail.dispose();
    regPassword.dispose();
    regConfirmPass.dispose();
    regName.dispose();
    regLastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: primaryblue,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            color: cardcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.20,
              width: size.width,
              decoration: BoxDecoration(
                color: primaryblue,
              ),
              padding: EdgeInsets.symmetric(horizontal: size.aspectRatio * 50),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: background),
                    child: Image.asset(
                      'assets/images/lamarlogo/logo_with_text.png',
                      width: size.width / 4.3,
                    ),
                  ),
                  _buildSpacer(w: 0, h: size.height * 0.02),
                  Text(
                    AppLocalizations.of(context)!.registration,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: cardcolor,
                        fontSize: size.aspectRatio * 60,
                        letterSpacing: 1),
                  )
                ],
              ),
            ),
            _buildSpacer(w: 0, h: size.height * 0.02),
            Container(
              height: size.height * 0.60,
              padding: const EdgeInsets.all(10),
              width: size.width,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                        child: TextFormField(
                          controller: regName,
                          validator: (v) {
                            if (v == null) {
                              return "this field is required";
                            } else if (v.characters.length < 2) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.firstName),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                        child: TextFormField(
                          controller: regLastName,
                          validator: (v) {
                            if (v == null) {
                              return "this field is required";
                            } else if (v.isNotEmpty) {
                              return null;
                            } else if (v.characters.length < 2) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.surname),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                        child: TextFormField(
                          controller: regEmail,
                          validator: (v) {
                            if (v == null) {
                              return 'this field is required';
                            } else if (v.isEmpty) {
                              return 'this field is required';
                            } else if (!v.contains('@')) {
                              return "Must be Email Format";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.email),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                        child: TextFormField(
                          controller: regPassword,
                          obscureText: true,
                          validator: (v) {
                            if (v == null) {
                              return "Enter your password";
                            }
                            if (v.isEmpty) {
                              return "Enter your password";
                            } else if (v.characters.length < 6) {
                              return " less than 6";
                            } else if (v != regConfirmPass.text) {
                              return "Password isn't matched";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.enterPass),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.02),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                        child: TextFormField(
                          controller: regConfirmPass,
                          obscureText: true,
                          validator: (v) {
                            if (v == null) {
                              return "Enter your password";
                            } else if (v.isEmpty) {
                              return "Enter your password";
                            } else if (v.characters.length < 6) {
                              return " less than 6";
                            } else if (v != regPassword.text) {
                              return "Password isn't matched";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.confirmPass),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.04),
                      ElevatedButton(
                        onPressed: () async {
                          bool userdata = getUserData(
                              name: regName.text,
                              email: regEmail.text,
                              password: regPassword.text,
                              confPass: regConfirmPass.text);

                          _formKey.currentState!.validate();

                          setState(() {});

                          if (userdata) {
                            try {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => LoadingWidgetMain(),
                              //   ),
                              // );
                              pressIndcatorDialog(context);
                              await createAccount(
                                  name: '${regName.text} ${regLastName.text}',
                                  email: regEmail.text,
                                  password: regPassword.text,
                                  confPass: regConfirmPass.text);
                              if (!_isrejDone) return;
                              if (!mounted) return;
                              if (users.data.token == '') {
                                return showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const Errordislog().error(context, 'Token= ${users.data.token}'));
                              }
                              if (isFromBooking == true) {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop()
                                  ..push(MaterialPageRoute(
                                      builder: (context) => PreBookStepper(
                                          isFromNavBar: context.read<AppData>().searchMode == ''
                                              ? false
                                              : true)));
                                return;
                              }
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  TabPage.idScreen, (Route<dynamic> route) => false);
                            } catch (e) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryblue, fixedSize: Size(size.width, size.height * 0.07)),
                        child: Text(
                          AppLocalizations.of(context)!.createAccount,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: size.aspectRatio * 35),
                        ),
                      ),
                      _buildSpacer(w: 0, h: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacer({required double w, required double h}) => SizedBox(
        width: w,
        height: h,
      );

  bool getUserData(
      {required String name,
      required String email,
      required String password,
      required String confPass}) {
    if (password != confPass) {
      return false;
    } else if (name.isEmpty) {
      return false;
    } else if (email.contains('@') == false) {
      return false;
    } else if (password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool _isrejDone = false;
  createAccount(
      {required String name,
      required String email,
      required String password,
      required String confPass}) async {
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confPass.isNotEmpty) {
      Map<String, dynamic> rejData = {
        "name": name,
        "email": email,
        "password": password,
        "confirm_password": confPass,
        "selected_currency": gencurrency,
        "selected_language": genlang.toLowerCase(),
      };

      _isrejDone = await AssistantMethods.rejUser(rejData, context);
    }
  }
}
