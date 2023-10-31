// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/checkout_information.dart';
import 'package:lamar_travel_packages/screen/booking/newPreBooking/prebook_failed_todolist.dart';
import 'package:lamar_travel_packages/screen/booking/prebooking_steper.dart';
import 'package:lamar_travel_packages/screen/booking/summrey_and_pay.dart';
import 'package:lamar_travel_packages/screen/customize/activity/activitylist.dart';
import 'package:lamar_travel_packages/screen/customize/activity/manageActivity.dart';
import 'package:lamar_travel_packages/screen/customize/flightcustomiz.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/hotelcustomize.dart';
import 'package:lamar_travel_packages/screen/customize/hotel/splithotel.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/customize/transfer/transferCoustomize.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search.dart';
import 'package:lamar_travel_packages/screen/packages_screen.dart';
import 'package:lamar_travel_packages/setting/setting.dart';
import 'package:lamar_travel_packages/splash_screen.dart';
import 'package:lamar_travel_packages/tab_screen_controller.dart';
import 'package:lamar_travel_packages/widget/flight_details_from_customize.dart';
import 'package:lamar_travel_packages/widget/loading.dart';
import 'package:lamar_travel_packages/widget/mini_loader_widget.dart';
import 'package:lamar_travel_packages/widget/pdfpage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';

import 'Assistants/assistant_data.dart';
import 'config.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Settings.init(cacheProvider: SharePreferenceCache());
  await AssistenData.init();
  final loclaFromLocal = AssistenData.getUserLocal();
  if (loclaFromLocal != null) {
    genlang = loclaFromLocal;
  }
  packageInfo = await PackageInfo.fromPlatform();
  runApp(
    
    
    const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppData appData = AppData();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => appData,
        child: Consumer<AppData>(builder: (context, locale, child) {
          return MaterialApp(
            title: 'I Book Holiday',
            supportedLocales: L10n.all,
            locale: Provider.of<AppData>(context, listen: false).locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: ThemeData(
              fontFamily: Provider.of<AppData>(context, listen: false).locale == const Locale('en')
                  ? 'Lato'
                  : 'Bhaijaan',
              primarySwatch: Colors.blue,
            ),
            home: const TabPage(),
            debugShowCheckedModeBanner: false,
            initialRoute:
                //PreBookTodo.idScreen,
                //NewLogin.idScreen,
                // LoadingWidgetMain.idScreen,
                SplashScreen.idScreen,
            // LoginScreen.idscreen,
            routes: {
              PreBookTodo.idScreen: (context) => const PreBookTodo(
                    isIndv: null,
                  ),
              NewLogin.idScreen: (context) => const NewLogin(),
              MainScreen.idScreen: (context) => const MainScreen(),
              PackagesScreen.idScreen: (context) => const PackagesScreen(),
              //  CustomizePackage.idScreen: (context) => const CustomizePackage(),
              ManageActivity.idScreen: (context) => const ManageActivity(),
              HotelCustomize.idScreen: (context) => HotelCustomize(
                    oldHotelID: '',
                    hotelFailedName: '',
                  ),
              FlightCustomize.idScreen: (context) => FlightCustomize(
                    failedFlightNamed: '',
                  ),
              TransferCustomize.idScreen: (context) => const TransferCustomize(),
              ActivityList.idScreen: (context) => ActivityList(
                    faildActivity: '',
                  ),
              Setting.idscreen: (context) => Setting(false),
              LoadingWidgetMain.idScreen: (context) => const LoadingWidgetMain(),
              CheckoutInformation.idScreen: (context) => const CheckoutInformation(),
              CheckoutInformation.idScreen: (context) => const CheckoutInformation(),
              SumAndPay.idScreen: (context) => const SumAndPay(
                    isIndv: null,
                  ),
              SplashScreen.idScreen: (context) => const SplashScreen(),
              PdfScreen.idScreen: (context) => const PdfScreen(
                    path: '',
                    title: '',
                    isPDF: null,
                  ),
              MiniLoader.idScreen: (context) => const MiniLoader(),
              TabPage.idScreen: (context) =>const TabPage(),
              SearchStepper.idScreen: (context) => SearchStepper(
                    section: -1,
                    isFromNavBar: false,
                    searchMode: '',
                  ),
              PreBookStepper.idScreen: (context) => PreBookStepper(
                    isFromNavBar: false,
                  ),
              FlightDetial.idScreen: (context) =>const FlightDetial(),
              NewCustomizePage.idScreen: (context) => const NewCustomizePage(),
              CustomizeSlider.idScreen: (context) =>const CustomizeSlider(),
              SplitHotel.idScreen: (context) =>const SplitHotel(
                    hotels: null,
                  ),
            },
          );
        }));
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(onSignalAppId);
    OneSignal.shared.getDeviceState().then((value) {});
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    });

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {});
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {});
  }
}
class RestartWidget extends StatefulWidget {
  const RestartWidget({Key key, this.child}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
   _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}