// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:lamar_travel_packages/screen/booking/prebookingSteper.dart';
// import 'package:lamar_travel_packages/setting/setting_widgets/reset-password.dart';
// import 'package:lamar_travel_packages/tabScreenController.dart';
// import '../../Assistants/assistantMethods.dart';
// import 'ui/button.dart';
// import 'ui/outlinebtn.dart';
// import '../../widget/errordialog.dart';
// import '../../widget/loading.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:keyboard_visibility/keyboard_visibility.dart';
//
// import '../../config.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key? key, this.states}) : super(key: key);
//   static String idscreen = 'LoginScreen';
//    int? states;
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController loginEmail = TextEditingController();
//   TextEditingController loginPassWord = TextEditingController();
//   TextEditingController rejEmail = TextEditingController();
//   TextEditingController rejpassword = TextEditingController();
//   TextEditingController rejConfirmpass = TextEditingController();
//   TextEditingController rejname = TextEditingController();
//   TextEditingController rejLastName = TextEditingController();
//
//   int _pageState = 1;
//
//   var _backgroundColor = Colors.white;
//   var _headingColor = primaryblue;
//
//   double _headingTop = 100;
//
//   double _loginWidth = 0;
//   double _loginHeight = 0;
//   double _loginOpacity = 1;
//
//   double _loginYOffset = 0;
//   double _loginXOffset = 0;
//   double _registerYOffset = 0;
//   double _registerHeight = 0;
//
//   double windowWidth = 0;
//   double windowHeight = 0;
//
//   bool _keyboardVisible = false;
//
//   int fill = 1;
//   bool x = false;
//
//   final _formKey = GlobalKey<FormState>();
//
//   checkisFormbooking() {
//     if (isFromBooking == true) {
//       _pageState = 1;
//     } else {
//       _pageState = 0;
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.states != null) {
//       _pageState = widget.states!;
//     }
//     KeyboardVisibilityNotification().addNewListener(
//       onChange: (bool visible) {
//         setState(() {
//           _keyboardVisible = visible;
//           print("Keyboard State Changed : $visible");
//         });
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     loginEmail.dispose();
//     loginPassWord.dispose();
//     rejEmail.dispose();
//     rejpassword.dispose();
//     rejConfirmpass.dispose();
//     rejname.dispose();
//     rejLastName.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     windowHeight = MediaQuery.of(context).size.height;
//     windowWidth = MediaQuery.of(context).size.width;
//
//     _loginHeight = windowHeight * 0.1;
//     _registerHeight = windowHeight - 270;
//
//     switch (_pageState) {
//       case 0:
//         _backgroundColor = Colors.white;
//         _headingColor = primaryblue;
//
//         _headingTop = 100;
//
//         _loginWidth = windowWidth;
//         _loginOpacity = 1;
//
//         _loginYOffset = windowHeight;
//         _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 270;
//
//         _loginXOffset = 0;
//         _registerYOffset = windowHeight;
//         break;
//       case 1:
//         _backgroundColor = primaryblue;
//         _headingColor = Colors.white;
//
//         _headingTop = 90;
//
//         _loginWidth = windowWidth;
//         _loginOpacity = 1;
//
//         _loginYOffset = _keyboardVisible ? 40 : MediaQuery.of(context).size.height * 0.35;
//         _loginHeight = _keyboardVisible
//             ? windowHeight
//             : windowHeight - MediaQuery.of(context).size.height * 0.3;
//
//         _loginXOffset = 0;
//         _registerYOffset = windowHeight;
//         break;
//       case 2:
//         _backgroundColor = yellowColor;
//         _headingColor = Colors.white;
//
//         _headingTop = 80;
//
//         _loginWidth = windowWidth - 40;
//         _loginOpacity = 0.7;
//
//         _loginYOffset = _keyboardVisible ? 30 : MediaQuery.of(context).size.height * 0.35;
//         _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 240;
//
//         _loginXOffset = 20;
//
//         _registerYOffset = _keyboardVisible ? 55 : MediaQuery.of(context).size.height * 0.15;
//         _registerHeight = _keyboardVisible
//             ? windowHeight
//             : windowHeight - MediaQuery.of(context).size.height * 0.1;
//         break;
//     }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: Container(
//         child: Form(
//           key: _formKey,
//           child: Stack(
//             // clipBehavior:Clip.
//             overflow: Overflow.visible,
//             children: <Widget>[
//               AnimatedContainer(
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   duration: Duration(milliseconds: 1000),
//                   color: _backgroundColor,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Container(
//                         child: Column(
//                           children: <Widget>[
//                             AnimatedContainer(
//                               width: _pageState == 0
//                                   ? MediaQuery.of(context).size.width * 0.5
//                                   : MediaQuery.of(context).size.width * 0.4,
//                               curve: Curves.fastLinearToSlowEaseIn,
//                               duration: Duration(milliseconds: 1000),
//                               margin: EdgeInsets.only(
//                                 top: _headingTop,
//                               ),
//                               child: Image.asset(
//                                 "assets/images/mascot+logo1.png",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (_pageState != 0) {
//                                 _pageState = 0;
//                               } else {
//                                 _pageState = 1;
//                               }
//                             });
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(32),
//                             padding: EdgeInsets.all(20),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: primaryblue, borderRadius: BorderRadius.circular(50)),
//                             child: Center(
//                               child: Text(
//                                 "Get Started",
//                                 style: TextStyle(color: Colors.white, fontSize: 16),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   )),
//
//               ////////////////////////////////////////////////////////
//               ////////////////////////////////////////////////////////
//               /////////////////////LOGIN//////////////////////////////
//               ////////////////////////////////////////////////////////
//               ////////////////////////////////////////////////////////
//               AnimatedContainer(
//                 padding: const EdgeInsets.all(32),
//                 width: _loginWidth,
//                 height: _loginHeight,
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 duration: const Duration(milliseconds: 1000),
//                 transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
//                 decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(_loginOpacity),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(25), topRight: Radius.circular(15))),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(bottom: 20),
//                           child: const Text(
//                             "Login To Continue",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.09,
//                           child: TextFormField(
//                             obscureText: false,
//                             //   key: _formKey,
//                             validator: (v) {
//                               if (v!.isNotEmpty) {
//                                 return null;
//                               }
//                               else if (v.isEmpty) {
//                                 return "this field is required";
//                               }
//                               else if (!v.contains('@')) {
//                                 return "Must be Email Format";
//                               }
//                             },
//                             controller: loginEmail,
//                             decoration: InputDecoration(
//                                 labelText: 'Email',
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Colors.red, //this has no effect
//                                   ),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.email,
//                                   size: 20,
//                                   color: Color(0xFFBB9B9B9),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(vertical: 20),
//                                 hintText: "Enter Email..."),
//
//
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.09,
//                           child: TextFormField(
//                             obscureText: true,
//                             //   key: _formKey,
//                             validator: (v) {
//                               if (v!.isEmpty) {
//                                 return null;
//                               } else if (v.characters.length < 2) {
//                                 return " this field is required ";
//                               }
//                             },
//                             controller: loginPassWord,
//                             decoration: InputDecoration(
//                                 labelText: 'Password',
//                                 prefixIcon: const Icon(
//                                   Icons.vpn_key,
//                                   size: 20,
//                                   color: Color(0xFFBB9B9B9),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                     color: Colors.red, //this has no effect
//                                   ),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 hintText: "Enter  Password"),
//
//
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//
//
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.09,
//                           width: MediaQuery.of(context).size.width,
//                           child: PrimaryButton(
//                             ontap: () async {
//                               try {
//                                 _formKey.currentState!.validate();
//                                 if (loginEmail.text.isNotEmpty &&
//                                     loginEmail.text.characters.length >= 9 &&
//                                     loginPassWord.text.isNotEmpty &&
//                                     loginPassWord.text.characters.length >= 6) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => LoadingWidgetMain(),
//                                     ),
//                                   );
//                                   await login(email: loginEmail.text, password: loginPassWord.text);
//                                   if (islogin == false) {
//                                     Navigator.popAndPushNamed(context, LoginScreen.idscreen);
//
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) => Errordislog().error(context,
//                                           "You have entered an invalid username or password"),
//                                     );
//
//                                   } else {
//                                     if (users.data.token == '') {
//                                       Navigator.pushReplacementNamed(context, LoginScreen.idscreen);
//                                       showDialog(
//                                         context: context,
//                                         builder: (context) => Errordislog().error(context,
//                                             "You have entered an invalid username or password"),
//                                       );
//                                     } else {
//                                       if (isFromBooking == true) {
//                                         Navigator.pushNamedAndRemoveUntil(
//                                             context, PreBookStepper.idScreen, (route) => false);
//                                       } else {
//                                         Navigator.of(context).pushNamedAndRemoveUntil(
//                                             TabPage.idScreen, (Route<dynamic> route) => false);
//                                         loginEmail.clear();
//                                         loginPassWord.clear();
//                                       }
//                                     }
//                                   }
//                                 }
//                               } catch (e) {
//                                 Navigator.pushReplacementNamed(context, LoginScreen.idscreen);
//
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => Errordislog().error(
//                                     context,
//                                     "You have entered an invalid username or password",
//                                   ),
//                                 );
//                               }
//                             },
//                             btnText: "Login",
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.09,
//                           width: MediaQuery.of(context).size.width,
//                           child: OutlineBtn(
//                             ontap: () {
//                               setState(() {
//                                 _pageState = 2;
//                               });
//                             },
//                             btnText: "Create New Account",
//                           ),
//                         ),
//                           TextButton(onPressed: (){
//                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ResetPasswordScreen() ));
//                           }, child: Text('Forget your password?',style: TextStyle(color: primaryblue),)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               //////////////////////////////////////////////////////
//               //////////////////////////////////////////////////////
//               ///////////////////Regestration///////////////////////
//               //////////////////////////////////////////////////////
//               //////////////////////////////////////////////////////
//
//               AnimatedContainer(
//                 height: _registerHeight,
//                 padding: const EdgeInsets.all(32),
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 duration: Duration(milliseconds: 1000),
//                 transform: Matrix4.translationValues(0, _registerYOffset, 0),
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(25), topRight: Radius.circular(15))),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       SizedBox(height: 10,),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             margin: const EdgeInsets.only(bottom: 10),
//                             child: const Text(
//                               "Create a New Account",
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             child: TextFormField(
//                               obscureText: false,
//                               //   key: _formKey,
//                               validator: (v) {
//                                 if (v!.isNotEmpty) {
//                                   return null;
//                                 } else if (v.characters.length < 2) {
//                                   return " please Enter your first name";
//                                 }
//                               },
//                               controller: rejname,
//                               decoration: InputDecoration(
//                                   labelText: 'First Name',
//                                   prefixIcon: const Icon(
//                                     Icons.person,
//                                     size: 20,
//                                     color: Color(0xFFBB9B9B9),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       color: Colors.red, //this has no effect
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   hintText: "Enter your name"),
//
//                               // focusNode: focusNode,
//                               // onEditingComplete: () {
//                               //   _formKey.currentState!.validate();
//                               //   focusNode.unfocus();
//                               // },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           //! ///////////////////////last name
//
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             child: TextFormField(
//                               obscureText: false,
//                               //   key: _formKey,
//                               validator: (v) {
//                                 if (v!.isNotEmpty) {
//                                   return null;
//                                 } else if (v.characters.length < 2) {
//                                   return " please Enter your last name";
//                                 }
//                               },
//                               controller: rejLastName,
//                               decoration: InputDecoration(
//                                   labelText: 'Last Name',
//                                   prefixIcon: const Icon(
//                                     Icons.person,
//                                     size: 20,
//                                     color: Color(0xFFBB9B9B9),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: const BorderSide(
//                                       color: Colors.red, //this has no effect
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   hintText: "Enter your name"),
//                             ),
//                           ),
//
//                           SizedBox(
//                             height: 10,
//                           ),
//
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             child: TextFormField(
//                               obscureText: false,
//                               //   key: _formKey,
//                               validator: (v) {
//                                 if (v!.isNotEmpty) {
//                                   return null;
//                                 } else if (!v.contains('@')) {
//                                   return "Must be Email Format";
//                                 }
//                                 //  else if (v.characters.length < 9) {
//                                 //   return "too short";
//                                 // }
//                               },
//                               controller: rejEmail,
//                               decoration: InputDecoration(
//                                   labelText: 'Email',
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.red, //this has no effect
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.email,
//                                     size: 20,
//                                     color: Color(0xFFBB9B9B9),
//                                   ),
//                                   contentPadding: EdgeInsets.symmetric(vertical: 20),
//                                   hintText: 'Email'),
//
//                               // focusNode: focusNode,
//                               // onEditingComplete: () {
//                               //   _formKey.currentState!.validate();
//                               //   focusNode.unfocus();
//                               // },
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             child: TextFormField(
//                               obscureText: true,
//                               //   key: _formKey,
//                               validator: (v) {
//                                 if (v!.isEmpty) {
//                                   return "Enter your password";
//                                 } else if (v.characters.length < 6) {
//                                   return " less than 6";
//                                 } else if (v != rejConfirmpass.text) {
//                                   return "Password is't matched";
//                                 }
//                               },
//                               controller: rejpassword,
//                               decoration: InputDecoration(
//                                   labelText: 'Password',
//                                   prefixIcon: Icon(
//                                     Icons.vpn_key,
//                                     size: 20,
//                                     color: Color(0xFFBB9B9B9),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.red, //this has no effect
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   hintText: "Enter your password"),
//
//                               // focusNode: focusNode,
//                               // onEditingComplete: () {
//                               //   _formKey.currentState!.validate();
//                               //   focusNode.unfocus();
//                               // },
//                             ),
//                           ),
//                           //  InputWithIcon(
//                           //     validation: (v) {},
//                           //     ispass: true,
//                           //     controller: rejpassword,
//                           //     icon: Icons.vpn_key,
//                           //     hint: "Enter your password",
//                           //   ),
//                           SizedBox(
//                             height: 10,
//                           ),
//
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             child: TextFormField(
//                               obscureText: true,
//                               validator: (v) {
//                                 if (v!.isEmpty) {
//                                   return "Enter your password";
//                                 } else if (v.characters.length < 6) {
//                                   return " less than 6";
//                                 } else if (v != rejpassword.text) {
//                                   return "Password is't matched";
//                                 }
//                               },
//                               controller: rejConfirmpass,
//                               decoration: InputDecoration(
//                                   labelText: 'password',
//                                   errorBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   prefixIcon: Icon(
//                                     Icons.vpn_key,
//                                     size: 20,
//                                     color: Color(0xFFBB9B9B9),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.red, //this has no effect
//                                     ),
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   contentPadding: EdgeInsets.symmetric(vertical: 20),
//                                   hintText: 'Confirm password'),
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Column(
//                         children: <Widget>[
//                           GestureDetector(
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * 0.09,
//                               width: MediaQuery.of(context).size.width,
//                               child: PrimaryButton(
//                                 ontap: () async {
//                                   bool userdata = getUserData(
//                                       name: rejname.text,
//                                       email: rejEmail.text,
//                                       password: rejpassword.text,
//                                       confPass: rejConfirmpass.text);
//
//                                   _formKey.currentState!.validate();
//
//                                   setState(() {});
//
//                                   if (userdata) {
//                                     try {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => LoadingWidgetMain(),
//                                         ),
//                                       );
//                                       await createAcount(
//                                           name: rejname.text + ' ' + rejLastName.text,
//                                           email: rejEmail.text,
//                                           password: rejpassword.text,
//                                           confPass: rejConfirmpass.text);
//                                       if(!_isrejDone) return;
//                                       if (users.data.token == '') {
//                                         return showDialog(
//                                             context: context,
//                                             builder: (context) => Errordislog()
//                                                 .error(context, 'Token= ${users.data.token}'));
//                                       }
//                                       if (isFromBooking == true) {
//                                         Navigator.pushNamedAndRemoveUntil(
//                                             context, PreBookStepper.idScreen, (route) => false);
//                                         return;
//                                       }
//                                       Navigator.of(context).pushNamedAndRemoveUntil(
//                                           TabPage.idScreen, (Route<dynamic> route) => false);
//                                     } catch (e) {
//                                       Navigator.pop(context);
//
//                                     }
//                                   }
//                                 },
//                                 btnText: "Create Account",
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.09,
//                             width: MediaQuery.of(context).size.width,
//                             child: OutlineBtn(
//                               ontap: () {
//                                 setState(() {
//                                   _pageState = 1;
//                                 });
//                               },
//                               btnText: "Already registered user",
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                   left: 0,
//                   top: 40,
//                   child: IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pushReplacementNamed(TabPage.idScreen);
//                       },
//                       icon: Icon(
//                         Icons.keyboard_arrow_left,
//                         color: Colors.white,
//                         size: 30,
//                       ))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool islogin = false;
//   login({required String email, required String password}) async {
//     if (email.isNotEmpty && password.isNotEmpty) {
//       Map<String, dynamic> rejData = {
//         "email": email,
//         "password": password,
//       };
//       //   String postData = jsonEncode(rejData);
//
//       islogin = await AssistantMethods.loginUser(rejData, context);
//     }
//   }
// bool _isrejDone= false;
//   createAcount(
//       {required String name,
//       required String email,
//       required String password,
//       required String confPass}) async {
//     if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confPass.isNotEmpty) {
//       Map<String, dynamic> rejData = {
//         "name": name,
//         "email": email,
//         "password": password,
//         "confirm_password": confPass,
//         "selected_currency": gencurrency,
//         "selected_language": genlang.toLowerCase(),
//       };
//       String postData = jsonEncode(rejData);
//       print(postData);
//       _isrejDone=  await AssistantMethods.rejUser(rejData, context);
//     }
//   }
//
//   bool getUserData(
//       {required String name,
//       required String email,
//       required String password,
//       required String confPass}) {
//     if (password != confPass) {
//       return false;
//     } else if (name.isEmpty) {
//       return false;
//     } else if (email.contains('@') == false) {
//       return false;
//     } else if (password.length < 6) {
//       return false;
//     } else {
//       return true;
//     }
//   }
// }
//
//
// ///{
// ///'name':'mah'
// ///'email':'ssfagf@gmail.com'
// ///'password':'1234'
// ///'confirm_password':'1234'}
// ///
// ///{"name":"moah",
// ///"email":"kllosheshe2@gmail.com",
// ///"password":"Q8eRgYzjy8gX356",
// ///"confirm_password":"Q8eRgYzjy8gX356",
// ///"step":2,
// ///"errors":{"name":{"msg":"","valid":true},
// ///"email":{"msg":"","valid":true},
// ///"password":{"msg":"","valid":true},
// ///"confirm_password":{"msg":"","valid":true}},
// ///"pass":false,
// ///"emailPreCheck":false,
// ///"selected_language":"en",
// ///"selected_currency":"USD"}
