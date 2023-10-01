// ignore_for_file: avoid_print, library_private_types_in_public_api, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Assistants/assistant_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/config.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/account_screen.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';

import 'package:lamar_travel_packages/widget/pdfpage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  static String idscreen = 'Setting';
  static String keyDark = 'dark';
  static const List<String> laung = ['AR', 'EN'];
  static const List<String> urls = [
    "https://mapi2.ibookholiday.com/api/v1/",
    "https://mapi.ibookholiday.com/api/v1/",
    "https://staging.ibookholiday.com/api/v1/",
    "http://192.168.0.222/ibookholiday/api/v1/"
  ];

  Setting(this.pageid, {Key? key}) : super(key: key);
  bool pageid = false;

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final keyCurrency = 'key-currency';
  final keylung = 'key-lungz';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: black),
        ),
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: cardcolor,
      ),
      body: SafeArea(
        child: Column(
          // primary: false,
          // shrinkWrap: false,
          // padding: const EdgeInsets.all(10),
          children: [
            SettingsGroup(
              title: AppLocalizations.of(context)!.general,
              children: [
                _buildcurrency(),
                //   _buildMode(),
                _buildLang(),
                _buildUserBalance(),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            SettingsGroup(title: AppLocalizations.of(context)!.account, children: [
              _buildprofile(),
              //       _buildprivacy(),
              fullName == '' ? const SizedBox() : buildLogout(),
              //  _buildDarkmode()
              // _buildpolicy()
            ]),
            SettingsGroup(title: AppLocalizations.of(context)!.privacyPolicyTitle, children: [
              _buildpolicy(),
              _buildterms(),
            ]),
            SizedBox(
              height: 2.h,
            ),
            _buildContactUs()
          ],
        ),
      ),
    );
  }

  final String _url = 'https://wa.me/message/OIIYEFCLSXCZI1';

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  int seclectedcurrncy = currencyapi.indexOf(gencurrency);

  int selectedLang = Setting.laung.indexOf(genlang);

  Widget buidChangeCurrncy() => Container(
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: 100.w,
        height: 90.h,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
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
                        AppLocalizations.of(context)!.currency,
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 50.h,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: currencyapi.length,
                      itemBuilder: (context, i) => ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () async {
                              gencurrency = currencyapi[i];

                              if (fullName != '') {
                                pressIndcatorDialog(context);
                                await AssistantMethods.changeCurranceylanguage(
                                    context, {"currency": gencurrency}, 'currency');
                                    if (!mounted) return;
                                Navigator.of(context).pop();
                                setState(() {
                                  seclectedcurrncy = i;
                                });
                              }
                              if (!mounted) return;
                              if (widget.pageid == true) {
                                return;
                              }
                              if (Provider.of<AppData>(context, listen: false)
                                  .resarchWhenChangecrruncy) {
                               // Navigator.of(context).pushNamed(LoadingWidgetMain.idScreen);
                           pressIndcatorDialog(context);
                                await AssistantMethods.updatePakagewithcurruncy(
                                    Provider.of<AppData>(context, listen: false)
                                        .mainsarchForPackage
                                        .data
                                        .packageId,
                                    context);
                                    if (!mounted) return;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    PackagesScreen.idScreen, (route) => false);
                              } else {
                                Navigator.of(context).pop();
                                setState(() {
                                  seclectedcurrncy = i;
                                });
                                return;
                              }
                            },
                            horizontalTitleGap: 0,
                            minVerticalPadding: 0,
                            title: Text(localizeCurrency(currencyapi[i])),
                            leading: seclectedcurrncy == i ? const Icon(Icons.check) : const SizedBox(),
                          )),
                )
              ],
            );
          },
        ),
      );

  // Widget buidChangeMode() =>
  //     Container(
  //       decoration: BoxDecoration(
  //           borderRadius:
  //           BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
  //       width: 100.w,
  //       height: 90.h,
  //       child: StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 width: 60.w,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     TextButton(
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text(
  //                           AppLocalizations.of(context)!.close,
  //                           style: TextStyle(color: primaryblue),
  //                         )),
  //                     Text(
  //                       'Mode',
  //                       style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //                SizedBox(
  //                  width: 100.w,
  //                  height: 49.h,
  //                  child: ListView.separated(
  //                      separatorBuilder: (context, index) => Divider(),
  //                      itemCount: Setting.urls.length,
  //                      itemBuilder: (context, i) =>
  //                          ListTile(
  //                            contentPadding: EdgeInsets.all(0),
  //                            onTap: () async {
  //                              baseUrl =Setting.urls[i];
  //                              setState((){});
  //                            },
  //                            horizontalTitleGap: 0,
  //                            minVerticalPadding: 0,
  //                            title: Text(Setting.urls[i]),
  //                            leading: selectedLang == i ? Icon(Icons.check) : SizedBox(),
  //                          )),
  //                )
  //             ],
  //           );
  //         },
  //       ),
  //     );

  Widget buidChangeLang() => Container(
        decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        width: 100.w,
        height: 90.h,
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
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
                        AppLocalizations.of(context)!.language,
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  height: 49.h,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: Setting.laung.length,
                      itemBuilder: (context, i) => ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () async {
                              genlang = Setting.laung[i].toLowerCase();
                              Provider.of<AppData>(context, listen: false)
                                  .setLocale(Locale(genlang.toLowerCase()));

                              await AssistenData.setUserLocal(genlang);
                              if (fullName != '') {
                                if (!mounted) return;
                                pressIndcatorDialog(context);
                                await AssistantMethods.changeCurranceylanguage(context,
                                    {"currency": gencurrency, "language": genlang}, 'language');
                                    if (!mounted) return;
                                Navigator.of(context).pop();
                                setState(() {
                                  selectedLang = i;
                                });
                              }

                              if (widget.pageid == true) {
                                return;
                              }
if (!mounted) return;
                              Navigator.of(context).pop();
                              setState(() {
                                seclectedcurrncy = i;
                              });

                              return;
                            },
                            horizontalTitleGap: 0,
                            minVerticalPadding: 0,
                            title: Text(localizelung(Setting.laung[i])),
                            leading: selectedLang == i ? const Icon(Icons.check) :const SizedBox(),
                          )),
                )
              ],
            );
          },
        ),
      );

  Widget _buildUserBalance() => fullName == ''
      ? const SizedBox()
      : Container(
          padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Credit balance',
                style: TextStyle(fontSize: titleFontSize),
              ),
              Text('${users.data.creditBalance} ${users.data.creditCurrency}',
                  style: TextStyle(color: greencolor))
            ],
          ),
        );

  Widget _buildcurrency() => InkWell(
        onTap: () async {
          await showModalBottomSheet(
              context: context,
              shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15), topLeft: Radius.circular(15))),
              builder: (_) => buidChangeCurrncy());
          setState(() {});
        },
        child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.currency,
                  style: TextStyle(fontSize: titleFontSize),
                ),
                Text(localizeCurrency(gencurrency), style: TextStyle(color: greencolor)),
              ],
            )),
      );

  Widget _buildLang() => InkWell(
        onTap: () async {
          await showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15), topLeft: Radius.circular(15))),
              builder: (_) => buidChangeLang());
          setState(() {});
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: TextStyle(fontSize: titleFontSize),
                ),
                Text(localizelung(genlang), style: TextStyle(color: greencolor)),
              ],
            )),
      );
  //
  // Widget _buildMode() =>
  //     InkWell(
  //       onTap: () async {
  //         await showModalBottomSheet(
  //             context: context,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(15), topLeft: Radius.circular(15))),
  //             builder: (_) => buidChangeMode());
  //         setState(() {});
  //       },
  //       child:
  //       Container(
  //           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //           width: 100.w,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 'Base Url',
  //                 style: TextStyle(fontSize: titleFontSize),
  //               ),
  //               Text(baseUrl, style: TextStyle(color: greencolor)),
  //             ],
  //           )),
  //     );
  //

  // Widget _buildlung() => SizedBox(
  //       child: DropDownSettingsTile(
  //         title: 'Language',
  //         settingKey: keylung,
  //         selected: 1,
  //         values: const <int, String>{
  //           1: 'EN',
  //           2: 'AR',
  //         },
  //         onChange: (currency) {
  //           gencurrency = currency.toString();
  //         },
  //       ),
  //     );

  Widget buildLogout() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.logout,
        subtitle: '',
        leading: const IconWidget(icon: Icons.logout, color: Colors.redAccent),
        onTap: () {
          if (fullName == '') {
            AssistenData.removeUserMediaLogin();
            displayTostmessage(context, true,
                message: AppLocalizations.of(context)!.uAreNotLoggedIn);
          } else {
            logoutUser();
          }
        },
      );

  void logoutUser() async {
    try {
      await AssistantMethods.logOutUser(users.data.token);
      AssistenData.removeUserDate();
      fullName = '';
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, TabPage.idScreen, (route) => false);
    } catch (e) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.uAreNotLoggedIn);
    }
  }

  Widget _buildprofile() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.profile,
        subtitle: fullName != '' ? users.data.name : AppLocalizations.of(context)!.login,
        leading: IconWidget(icon: Icons.person, color: primaryblue),
        child: fullName != '' ? const AccountPage() : null,
        onTap: () {
          if (fullName == '') {
            isFromBooking = false;
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewLogin()
                // LoginScreen(
                //   states: 1,
                // )
                ));
          } else {
            print(isLoginWithMedia);
            return;
          }
        },
      );

  Widget _buildpolicy() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.privacyPolicy,
        subtitle: '',
        leading: Container(
          decoration: BoxDecoration(color: greencolor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(6),
          child: Icon(
            Icons.security,
            color: Colors.white,
            size: 4.w,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PdfScreen(
                    path: 'https://ibookholiday.com/services/privacy',
                    title: AppLocalizations.of(context)!.privacyPolicy,
                    isPDF: false,
                  )));
        },
      );

  Widget _buildterms() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.termsAndConditions,
        subtitle: '',
        leading: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryblue,
            ),
            child: Image.asset(
              'assets/images/terms-1.png',
              width: 4.w,
              color: cardcolor,
            )),
        //IconWidget(icon: Icons., color: Colors.green),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PdfScreen(
                  path: 'https://ibookholiday.com/services/terms',
                  title: AppLocalizations.of(context)!.termsAndConditions,
                  isPDF: false)));
        },
      );

  Widget _buildContactUs() => SimpleSettingsTile(
        title: AppLocalizations.of(context)!.contactUs,
        subtitle: '',
        leading: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: greencolor,
            ),
            child: Image.asset(
              'assets/images/whatsapp_PNG95182.png',
              width: 4.w,
              color: cardcolor,
            )),
        //IconWidget(icon: Icons., color: Colors.green),
        onTap: _launchURL,
      );

  String localizelung(String val) {
    switch (val.toLowerCase()) {
      case 'en':
        {
          return AppLocalizations.of(context)!.en;
        }
      case 'ar':
        {
          return AppLocalizations.of(context)!.ar;
        }
      default:
        {
          return val;
        }
    }
  }
}

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconWidget({Key? key, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
