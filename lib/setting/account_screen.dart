// ignore_for_file: library_private_types_in_public_api, unused_element

import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lamar_travel_packages/Model/user_booking_data.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/billing_information.dart';

import 'package:lamar_travel_packages/setting/setting_widgets/change_password.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/reset_password.dart';
import 'package:lamar_travel_packages/widget/image_spinnig.dart';
import '../Assistants/assistant_methods.dart';
import '../Datahandler/app_data.dart';

import '../config.dart';

import '../tab_screen_controller.dart';
import 'my-bookinglist.dart';
import 'setting_widgets/passinger_list.dart';
import 'setting_widgets/user_profile_infomation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const keyPassword = 'key-password';

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isuploadingimage = false;
  File? image;
  List<BookingListData> pastbooking = [];
  List<BookingListData> activebooking = [];

  getuserImage() async {
    AssistantMethods.getUserDetails(context);
    if (Provider.of<AppData>(context, listen: false).image == null) return;
    image = Provider.of<AppData>(context, listen: false).image;
  }

  @override
  void initState() {
    getuserImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    users = users;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: primaryblue,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const TabPage(
                          restore: 2,
                        )),
                (route) => false);
          },
          icon: Icon(
            Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 1.h),
              _buildEditUserInformation(),
              SizedBox(height: 1.h),
              _buildPassinger(),
              SizedBox(height: 1.h),
              _buildBilling(),
              SizedBox(height: 1.h),
              _buildMybooking(),
              SizedBox(height: 1.h),
              !isLoginWithMedia ? _buildPasswordReset(context) : const SizedBox(),
              SizedBox(height: 1.h),
              !isLoginWithMedia ? _buildchangePassword() : const SizedBox(),
              SizedBox(height: 3.h),
              isLoggin == true || fullName != ''
                  ? SizedBox(
                      child: InkWell(
                        onTap: () async {
                          final action = await showDialog<bool>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                    content:
                                        Text(AppLocalizations.of(context)!.sureToDeleteThisAccount),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text(AppLocalizations.of(context)!.cancel,
                                              style: TextStyle(color: greencolor))),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text(AppLocalizations.of(context)!.delete,
                                              style: const TextStyle(color: Colors.red)))
                                    ],
                                  ));

                          if (action != null && action == false) return;
                          if (!mounted) return;
                          pressIndcatorDialog(context);
                          final isDeleted = await AssistantMethods.deleteAcount();
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          if (isDeleted) {
                            displayTostmessage(context, false,
                                message: AppLocalizations.of(context)!.deleteSuccess);
                            Navigator.pushNamedAndRemoveUntil(
                                context, TabPage.idScreen, (route) => false);
                          } else {
                            displayTostmessage(context, true,
                                message: AppLocalizations.of(context)!.deleteFailed);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.deleteAccount,
                          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
        width: 100.w,
        height: 20.h,
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
                        child: !isuploadingimage
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
                                child: const ImageSpinning(withOpasity: true)),
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
                    Positioned(
                      child: SizedBox(
                        child: Column(
                          children: const [Text('')],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Consumer<AppData>(
                builder: (context, data, child) => Text(
                  data.userupadate != null ? data.userupadate!.data.name : '',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
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
        isuploadingimage = true;
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
        isuploadingimage = false;
      });
    } catch (e) {
      setState(() {
        isuploadingimage = false;
      });
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

  // Widget _buildUplodFrom({required String title, required IconData icon}) => Container(
  //       decoration:
  //           BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey.shade400),
  //       padding: EdgeInsets.all(8),
  //       margin: EdgeInsets.all(10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             icon,
  //             color: primaryblue,
  //           ),
  //           SizedBox(
  //             width: 1.w,
  //           ),
  //           Text(
  //             title,
  //             style: TextStyle(
  //                 fontSize: 18.sp, color: Colors.grey.shade100, fontWeight: FontWeight.w600),
  //           ),
  //         ],
  //       ),
  //     );

  Widget _buildEditUserInformation() => Consumer<AppData>(
        builder: (context, data, child) {
          return SimpleSettingsTile(
            title: AppLocalizations.of(context)!.profileInformation,
            subtitle: data.userupadate != null
                ? '${data.userupadate!.data.name}  ${data.userupadate!.data.lastName}'
                : '${users.data.name} ${users.data.lastName}',
            child: UserProfileInfomation(
              isFromPreBook: false,
            ),
          );
        },
      );

  Widget _buildPassinger() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.passengers,
        subtitle: AppLocalizations.of(context)!.passengersRecords,
        // leading:
        //     IconWidget(icon: Icons.family_restroom, color: Colors.redAccent),
        child: const PassingerList(),
      );

  Widget _buildPasswordReset(BuildContext context) => SimpleSettingsTile(
        title: 'Reset Password',
        subtitle: '',
        child: const ResetPasswordScreen(),

        //    callresetPassword(email, context);
      );

  Widget _buildChangePassword(BuildContext context) => TextInputSettingsTile(
        settingKey: AccountPage.keyPassword,
        title: 'Change Password',
        validator: (email) =>
            email != null && email.contains('@') ? null : 'The Password is requred',
        obscureText: false,
        onChange: (email) {
          //     callresetPassword(email, context);
        },
      );

  callChangePassword(BuildContext context, password) {}

  Widget _buildchangePassword() => SimpleSettingsTile(
        title: 'change password',
        subtitle: ' ',
        // leading:
        //     IconWidget(icon: Icons.family_restroom, color: Colors.redAccent),
        child: const ChangePassword(),
      );

  Widget _buildMybooking() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.myBooking,
        subtitle: '',
        onTap: () async {
          //      pressIndcatorDialog(context);

          // Navigator.of(context).pushNamed(MiniLoader.idScreen);

          pastbooking = await AssistantMethods.getuserBookingList(context);
          // Navigator.of(context).pop();
          if (!mounted) return;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyBookingScreen(
                    bookingList: pastbooking,
                  )));
        },
        //  child: MyBookingScreen(pastbooking: pastbooking,activebooking: activebooking,),
        //  leading: IconWidget(icon: Icons.history, color: greencolor),
      );

  Widget _buildBilling() => SimpleSettingsTile(
        title: 'Billing information',
        subtitle: ' ',
        child: const BillingInformationScreen(),
      );

  saveimagetotheUserAccount(file) async {
    String base64Image = "data:image/png;base64,${base64Encode(file)}";
    await AssistantMethods.uploadUserimage(context, base64Image);

    setState(() {});
  }
}

class Restpassword {
  Restpassword({required this.error, required this.message});

  bool error;
  String message;

  factory Restpassword.fromjson(Map<String, dynamic> json) =>
      Restpassword(error: json["error"], message: json["message"]);
}

Restpassword resetPassfromjson(String str) => Restpassword.fromjson(json.decode(str));
