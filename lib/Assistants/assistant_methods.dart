// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import 'package:lamar_travel_packages/Assistants/assistant_data.dart';
import 'package:lamar_travel_packages/Assistants/requesta_assistant.dart';
import 'package:lamar_travel_packages/Datahandler/app_data.dart';
import 'package:lamar_travel_packages/Model/cancelltionpolicy.dart';
import 'package:lamar_travel_packages/Model/activity_list.dart';
import 'package:lamar_travel_packages/Model/activity_questions.dart';
import 'package:lamar_travel_packages/Model/cancel_booking_model.dart';
import 'package:lamar_travel_packages/Model/cancelation_model.dart';
import 'package:lamar_travel_packages/Model/cancelation_resones.dart';
import 'package:lamar_travel_packages/Model/change_transfer_distnation_if_remove_model.dart';
import 'package:lamar_travel_packages/Model/changeflight.dart';
import 'package:lamar_travel_packages/Model/changehotel.dart';
import 'package:lamar_travel_packages/Model/countries.dart';
import 'package:lamar_travel_packages/Model/coupon_code.dart';
import 'package:lamar_travel_packages/Model/currencies.dart';
import 'package:lamar_travel_packages/Model/customizpackage.dart';
import 'package:lamar_travel_packages/Model/delete_account_model.dart';
import 'package:lamar_travel_packages/Model/footer_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_customize_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/privet_jet_category_model.dart';

import 'package:lamar_travel_packages/Model/login/user.dart';

import 'package:lamar_travel_packages/Model/mainsearch.dart';
import 'package:lamar_travel_packages/Model/newchangehotel.dart';
import 'package:lamar_travel_packages/Model/payload.dart';

import 'package:lamar_travel_packages/Model/prebookfaild.dart';
import 'package:lamar_travel_packages/Model/promo_list.dart';
import 'package:lamar_travel_packages/Model/promp_popup.dart';
import 'package:lamar_travel_packages/Model/refrech_pay_url_model.dart';
import 'package:lamar_travel_packages/Model/room_cancellation_policy.dart';
import 'package:lamar_travel_packages/Model/searchforflight.dart';
import 'package:lamar_travel_packages/Model/searchforhotel.dart';
import 'package:lamar_travel_packages/Model/transfer_listing_model.dart';
import 'package:lamar_travel_packages/Model/user_booking_data.dart';
import 'package:lamar_travel_packages/screen/auth/new_login.dart';
import 'package:lamar_travel_packages/screen/booking/InfomationModel.dart';
import 'package:lamar_travel_packages/screen/booking/booking_failed_model.dart';
import 'package:lamar_travel_packages/screen/booking/payment_failed_model.dart';
import 'package:lamar_travel_packages/screen/booking/summrey_and_pay.dart';

import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize_slider.dart';
import 'package:lamar_travel_packages/screen/customize/new-customize/new_customize.dart';
import 'package:lamar_travel_packages/screen/individual_services/ind_widgets/ind_activity/ind_activity_list.dart';
import 'package:lamar_travel_packages/screen/main_screen1.dart';
import 'package:lamar_travel_packages/screen/newsearch/new_search_room_passinger.dart';
import 'package:lamar_travel_packages/setting/account_screen.dart';
import 'package:lamar_travel_packages/widget/errordialog.dart';
import 'package:lamar_travel_packages/widget/maintnancmode.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:provider/provider.dart';

import '../Model/change_transfer.dart';
import '../Model/individual_services_model/indv_packages_listing_model.dart';
import '../config.dart';
import '../screen/individual_services/ind_packages_screen.dart';
import '../screen/packages_screen.dart';

class AssistantMethods {
  static Future<dynamic> getcountries(BuildContext context) async {
    String url = '${baseUrl}global/countries?currency=$gencurrency&language=$genlang';
    List<Country> res = [];
    var response = await RequsestAssistant.getRequest(url);

    if (response != "Failed") {
      int ind = 0;
      for (var countris in response['countries']) {
        Country country = Country(
            id: response['countries'][ind]['id'],
            name: response['countries'][ind]['name'],
            code: response['countries'][ind]['code'],
            currency: response['countries'][ind]['currency']);
        res.add(country);
        ind++;
      }
      Provider.of<AppData>(context, listen: false).getcountrydatapro(res);
      return res;
    } else {
      return;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* GET REQUSTE ******************************** */
//**********************************  SEARCH  ********************************** */
//****************************************************************************** */
//****************************************************************************** */
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////

//****************************************************************************** */
//****************************************************************************** */
//*********************************  SEARCH FOR   ****************************** */
//**********************************   Cities    ******************************* */
//****************************************************************************** */
//****************************************************************************** */

  static Future getPayloadFromLocation(BuildContext context, String citiy) async {
    String url =
        '${baseUrl}holiday/destination_list?destination=$citiy&currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String json = await response.stream.bytesToString();

      var data = jsonDecode(json);
      var x = PayloadElement.fromJson(data['payload'][0]);
      //

      return x;
    } else if (response.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else {}
  }

  static Future<List<PayloadElement>> searchfrom(String citiyName, BuildContext context) async {
    late Payload payload;
    citiyName.trimRight();
    //(citiyName);
    String url = baseUrl +
        'holiday/destination_list?destination=$citiyName&currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);

    print(response.body);
    if (response.statusCode != 200) {
    } else {
      payload = payloadFromJson(response.body);
      //
      Provider.of<AppData>(context, listen: false).gitcities(payload.payload);
    }
    return payload.payload;
  }

  static Future<List<PayloadElement>> searchForTransferDistnation(
      String citiyName, BuildContext context) async {
    late Payload payload;
    citiyName.trimRight();
    //(citiyName);
    String url = baseUrl +
        'holiday/destination_list?destination=$citiyName&currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
    } else {
      payload = payloadFromJson(response.body);
      //
      Provider.of<AppData>(context, listen: false).transferdistnation(payload.payload);
    }
    return payload.payload;
  }

//****************************************************************************** */
//****************************************************************************** */
//*********************************  SEARCH FOR   ****************************** */
//**********************************   FLIGHT    ******************************* */
//****************************************************************************** */
//****************************************************************************** */

  static Future<Searchforflight?> searchingFlight(String quere, BuildContext context) async {
    String url =
        baseUrl + 'global/holiday_flights?currency=$gencurrency&language=$genlang&key=$quere';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final flight = searchforflightFromJson(jsonString);

      Provider.of<AppData>(context, listen: false).getFlightSearchList(flight);

      return flight;
    } else {
      return null;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//*********************************  SEARCH FOR   ****************************** */
//**********************************   HOTELS    ******************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future<Searchforhotel?> searchHotel(String qu, BuildContext context) async {
    String url = baseUrl +
        'global/holiday_hotels?&currency=$gencurrency&language=$genlang&key=$qu&cityCode=${Provider.of<AppData>(context, listen: false).payloadto.id}';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    final jsonData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final hotel = searchforhotelFromJson(jsonData);
      Provider.of<AppData>(context, listen: false).getHotelSearchList(hotel);
      return hotel;
    } else {
      return null;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* Main Search ******************************** */
//**********************************  PACKAGES  ******************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future<bool> mainSearchpackage(
      BuildContext context,
      String packageStart,
      String packageEnd,
      String departureCode,
      String arrivalCode,
      String hotelCode,
      String flightCode,
      String flightClass,
      int rooms,
      int adults,
      int children,
      String childages,
      String hotelstar,
      String searchMode,
      String flightType) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    context.read<AppData>().flightType =
        flightType.trim() == "1" ? FlightType.onewayFlight : FlightType.roundedFlight;
    String url =
        //  'http://192.168.0.222/ibookaholidaynew/api/v1/holiday/list?package_id=6245b5e172a5cf36d60d2d62';
        '${baseUrl}holiday/search?os=${Platform.isIOS ? 'ios' : 'android'}&app_version=${packageInfo.buildNumber}&package_start=$packageStart&package_end=$packageEnd&departure_code=$departureCode&arrival_code=$arrivalCode&hotelCode=$hotelCode&flightCode=$flightCode&search_Type=1&flightClass=$flightClass&rooms[1]=$rooms&adults[1]=$adults&children[1]=$children&$childages&hotelStar=$hotelstar&currency=$gencurrency&language=$genlang&selling_currency=$gencurrency&searchRequest=1&flight_trip_type=$flightType&searchMode=$searchMode';

    log(url);
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo.buildNumber,
      'Accept': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    log(url);

    request.headers.addAll(headers);

    http.StreamedResponse respons = await request.send();
    String data = await respons.stream.bytesToString();
    log(data);
    if (respons.statusCode == 200) {
      if (searchMode == '') {
        MainSarchForPackage mainSarchFor = mainSarchForPackageFromJson(data);
        Provider.of<AppData>(context, listen: false).getmainpakcages(mainSarchFor, false);

        Navigator.of(context)
          ..pop()
          ..pushNamed(PackagesScreen.idScreen);
      } else {
        final indvPackagesModel = indvPackagesModelFromMap(data);
        context.read<AppData>().setIndvPackages(indvPackagesModel);
        if (searchMode.toLowerCase().trim() == 'activity') {
          await customizingPackage(context, indvPackagesModel.data.packages.first.id);

          final d1 = context.read<AppData>().newSearchFirstDate;
          final d2 = context.read<AppData>().newSearchsecoundDate;

          if (d2 == null || d1!.isAtSameMomentAs(d2)) {
            Provider.of<AppData>(context, listen: false).getActivityDat(0);

            await AssistantMethods.getActivityList(context,
                searchId: context.read<AppData>().packagecustomiz.result.searchId,
                customizeId: context.read<AppData>().packagecustomiz.result.customizeId,
                activityDay: 0,
                currency: gencurrency);
            Navigator.of(context)
              ..pop()
              ..push(MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()))
              ..push(MaterialPageRoute(
                  builder: (context) => IndActivityList(
                        faildActivity: '',
                        fromChange: false,
                      )));
          } else {
            Navigator.of(context)
              ..pop()
              ..push(MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()));
          }
        } else {
          Navigator.of(context)
            ..pop()
            ..push(MaterialPageRoute(builder: (context) => const IndividualPackagesScreen()));
        }
      }

      // log(mainSarchFor.data.listingUrl);
      return true;
    } else if (respons.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else {
      String data = await respons.stream.bytesToString();
      Map<String, dynamic> error = jsonDecode(data);

      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      error.containsKey('message')
          ? displayTostmessage(context, true, message: error['message'])
          : null;
      return false;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* Main  Search ******************************* */
//*********************************   Packages  ******************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future<bool> mainSearchFromTrending(BuildContext context, String url) async {
    url = url +
        '?os=${Platform.isIOS ? 'ios' : 'android'}&app_version=${packageInfo!.buildNumber}&selling_currency=$gencurrency';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse respons = await request.send();

    if (respons.statusCode == 200) {
      String data = await respons.stream.bytesToString();

      MainSarchForPackage mainSarchFor = mainSarchForPackageFromJson(data);
      Provider.of<AppData>(context, listen: false).getmainpakcages(mainSarchFor, false);

      if (mainSarchFor.data.code == 206) {
        bool isnotload = true;
        while (isnotload == true) {
          isnotload = await getpackagesfromlisting(url, context);
        }

        return true;
      }

      return true;
    } else if (respons.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      return false;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* GET REQUSTE ******************************** */
//**********************************  PACKAGES  ******************************** */
//****************************************************************************** */
//****************************************************************************** */

  // static Future<Packages> getPackages(
  //     BuildContext context, String mainPackageId) async {
  //   var headers = {
  //     'Cookie':
  //         'ibookaholidaystaging_session=dVU44bdgmZMbiLkhxocCRegsbSV0YicnLsbcyWtT'
  //   };
  //   var request = http.Request(
  //       'GET', Uri.parse(baseUrl + 'holiday/list?package_id=$mainPackageId'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse responses = await request.send();
  //   if (responses.statusCode == 200) {
  //     //
  //     String data = await responses.stream.bytesToString();
  //     Packages packages = packagesFromJson(data);
  //     Provider.of<AppData>(context, listen: false).getPackages(packages);
  //     return packages;
  //   } else {
  //
  //   }
  //   late Packages package;
  //   http.Response response = await http
  //       .get(Uri.parse(baseUrl + 'holiday/list?package_id=$mainPackageId'));
  //   if (response.statusCode == 200) {
  //     Packages packages = packagesFromJson(response.body);
  //     package = packages;
  //
  //     Provider.of<AppData>(context, listen: false).getPackages(package);
  //   } else {
  //
  //   }
  //
  //   return package;
  // }

//****************************************************************************** */
//****************************************************************************** */
//********************************* customizing ******************************** */
//******************************  PACKAGES Deep Link *************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future customizeingFormDeepLink(Uri url, BuildContext context) async {
    var request = http.Request('GET', url);
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
      Provider.of<AppData>(context, listen: false).isFromDeeplink(true);

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CustomizeSlider()));
    } else {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.invalidOrExpiredUrl);
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* customizing ******************************** */
//**********************************  PACKAGES  ******************************** */
//****************************************************************************** */
//****************************************************************************** */
  static Future<Customizpackage?> customizingPackage(BuildContext context, String packageId) async {
    Customizpackage? customizePackages;

    String url =
        baseUrl + 'holiday/customize?package_id=$packageId&currency=$gencurrency&language=$genlang';
    log(url.toString());

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };
    http.Response response = await http.get(
      Uri.parse(url),
    );
    response.headers.addAll(headers);
    //  log(response.body);
    // try {
    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(response.body);
      customizePackages = customizePackage;
      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackages);
    } else if (response.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
    } else {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      customizePackages = null;
    }
    // } catch (e) {
    // print(e.toString());
    //   }

    return customizePackages;
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* Customizing ******************************** */
//********************************** ChangeHotel  ****************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future changehotel(BuildContext context,
      {required String customizeId,
      required String checkIn,
      required String checkOut,
      required int hId,
      required String star}) async {
    Provider.of<AppData>(context, listen: false).changehotels(null);
    String url = baseUrl +
        'holiday/change_hotel?customizeId=$customizeId&checkIn=$checkIn&checkOut=$checkOut&hId=$hId&star=$star&action=changeHotel&currency=$gencurrency&language=$genlang';
    late Changehotel changehotel;
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    log(url);
    if (response.statusCode == 200) {
      // changehotelFromJson(response.body);
      // log(response.body);
      Changehotel x = changehotelFromJson(response.body);
      //if (x.status.error == false) {
      changehotel = x;
      Provider.of<AppData>(context, listen: false).changehotels(changehotel);
      //  }
    } else {}
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* Customizing ******************************** */
//********************************** HOTEL SPLIT  ****************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future newSplitHotel(BuildContext context,
      {required String id, required String checkIn, required String checkOut}) async {
    String url = baseUrl +
        'holiday/split-hotel-search?customize_id=$id&check_in=$checkIn&check_out=$checkOut&selling_currency=$gencurrency&currency=$gencurrency&language=$genlang';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Navigator.of(context);
      NewChangeHotel x = newChangeHotelFromJson(jsonString);
      //   if (x.status.error == false) {
      Provider.of<AppData>(context, listen: false).newChangehotel(x);
      //   }
      return true;
    } else {
      return false;
    }
  }

  static Future selectTheRoomAndMakeSplit(BuildContext context, data) async {
    String url = baseUrl + 'holiday/split-hotel-save';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(jsonString);

      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
    } else {}
  }

//****************************************************************************** */
//****************************************************************************** */
//********************************* Customizing ******************************** */
//********************************** ChangeFlight ****************************** */
//****************************************************************************** */
//****************************************************************************** */

  static Future changeflight(String customizeId, String flightClass, BuildContext context) async {
    Provider.of<AppData>(context, listen: false).getflights(null);
    String url =
        '${baseUrl}holiday/change_flight?holidayCustomizeId=$customizeId&flightClass=$flightClass&currency=$gencurrency&language=$genlang';
    log(url.toString());

    late Changeflight changeflight;
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    log(response.body);
    if (response.statusCode == 200) {
      Changeflight changeflight0 = changeflightFromJson(response.body);
      changeflight = changeflight0;
      Provider.of<AppData>(context, listen: false).getflights(changeflight);
      // Provider.of<AppData>(context, listen: false). getflighforfilter(changeflight);
      //
      return changeflight;
    } else {}
  }

  static Future updateThePackage(String id) async {
    String url =
        '${baseUrl}holiday/transfer_hotel_flight_change?customizeId=$id&currency=$gencurrency&language=$genlang';

    log(url.toString());
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    log("updateThePackage =>" + response.body);
  }

////////////////////////////////////////////////////////////////////////////////

  static Future updateHotelDetails(String id, BuildContext context) async {
    String url = baseUrl +
        'holiday/customize?customizeId=$id&selling_currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    log('updateHotelDetails ====>>>' + response.body);
    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(response.body);

      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);

      if (customizePackage.status.error == false) {
        Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
        //  final result = json.decode(response.body);
        //  log(response.body);
      }
    } else {}
  }

  //FOR UPDATE FLIGHT HOTEL CHECKIN
  static Future updateHotelCheckIn(String id) async {
    String url = baseUrl +
        'holiday/check_hotel_checkin?customizeId=$id&currency=$gencurrency&language=$genlang&fn=mobapi';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.body == '') {
    } else {}
  }

  static Future getActivityList(BuildContext context,
      {required int searchId,
      required String customizeId,
      required dynamic activityDay,
      required String currency}) async {
    AcivityList acivityList;
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    try {
      String url = baseUrl +
          'holiday/change_activity?searchId=$searchId&customizeId=$customizeId&activityDay=$activityDay&currency=$gencurrency&language=$genlang&priceSort=asc&nameSort=&searchQuery=';
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      AcivityList acivityList0 = acivityListFromJson(response.body);
      if (response.statusCode == 200) {
        acivityList = acivityList0;
        Provider.of<AppData>(context, listen: false).getAcivityList(acivityList);
        if (acivityList0.data.isEmpty) {}
      } else {}
    } catch (e) {
      Navigator.of(context).maybePop();
    }
  }

//Remove All ACTIVITYS
  static Future removeAllActivites(String id) async {
    String url = baseUrl +
        'holiday/remove_activities?customizeId=$id&currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
  }

  // REMOVE ONE ACTIVITY

  static Future<bool> removeOneActivity(
      BuildContext context, String customizeId, String activityId, String activityDate) async {
    String url = baseUrl +
        'holiday/remove_activity?customizeId=$customizeId&activityId=$activityId&activityDate=$activityDate&currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        await AssistantMethods.updateHotelDetails(customizeId, context);

        return true;
      } else {
        final error = json.decode(response.body);

        displayTostmessage(context, true, message: error['message']);
        return false;
      }
    } catch (e) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      return false;
    }
  }

  //CHANGE TRANSFER

  static Future<bool> changeTransfer(String id, String type, BuildContext context) async {
    String url =
        "${baseUrl}holiday/transfer-list-inout?&currency=$gencurrency&language=$genlang&customizeId=$id";

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);

    if (response.statusCode == 200) {
      ChangeTransfer changeTransfer = changeTransferFromJson(jsonString);
      //  final newChangeTransfer = newChangeTransferFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getTransferList(changeTransfer);

      if (changeTransfer.data.dataIn.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

//****************************************************************************** */
//****************************************************************************** */
//************************************* POST REQUSTE *************************** */
//****************************************************************************** */
//****************************************************************************** */

//FOR SAVING HOTEL+++++++++++++++++++++++++++++++++++++++++++
  static Future<dynamic> saveHotel(data, BuildContext context) async {
    String url = '${baseUrl}holiday/save_split';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // Customizpackage customizePackage = customizpackageFromJson(response.body);
      //
      // Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
    } else {}
  }

//FOR SAVING FLIGHTS+++++++++++++++++++++++++++++++++++++++++++

  static Future changeFlight(data) async {
    String url = baseUrl + 'holiday/update_flight?currency=$gencurrency&language=$genlang';

    log(url.toString());
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );
    log(response.body);
  }

  //FOR UPDATE ACTIVITYS
  static Future<bool> updateActivity(data) async {
    String url = baseUrl + 'holiday/update_activity?currency=$gencurrency&language=$genlang';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    http.Response response = await http.post(
      Uri.parse(url),
      body: data,
      headers: headers,
    );
    final result = jsonDecode(response.body);
    log(result.toString());
    if (response.statusCode == 200) {
      return result["data"]["missing"];
    } else {
      return result["data"]["missing"];
    }
  }

  //FOR UPDATE TRANSFER

  static Future updateTransfer(
      String id, String? inTrans, String? outTrans, BuildContext context) async {
    String url = baseUrl +
        'holiday/transfer-update-inout?currency=$gencurrency&customizeId=$id&in=$inTrans&out=$outTrans&language=$genlang';
    var request = http.Request('PUT', Uri.parse(url));

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString);

    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(jsonString);

      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
      return true;
    } else {
      return false;
    }
  }
  // NEW UPDATE TRANSFER

  static Future<bool> newUpdateTransfer(data, BuildContext context) async {
    String url = baseUrl + 'holiday/update_transfer?&language=$genlang';

    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(data);
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      updateHotelDetails(data['customize_id'], context);
      // Customizpackage customizePackage = customizpackageFromJson(jsonString);

      // Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
      return true;
    } else {
      return false;
    }
  }

  //FOR REMOVE TRANSFER

  static Future removeTransfer(data) async {
    String url = baseUrl + 'holiday/remove_transfer?currency=$gencurrency&language=$genlang';

    http.Response response = await http.post(Uri.parse(url), body: data, headers: {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    });
  }

  /// ? //////////////////  REGISTER NEW USER  ////////////////////
  /// ? //////////////////  REGISTER NEW USER  ////////////////////
  /// ? //////////////////  REGISTER NEW USER  ////////////////////

  static Future<bool> rejUser(data, BuildContext context) async {
    String url = baseUrl + 'user/mob/preregistration?currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(data);
    request.headers.addAll(headers);

    log(request.body);

    http.StreamedResponse response = await request.send();
    String jsondata = await response.stream.bytesToString();
    log(jsondata);
    if (response.statusCode == 200) {
      final user = userFromJson(jsondata);
      users = user;
      Provider.of<AppData>(context, listen: false).getUser(user);

      fullName = user.data.name + '' + user.data.lastName;
      await AssistenData.setUserdata(user.data.token);
      await AssistenData.removeUserMediaLogin();
      isLoginWithMedia = false;

      return true;
    } else if (response.statusCode == 401) {
      Navigator.of(context).pop();
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.emailTaken);
      return false;
    } else if (response.statusCode == 403) {
      final deleteAccountModel = deleteAccountModelFromMap(jsondata);
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => const Errordislog().error(
            context,
            AppLocalizations.of(context)!.loginDeactivated(
                deleteAccountModel.data.deactivatedOn,
                deleteAccountModel.data.remainingDays.toString(),
                deleteAccountModel.data.deletionDate,
                deleteAccountModel.data.supportEmail),
            title: ''),
      );
      return false;
    } else {
      Navigator.of(context).pop();

      return false;
    }
  }

  /// ? //////////////////  LOGIN USER  ////////////////////
  /// ? //////////////////  LOGIN USER  ////////////////////
  /// ? //////////////////  LOGIN USER  ////////////////////

  static Future loginUser(data, BuildContext context) async {
    String url = baseUrl + 'user/login?currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String jsonData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final userlogedin = userFromJson(jsonData);
      log(jsonData.toString());
      Provider.of<AppData>(context, listen: false).getUser(userlogedin);
      await AssistenData.setUserdata(userlogedin.data.token);
      await AssistenData.removeUserMediaLogin();
      isLoginWithMedia = false;

      return true;
    } else if (response.statusCode == 521) {
      Navigator.popAndPushNamed(context, NewLogin.idScreen);
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else if (response.statusCode == 403) {
      Navigator.popAndPushNamed(context, NewLogin.idScreen);
      final deleteAccountModel = deleteAccountModelFromMap(jsonData);

      showDialog(
        context: context,
        builder: (context) => const Errordislog().error(
            context,
            AppLocalizations.of(context)!.loginDeactivated(
                deleteAccountModel.data.deactivatedOn,
                deleteAccountModel.data.remainingDays.toString(),
                deleteAccountModel.data.deletionDate,
                deleteAccountModel.data.supportEmail),
            title: ''),
      );
      return false;
    } else {
      Navigator.popAndPushNamed(context, NewLogin.idScreen);
      showDialog(
        context: context,
        builder: (context) => const Errordislog().error(
          context,
          "You have entered an invalid username or password",
        ),
      );
      return false;
    }
  }

  static Future<bool> signinWithProviders(BuildContext context,
      {required data, required String providerName}) async {
    String url = baseUrl + 'user/social-auth/$providerName';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      final userlogedin = userFromJson(jsonString);
      isLoginWithMedia = true;
      await AssistenData.setUserLoginProvider();

      Provider.of<AppData>(context, listen: false).getUser(userlogedin);
      await AssistenData.setUserdata(userlogedin.data.token);
      return true;
    } else if (response.statusCode == 403) {
      final deleteAccountModel = deleteAccountModelFromMap(jsonString);

      await showDialog(
        context: context,
        builder: (context) => const Errordislog().error(
            context,
            AppLocalizations.of(context)!.loginDeactivated(
                deleteAccountModel.data.deactivatedOn,
                deleteAccountModel.data.remainingDays.toString(),
                deleteAccountModel.data.deletionDate,
                deleteAccountModel.data.supportEmail),
            title: ''),
      );
      return false;
    } else {
      final error = jsonDecode(jsonString);
      displayTostmessage(context, true, message: error["message"]);
      return false;
    }
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
  ////////////////////////// ? Prebooking//////////////////////////////
  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  static Future preBooking(data, String token, BuildContext context) async {
    String url = baseUrl + "holiday/prebook-mob?currency=$gencurrency&language=$genlang";

    try {
      var headers = {
        'token': token,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber,
        'Accept': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = data;
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      String json = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        //   dynamic suc = jsonDecode(json);
        //
        //   bool isSeccess = suc["success"];
        //
        // //
        //
        //   if (!isSeccess) {
        //     Navigator.of(context).pop();
        //     Provider.of<AppData>(context, listen: false).getPrebook(json, isSeccess);
        //     return false;
        //   } else {
        //     Prebook prebook = prebookFromJson(json);
        //     Provider.of<AppData>(context, listen: false).getPrebook(prebook, isSeccess);
        //     return true;
        //   }

        final prebookFalid = prebookFalidFromJson(json);
      } else if (response.statusCode == 403) {
        displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
        AssistenData.removeUserDate();
        users.data.token = '';
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(NewLogin.idScreen);
        return false;
      } else if (response.statusCode == 521) {
        await MaintenanceMode.showMaintenanceDialog(context);
        return false;
      } else {
        Navigator.of(context).pop();
        final errordata = jsonDecode(json);
        displayTostmessage(context, true, message: errordata["message"]);
        return false;
      }
    } catch (e) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    }
  }

  ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////
  // ? //////////// Login from pref//////////////////////
  ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////

  static Future getUserFromPref(String token, BuildContext context) async {
    String url = baseUrl + 'user/token-login';

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String json = await response.stream.bytesToString();

    //
    if (response.statusCode == 200) {
      return json;
    } else {
      return '';
    }
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  ///////////////// Trends And offers /////////////////
  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  static Future getTrendsAndOffers(BuildContext context, String city) async {
    String url = baseUrl +
        'global/app-home-links/$genlang/$gencurrency?city=$city&currency=$gencurrency&language=$genlang';
    var request = http.Request('GET', Uri.parse(url));

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Holidaysfotter holidaysfotter = holidaysfotterFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).offerAndTrending(holidaysfotter);
    } else {}
  }

  /// ? ////////////////// LOGOUT USER ////////////////////
  /// ? ////////////////// LOGOUT USER ////////////////////
  /// ? ////////////////// LOGOUT USER ////////////////////

  static Future logOutUser(String token) async {
    String url = baseUrl + 'user/logout';

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String json = await response.stream.bytesToString();

    if (response.statusCode == 200) {
    } else {}
  }

  /// ? //////////////////  UPDATE PACKAGE WITH CURRENCY  ////////////////////
  /// ? //////////////////  UPDATE PACKAGE WITH CURRENCY  ////////////////////
  /// ? //////////////////  UPDATE PACKAGE WITH CURRENCY  ////////////////////

  static Future updatePakagewithcurruncy(String id, BuildContext context) async {
    String url =
        '${baseUrl}holiday/list?package_id=$id&selling_currency=$gencurrency&currency=$gencurrency&language=$genlang';
    print(url);
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var jsondata = await response.stream.bytesToString();
    //
    if (response.statusCode == 200) {
      MainSarchForPackage mainSarchFor = mainSarchForPackageFromJson(jsondata);
      Provider.of<AppData>(context, listen: false).getpakagesafterchangecurrency(mainSarchFor);
    } else {
      Navigator.of(context).pop();
    }
  }

  /// ? //////////////////  GET CANCELLATION PRICE  ////////////////////
  /// ? //////////////////  GET CANCELLATION PRICE  ////////////////////
  /// ? //////////////////  GET CANCELLATION PRICE  ////////////////////

  static Future<Canceliation?> getCancelationPrice(
      {required String currency, required String custoizeId, required String packageId}) async {
    String url =
        '${baseUrl}holiday/canx-policy?packageId=$packageId&customizeId=$custoizeId&currency=$currency&language=$genlang';
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsondata = await response.stream.bytesToString();
      log(jsondata);
      final canceliation = canceliationFromJson(jsondata);
      return canceliation;
    } else {
      return null;
    }
  }

  /// ? //////////////////  UPLOAD USER IMAGE  ////////////////////
  /// ? //////////////////  UPLOAD USER IMAGE  ////////////////////
  /// ? //////////////////  UPLOAD USER IMAGE  ////////////////////

  static Future uploadUserimage(BuildContext context, data) async {
    String url = baseUrl + 'user/update-profile-pic';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({"profilePic": data});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    //final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      displayTostmessage(context, false,
          message: AppLocalizations.of(context)!.imageUpdatedSuccess);
      await AssistantMethods.getUserDetails(context);
    } else {}
  }

  /// ? //////////////////  UPDATE USER INFORMATION   ////////////////////
  /// ? //////////////////  UPDATE USER INFORMATION   ////////////////////
  /// ? //////////////////  UPDATE USER INFORMATION   ////////////////////

  static Future updateUserInformation(
    BuildContext context, {
    required String phoneCountryCode,
    required String email,
    required String firstname,
    required String lastname,
    required String postalcode,
    required String phone,
    required String country,
    //  required String address,
    required String countryCode,
    required String citycode,
  }) async {
    String url = baseUrl + 'user/update-profile-data?language=$genlang';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "phone": phone,
      "country": country,
      "phone_country_code": phoneCountryCode,
      "country_code": countryCode,
      //"address": address,
      "city_code": citycode,
      "postal_code": postalcode
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      //
      final user = userFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getUser(user);

      //await AssistantMethods.getUserDetails(context);
      displayTostmessage(context, false,
          message: AppLocalizations.of(context)!.informationUpdatedSuccess);
      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (context) => UserProfileInfomation()));
    } else {}
  }

  /// ?//////////////////  UPDATE USER BILLING INFORAMTION ////////////////////
  /// ?//////////////////  UPDATE USER BILLING INFORAMTION ////////////////////
  /// ?//////////////////  UPDATE USER BILLING INFORAMTION ////////////////////
  static Future<bool> updateBillingInformation(BuildContext context,
      {required Map<String, dynamic> data}) async {
    String url = baseUrl + 'user/update-profile-data?language=$genlang';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      displayTostmessage(context, false, message: "message");
      final user = userFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getUser(user);

      await AssistantMethods.getUserDetails(context);

      return true;
    } else {
      return false;
    }
  }

  /// ? //////////////////  REMOVE & ADD SERVICES MANAGER ////////////////////
  /// ? //////////////////  REMOVE & ADD SERVICES MANAGER ////////////////////
  /// ? //////////////////  REMOVE & ADD SERVICES MANAGER ////////////////////

  static Future sectionManager(BuildContext context,
      {required String section, required String cusID, required String action}) async {
    String url = baseUrl +
        'holiday/service/$action/$section?customizeId=$cusID&selling_currency=$gencurrency&currency=$gencurrency&language=$genlang';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsondata = await response.stream.bytesToString();
    log(jsondata);
    if (response.statusCode == 200) {
      Customizpackage customizePackage = customizpackageFromJson(jsondata);
      if (action == 'add') {
        String localSection = section;
        switch (section) {
          case "flight":
            {
              localSection = AppLocalizations.of(context)!.flight;
              break;
            }
          case "hotel":
            {
              localSection = AppLocalizations.of(context)!.yourhotel;
              break;
            }
          case "activity":
            {
              localSection = AppLocalizations.of(context)!.activity;
              break;
            }
          case "transfer":
            {
              localSection = AppLocalizations.of(context)!.transfer;
              break;
            }

          default:
            {
              localSection = section;
            }
            break;
        }

        displayTostmessage(context, false,
            message: AppLocalizations.of(context)!.sectionManagerMess(localSection, action));
      }
      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizePackage);
    } else if (response.statusCode == 400) {
      final message = jsonDecode(jsondata);
      displayTostmessage(context, true, message: message['message']);
    }
  }

  /// ? //////////////////  GET USER POSITION ////////////////////
  /// ? //////////////////  GET USER POSITION ////////////////////
  /// ? //////////////////  GET USER POSITION ////////////////////

  static Future<bool> getlocationFromApi(BuildContext context) async {
    String url = baseUrl + 'geo-data?language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsondata = await response.stream.bytesToString();
    final data = jsonDecode(jsondata);
    if (response.statusCode == 200) {
      // gencurrency = data["currency_code"];
      Provider.of<AppData>(context, listen: false).getcitiynamefromApi(data['city']);
      return true;
    } else if (response.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else if (response.statusCode == 403) {
      return false;
    } else {
      return true;
    }
  }

  /// ? //////////////////  LOAD PACKAGE FROM LISTING ////////////////////
  /// ? //////////////////  LOAD PACKAGE FROM LISTING ////////////////////
  /// ? //////////////////  LOAD PACKAGE FROM LISTING ////////////////////

  static Future<bool> getpackagesfromlisting(String url, BuildContext context) async {
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      //
      MainSarchForPackage mainSarchFor = mainSarchForPackageFromJson(data);

      Provider.of<AppData>(context, listen: false).getmainpakcages(mainSarchFor, true);

//      Provider.of<AppData>(context, listen: false).hundletheloading(true);

      return false;
    } else {
      Provider.of<AppData>(context, listen: false).hundletheloading(false);

      return true;
    }
  }

  /// ? //////////////////  SPLIT HOTEL  ////////////////////
  /// ? //////////////////  SPLIT HOTEL  ////////////////////
  /// ? //////////////////  SPLIT HOTEL  ////////////////////

  static Future splitHotel(BuildContext context,
      {required String satrt, required String end, required String customize}) async {
    String url = baseUrl +
        'holiday/split-hotel/add?customizeId=$customize&checkIn=$satrt&checkOut=$end&currency=$gencurrency&language=$genlang';
    try {
      var request = http.Request('GET', Uri.parse(url));
      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Customizpackage customizpackage = customizpackageFromJson(jsonString);

        Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizpackage);
        Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
        displayTostmessage(context, false, message: AppLocalizations.of(context)!.newHotelAdded);
      } else if (response.statusCode == 422) {
        final error = jsonDecode(jsonString);
        displayTostmessage(context, true, message: error['message']);
      } else {
        displayTostmessage(context, true,
            message: "We can't make split Hotel at the moment", isInformation: true);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// ? //////////////////  REMOVE SPLIT HOTEL  ////////////////////
  /// ? //////////////////  REMOVE SPLIT HOTEL  ////////////////////
  /// ? //////////////////  REMOVE SPLIT HOTEL  ////////////////////

  static Future removesplitHotels(
    BuildContext context, {
    required String id,
    required int hotelId,
    required int hotelIndex,
  }) async {
    try {
      String url = baseUrl +
          'holiday/split-hotel/remove?customizeId=$id&hotelId=$hotelId&hotelKey=$hotelIndex&currency=$gencurrency&language=$genlang';

      var request = http.Request('GET', Uri.parse(url));
      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String jsonString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Customizpackage customizpackage = customizpackageFromJson(jsonString);

        Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizpackage);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// ? //////////////////  NEW CHANGE ROOM  ////////////////////
  /// ? //////////////////  NEW CHANGE ROOM  ////////////////////
  /// ? //////////////////  NEW CHANGE ROOM  ////////////////////

  static Future newChangeRoom(BuildContext context, data) async {
    String url =
        baseUrl + 'holiday/split-hotel/change-room?currency=$gencurrency&language=$genlang';
    log(url);
    try {
      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(data);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      log(jsonString);
      if (response.statusCode == 200) {
        Customizpackage customizpackage = customizpackageFromJson(jsonString);

        Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizpackage);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// ? //////////////////  NEW CHANGE HOTEL  ////////////////////
  /// ? //////////////////  NEW CHANGE HOTEL  ////////////////////
  /// ? //////////////////  NEW CHANGE HOTEL  ////////////////////

  static Future newchangehotel(BuildContext context, data) async {
    String url =
        baseUrl + 'holiday/split-hotel/change-hotel?currency=$gencurrency&language=$genlang';
    try {
      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode(data);

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      log(jsonString);
      if (response.statusCode == 200) {
        Customizpackage customizpackage = customizpackageFromJson(jsonString);

        Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizpackage);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //? ////////////////////////////////////////////////
  //? ////////////////////////////////////////////////
  //! ///////////      TRANSFER      /////////////////
  //? ////////////////////////////////////////////////
  //? ////////////////////////////////////////////////

  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////
  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////
  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////

  static Future searchDistnationsForTransfer(
      BuildContext context, String q, String id, String mode) async {
    String url = baseUrl +
        'holiday/transfer-destinations?customizeId=$id&search_key=$q&mode=$mode&currency=$gencurrency&language=$genlang';
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final searchTransferIfRemoveForH = searchTransferIfRemoveForHFromJson(jsonString);

      Provider.of<AppData>(context, listen: false)
          .getDistnationForTransfer(searchTransferIfRemoveForH);
    } else {}
  }

  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////
  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////
  /// ? //////////////////  SEARCH FOR DISTNATIONS  ////////////////////

  static Future searchDistnationsForTransferAir(BuildContext context, String q, String id) async {
    String url = baseUrl +
        'holiday/transfer-destinations?customizeId=$id&search_key=$q&mode=airports&currency=$gencurrency&language=$genlang';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final searchTransferIfRemoveForH = searchTransferIfRemoveForHFromJson(jsonString);

      Provider.of<AppData>(context, listen: false)
          .getDistnationForTransferAir(searchTransferIfRemoveForH);
    } else {}
  }

  // ? ////////////////// ADD THE TRANSFER ///////////////////
  // ? ////////////////// ADD THE TRANSFER ///////////////////
  // ? ////////////////// ADD THE TRANSFER ///////////////////

  static Future addtransferListing(BuildContext context, {required data}) async {
    String url = baseUrl + 'holiday/transfer-change-search?currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final transferListing = transferListingFromJson(jsonString);

      Provider.of<AppData>(context, listen: false).gettransferlisting(transferListing);
      //  displayTostmessage(context, false, messeage: "Transfer has been Add");
    } else {
      //  displayTostmessage(context, true, messeage: 'We can,t add transfer to this package');
      if (response.statusCode == 400) {
        displayTostmessage(context, true,
            message: AppLocalizations.of(context)!.noTransferFoundToTheLocation,
            isInformation: true);
      }
    }
    //Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
  }

//? ////////////// ADD THE TRANSFER /////////////////

  static Future addrTransferIfNoForH(BuildContext context, data) async {
    String url = baseUrl + 'holiday/transfer-change-save?currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      final customizpackage = customizpackageFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getPackageIdforcustomiz(customizpackage);
      Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
    } else if (response.statusCode == 422) {
      displayTostmessage(context, true,
          message: AppLocalizations.of(context)!.pleaseSelectOtherOne);
    } else {}
  }

//? ////////////////////////////////////////////////
//? ////////////////////////////////////////////////
//? ////////////////////////////////////////////////
//! ///////////      PROFILE       /////////////////
//? ////////////////////////////////////////////////
//? ////////////////////////////////////////////////
//? ////////////////////////////////////////////////

  static Future changeCurranceylanguage(BuildContext context, data, String action) async {
    String url = baseUrl + 'user/update-language-and-currency';

    //   try {
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json',
      'Authorization': 'Bearer ${users.data.token}',
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // String jsonString = await response.stream.bytesToString();
    //final res = jsonDecode(jsonString);
    final jsonData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      users.data.currency = data[action];

      await AssistenData.setUserdata(users.data.token);
      switch (action) {
        case "language":
          {
            action = AppLocalizations.of(context)!.language;
            displayTostmessage(context, false,
                message: AppLocalizations.of(context)!.lungHasBeenChanged);

            break;
          }
        case "currency":
          {
            action = AppLocalizations.of(context)!.currency;
            displayTostmessage(context, false,
                message: AppLocalizations.of(context)!.currHasBeenChanged);

            break;
          }
      }
    } else {}
    // } catch (e) {
    // // displayTostmessage(context, true, messeage: 'please try again later');
    // }
  }

  /// ? /////////////////////////////////////////////////////
  /// ? /////////////////////////////////////////////////////
  /// ? ////////////////// ResetPassword ////////////////////
  /// ? /////////////////////////////////////////////////////
  /// ? /////////////////////////////////////////////////////

  static Future<Restpassword?> resetPassword(data, BuildContext context) async {
    String url = baseUrl + 'user/password/reset';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Authorization': 'Bearer ${users.data.token}',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String jsondata = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Restpassword restpassword = resetPassfromjson(jsondata);
      displayTostmessage(context, false, message: AppLocalizations.of(context)!.haveMailed);
      return restpassword;
    } else if (response.statusCode == 500) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      return null;
    } else {
      final error = jsonDecode(jsondata);
      displayTostmessage(context, true, message: error["message"]);

      return null;
    }
  }

  /// ? ////////////////// Change Password ////////////////////
  /// ? ////////////////// Change Password ////////////////////
  /// ? ////////////////// Change Password ////////////////////
  /// ? ////////////////// Change Password ////////////////////

  static Future changethepassword(
      String password, String old, String conf, BuildContext context) async {
    String url = baseUrl + 'user/change-password';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('PUT', Uri.parse(url));
    request.body = json.encode({
      "token": users.data.token,
      "oldPassword": old,
      "newPassword": password,
      "confirmPassword": conf
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      displayTostmessage(context, false, message: AppLocalizations.of(context)!.passwordChangedSuc);
      Navigator.of(context).pop();
    } else if (response.statusCode == 406) {
      displayTostmessage(context, true,
          message: AppLocalizations.of(context)!.passwordShouldBeDifferent);
    } else if (response.statusCode == 401) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.incorrectPassword);
    } else if (response.statusCode == 400) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    }
  }

  // ? ////////////////// GET USER DETAILS ////////////////////
  // ? ////////////////// GET USER DETAILS ////////////////////
  // ? ////////////////// GET USER DETAILS ////////////////////
  // ? ////////////////// GET USER DETAILS ////////////////////

  static Future getUserDetails(BuildContext context) async {
    String url = baseUrl + 'user/get-profile-data?currency=$gencurrency&language=$genlang';

    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonData = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final userlogedin = userFromJson(jsonData);
      Provider.of<AppData>(context, listen: false).getUser(userlogedin);
      await AssistenData.setUserdata(userlogedin.data.token);
    } else {}
  }

  // ? //////////////////  GET USER BOOKINGS  ////////////////////
  // ? //////////////////  GET USER BOOKINGS  ////////////////////
  // ? //////////////////  GET USER BOOKINGS  ////////////////////
  // ? //////////////////  GET USER BOOKINGS  ////////////////////

  static Future<List<BookingListData>> getuserBookingList(BuildContext context) async {
    String url = baseUrl + 'user/bookings/all?currency=$gencurrency&language=$genlang';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json',
      'Authorization': 'Bearer ${users.data.token}',
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);

    if (response.statusCode == 200) {
      final userBookingsData = userBookingsDataFromJson(jsonString);

      return userBookingsData.data!;
    } else if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return [];
    } else {
      return [];
    }
  }

  // ? //////////////////  GET Currency ////////////////////
  // ? //////////////////  GET Currency ////////////////////
  // ? //////////////////  GET Currency ////////////////////
  // ? //////////////////  GET Currency ////////////////////

  static Future<Currencies?> getCurrency(BuildContext context) async {
    String url = baseUrl + 'global/currencies?currency=$gencurrency&language=$genlang';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final currencies = currenciesFromJson(jsonString);
      Provider.of<AppData>(context, listen: false).getcurrencylist(currencies);
      return currencies;
    } else {
      return null;
    }
  }

  // ? //////////////////  Edit User Passenger ////////////////////
  // ? //////////////////  Edit User Passenger ////////////////////
  // ? //////////////////  Edit User Passenger ////////////////////
  // ? //////////////////  Edit User Passenger ////////////////////

  static Future editUserpassenger(data, BuildContext context,
      {bool isFromForm = false, required String searchType}) async {
    String url = baseUrl +
        'user/update-passenger-details?currency=$gencurrency&language=$genlang&search_type=$searchType';

    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      await getUserDetails(context);
      if (!isFromForm) {
        Navigator.of(context).pop();
        displayTostmessage(context, false,
            message: AppLocalizations.of(context)!.passengerHasBeenUpdatedSuccessfully);
      } else {
        Navigator.of(context).pop();
      }
    } else if (response.statusCode == 500) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    } else if (response.statusCode == 401) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
      AssistenData.removeUserDate();
      isFromBooking = true;
      users.data.token = '';
      fullName = '';
      isFromBooking = true;
      Navigator.of(context).pop();

      Navigator.of(context).pushNamed(NewLogin.idScreen);
    } else {
      try {
        final errordata = jsonDecode(jsonString);

        displayTostmessage(context, true, message: errordata["message"]);
        Navigator.of(context).pop();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
        Navigator.of(context).pop();
      }
    }
  }

  // ? //////////////////  Remove User Passenger ////////////////////
  // ? //////////////////  Remove User Passenger ////////////////////
  // ? //////////////////  Remove User Passenger ////////////////////
  // ? //////////////////  Remove User Passenger ////////////////////

  static Future removePassenger(id, BuildContext context) async {
    String url = baseUrl + 'user/delete-passenger/$id?language=$genlang';

    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('DELETE', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final errordata = jsonDecode(jsonString);
      await getUserDetails(context);

      displayTostmessage(context, false, message: AppLocalizations.of(context)!.passDeleted);
    } else if (response.statusCode == 500) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    } else {
      final errordata = jsonDecode(jsonString);

      displayTostmessage(context, true, message: errordata["message"]);
    }
  }

  // ? ///////////////////////////////////////////////////////////
  // ? ///////////////////////////////////////////////////////////
  // ? //////////////////  GetCancellation Reasones //////////////
  // ? ///////////////////////////////////////////////////////////
  // ? ///////////////////////////////////////////////////////////

  static Future<CancellationReasons?> getCancellationReasons() async {
    String url =
        baseUrl + 'holiday/booking/cancellation/reasons?currency=$gencurrency&language=$genlang';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final cancellationReasons = cancellationReasonsFromJson(jsonString);

      return cancellationReasons;
    } else {
      return null;
    }
  }

  // ? //////////////////////////////////////////////////////////////
  // ? //////////////////////////////////////////////////////////////
  // ? //////////////////  GET CANCELLATION PLIICY //////////////////
  // ? //////////////////////////////////////////////////////////////
  // ? //////////////////////////////////////////////////////////////

  static Future<CancellationPolicy?> getCancelltionPolicy(id, BuildContext context) async {
    String url =
        '${baseUrl}holiday/booking/cancellation/policy?reference=$id&currency=$gencurrency&language=$genlang';

    log(users.data.token);
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'accept': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      final cancellationPolicy = cancellationPolicyFromMap(jsonString);
      return cancellationPolicy;
    } else if (response.statusCode == 401) {
      final error = jsonDecode(jsonString);

      displayTostmessage(context, true, message: error["message"]);

      return null;
    } else if (response.statusCode == 422) {
      final error = jsonDecode(jsonString);
      displayTostmessage(context, true, message: error["message"]);

      return null;
    } else {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);

      return null;
    }
  }

  // ? ////////////////// CANCEL Booking Action ////////////////////
  // ? ////////////////// CANCEL Booking Action ////////////////////
  // ? ////////////////// CANCEL Booking Action ////////////////////
  // ? ////////////////// CANCEL Booking Action ////////////////////

  static Future<CancelBookingModel?> cancelBooking(data, BuildContext context) async {
    try {
      String url = '${baseUrl}holiday/cancel?currency=$gencurrency&language=$genlang';

      var headers = {
        'Authorization': 'Bearer ${users.data.token}',
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber,
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = data;
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      log(jsonString);
      if (response.statusCode == 500) {
        return null;
      } else {
        final cancelBookingModel = cancelBookingModelFromMap(jsonString);
        return cancelBookingModel;
      }
    } catch (e) {
      displayTostmessage(context, true, message: 'under developing');
      return null;
    }
  }

  // ? ////////////////// Use Coupon  ////////////////////
  // ? ////////////////// Use Coupon  ////////////////////
  // ? ////////////////// Use Coupon  ////////////////////
  // ? ////////////////// Use Coupon  ////////////////////

  static Future useCoupon(BuildContext context, String coupon, String id) async {
    try {
      String url =
          '${baseUrl.replaceFirst('v1', 'v2')}coupon/apply?currency=$gencurrency&language=$genlang';

      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber,
        'Authorization': 'Bearer ${users.data.token}'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({"coupon_code": coupon, "customize_id": id});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final coupon = couponFromMap(jsonString);
        Provider.of<AppData>(context, listen: false).getCouponResultData(coupon);
        displayTostmessage(context, false,
            message: AppLocalizations.of(context)!.couponHasBeenApplied);

        return true;
      } else {
        final error = jsonDecode(jsonString);

        displayTostmessage(context, true, message: error["message"]);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  // ? ////////////////// Remove Coupon  ////////////////////
  // ? ////////////////// Remove Coupon  ////////////////////

  static Future removeTheCoupon(BuildContext context, String customizeID) async {
    String url = baseUrl.replaceFirst('v1', 'v2') + 'coupon/remove/$customizeID';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Authorization': 'Bearer ${users.data.token}'
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final coupon = couponFromMap(jsonString);
      Provider.of<AppData>(context, listen: false).getCouponResultData(coupon);
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  static Future addPassengerToTheList(BuildContext context, Forms passenger, num? id) async {
    String url =
        'https://mapi2.ibookholiday.com/api/holidays/save-passenger?currency=$gencurrency&language=$genlang';
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({
      "passengers": [
        {
          "id": id,
          "person_type": passenger.type,
          "selected_title": passenger.type,
          "name": passenger.firstName,
          "surname": passenger.surname,
          "birthdate": passenger.dateofbirth,
          "nationatily": passenger.nationality,
          "passport_number": passenger.passportnumber,
          "passport_expirity_date": passenger.passportexpirydate,
          "passport_country_issued": passenger.passportissuedcountry
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    //
    if (response.statusCode == 200) {
      final user = userFromJson(jsonString);

      Provider.of<AppData>(context, listen: false).getUser(user);
    } else {}
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  /////////////////////////    PREBOOK     ////////////////////
  /////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  static Future<bool?> newPreBook(data, String token, BuildContext context) async {
    String url =
        "${baseUrl.replaceFirst('v1', 'v2')}holiday/prebook?currency=$gencurrency&language=$genlang";
    //String url = baseUrl + "holiday/prebook-mob?currency=$gencurrency&language=$genlang";
    // "?hotelDebug=yes&flightDebug=yes&transferDebug=no&activityDebug=yes";
    log(data);
    // try {
    var headers = {
      'token': token,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };

    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    // log('=> '+request.body);

    String json = await response.stream.bytesToString();
    log(json);
    context.read<AppData>().clearAllPassengerInformation();
    if (response.statusCode == 200) {
      final prebookFalid = prebookFalidFromJson(json);
      Provider.of<AppData>(context, listen: false).getPreBookData(prebookFalid);
      Provider.of<AppData>(context, listen: false).changePrebookFaildStatus(false);
      return true;
    } else if (response.statusCode == 424) {
      final prebookFalid = prebookFalidFromJson(json);
      Provider.of<AppData>(context, listen: false).getPreBookData(prebookFalid);

      return false;
    } else if (response.statusCode == 403) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
      AssistenData.removeUserDate();
      users.data.token = '';
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(NewLogin.idScreen);
      return null;
    } else if (response.statusCode == 521) {
      await MaintenanceMode.showMaintenanceDialog(context);
      return false;
    } else if (response.statusCode == 409) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => context.read<AppData>().searchMode.isEmpty
              ? const PackagesScreen()
              : const IndividualPackagesScreen()));

      return false;
    }
    if (response.statusCode == 400) {
      final error = jsonDecode(json);
      displayTostmessage(context, true, message: error['message']);

      // Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
      return false;
    } else if (response.statusCode == 401) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
      AssistenData.removeUserDate();
      fullName = '';
      isFromBooking = true;
      users.data.token = '';

      await Navigator.of(context).pushNamed(NewLogin.idScreen);
      return false;
    } else {
      final errordata = jsonDecode(json);
      displayTostmessage(context, true, message: errordata["message"]);

      return false;
    }
    //} catch (e) {
    //  print(e);
    // displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
    // return false;
    //}
  }

  static Future<bool?> newFuckingBook(data, String token, BuildContext context) async {
    String url = baseUrl.replaceFirst('v1', 'v2') +
        "holiday/prebook?currency=$gencurrency&language=$genlang?debug=yes";
    // "?hotelDebug=yes&flightDebug=yes&transferDebug=no&activityDebug=yes";

    try {
      var headers = {
        'token': token,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber,
        'Accept': 'application/json'
      };

      var request = http.Request('POST', Uri.parse(url));
      request.body = data;
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      // log('=> '+request.body);

      String json = await response.stream.bytesToString();
      context.read<AppData>().clearAllPassengerInformation();
      if (response.statusCode == 200) {
        final prebookFalid = prebookFalidFromJson(json);
        Provider.of<AppData>(context, listen: false).getPreBookData(prebookFalid);
        Provider.of<AppData>(context, listen: false).changePrebookFaildStatus(false);
        return true;
      } else if (response.statusCode == 424) {
        final prebookFalid = prebookFalidFromJson(json);
        Provider.of<AppData>(context, listen: false).getPreBookData(prebookFalid);

        return false;
      } else if (response.statusCode == 403) {
        displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
        AssistenData.removeUserDate();
        users.data.token = '';
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(NewLogin.idScreen);
        return null;
      } else if (response.statusCode == 521) {
        await MaintenanceMode.showMaintenanceDialog(context);
        return false;
      }
      if (response.statusCode == 400) {
        final error = jsonDecode(json);
        displayTostmessage(context, true, message: error['message']);

        // Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
        return false;
      } else if (response.statusCode == 401) {
        displayTostmessage(context, true, message: AppLocalizations.of(context)!.pleaseLogin);
        AssistenData.removeUserDate();
        fullName = '';
        isFromBooking = true;
        users.data.token = '';

        await Navigator.of(context).pushNamed(NewLogin.idScreen);
        return false;
      } else {
        final errordata = jsonDecode(json);
        displayTostmessage(context, true, message: errordata["message"]);

        return false;
      }
    } catch (e) {
      displayTostmessage(context, true, message: AppLocalizations.of(context)!.tryAgainLater);
      return false;
    }
  }

  static Future<String> getCountryFormDoc(String code) async {
    String url = baseUrl + 'country/$code?currency=$gencurrency&language=$genlang';
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        final jsondata = jsonDecode(jsonString);
        return jsondata['data']['code'].toString();
      } else {
        return code;
      }
    } catch (e) {
      return code;
    }
  }

  static Future<String> sharePackageDeepLink(String cusID, String level) async {
    String url = '${baseUrl}share?$level=$cusID&currency=$gencurrency&language=$genlang';
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = jsonDecode(jsonString);
      return data['data']['shortLink'];
    } else {
      return '';
    }
  }

  static Future<bool> deleteAcount() async {
    String url = baseUrl + 'user/delete/account';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 202) {
      AssistenData.removeUserDate();
      AssistenData.removeUserMediaLogin();
      fullName = '';
      isLoggin = false;
      return true;
    } else {
      return false;
    }
  }

  //.........................................................//

  ///////////////////////////////////////////////////////////
  //////////////////////  Privet Jet ////////////////////////
  ///////////////////////////////////////////////////////////

  //.........................................................//

  static Future<bool> getPrivetJetCategories(BuildContext context) async {
    String url = baseUrl + 'enquiry/private-jet/categories';

    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final data = privetJetCategoryModelFromMap(jsonString);
      context.read<AppData>().setPrivetJetCategory(data);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> sendPrivetJet(BuildContext context, data) async {
    String url = baseUrl + 'enquiry/private-jet/submit';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.body = data;
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    final res = jsonDecode(jsonString);
    context.read<AppData>().getPrivetJetResponse = res;
    if (response.statusCode == 200) {
      displayTostmessage(context, false, message: res['message']);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> sendTravelInsurance(String req) async {
    String url = baseUrl + 'enquiry/travel-insurance/submit';
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
      'Accept': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = req;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  ////////////////////////////////////////////////////////////////////////
  ////////////////////// SEARCH IND TRANSFER  ////////////////////////////
  ////////////////////////////////////////////////////////////////////////

  static Future<IndTransferSearchModel?> getIndTransferSearch(
      String query, String id, String airportCode, String city) async {
    try {
      final baseUrlV2 = baseUrl.replaceFirst('v1', 'v2');
      String url =
          '${baseUrlV2}transfer/location?search=$query&country_code=$id&airport_code=$airportCode&&city=$city';

      var request = http.Request('GET', Uri.parse(url));

      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final jsonString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final indTransferSearchModel = indTransferSearchModelFromMap(jsonString);

        return indTransferSearchModel;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> makeTransferSearch(BuildContext context, String data) async {
    String url = '${baseUrl.replaceFirst('v1', 'v2')}transfer/search';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber,
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);
    log(request.body);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      final indvPackagesModel = indvPackagesModelFromMap(jsonString);
      context.read<AppData>().setIndvPackages(indvPackagesModel);
      return true;
    } else {
      return false;
    }
  }

  static Future<IndTransferCustomizeModel?> indTransferCustomize(String id) async {
    String url = baseUrl + 'holiday/customize?package_id=$id';

    var request = http.Request('GET', Uri.parse(url));

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    log(jsonString);
    if (response.statusCode == 200) {
      final indTransferCustomizeModel = indTransferCustomizeModelFromMap(jsonString);
      return indTransferCustomizeModel;
    } else {
      return null;
    }
  }

  static Future<bool> checkVersion(String os, String buildNo) async {
    String url = '${baseUrl}check-version/$os?app_version=$buildNo';

    var request = http.Request('GET', Uri.parse(url));

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> getActivityQuestions(BuildContext context, String id) async {
    context.read<AppData>().hasQuestions = false;

    String url = '${baseUrl}sort-activity-questions/$id';

    try {
      var request = http.Request('GET', Uri.parse(url));
      var headers = {
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final jsonString = await response.stream.bytesToString();
      log(jsonString);
      if (response.statusCode == 200) {
        final activityQuestions = activityQuestionsFromMap(jsonString);
        context.read<AppData>().getActivityQuestions = activityQuestions;
        return true;
      } else if (response.statusCode == 207) {
        final activityQuestions = activityQuestionsFromMap(jsonString);
        context.read<AppData>().getActivityQuestions = activityQuestions;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<PaymentFailedModel?> getPaymentFailedReason(String url) async {
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 500) {
      return null;
    } else {
      final paymentFailedModel = paymentFailedModelFromMap(jsonString);
      return paymentFailedModel;
    }
  }

  static Future<BookingFailedModel?> getBookingFailedReason(String url) async {
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return null;
    } else {
      final bookingFailedModel = bookingFailedModelFromMap(jsonString);
      return bookingFailedModel;
    }
  }

  ////////////////////////////////////////////////////////////////////////
  //////////////////////    PROMO CODE POPUP  ////////////////////////////
  ////////////////////////////////////////////////////////////////////////

  static Future<PromoPopup?> getPromoPopupData() async {
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    String url = '${baseUrl}popup-promotions/mobile';
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final promoPopup = promoPopupFromMap(jsonString);
      return promoPopup;
    } else {
      return null;
    }
  }

  static Future getPromotionList(BuildContext context) async {
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    String url = '${baseUrl}mobile/promotions/list';

    var request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final promoList = promoListFromMap(jsonString);
      context.read<AppData>().promotionList = promoList;
    } else {
      context.read<AppData>().promotionList = null;
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  static Future<String?> refreshPayUrl(BuildContext context, data) async {
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    String url = '${baseUrl}holiday/update-payment-method';

    var request = http.Request('POST', Uri.parse(url));
    request.body = data;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final refreshPayUrLModel = refreshPayUrLModelFromMap(jsonString);
      return refreshPayUrLModel.data.paymentUrl;
    } else {
      displayTostmessage(context, false,
          isInformation: true, message: "we can't change payment method at this time");
      return null;
    }
  }

  static Future<String> getCoinPaymentResult(String url) async {
    var request = http.Request('GET', Uri.parse(url));
    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();

    final res = jsonDecode(jsonString);
    return res['message'];
  }

  static Future<RoomCancellationPolicy?> getCancellationPolicyForRoom(BuildContext context,
      {required String cusID, required String currency, required String rateKey}) async {
    String url = '${baseUrl}holiday/hotel-canx-policy';

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode({"customizeId": cusID, "currency": currency, "rateKey": rateKey});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString);

    if (response.statusCode == 200) {
      final roomCancellationPolicy = roomCancellationPolicyFromMap(jsonString);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).maybePop();
                              },
                              child: Icon(Icons.cancel, color: primaryblue))),
                      Text(
                        'Cancellation Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16, color: primaryblue),
                      ),
                      const SizedBox(height: 10),
                      for (int k = 0; k < roomCancellationPolicy.data.length; k++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              roomCancellationPolicy.data[k].amount.toString() == '0'
                                  ? 'Free cancellation'
                                  : 'From ${roomCancellationPolicy.data[k].fromDate} the cancellation charges will be ${roomCancellationPolicy.data[k].amount.toString()} ${roomCancellationPolicy.data[k].currency}',
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            const Divider(),
                          ],
                        )
                    ],
                  ),
                ),
              ));
      return roomCancellationPolicy;
    } else {
      return null;
    }
  }

  static Stream<http.Response> coinPaymentStreaming(String chargeID) async* {
    bool done = false;

    String url = baseUrl + "coinbase/stream/$chargeID/created";
    Stream<http.Response> request;

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    int i = 1;
    while (true) {
      request = http.get(Uri.parse(url), headers: headers).asStream();

      request.listen((event) {
        final res = jsonDecode(event.body);
        if (res['data']['type'] != 'confirmed') {
          url = res['data']['next_url'];

          done = false;
        } else {
          done = true;
        }
      }, onDone: () {});

      yield* request;
    }
  }

  static Future tryThis(BuildContext context, String streamApi) async {
    bool done = false;

    String url = streamApi;

    var headers = {
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    while (!done) {
      var request = await http.get(Uri.parse(url), headers: headers);
      final res = jsonDecode(request.body);
      if (res['data']['type'] == 'confirmed' || res['data']['type'] == 'failed') {
        done = true;

        context.read<AppData>().getCoinPaymentStatus = res;
      } else {
        context.read<AppData>().getCoinPaymentStatus = res;

        if (res["data"].containsKey('next_url')) {
          url = res['data']['next_url'];
        }

        done = false;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  static Future<CheckOutModel?> updatePaymentMethods(
      BuildContext context, PaymentMethod method, String customizeID) async {
    final url = baseUrl.replaceFirst('v1', 'v2') + 'holiday/prebook/update-payment';

    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    String paymentMethod;

    switch (method) {
      case PaymentMethod.card:
        paymentMethod = 'hyperpay';
        break;
      case PaymentMethod.coin:
        paymentMethod = 'hyperpay';
        break;
      case PaymentMethod.creditAmount:
        paymentMethod = 'credit-balance';
        break;
      case PaymentMethod.mada:
        paymentMethod = 'hyperpay';
        break;
      case PaymentMethod.applePay:
        paymentMethod = 'hyperpay';
        break;
    }

    Map<String, dynamic> data = {
      "customizeId": customizeID,
      "paymentMethod": paymentMethod,
      "NewPaymentMethod": "hyperpay"
    };

    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(data);
    request.headers.addAll(headers);

    pressIndcatorDialog(context);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();

    log(jsonString.toString());
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      final coupon = couponFromMap(jsonString);
      Provider.of<AppData>(context, listen: false).getCouponResultData(coupon);
      return coupon;
    } else {
      return null;
    }
  }

  static Future applyCredit(BuildContext context, String id, bool addCredit, amount) async {
    String url = '${baseUrl.replaceFirst('v1', 'v2')}credit-balance/change';
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    final data = {"customizeId": id, "applyCredit": addCredit, "creditQuantity": amount};
    if (!addCredit) {
      data.remove('creditQuantity');
    }

    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final coupon = couponFromMap(jsonString);
      Provider.of<AppData>(context, listen: false).getCouponResultData(coupon);
      return true;
    } else {
      return false;
    }
  }

  static Stream<http.Response> paymentStatListener(String url) async* {
    yield* http.get(Uri.parse(url)).asStream();
  }

  static Stream<http.Response> getRandomNumberFact(String url) async* {
    yield* Stream.periodic(const Duration(seconds: 2), (_) {
      return http.get(Uri.parse(url));
    }).asyncMap((event) async => await event);
  }

  static Future<String> fetchCheckOutId(
      {required String amount,
      required Map<String, String> data,
      required String merchantTransactionId,
      required String testMode}) async {
    const url = "$paymentUrl/checkouts";
    // const url = "https://oppwa.com/v1/checkouts";

    var headers = {
      'Authorization': 'Bearer $paymentToken',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    };

    var request = http.Request('POST', Uri.parse(url));
    Map<String, String> fields = {
      'entityId': entityId[paymentBrand] ?? "",
      'amount': amount,
      'currency': 'SAR',
      'paymentType': 'DB',
      'merchantTransactionId': merchantTransactionId,
      'testMode': 'EXTERNAL'
    };
    fields.addAll(data);
    request.bodyFields = fields;

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(jsonString)["id"];
    } else {
      return '';
    }
  }

  static Future<Map<String, dynamic>> checkPaymentStatus(String checkOutID) async {
    final url = "$paymentUrl/checkouts/$checkOutID/payment?entityId=${entityId[paymentBrand]}";

    //   "https://oppwa.com/v1/checkouts/{id}/payment/$checkOutID/payment?entityId=${entityId[paymentBrand]}";
    var headers = {
      'Authorization': 'Bearer $paymentToken',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'entityId': entityId[paymentBrand] ?? ''
    };

    var request = http.Request('GET', Uri.parse(url));
    request.bodyFields = {'entityId': entityId[paymentBrand] ?? '', 'testMode': 'EXTERNAL'};

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(jsonString);

      final String status = jsonData["result"]["description"] ?? '';
      final statusCode = jsonData["result"]["code"];
      final result = {
        'id': jsonData['id'],
        "status": status,
        "data": jsonData,
        "code": statusCode.toString()
      };

      return result;
    } else {
      final jsonData = jsonDecode(jsonString);

      final String status = jsonData["result"]["description"] ?? '';
      final statusCode = jsonData["result"]["code"];
      final result = {
        'id': jsonData['id'],
        "status": status,
        "data": jsonData,
        "code": statusCode.toString()
      };
      return result;
    }
  }

  static Future storeTransaction(data) async {
    final url = "${baseUrl.replaceAll('v1', 'v2')}hyperpay/transaction/hyperpay-booking";

    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };

    var request = http.Request('POST', Uri.parse(url));
    request.body = jsonEncode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
  }

  static Future<String> reversePayment(String paymentId, {required testMode}) async {
    final url = "$paymentUrl/payments/$paymentId";
    //"https://oppwa.com/v1/payments/$paymentId";

    var headers = {
      'Authorization': 'Bearer $paymentToken',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'entityId': entityId[paymentBrand] ?? ''
    };

    var request = http.Request('POST', Uri.parse(url));
    request.bodyFields = {
      "entityId": entityId[paymentBrand] ?? "",
      "paymentType": "RV",
      'testMode': testMode
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(jsonString);
      final String status = jsonData["id"] ?? '';
      return status;
    } else {
      return '';
    }
  }

  static Future proceedBooking({required String cusID}) async {
    final url =
        "${baseUrl.replaceAll("/v1/", '')}/holidays/package_booking?customizeId=$cusID&sellingCurrency=$gencurrency&bookingType=credit";
    log(users.data.token);
    var headers = {
      'Authorization': 'Bearer ${users.data.token}',
      'Content-Type': 'application/json',
      'mobile-os': Platform.isIOS ? 'ios' : 'android',
      'app_version': packageInfo!.buildNumber
    };
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final jsonString = await response.stream.bytesToString();
    log(jsonString.toString());
    if (jsonString is String) {
    } else {
      final error = jsonDecode(jsonString);
      return (error['message'] ?? 'Booking failed');
    }
  }

  static Future<Map<String, dynamic>> proceedBookingV2(String url) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${users.data.token}',
        'Content-Type': 'application/json',
        'mobile-os': Platform.isIOS ? 'ios' : 'android',
        'app_version': packageInfo!.buildNumber
      };
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      final jsonString = await response.stream.bytesToString();
      log(jsonString.toString());
      if (response.statusCode == 200) {
        final data = jsonDecode(jsonString);

        return data;
      } else {
        final error = jsonDecode(jsonString);
        return error;
      }
    } catch (e) {
      return {
        "message": "Booking Failed",
        "data": {
          "desc":
              "Sorry, your booking attempt has failed. Please send us an email support@ibookholiday.com or call us on +971 58 558 8845"
        }
      };
    }
  }
}
