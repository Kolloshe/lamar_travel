// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import '../../Assistants/assistant_methods.dart';
import '../../Datahandler/app_data.dart';
import '../../config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileInfomation extends StatefulWidget {
  bool isFromPreBook = false;

  UserProfileInfomation({Key? key, required this.isFromPreBook}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileInfomationState createState() => _UserProfileInfomationState();
}

class _UserProfileInfomationState extends State<UserProfileInfomation> {
  bool showcitiyList = false;

  bool isuploadingImage = false;

  File? image;

  bool ischangesoting = false;

  final fullNameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final emailController = TextEditingController();
  final citiyController = TextEditingController();
  final postalController = TextEditingController();
  final addressController = TextEditingController();

  String countryCode = 'SA';
  String phoneCountryCode = '971';
  String filagurl = '';
  String fullCName = '';
  final _formKey = GlobalKey<FormState>();

  getuserInitialData() {
    if (widget.isFromPreBook) {
      displayTostmessage(context, false,
          message: AppLocalizations.of(context)?.youAccountMissSomeInformation ??
              "You account miss some information");
    }
    image = Provider.of<AppData>(context, listen: false).image;

    fullNameController.text = '${users.data.name} ${users.data.lastName}';
    emailController.text = users.data.email;
    phonenumberController.text = users.data.phone;

    phonenumberController.text = users.data.phone;
    if (users.data.address != null) {
      addressController.text = users.data.address!;
    }
    if (users.data.postalCode != null) {
      postalController.text = users.data.postalCode ?? '';
    }

    if (users.data.phoneCountryCode.isNotEmpty) {
      phoneCountryCode = users.data.phoneCountryCode;
    }
    if (Provider.of<AppData>(context, listen: false).image == null) return;
  }

  @override
  void initState() {
    getuserInitialData();
    super.initState();
  }

  @override
  void dispose() {
    phonenumberController.dispose();
    emailController.dispose();
    citiyController.dispose();
    fullNameController.dispose();
    postalController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryblue,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.information),
        leading: IconButton(
          onPressed: () {
            setState(() {
              users = users;
            });

            Navigator.of(context).pop(false);
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            size: 30.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInformationFeild(
                        validation: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                        title: AppLocalizations.of(context)!.name,
                        data: "${users.data.name} ${users.data.lastName} ",
                        controller: fullNameController,
                        keyboard: TextInputType.name),
                    _buildInformationFeild(
                        validation: (v) {
                          if (v != null && EmailValidator.validate(v)) {
                            return null;
                          } else {
                            return "Please enter a valid email";
                          }
                        },
                        title: AppLocalizations.of(context)!.email,
                        data: emailController.text,
                        controller: emailController,
                        keyboard: TextInputType.emailAddress),
                    _buildPhoneFeild(
                        title: AppLocalizations.of(context)!.phone,
                        data: '  xx xxx xxxx ',
                        controller: phonenumberController,
                        keyboard: TextInputType.phone),
                    // _buildInformationFeild(
                    //     validation: (v) {},
                    //     title: AppLocalizations.of(context)!.address,
                    //     data: addressController.text,
                    //     controller: addressController,
                    //     keyboard: TextInputType.streetAddress),
                    // _buildInformationFeild(
                    //     validation: (v) {},
                    //     title:AppLocalizations.of(context)!.postalCode,
                    //     data: postalController.text,
                    //     controller: postalController,
                    //     keyboard: TextInputType.phone),
                    //     _buildcitiywidget(),
                  ],
                )),
            SizedBox(
              height: 3.h,
            ),
            _buildButton(),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
        width: 100.w,
        height: 18.h,
        decoration: BoxDecoration(
            color: primaryblue,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70.sp,
                child: Stack(
                  children: [
                    Positioned(
                      child: ClipOval(
                        child: !isuploadingImage
                            ? CachedNetworkImage(
                                imageUrl: users.data.profileImage,
                                width: 70.sp,
                                height: 100.sp,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const ImageSpinning(
                                  withOpasity: true,
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                            : SizedBox(
                                width: 70.sp,
                                height: 100.sp,
                                child: const ImageSpinning(
                                  withOpasity: true,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0.w,
                      bottom: 1.h,
                      child: GestureDetector(
                        onTap: () async {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              await changePhoto(ImageSource.camera);
                                            },
                                            child: _buildUplodFrom(
                                                title: AppLocalizations.of(context)!.takeFromCamera,
                                                icon: Icons.camera)),
                                        GestureDetector(
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              await changePhoto(ImageSource.gallery);
                                            },
                                            child: _buildUplodFrom(
                                                title:
                                                    AppLocalizations.of(context)!.takeFromGallery,
                                                icon: Icons.photo)),
                                      ],
                                    ),
                                  ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: yellowColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                users.data.name,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Future changePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        isuploadingImage = true;
      });

      final imagefile = File(image.path);
      setState(() {
        this.image = imagefile;
      });
      if (!mounted) return;
      Provider.of<AppData>(context, listen: false).getuerimage(imagefile);
      final data = this.image!.readAsBytesSync();
      await saveimagetotheUserAccount(data);
      setState(() {
        isuploadingImage = false;
      });
      ischangesoting = true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Widget _buildUplodFrom({required String title, required IconData icon}) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(10),
        child: Text(
          title,
          style:
              TextStyle(fontSize: titleFontSize, color: primaryblue, fontWeight: FontWeight.w600),
        ),
      );

  saveimagetotheUserAccount(file) async {
    String base64Image = "data:image/png;base64,${base64Encode(file)}";
    await AssistantMethods.uploadUserimage(context, base64Image);
    setState(() {});
  }

  Widget _buildInformationFeild(
          {required String? Function(String?)? validation,
          required String title,
          required String data,
          required TextEditingController controller,
          required TextInputType keyboard}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(5),
        child: TextFormField(
          onChanged: (v) {
            setState(() {
              ischangesoting = true;
            });
          },
          validator: validation,
          controller: controller,
          keyboardType: keyboard,
          style: TextStyle(color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
          decoration: InputDecoration(
            labelStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.bold, fontSize: 12.sp),
            labelText: title,
            hintText: data,
            hintStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),
        ),
      );

  // Widget _buildcitiywidget() {
  //   return GestureDetector(
  //     onTap: () {
  //       showCountryPicker(
  //           context: context,
  //           onSelect: (citiy) {
  //             setState(() {});
  //             try {
  //               citiyname = citiy.name;
  //               final x = users.data.countries;
  //               final y = x!.where((element) => element.name == citiyname);
  //             } catch (e) {
  //               showcitiyList = false;
  //               print(e);
  //             }
  //             print(citiy.toJson());
  //           });
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(20).copyWith(left: 8, right: 8),
  //       margin: EdgeInsets.all(10),
  //       child: Material(
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(
  //                 width: 80.w,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Country\n',
  //                       style: TextStyle(
  //                           color: blackTextColor, fontWeight: FontWeight.bold, fontSize: 11.sp),
  //                     ),
  //                     Text(
  //                       citiyname,
  //                       style: TextStyle(fontSize: 12.sp),
  //                     ),
  //                     Divider(
  //                       color: Colors.black,
  //                     ),
  //                   ],
  //                 )),
  //             Icon(Icons.arrow_drop_down)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  country() {
    showCountryPicker(
      context: context,
      showPhoneCode: false, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          phoneCountryCode = country.phoneCode;
          countryCode = country.countryCode;
          fullCName = country.name;
          if (kDebugMode) {
            print(phoneCountryCode.toString() + countryCode.toString() + fullCName);
          }
        });
      },
    );
  }

  Widget _buildPhoneFeild(
          {required String title,
          required String data,
          required TextEditingController controller,
          required TextInputType keyboard}) =>
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        child: TextFormField(
          maxLength: 10,
          validator: (v) {
            ischangesoting = true;
            if (v == null || v.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
          controller: controller,
          keyboardType: keyboard,
          style: TextStyle(color: blackTextColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
          decoration: InputDecoration(
            prefix: GestureDetector(
              onTap: () {
                country();
              },
              child: Container(
                padding: const EdgeInsets.all(3),
                child: Text('+$phoneCountryCode'),
              ),
            ),
            suffix: InkWell(
                onTap: () {
                  country();
                },
                child: const Icon(Icons.keyboard_arrow_down)),
            labelStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.bold, fontSize: 14.sp),
            labelText: title,
            hintText: data,
            hintStyle:
                TextStyle(color: blackTextColor, fontWeight: FontWeight.w600, fontSize: 12.sp),
          ),
        ),
      );

  _buildButton() => ElevatedButton(
        onPressed: updatadata,
        style: ElevatedButton.styleFrom(backgroundColor: primaryblue, fixedSize: Size(95.w, 7.h)),
        child: Text(
          AppLocalizations.of(context)!.update,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  collectUserData() async {
    String fullphone = phoneCountryCode + phonenumberController.text;
    // final firstname = fullNameController.text.indexOf(fullNameController.text.split(' ')[1]);
    // final fullname = fullNameController.text.substring(0, firstname);

    final fullname = fullNameController.text.trim().split(' ');
    String firstname = ' ';
    String lastname = ' ';

    for (var i = 0; i < fullname.length; i++) {
      if (i == 0) {
        firstname = fullname[i];
      }
      if (i > 0) {
        lastname = '$lastname ${fullname[i]}';
      }
    }
    if (lastname == " ") {
      displayTostmessage(context, true, message: 'Please add full name');
      return;
    }

    await AssistantMethods.updateUserInformation(context,
        email: emailController.text,
        firstname: firstname.trim(),
        lastname: lastname.trim(),
        phone: phonenumberController.text,
        phoneCountryCode: phoneCountryCode,
        postalcode: "",
        country: fullCName,
        countryCode: countryCode,
        citycode: '');
    if (!mounted) return;
    setState(() {});
    if (widget.isFromPreBook) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(true);
      ischangesoting = false;
    }
  }

  void updatadata() {
    _formKey.currentState!.validate();
    if (_formKey.currentState!.validate() == false) return;
    if (fullNameController.text.contains('firstname') ||
        fullNameController.text.contains('lastname')) {
      displayTostmessage(context, true, message: 'Please use real name');
      return;
    }

    if (ischangesoting) {
      collectUserData();
    } else {
      displayTostmessage(context, true, message: 'please make some changes');
    }
  }
}
