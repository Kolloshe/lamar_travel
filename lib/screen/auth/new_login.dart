// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/auth/registration.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';

import 'package:lamar_travel_packages/widget/errordialog.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../tab_screen_controller.dart';

class NewLogin extends StatefulWidget {
  static String idScreen = 'NewLoginScreen';

  const NewLogin({Key? key}) : super(key: key);

  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassWord = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginEmail.dispose();
    loginPassWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor:primaryblue ,
      appBar: AppBar(
        backgroundColor: primaryblue,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            isFromBooking = false;
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
              height: size.height * 0.26,
              width: size.width,
              decoration: BoxDecoration(color: primaryblue),
              padding: EdgeInsets.symmetric(horizontal: size.aspectRatio * 50),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: background),
                    child: Image.asset(
                      'assets/images/lamarlogo/logo_with_text.png',
                      width: size.width / 3.7,
                    ),
                  ),
                  _buildSpacer(w: 0, h: size.height * 0.01),
                  Text(
                    AppLocalizations.of(context)!.login,
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
              color: background,
              height: size.height * 0.55,
              padding: const EdgeInsets.all(10),
              width: size.width,
              child: Form(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                          child: TextFormField(
                            controller: loginEmail,
                            validator: (v) {
                              if (v == null) {
                                return "this field is required";
                              } else if (v.isEmpty) {
                                return "this field is required";
                              } else if (!v.contains('@')) {
                                return "Must be Email Format";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.enterEmail),
                          ),
                        ),
                        _buildSpacer(w: 0, h: size.height * 0.02),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
                          child: TextFormField(
                            obscureText: true,
                            //   key: _formKey,
                            validator: (v) {
                              if (v == null) {
                                return " this field is required ";
                              } else if (v.isEmpty) {
                                return " this field is required ";
                              } else if (v.characters.length < 2) {
                                return " this field is required ";
                              } else {
                                return null;
                              }
                            },
                            controller: loginPassWord,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context)!.enterPass),
                          ),
                        ),
                        _buildSpacer(w: 0, h: size.height * 0.09),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              _formKey.currentState!.validate();
                              if (loginEmail.text.isNotEmpty &&
                                  loginEmail.text.characters.length >= 9 &&
                                  loginPassWord.text.isNotEmpty &&
                                  loginPassWord.text.characters.length >= 6) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => LoadingWidgetMain(),
                                //   ),
                                // );
                                pressIndcatorDialog(context);

                                await login(email: loginEmail.text, password: loginPassWord.text);
                                if (!mounted) return;
                                if (islogin == false) {
                                  //  Navigator.popAndPushNamed(context, NewLogin.idScreen);

                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => Errordislog().error(
                                  //       context, AppLocalizations.of(context)!.invalidUsernameOrPassword),
                                  // );
                                } else {
                                  if (users.data.token == '') {
                                    Navigator.pushReplacementNamed(context, NewLogin.idScreen);
                                    showDialog(
                                      context: context,
                                      builder: (context) => const Errordislog().error(context,
                                          AppLocalizations.of(context)!.invalidUsernameOrPassword),
                                    );
                                  } else {
                                    if (isFromBooking == true) {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => PreBookStepper(
                                                isFromNavBar:
                                                    context.read<AppData>().searchMode.isNotEmpty,
                                              )));
                                      // Navigator.pushNamedAndRemoveUntil(
                                      //     context, PreBookStepper.idScreen, (route) => false);
                                    } else {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          TabPage.idScreen, (Route<dynamic> route) => false);
                                      loginEmail.clear();
                                      loginPassWord.clear();
                                    }
                                  }
                                }
                              }
                            } catch (e) {
                              Navigator.pushReplacementNamed(context, NewLogin.idScreen);

                              showDialog(
                                context: context,
                                builder: (context) => const Errordislog().error(
                                  context,
                                  AppLocalizations.of(context)!.invalidUsernameOrPassword,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryblue,
                              fixedSize: Size(size.width, size.height * 0.07)),
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: size.aspectRatio * 35),
                          ),
                        ),
                        _buildSpacer(w: 0, h: size.height * 0.02),
                        SizedBox(
                            width: size.width,
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.didHaveAccount,
                                style:
                                    TextStyle(color: primaryblue, fontSize: size.aspectRatio * 35),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (ctx) => const NewRegistration()));
                              },
                            )),
                        _buildSpacer(w: 0, h: size.height * 0.001),
                        //   SizedBox(
                        //     width: size.width,
                        //     child: Row(
                        //       children: [
                        //         Expanded(
                        //             child: Divider(
                        //           color: primaryblue,
                        //           endIndent: 10,
                        //         )),
                        //         Text(
                        //           AppLocalizations.of(context)!.orSignInWith,
                        //           style: TextStyle(fontSize: size.aspectRatio * 35),
                        //         ),
                        //         Expanded(
                        //             child: Divider(
                        //           color: primaryblue,
                        //           indent: 10,
                        //         )),
                        //       ],
                        //     ),
                        //   ),
                        //   _buildSpacer(w: 0, h: size.height * 0.02),
                        //   SignInButton(
                        //     Buttons.Facebook,
                        //     onPressed: () async {
                        //       try {
                        //         pressIndcatorDialog(context);
                        //         final faceBookRes = await FacebookSignIn().facebookLogin();
                        //         if (faceBookRes != null) {
                        //           facebooksignhundler(faceBookRes);
                        //         } else {
                        //           Navigator.of(context).pop();
                        //         }
                        //       } catch (e) {
                        //         Navigator.of(context).pop();
                        //         print(e);
                        //       }
                        //     },
                        //   ),
                        //   SignInButton(
                        //     Buttons.Google,
                        //     onPressed: () async {
                        //       try {
                        //         pressIndcatorDialog(context);
                        //         final googleRes = await GoogleAuth.googleLogin();
                        //         if (googleRes != null) {
                        //           googleSignHundler(googleRes);
                        //         } else {
                        //           Navigator.of(context).pop();
                        //         }
                        //       } catch (e) {
                        //         Navigator.of(context).pop();
                        //         print(e);
                        //         return;
                        //       }
                        //     },
                        //   ),
                        //   Platform.isIOS
                        //       ? SignInButton(
                        //           Buttons.AppleDark,
                        //           onPressed: () async {
                        //             try {
                        //               pressIndcatorDialog(context);
                        //               _isRegDone = await AppleAuth.appleSignAuth(context);
                        //               if (!_isRegDone) {
                        //                 Navigator.of(context).pop();
                        //                 return;
                        //               }
                        //               if (users.data.token == '') {
                        //                 return showDialog(
                        //                     context: context,
                        //                     builder: (context) => Errordislog()
                        //                         .error(context, 'Token= ${users.data.token}'));
                        //               }
                        //               if (isFromBooking == true) {
                        //                 Navigator.of(context).push(MaterialPageRoute(
                        //                     builder: (context) => PreBookStepper(
                        //                           isFromNavBar:
                        //                               context.read<AppData>().searchMode.isNotEmpty,
                        //                         )));
                        //                 return;
                        //               }
                        //               Navigator.of(context).pushNamedAndRemoveUntil(
                        //                   TabPage.idScreen, (Route<dynamic> route) => false);
                        //               _isRegDone = false;
                        //             } catch (e) {
                        //               Navigator.of(context).pop();
                        //               print(e);
                        //             }
                        //             print(users.data.name);
                        //           },
                        //         )
                        //       : const SizedBox(
                        //           height: 10,
                        //         ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool islogin = false;

  login({required String email, required String password}) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      Map<String, dynamic> rejData = {
        "email": email,
        "password": password,
      };
      //   String postData = jsonEncode(rejData);

      islogin = await AssistantMethods.loginUser(rejData, context);
    }
  }

  Widget _buildSpacer({required double w, required double h}) => SizedBox(
        width: w,
        height: h,
      );
  bool _isRegDone = false;

  void facebooksignhundler(data) async {
    try {
      _isRegDone =
          await AssistantMethods.signinWithProviders(context, data: data, providerName: 'facebook');
      if (!mounted) return;
      if (!_isRegDone) {
        Navigator.of(context).pop();
        return;
      }
      if (users.data.token == '') {
        return showDialog(
            context: context,
            builder: (context) => const Errordislog().error(context, 'Token= ${users.data.token}'));
      }
      if (isFromBooking == true) {
        Navigator.of(context)
          ..pop()
          ..pop(
              // MaterialPageRoute(
              //     builder: (context) =>
              //         PreBookStepper(isFromNavBar: context.read<AppData>().searchMode.isNotEmpty)),
              // (route) => false
              );
        //Navigator.pushNamedAndRemoveUntil(context, PreBookStepper.idScreen, (route) => false);
        return;
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TabPage.idScreen, (Route<dynamic> route) => false);
      _isRegDone = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void googleSignHundler(data) async {
    try {
      _isRegDone =
          await AssistantMethods.signinWithProviders(context, data: data, providerName: 'google');
      if (!mounted) return;
      if (!_isRegDone) {
        Navigator.of(context).pop();
        return;
      }
      if (users.data.token == '') {
        return showDialog(
            context: context,
            builder: (context) => const Errordislog().error(context, 'Token= ${users.data.token}'));
      }
      if (isFromBooking == true) {
        Navigator.of(context)
          ..pop()
          ..pop();

        return;
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(TabPage.idScreen, (Route<dynamic> route) => false);
      _isRegDone = false;
    } catch (e) {
         if (kDebugMode) {
        print(e);
      }
    }
  }
}
