// ignore_for_file: use_build_context_synchronously, deprecated_member_use, unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenshot_callback/flutter_screenshot_callback.dart';
import 'package:lamar_travel_packages/Assistants/assistant_methods.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/checkout_information.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting_widgets/user_profile_infomation.dart';
import 'package:lamar_travel_packages/widget/pakageimage.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config.dart';

import 'package:sizer/sizer.dart';

import '../../../tab_screen_controller.dart';

class CustomizeSlider extends StatefulWidget {
  const CustomizeSlider({Key? key}) : super(key: key);

  static String idScreen = 'CustomizeSlider';

  @override
  _CustomizeSliderState createState() => _CustomizeSliderState();
}

class _CustomizeSliderState extends State<CustomizeSlider>
    with SingleTickerProviderStateMixin, IScreenshotCallback {
  //late Customizpackage _customizpackage;
  // late Animation<double> _animation;
  // late Animation<Offset> _animation2;

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(milliseconds: 500),
  //   vsync: this,
  // );

  get packagesList => null;

  bool isLogin = false;

  getlogin() {
    if (fullName == '') {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  late Customizpackage _customizpackage;

  CarouselController buttonCarouselController = CarouselController();


  // void _scrollListener() {
  //   final percent = _controller.position.pixels / MediaQuery.of(context).size.height;
  // }

  String imagepath = '';
  File? filepath;
  bool isModelSheetIsShown = false;
  late ScreenshotCallback screenshotCallbacks;

  void initCallback() {
    screenshotCallbacks = ScreenshotCallback();
    screenshotCallbacks.startScreenshot();
    screenshotCallbacks.setInterfaceScreenshotCallback(this);
  }

  @override
  void initState() {
    initCallback();

    Provider.of<AppData>(context, listen: false).locale;
    super.initState();
    getlogin();
    _customizpackage = Provider.of<AppData>(context, listen: false).packagecustomiz;

    // _controller.addListener(_scrollListener);
    // screenListener.addScreenShotListener((filePath) async{
    //   print(filepath);
    //   imagepath = filePath;
    //   filepath  = new File(filePath);
    //
    //   displayShareDialog(context);},
    // );
    // screenListener.watch();
  }

  @override
  void dispose() {
    isModelSheetIsShown = true;
    screenshotCallbacks.stopScreenshot();
    super.dispose();
  }

  Future displayShareDialog(BuildContext ctx) => showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      isScrollControlled: true,
      builder: (ctx) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100.w,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        //  filepath!.deleteSync(recursive: true);
                        setState(() {
                          isModelSheetIsShown = false;
                        });

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    Text('       ${AppLocalizations.of(context)!.shareYourPackage}'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                color: Colors.grey.shade200,
                //    width: 100.w,
                height: 75.h,
                child: Image.file(
                  filepath!,
                  fit: BoxFit.contain,
                  height: 100.h,
                ),
              ),
              SizedBox(
                  width: 60.w,
                  child: OutlinedButton(
                    onPressed: () async {
                      pressIndcatorDialog(context);

                      final shareUrl = await AssistantMethods.sharePackageDeepLink(
                          _customizpackage.result.customizeId, 'customizeId');
                      Navigator.of(context).pop();
                      if (shareUrl != null || shareUrl != '') {
                        await Share.share(shareUrl, subject: _customizpackage.result.packageName);
                      }
                      isModelSheetIsShown = false;
                      Navigator.of(context).pop();
                      await deleteFile(filepath!);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryblue, side: BorderSide(color: primaryblue, width: 2),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.shareYourPackage,
                      style: TextStyle(fontSize: titleFontSize, color: primaryblue),
                    ),
                  )),
              SizedBox(
                height: 5.h,
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    double h = 100.h;
    double w = 100.w;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                    pinned: true,
                    delegate: CustmizeHederDelegate(
                      max: h - (kBottomNavigationBarHeight + 200),
                      min: h / 7,
                      builder: (percent) {
                        final topPadding = MediaQuery.of(context).padding.top;
                        final bottomPercent = (percent / .6).clamp(0.0, 1.0);

                        final topPercent = ((1 - percent) / .9).clamp(0.0, 1.0);
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            HeaderWidget(
                                w: w,
                                topPadding: topPadding,
                                bottomPercent: bottomPercent,
                                customizpackage: _customizpackage,
                                buttonCarouselController: buttonCarouselController),
                            Positioned(
                              top: topPadding,
                              left: -60 * (1 - bottomPercent),
                              child: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? IconButton(
                                      icon: Icon(
                                        Provider.of<AppData>(context, listen: false).locale ==
                                                const Locale('ar')
                                            ? Icons.keyboard_arrow_right_rounded
                                            : Icons.keyboard_arrow_left_rounded,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        if (Provider.of<AppData>(context, listen: false)
                                            .isFromdeeplink) {
                                          Provider.of<AppData>(context, listen: false)
                                              .isFromDeeplink(false);

                                          Navigator.pushNamedAndRemoveUntil(
                                              context, TabPage.idScreen, (route) => false);
                                        } else {
                                          Navigator.of(context).pushNamedAndRemoveUntil(
                                              PackagesScreen.idScreen, (route) => false);
                                        }
                                      },
                                      color: Colors.white,
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        pressIndcatorDialog(context);
                                        final shareUrl =
                                            await AssistantMethods.sharePackageDeepLink(
                                                _customizpackage.result.customizeId, 'customizeId');
                                        Navigator.of(context).pop();
                                        if (shareUrl != null || shareUrl != '') {
                                          Share.share(shareUrl,
                                              subject: _customizpackage.result.packageName);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            Positioned(
                              top: lerpDouble(-100, 140, topPercent)!.clamp(topPadding + 10, 140),
                              left: lerpDouble(100, 20, topPercent)!.clamp(20.0, 50.0),
                              right: 40,
                              child: AnimatedOpacity(
                                duration: kThemeAnimationDuration,
                                opacity: bottomPercent < 1 ? 0 : 1,
                                child: Text(
                                  _customizpackage.result.packageName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: lerpDouble(0, 40, topPercent)!.clamp(20.0, 40.0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned(
                              top: topPadding,
                              right: -60 * (1 - bottomPercent),
                              child: Provider.of<AppData>(context, listen: false).locale ==
                                      const Locale('en')
                                  ? IconButton(
                                      onPressed: () async {
                                        pressIndcatorDialog(context);
                                        final shareUrl =
                                            await AssistantMethods.sharePackageDeepLink(
                                                _customizpackage.result.customizeId, 'customizeId');
                                        Navigator.of(context).pop();
                                        if (shareUrl != null || shareUrl != '') {
                                          Share.share(shareUrl,
                                              subject: _customizpackage.result.packageName);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Provider.of<AppData>(context, listen: false).locale ==
                                                const Locale('ar')
                                            ? Icons.keyboard_arrow_right_rounded
                                            : Icons.keyboard_arrow_left_rounded,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        if (Provider.of<AppData>(context, listen: false)
                                            .isFromdeeplink) {
                                          Provider.of<AppData>(context, listen: false)
                                              .isFromDeeplink(false);

                                          Navigator.pushNamedAndRemoveUntil(
                                              context, TabPage.idScreen, (route) => false);
                                        } else {
                                          Navigator.of(context).pushNamedAndRemoveUntil(
                                              PackagesScreen.idScreen, (route) => false);
                                        }
                                      },
                                      color: Colors.white,
                                    ),
                            ),
                          ],
                        );
                      },
                    )),
                SliverToBoxAdapter(
                    child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  width: 100.w,
                  child:
                      Material(borderRadius: BorderRadius.circular(20), child: const NewCustomizePage()),
                ))
              ],
            )
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: cardcolor, boxShadow: [shadow]),
        padding: const EdgeInsets.all(10),
        height: 14.5.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              child: Consumer<AppData>(
                builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalPACKAGEPRICE,
                      style: TextStyle(
                          color: greencolor,
                          fontWeight: FontWeight.normal,
                          fontSize: subtitleFontSize),
                    ),
                    Text(
                      ' ${value.packagecustomiz.result.totalAmount} ${localizeCurrency(value.packagecustomiz.result.sellingCurrency)}',
                      //   '${value.packagecustomiz.result.sellingCurrency}',
                      style: TextStyle(
                          color: greencolor,
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleFontSize),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    screenshotCallbacks.stopScreenshot();
                    getlogin();

                    if (Provider.of<AppData>(context, listen: false).isFromdeeplink) {
                      pressIndcatorDialog(context);
                      await Future.delayed(const Duration(seconds: 2), () {
                        if (!isLogin) {
                          getlogin();
                        }
                      });
                      Navigator.of(context).pop();
                    }
                    if (isLogin) {
                      if (users.data.phone.isEmpty) {
                        displayTostmessage(context, false,
                            message: AppLocalizations.of(context)!.youAccountMissSomeInformation);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserProfileInfomation(
                                  isFromPreBook: true,
                                )));
                      } else {
                        Provider.of<AppData>(context, listen: false)
                            .newPreBookTitle(AppLocalizations.of(context)!.passengersInformation);
                        // GET ACTIVITY QUESTIONS

                        context.read<AppData>().toggleHasQuestions(
                            await AssistantMethods.getActivityQuestions(
                                context, _customizpackage.result.customizeId));
                        Navigator.pushNamedAndRemoveUntil(
                            context, CheckoutInformation.idScreen, (route) => false);
                        //  Provider.of<AppData>(context, listen: false).clearAllPassengerInformation();
                        Provider.of<AppData>(context, listen: false)
                            .resetSelectedPassingerfromPassList();
                      }
                    } else {
                      isFromBooking = true;
                      Navigator.of(context).pushNamed(NewLogin.idScreen);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryblue.withOpacity(0.8),
                      elevation: 0.0,
                      fixedSize: Size(40.w, 5.h)),
                  child: Text(
                    AppLocalizations.of(context)!.bookNow,
                    style: TextStyle(
                        fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final shareUrl = await AssistantMethods.sharePackageDeepLink(
                        _customizpackage.result.customizeId, 'customizeId');

                    String url =
                        // 'https://wa.me/message/OIIYEFCLSXCZI1';

                        //  "https://wa.me/OIIYEFCLSXCZI1?text=${Uri.parse("hiii")}";
                        'https://wa.me/+971585588845/?text=${Uri.parse("I+need+help+with+this+package++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++$shareUrl")}';

                    if (!await launch(url, forceSafariVC: false)) throw 'Could not launch $url';
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade400, elevation: 0.0, fixedSize: Size(35.w, 5.h)),
                  child: Text(
                    AppLocalizations.of(context)!.needHelp,
                    style: TextStyle(
                        fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  deniedPermission() {
  }

  @override
  screenshotCallback(String data) async {
    log(data);

    imagepath = data;
    filepath = File(data);

    filepath = await filepath!
        .rename(data.replaceAll('.png', '${DateTime.now().microsecondsSinceEpoch / 1080}.png'));
    if (isModelSheetIsShown) {
      return;
    } else {
      isModelSheetIsShown = true;
      displayShareDialog(context);
    }
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.w,
    required this.topPadding,
    required this.bottomPercent,
    required Customizpackage customizpackage,
    required this.buttonCarouselController,
  })  : super(key: key);

  final double w;
  final double topPadding;
  final double bottomPercent;
  final CarouselController buttonCarouselController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      child: Padding(
        padding: EdgeInsets.only(
          top: (10 + topPadding) * (1 - bottomPercent),
          bottom: 0,
        ),
        child: Consumer<AppData>(
          builder: (context, data, child) => Transform.scale(
              scale: lerpDouble(1, 1.3, bottomPercent)!,
              child: data.packagecustomiz.result.nohotels
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/iconss/top.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PlaceImagesPageView(
                        imagesUrl: data.packagecustomiz.result.hotels.isNotEmpty
                            ? data.packagecustomiz.result.hotels[0].imgAll
                                .map((e) => e.src)
                                .toList()
                            : ['assets/images/iconss/top.png'],
                      ),
                    )

              //  CachedNetworkImage(
              //   imageUrl: e.src.trimLeft(),
              //   fit: BoxFit.cover,
              //   placeholder: (context, url) => Container(
              //       child: ImageSpinning(
              //     withOpasity: true,
              //   )),
              //   errorWidget: (context, erorr, x) => Image.asset(
              //     'assets/images/image-not-available.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),

              ),
        ),
      ),
    );

    //       Image.network(_customizpackage.result.hotels[0].image,fit: BoxFit.cover,),
  }
}

class CustmizeHederDelegate extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  final Widget Function(double percent) builder;

  CustmizeHederDelegate({
    required this.max,
    required this.min,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / max);
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
