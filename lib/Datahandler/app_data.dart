// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:lamar_travel_packages/Model/activity_questions.dart';
import 'package:lamar_travel_packages/Model/change_transfer_distnation_if_remove_model.dart';
import 'package:lamar_travel_packages/Model/coupon_code.dart';
import 'package:lamar_travel_packages/Model/currencies.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/ind_transfer_search_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/privet_jet_category_model.dart';
import 'package:lamar_travel_packages/Model/individual_services_model/travel_insurance_pax_details_data.dart';
import 'package:lamar_travel_packages/Model/newchangehotel.dart';
import 'package:lamar_travel_packages/Model/prebookfaild.dart';
import 'package:lamar_travel_packages/Model/promo_list.dart';
import 'package:lamar_travel_packages/Model/promp_popup.dart';
import 'package:lamar_travel_packages/Model/transfer_listing_model.dart';
import 'package:lamar_travel_packages/l10n/l10n.dart';
import 'package:lamar_travel_packages/screen/booking/newPreBooking/prebook_failed_todolist.dart';

import 'package:lamar_travel_packages/screen/customize/filtter_screen.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Assistants/assistant_methods.dart';
import '../Assistants/assistant_data.dart';
import '../Model/activity_list.dart';
import '../Model/change_transfer.dart';
import '../Model/changeflight.dart';
import '../Model/changehotel.dart';
import '../Model/changehotel.dart' as rom;
import '../Model/countries.dart';
import '../Model/customizpackage.dart' as cus;
import '../Model/footer_model.dart';

import '../Model/individual_services_model/indv_packages_listing_model.dart';
import '../Model/login/user.dart';

import '../Model/mainsearch.dart';

import '../Model/payload.dart';
import '../Model/searchforflight.dart';
import '../Model/searchforhotel.dart';
import '../screen/booking/InfomationModel.dart';
import '../screen/booking/prebooking_faild_model.dart';
import '../screen/booking/prebooking_model.dart';

import '../config.dart';

class AppData extends ChangeNotifier {
  String firstcity = '';
  String seccity = '';
  String firstday = '';
  String lastday = '';
  String flightclass = '';
  String roomcunt = '';
  String childs = '';
  String adultcounts = '';
  String searchMode = '';

  void cheakResarh(
      {required String fday,
      required String secday,
      required String fcity,
      required String secCity,
      required String room,
      required String child,
      required String adult,
      required String fclass}) {
    firstcity = fcity;
    seccity = secCity;
    firstday = fday;
    lastday = secday;
    flightclass = fclass;
    roomcunt = room;
    childs = child;
    adultcounts = adult;
    notifyListeners();
  }

  List<Country> countrys = [];

  void getcountrydatapro(List<Country> country) {
    countrys = country;
    notifyListeners();
  }

  List<PayloadElement> cities = [];

  void gitcities(List<PayloadElement> citity) {
    cities = citity;
    notifyListeners();
  }

  List<PayloadElement> distnationfortransfer = [];

  void transferdistnation(List<PayloadElement> citity) {
    distnationfortransfer = citity;
    notifyListeners();
  }

  PayloadElement? payloadFrom;

  void getpayloadFrom(PayloadElement payload) {
    payloadFrom = payload;

    notifyListeners();
  }

  PayloadElement? payloadFromlocation;

  void getpayloadFromlocation(PayloadElement payload) {
    payloadFromlocation = payload;
    notifyListeners();
  }

  late PayloadElement payloadto;

  void getpayloadTo(PayloadElement payload) {
    payloadto = payload;
    notifyListeners();
  }

  PayloadElement? payloadWhichCityForTransfer;

  void getPayloadWhichCityForTransfer(PayloadElement payload) {
    payloadWhichCityForTransfer = payload;
    notifyListeners();
  }

  String departures = '';
  String comes = '';

  void getdates(String departure, String come) {
    departures = departure;
    comes = come;
    notifyListeners();
  }

  String finalchildrenstext = '';

  void getfinalchildrenstext(String val) {
    finalchildrenstext = val;
    notifyListeners();
  }

  int rooms = 1;
  int adults = 1;
  int childrens = 0;

  void getRoomAndChildrenDetails(int room, int adult, int children) {
    rooms = room;
    adults = adult;
    childrens = children;

    notifyListeners();
  }

  String? mainpackageId = '';

  void getPackageId(String? packageIds) {
    mainpackageId = packageIds;
    notifyListeners();
  }

  bool isloadedonce = false;

  void hundletheloading(bool state) {
    isloadedonce = state;
    notifyListeners();
  }

  late MainSarchForPackage mainsarchForPackage;

  void getmainpakcages(MainSarchForPackage sarchForPackages, bool isfromlisting) {
    if (isfromlisting) {
      //!isloadedonce
      // mainsarchForPackage.data.packages.length != sarchForPackages.data.packages.length
      if (mainsarchForPackage.data.packages.length != sarchForPackages.data.packages.length) {
        mainsarchForPackage.data.packages = sarchForPackages.data.packages;
        //  mainsarchForPackage.data.packages.addAll(sarchForPackages.data.packages);

        // final packages = [
        //   ...{...mainsarchForPackage.data.packages}
        // ];

        // mainsarchForPackage.data.packages = packages;
        isloadedonce = true;
      }
    } else {
      isloadedonce = false;
      mainsarchForPackage = sarchForPackages;
    }

    notifyListeners();
  }

  IndvPackagesModel? indvPackagesModel;
  IndvPackagesModel? generalIndPackagesModel;
  List<PackageIndv> generalIndPackagesList = [];

  IndvPackagesModel? get getIndvPackageData => indvPackagesModel;

  void setIndvPackages(IndvPackagesModel? indvPackages) {
    indvPackagesModel = indvPackages;
    generalIndPackagesModel = indvPackages;
    generalIndPackagesList = indvPackages!.data.packages.map((e) => e).toList();
    notifyListeners();
  }

  void getpakagesafterchangecurrency(MainSarchForPackage package) {
    mainsarchForPackage = package;
    notifyListeners();
  }

  // late Packages packages;
  // void getPackages(Packages package) {
  //   packages = package;
  //   notifyListeners();
  // }

  late cus.Customizpackage packagecustomiz;

  void getPackageIdforcustomiz(cus.Customizpackage packagescustomiz) {
    packagecustomiz = packagescustomiz;
    notifyListeners();
  }

  Changehotel? changehotel;

  void changehotels(Changehotel? changehotels) {
    changehotel = changehotels;
    notifyListeners();
  }

  late rom.Room room;

  void saveRoomforUpdate(rom.Room room) {
    room = room;
    notifyListeners();
  }

  String selectedpackageId = '';

  void getselectedpackageid(String selectedpackageid) {
    selectedpackageId = selectedpackageid;
    notifyListeners();
  }

  Changeflight? changeflight;
  Changeflight? genchangeflight;

  void getflights(Changeflight? changeflights) {
    genchangeflight = changeflights;
    changeflight = changeflights;

    notifyListeners();
  }

  late FlightData datum;

  void getselectedFlightToShowDetials(FlightData data) {
    datum = data;
    notifyListeners();
  }

  late AcivityList acivityList;

  void getAcivityList(AcivityList list) {
    acivityList = list;
    notifyListeners();
  }

  int activityDay = 0;

  void getActivityDat(int day) {
    activityDay = day;
    notifyListeners();
  }

  late ChangeTransfer changeTransfer;

  void getTransferList(ChangeTransfer changeTransfers) {
    changeTransfer = changeTransfers;
    notifyListeners();
  }

  Searchforflight? searchforflight;

  void getFlightSearchList(Searchforflight searchforflights) {
    searchforflight = searchforflights;
    notifyListeners();
  }

  String selectedflightcode = '';

  void getselectedflightcode(String code) {
    selectedflightcode = code;
    notifyListeners();
  }

  String cityCodeforSelectHotelSearch = '';

  void getcityCodeforSelectHotelSearch(String citycode) {
    cityCodeforSelectHotelSearch = citycode;
    notifyListeners();
  }

  late Searchforhotel searchforhotel;

  void getHotelSearchList(Searchforhotel searchforhotels) {
    searchforhotel = searchforhotels;
    notifyListeners();
  }

  String selectdHoteltcode = '';

  void getselectedHotelcode(String code) {
    selectdHoteltcode = code.toString();
    notifyListeners();
  }

  late DateTime first;
  late DateTime sec;

  void getdatesfromCal(DateTime f, DateTime s) {
    first = f;
    sec = s;
    notifyListeners();
  }

  String currency = 'ADE';

  void getCurrency(String currencys) {
    currency = currencys;
    notifyListeners();
  }

  String lang = 'ENG';

  void getlang(String langs) {
    lang = langs;
    notifyListeners();
  }

  // late Rej rej;
  // void getRejsUser(Rej rejs) {
  //   rej = rejs;
  //   notifyListeners();
  // }

  // late Login login;
  // void getLoginUser(Login logins) {
  //   login = logins;
  //   notifyListeners();
  // }

  void getUser(User user) {
    users = user;

    gencurrency = 'SAR';
    fullName = users.data.name;
    updateuser(user);
    notifyListeners();
  }

  Map<String, Forms> passingerList = {};

  List<Forms> selectedPassingerfromPassList = [];

  List<Forms> formPassList = [];

  void resetSelectedPassingerfromPassList() {
    selectedPassingerfromPassList.clear();
    notifyListeners();
  }

  void clearAllPassengerInformation() {
    passingerList.clear();
    notifyListeners();
  }

  void removeOnPassener() {
    notifyListeners();
  }

  void getPassingerinformation({required Forms passingerInformation, required String id}) async {
    passingerList.containsKey(id)
        ? passingerList.update(id, (value) => passingerInformation)
        : passingerList.putIfAbsent(id, () => passingerInformation);
    selectedPassingerfromPassList = passingerList.values.toList();

    if (preBookREQData.isNotEmpty) {
      List<dynamic> finalPassingerInformationList = [];
      passingerList.forEach((key, value) {
        finalPassingerInformationList.add(value.toJson());
      });
      preBookREQData['passengers'] = finalPassingerInformationList;

      log(preBookREQData.toString());
    }

    notifyListeners();
  }

  Map<int, bool> isfilled = {};

  void checkfilling({required int ind, required bool fill}) {
    isfilled.putIfAbsent(ind, () => fill);
    notifyListeners();
  }

  String token = '';

  void getToken(String tokens) {
    token = tokens;
    notifyListeners();
  }

  Forms? userinformation;

  void getPassingerByIndex(String index) {
    userinformation = passingerList[index];
  }

  late Prebook prebook;
  late PrebookMessage prebookFaild;
  bool isfaild = false;
  Map<String, String> faildMessage = {};

  getPrebook(dynamic prebooking, bool isfailds) {
    isfaild = isfailds;

    if (isfaild) {
      prebook = prebooking;
      return prebook;
    } else {
      dynamic suc = jsonDecode(prebooking);
      PrebookMessage message = PrebookMessage(
          flightFail: suc['data']['message']['flightFail'],
          flightFailMessage: suc['data']['message']['flightFailMessage'],
          hotelFail: suc['data']['message']['hotelFail'],
          hotelFailMessage: suc['data']['message']['hotelFailMessage'],
          transferFail: suc['data']['message']['transferFail'],
          transferFailMessage: suc['data']['message']['transferFailMessage'],
          activityFail: suc['data']['message']['activityFail'],
          activityFailMessage: suc['data']['message']['activityFailMessage']);
      prebookFaild = message;

      faildMessage.clear();
      if (message.activityFail > 0) {
        dynamic activityFail = message.activityFailMessage;
        faildMessage.putIfAbsent('activityFail', () => activityFail.toString());
      }
      if (message.flightFail > 0) {
        dynamic flightFail = message.flightFailMessage;
        faildMessage.putIfAbsent('flightFail', () => flightFail.toString());
      }
      if (message.hotelFail > 0) {
        dynamic hotileFail = message.hotelFailMessage;
        faildMessage.putIfAbsent('hotelFail', () => hotileFail.toString());
      }
      if (message.transferFail > 0) {
        dynamic transferFail = message.transferFailMessage;
        faildMessage.putIfAbsent('transferFail', () => transferFail.toString());
      }
    }
    notifyListeners();
  }

  getUserFromPref(BuildContext context) async {
    final String? json = AssistenData.getUserData();
    final isMedia = AssistenData.getUserloginWithMedia();
    if (isMedia != null) {
      isLoginWithMedia = isMedia;
    } else {
      isLoginWithMedia = false;
    }
    if (json != null) {
      try {
        String data = await AssistantMethods.getUserFromPref(json, context);

        final user = userFromJson(data);

        bool isloggedIn = user.error;

        if (isloggedIn == false) {
          users = userFromJson(data);
          getUser(user);
          fullName = users.data.name;
        } else {}
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } else {}

    notifyListeners();
  }

  late Holidaysfotter holidaysfotter;

  void offerAndTrending(Holidaysfotter h) {
    holidaysfotter = h;

    notifyListeners();
  }

  File? image;

  void getuerimage(File images) {
    image = images;
    notifyListeners();
  }

  String newSearchCitiy = '';

  void newSearchPayload(String newSearchCitiys) {
    newSearchCitiy = newSearchCitiys;
    notifyListeners();
  }

  String title = '';

  void newSearchTitle(String titles) {
    title = titles;
    notifyListeners();
  }

  DateTime? newSearchFirstDate;
  DateTime? newSearchsecoundDate;

  void newsearchdateRange(PickerDateRange datesrang) {
    newSearchFirstDate = datesrang.startDate;
    newSearchsecoundDate = datesrang.endDate;
    notifyListeners();
  }

  bool showNavbar = false;

  void vNavBar(bool show) {
    showNavbar = show;
    notifyListeners();
  }

  List<CheckboxStateHolder> flightCheck = [
    CheckboxStateHolder(tilte: 'Non stop', value: false),
    CheckboxStateHolder(tilte: 'One stop', value: false),
    CheckboxStateHolder(tilte: 'Mutli stop', value: false),
  ];

  void getflightCheck(List<CheckboxStateHolder> flightChecks) {
    flightCheck = flightChecks;
    notifyListeners();
  }

  List<CheckboxStateHolder> starRatingcheck = [
    CheckboxStateHolder(tilte: '★ ★ ★', value: false),
    CheckboxStateHolder(tilte: '★ ★ ★ ★', value: false),
    CheckboxStateHolder(tilte: '★ ★ ★ ★ ★', value: false),
  ];

  void getStarRatingCheck(List<CheckboxStateHolder> starRatingchecks) {
    starRatingcheck = starRatingchecks;
    notifyListeners();
  }

  double? min;
  double? max;

  void getsliderLimit({required double mins, required double maxs}) {
    min = mins;
    max = maxs;

    //  notifyListeners();
  }

  RangeValues? _currentRangeValues;

  getSliderData({required double min, required double max}) {
    _currentRangeValues = RangeValues(min, max);
    // notifyListeners();
    return _currentRangeValues;
  }

  List<Package> packagefilter = [];
  bool ismakefilter = false;
  Map<int, bool> starsRate = {
    3: false,
    4: false,
    5: false,
  };

  Map<int, bool> flightStops = {
    0: false,
    1: false,
    2: false,
  };

  void filter() {
    List<Package> filterhundler =
        packagefilter = mainsarchForPackage.data.packages.map((e) => e).toList();

    List<int> selectedStars = [];
    List<int> selectedStops = [];

    starsRate.forEach((key, value) {
      if (value) {
        selectedStars.add(key);
      }
    });
    flightStops.forEach((key, value) {
      if (value) {
        selectedStops.add(key);
      }
    });

    if (ismakefilter) {
      filterhundler = mainsarchForPackage.data.packages.where((element) {
     
        return (element.total.toDouble() <= max! && element.total.toDouble() >= min!);
      }).where((element) {
        if (selectedStars.isNotEmpty) {
          return selectedStars.contains(element.hotelStar);
        } else {
          return true;
        }
      }).where((element) {
        if (selectedStops.isNotEmpty) {
          if (selectedStops.contains(2)) {
            return element.flightStop >= 2;
          } else {
            return selectedStops.contains(element.flightStop);
          }
        } else {
          return true;
        }
      }).toList();

      // starRatingcheck.forEach((star) {
      //   if (star.value == true) {
      //     final x = mainsarchForPackage.data.packages
      //         .where((element) => element.hotelStar == star.tilte.replaceAll(' ', '').length)
      //         .toList();
      //     print(x.length);
      //   }
      // });
    }

    packagefilter = filterhundler.toSet().toList();
  }

  void restTheFilter() {
    isMakeBudgetTuning = false;
    for (var element in flightCheck) {
      element.value = false;
    }

    for (var element in starRatingcheck) {
      element.value = false;
    }

    min = mainsarchForPackage.data.priceRange.min.toDouble();
    max = mainsarchForPackage.data.priceRange.max.toDouble();

    ismakefilter = false;

    packagefilter = mainsarchForPackage.data.packages.map((e) => e).toList();

    notifyListeners();
  }

  bool resarchWhenChangecrruncy = false;

  void makeresarchResearchCurr(bool can) {
    resarchWhenChangecrruncy = can;
    notifyListeners();
  }

  List<CheckboxStateHolder> starRatingcheckHotel = [
    CheckboxStateHolder(tilte: '★ ★ ★', value: false),
    CheckboxStateHolder(tilte: '★ ★ ★ ★', value: false),
    CheckboxStateHolder(tilte: '★ ★ ★ ★ ★', value: false),
  ];

  Map<int, bool> starsRateHotel = {
    3: false,
    4: false,
    5: false,
  };

  String priceForHotelDropList = '';
  String nameForHotelDroplist = '';

  bool isMakeHotelFilter = false;

  void makeHotelFiters(bool make) {
    isMakeHotelFilter = make;

    notifyListeners();
  }

  void getStarRatingCheckHotel(List<CheckboxStateHolder> starRatingchecks) {
    starRatingcheckHotel = starRatingchecks;
    notifyListeners();
  }

  Changehotel? filterHotelList;

  void filterHotel() {
    filterHotelList = changehotel;

    List<int> selectedStarsHotel = [];

    starsRateHotel.forEach((key, value) {
      if (value) {
        selectedStarsHotel.add(key);
      }
    });

    final x = filterHotelList!.response.where((element) {
      if (selectedStarsHotel.isNotEmpty) {
        return selectedStarsHotel.contains(int.parse(element.starRating.trim()));
      } else {
        return true;
      }
    }).toList();

    if (nameForHotelDroplist != '') {
      if (nameForHotelDroplist == 'A to Z') {
        x.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      } else {
        x.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      }
    }
    notifyListeners();
  }

  String preBookTitle = 'Passengers information';

  void newPreBookTitle(String preTitle) {
    preBookTitle = preTitle;
    notifyListeners();
  }

  bool requireaSmokingRoom = false;
  bool requireaNonSmokingRoom = false;
  bool requestRoomonaLowFloor = false;
  bool requestRoomonaHighFloor = false;
  bool honeymoonTrip = false;
  bool requestforaBabyCot = false;
  bool celebratingBirthday = false;
  bool celebratingAnniversary = false;
  String otherRE = '';

  prebookdata(
      {required bool requireaSmokingRoom1,
      required bool requireaNonSmokingRoom1,
      required bool requestRoomonaLowFloor1,
      required bool requestRoomonaHighFloor1,
      required bool honeymoonTrip1,
      required bool requestforaBabyCot1,
      required bool celebratingBirthday1,
      required bool celebratingAnniversary1,
      required String other}) {
    requireaSmokingRoom = requireaSmokingRoom1;
    requireaNonSmokingRoom = requireaNonSmokingRoom1;
    requestRoomonaLowFloor = requestRoomonaLowFloor1;
    requestRoomonaHighFloor = requestRoomonaHighFloor;
    honeymoonTrip = honeymoonTrip1;
    requestforaBabyCot = requestforaBabyCot1;
    celebratingBirthday = celebratingBirthday1;
    celebratingAnniversary = celebratingAnniversary1;
    otherRE = other;

    notifyListeners();
  }

  bool acceptprebookterm = false;

  accepttheterm(bool term) {
    acceptprebookterm = term;
    notifyListeners();
  }

  String citinameFormApi = '';

  void getcitiynamefromApi(String citiy) {
    citinameFormApi = citiy;
    notifyListeners();
  }

  NewChangeHotel? newChangeHotel;

  void newChangehotel(NewChangeHotel newChange) {
    newChangeHotel = newChange;

    notifyListeners();
  }

  List<FlightData> flightfilterList = [];

  List<FlightData> searchonFlightList(String name) {
    if (changeflight == null) return [];
    final flightsfilters = changeflight!.data;
    if (name.isNotEmpty && flightsfilters.isNotEmpty) {
      flightfilterList = flightsfilters
          .where((element) =>
              (element.carrier.label != null) &&
              (element.carrier.label.toLowerCase().contains(name.toLowerCase().trim())))
          .toList();
      notifyListeners();
      return flightfilterList;
    } else {
      return changeflight!.data;
    }
  }

  List<ResponseHotel> hotelfilterList = [];

  List<ResponseHotel> searchonHotelList(String name) {
    if (changehotel == null) return [];
    final hotelfilters = changehotel!.response;

    if (name.isNotEmpty) {
      hotelfilterList = hotelfilters
          .where((element) => (element.name.toLowerCase().contains(name.toLowerCase().trim())))
          .toList();
      notifyListeners();
      return hotelfilterList;
    } else {
      return changehotel!.response;
    }
  }

  String hotelStarfilter = '3 stars';

  void gethotelstarefilter(String star) {
    hotelStarfilter = star;
    notifyListeners();
  }

  int hotelindex = 0;

  void gethotelindex(int i) {
    hotelindex = i;
    notifyListeners();
  }

  late SearchTransferIfRemoveForH searchTransferDistnation;

  void getDistnationForTransfer(SearchTransferIfRemoveForH change) {
    searchTransferDistnation = change;
    notifyListeners();
  }

  late SearchTransferIfRemoveForH searchTransferDistnationAir;

  void getDistnationForTransferAir(SearchTransferIfRemoveForH change) {
    searchTransferDistnationAir = change;
    notifyListeners();
  }

  TransferListing? transferListing;

  void gettransferlisting(TransferListing transfer) {
    transferListing = transfer;
    notifyListeners();
  }

  Currencies? currencies;

  void getcurrencylist(Currencies currenciess) {
    currencies = currenciess;
    notifyListeners();
  }

  User? userupadate;

  void updateuser(User user) {
    userupadate = user;
    notifyListeners();
  }

  void resetApp() {
    selectedflightcode = '';
    selectdHoteltcode = '';

    notifyListeners();
  }

  num userCollectedPoint = 0;

  void userCollectedCoinFromGame(num coin) {
    userCollectedPoint = coin;
    notifyListeners();
  }

  bool isDiscountDialog = false;

  void gundletheDisountDialog(bool value) {
    isDiscountDialog = value;
    notifyListeners();
  }

  CheckOutModel? coupon;

  void getCouponResultData(CheckOutModel v) {
    coupon = v;
    notifyListeners();
  }

  PrebookFalid? prebookFalid;
  bool isPreBookFailed = false;
  int failedActivityDayNum = 0;
  String activityDateString = '';
  int transferChangeCounter = 0;
  int activityChangeCounter = 0;
  String failedActivityID = '';
  bool isFlightFaildFromForm = false;

  void resetFlightFromForm(bool val) {
    isFlightFaildFromForm = val;
    notifyListeners();
  }

  void getfailedActivityDay(int val) {
    failedActivityDayNum = val;
    notifyListeners();
  }

  void getFailedActivityID(String id) {
    failedActivityID = id;
    notifyListeners();
  }

  void getActivityDateString(DateTime date) {
    activityDateString = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void getPreBookData(PrebookFalid value) {
    prebookFalid = value;
    notifyListeners();
  }

  Map<String, dynamic> preBookREQData = {};

  void getPreBookREQData(Map<String, dynamic> value) {
    preBookREQData = value;
    notifyListeners();
  }

  void changePrebookFaildStatus(bool value) {
    isPreBookFailed = value;
    notifyListeners();
  }

  void changeTransferCounter(int val) {
    transferChangeCounter = val;
    notifyListeners();
  }

  void changeActivityCounterReset() {
    activityChangeCounter = 0;
    notifyListeners();
  }

  hundelPreBookResult(BuildContext context) async {
    isPreBookFailed = true;
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PreBookTodo(
              isIndv: searchMode.isEmpty && searchMode.toLowerCase().trim() == '' ? false : true,
            )));
    // if (prebookFalid != null) {
    //   if (prebookFalid!.data.prebookDetails != null) {
    //     await showDialog(
    //         context: context,
    //         builder: (context) => PrebookFailedSum(prebookFalid!.data.prebookDetails!),
    //         barrierDismissible: false);
    //   }
    // }

    //  try {
    //       while (isPreBookFailed == true) {
    //         if(fullName ==''){
    //           Navigator.of(context).pop();
    //           return;
    //         }
    //         if (prebookFalid != null && prebookFalid!.data.prebookDetails != null) {
    //           final prebookDetail = prebookFalid!.data.prebookDetails;
    //
    //           if (prebookDetail!.flights.prebookSuccess == false) {
    //
    //             if(prebookDetail.flights.failedReasons!.fielderrors)
    //             {isFlightFaildFromForm = true;
    //             displayTostmessage(context, true, message: 'Please make sure to fill the form with correct information');
    //            await   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PreBookStepper(isFromNavBar: false,)));
    //             isFlightFaildFromForm = false;
    //             }
    //             else
    //               {
    //                 final x = await AssistantMethods.changeflight(
    //                     packagecustomiz.result.customizeId, "Y", context);
    //                 if (x != null) {
    //                   await Navigator.of(context).push(MaterialPageRoute(
    //                       builder: (context) => FlightCustomize(
    //                         failedFlightNamed: prebookDetail.flights.message,
    //                       )));
    //                 } else {
    //                   displayTostmessage(context, false, message: 'Flight booking failed ');
    //                   Navigator.of(context).pop();
    //                 }
    //                 await AssistantMethods.updatethepackage(packagecustomiz.result.customizeId);
    //               }
    //
    //           }
    //
    //           if (prebookDetail.activites.prebookSuccess == false) {
    //             activityChangeCounter += 1;
    //
    //             final failedActivity = prebookDetail.activites.details;
    //             final allActivityMap =
    //                 packagecustomiz.result.activities as Map<String, List<cus.Activity>>;
    //             final allActivityList = allActivityMap.values.toList();
    //             final allActivity = allActivityList.map((e) => e[0]).toList();
    //             print(failedActivity.length.toString() + '>>>>>>>>>>>>>>>>>>>>>>>');
    //             for (var failed in failedActivity) {
    //               print(failed.date.toString() + "+++++++++++++++++++++++");
    //               final failedActiviyDaysList = allActivity
    //                   .where((element) => element.activityDate.isAtSameMomentAs(failed.date))
    //                   .toList();
    //               print(failedActiviyDaysList.toString());
    //               if (failedActiviyDaysList.isNotEmpty) {
    //                 failedActivityDayNum   = failedActiviyDaysList[0].day;
    //                 failedActivityID       = failedActiviyDaysList[0].activityId;
    //                 activityDay            = failedActivityDayNum;
    //                 activityDateString     = DateFormat('yyyy-MM-dd').format(failed.date);
    //                 await AssistantMethods.getActivityList(context,
    //                     searchId: packagecustomiz.result.searchId,
    //                     customizeId: packagecustomiz.result.customizeId,
    //                     activityDay: failed.date.toString(),
    //                     currency: gencurrency);
    //
    //                 await Navigator.of(context).push(MaterialPageRoute(
    //                     builder: (context) => ActivityList(faildActivity: failed.details.name)));
    //               }
    //             }
    //           }
    //           if (prebookDetail.hotels.prebookSuccess == false) {
    //             print(prebookDetail.hotels.details.length);
    //             if(prebookDetail.hotels.details.isNotEmpty) {
    //             final x = await AssistantMethods.changehotel(context,
    //                 customizeId: packagecustomiz.result.customizeId,
    //                 checkIn: DateFormat("yyyy-mm-dd")
    //                     .format(prebookDetail.hotels.details.first.details.checkIn),
    //                 checkOut: DateFormat("yyyy-mm-dd")
    //                     .format(prebookDetail.hotels.details[0].details.checkout),
    //                 hId: prebookDetail.hotels.details[0].details.hotelId,
    //                 star: prebookDetail.hotels.details[0].details.starRating);
    //             await Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => HotelCustomize(
    //                     oldHotelID: prebookDetail.hotels.details[0].details.hotelId.toString(),
    //                     hotelFailedName: prebookDetail.hotels.message)));
    //         }
    //         }
    //           if (prebookDetail.transfers.prebookSuccess == false) {
    //             transferChangeCounter += 1;
    //             await AssistantMethods.changeTransfer(
    //                 packagecustomiz.result.customizeId, 'IN', context);
    //             print(transferChangeCounter);
    //             await Navigator.of(context)
    //                 .push(MaterialPageRoute(builder: (context) => TransferCustomize()));
    //           }
    //         }
    // final data = jsonEncode(preBookREQData);
    //         isPreBookFailed =
    //             !await AssistantMethods.newPreBook(data, users.data.token, context);
    //
    //       }
    //       Navigator.of(context).pop();
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => SumAndPay()));
    //       print('       ===========  END OF FUNCTION  ===========');
    //      notifyListeners();
    //  } catch (e) {
    //      isPreBookFailed = false;
    //      displayTostmessage(context, true, message: 'Something goes wrong please try again');
    //      Navigator.of(context).pushNamedAndRemoveUntil(CustomizeSlider.idScreen, (route) => false);
    //      print(e.toString());
    //    }
  }

//   List<Passengers> pass = [];
// int? passengerID;
//   void hundelpassengerlist() {
//     if (users.data.passengers != null) {
//       pass = users.data.passengers!;
//       selectedPassingerfromPassList.forEach((element) {
//         pass.removeWhere((e) =>
//             element.passportnumber.trim().toLowerCase() == e.passportNumber.trim().toLowerCase());
//       });
//     }
//
//     notifyListeners();
//   }

  bool isFromdeeplink = false;

  void isFromDeeplink(bool val) {
    isFromdeeplink = val;
    notifyListeners();
  }

  bool isMakeBudgetTuning = false;
  double maxBudget = 100000;

  void getTuningBudget(bool val, {double maxB = 10000}) {
    isMakeBudgetTuning = val;
    if (val == true) {
      maxBudget = maxB;
    }

    notifyListeners();
  }

  Locale? _locale = const Locale('en');

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  Locale get locale => _locale!;

  void clearLocal() {
    _locale = null;
    notifyListeners();
  }

  String tryd = '';

  void tryed(String val) {
    tryd = val;
    notifyListeners();
  }

  bool stopCountDownTimer = false;

  bool get stopCountDownTimers => stopCountDownTimer;

  void setStopCountDownTimer(bool value) {
    stopCountDownTimer = value;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////    PRIVET JET    ////////////////////////
  /////////////////////////////////////////////////////////////////////////

  PrivetJetCategoryModel? privetJetCategory;

  PrivetJetCategoryModel? get getPrivetJetCategories => privetJetCategory;

  void setPrivetJetCategory(PrivetJetCategoryModel data) {
    privetJetCategory = data;

    notifyListeners();
  }

  int? minCategory;

  int? get getMinCategory => minCategory;

  set setMinCategory(int val) {
    minCategory = val;
  }

  int paxCount = 1;

  int get getPax => paxCount;

  set setPax(int val) {
    paxCount = val;
  }

  Map<String, dynamic> privetJetDateInformation = {};

  Map<String, dynamic> get getPrivetJetDataInformation => privetJetDateInformation;

  set setPrivetJetDateInformation(Map<String, dynamic> val) {
    privetJetDateInformation = val;
  }

  Map<String, dynamic> privetJetResponse = {};

  Map<String, dynamic> get getPrivetJetResponse => privetJetResponse;

  set getPrivetJetResponse(Map<String, dynamic> val) {
    privetJetResponse = val;
  }

////////////////////////////////////////////////////////////////////////////
  //////////////////////   PRIVET JET END     //////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  String holderEmail = '';

  String get getHolderEmail => holderEmail;

  set getHolderEmail(String val) {
    holderEmail = val;
  }

  String preBookPhoneNumber = '';
  String preBookPhoneCountryCode = '';

  void getHolderPhoneNumber({required String phone, required String code}) {
    preBookPhoneNumber = phone;
    preBookPhoneCountryCode = code;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////
  //////////////////////    Travel Insurance    //////////////////////////////
  ////////////////////////////////////////////////////////////////////////////

  Map<String, dynamic> holderDetails = {};

  Map<String, dynamic> get getHolderDetails => holderDetails;

  void setHolderDetail(Map<String, dynamic> val) {
    holderDetails = val;
  }

  int adultInsurancePaxNumber = 1;
  int seniorTravelersPaxNumber = 0;
  int childrenInsurancePaxNumber = 0;
  int paxSum = 1;

  Map<String, dynamic> allPax = {};
  List<TravelInsurancePaxDetailsData?> travelInsurancePaxDetailsList = [];

  void setTravelInsurancePax(int adult, int senior, int child) {
    adultInsurancePaxNumber = adult;
    seniorTravelersPaxNumber = senior;
    childrenInsurancePaxNumber = child;
    paxSum = adult + senior + child;
    allPax = {'adult': adult, 'old': senior, 'child': child};
    travelInsurancePaxDetailsList = List.generate(
        (adultInsurancePaxNumber - 1) + seniorTravelersPaxNumber + childrenInsurancePaxNumber,
        (index) => null);
  }

  int get allPaxSum => paxSum;

  void setTravelInsurancePaxDetailsList(TravelInsurancePaxDetailsData val, int i) {
    travelInsurancePaxDetailsList[i] = val;
  }

  List<TravelInsurancePaxDetailsData?> get getTravelInsurancePaxDetailsList =>
      travelInsurancePaxDetailsList;

  IndTransferSearchModel? indTransferSearchModel;

  IndTransferSearchModel? get indTransferSearchData => indTransferSearchModel;

  set indTransferSearchData(IndTransferSearchModel? val) {
    indTransferSearchModel = val;
    notifyListeners();
  }

  Map<String, IndTransferSearchResultData> transferPointsData = {};

  Map<String, IndTransferSearchResultData> get transferIndPoints => transferPointsData;

  set transferIndPoints(Map<String, IndTransferSearchResultData> val) {
    transferPointsData = val;
  }

  void injectTransferIndPoint(String key, IndTransferSearchResultData val) {
    transferPointsData.update(key, (value) => val, ifAbsent: () => val);
  }

  Map<String, dynamic> transferTimeAndDate = {};

  Map<String, dynamic> get transferIndTimeAndDate => transferTimeAndDate;

  set transferIndTimeAndDate(Map<String, dynamic> val) {
    transferTimeAndDate = val;
  }

  void injectTransferIndTimeAndDate(String key, IndTransferSearchResultData val) {
    transferTimeAndDate.update(key, (value) => val, ifAbsent: () => val);
  }

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////    FILTER     //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

  List<PackageIndv> indFilteringFlight(BuildContext context,
      {required bool oneStop, required nonStop, required multiStop, required bool changePrice}) {
    List<PackageIndv> filterList = [];
    List<PackageIndv> filter1 = [];
    max ??= generalIndPackagesModel!.data.priceRange.max.toDouble();
    min ??= generalIndPackagesModel!.data.priceRange.min.toDouble();
    if (getIndvPackageData != null) {
      filterList = generalIndPackagesList.map((e) => e).toList();
    }
    if (oneStop == false && nonStop == false && multiStop == false && changePrice == false) {
      filter1 = generalIndPackagesList.map((e) => e).toList();
    } else if (oneStop == false && nonStop == false && multiStop == false && changePrice == true) {
      filter1 =
          filterList.where((element) => (element.total >= min! && element.total <= max!)).toList();
    } else {
      filter1 = filterList
          .where((element) => (element.total >= min! && element.total <= max!))
          .where((element) =>
              (oneStop && element.flightStop == 1) ||
              (nonStop && element.flightStop == 0) ||
              (multiStop && element.flightStop > 1))
          .toList();
    }

    // if (filter1.isEmpty) {
    //   displayTostmessage(context, false, isInformation: true,message: 'No Packages for this options');
    //   filter1 = generalIndPackagesModel!.data.packages.map((e) => e).toList();
    //   indvPackagesModel!.data.packages =
    //       generalIndPackagesModel!.data.packages.map((e) => e).toList();
    // }

    return filter1;
  }

  List<PackageIndv> indFilteringHotel(BuildContext context,
      {required bool threeStars,
      required fourStars,
      required fiveStars,
      required bool changePrice}) {
    List<PackageIndv> filterList = [];
    List<PackageIndv> filter1 = [];
    max ??= generalIndPackagesModel!.data.priceRange.max.toDouble();
    min ??= generalIndPackagesModel!.data.priceRange.min.toDouble();
    if (getIndvPackageData != null) {
      filterList = generalIndPackagesList.map((e) => e).toList();
    }
    if (threeStars == false && fourStars == false && fiveStars == false && changePrice == false) {
      filter1 = generalIndPackagesList.map((e) => e).toList();
    } else {
      if (threeStars == false && fourStars == false && fiveStars == false && changePrice == true) {
        filter1 = filterList
            .where((element) =>
                (element.hotelDetails!.rateFrom >= min! && element.hotelDetails!.rateFrom <= max!))
            .toList();
      } else {
        filter1 = filterList
            .where((element) =>
                (element.hotelDetails!.rateFrom > min! && element.hotelDetails!.rateFrom <= max!))
            .where((element) =>
                (threeStars && element.hotelStar.toDouble() == 3) ||
                (fourStars && element.hotelStar.toDouble() == 4) ||
                (fiveStars && element.hotelStar.toDouble() == 5))
            .toList();
      }
    }

    // if (filter1.isEmpty) {
    //   displayTostmessage(context, false, isInformation: true,message: 'No Packages for this options');
    //   filter1 = generalIndPackagesModel!.data.packages.map((e) => e).toList();
    //   indvPackagesModel!.data.packages =
    //       generalIndPackagesModel!.data.packages.map((e) => e).toList();
    // }
    notifyListeners();
    return filter1;
  }

  void clearIndFilter() {
    indvPackagesModel!.data.packages =
        generalIndPackagesModel!.data.packages.map((e) => e).toList();
    max = generalIndPackagesModel!.data.priceRange.max.toDouble();
    min = generalIndPackagesModel!.data.priceRange.min.toDouble();
    notifyListeners();
  }

  int preNumberPicker = 0;

  int pickLimit = 0;

  int roomLeft = 3;

  void setRoomLeft(int room) {
    roomLeft = room;
    pickLimit = room;
  }

  int handleSelectRoomNumberPicker(int i, int roomLimit, DoAction action) {
    switch (action) {
      case DoAction.ADD:
        {
          if (roomLeft > 0) {
            roomLeft -= 1;
            pickLimit -= 1;
          }

          break;
        }
      case DoAction.MINUS:
        {
          if (roomLeft < roomLimit) {
            roomLeft += 1;
            pickLimit += 1;
          }

          break;
        }
      default:
        {
          break;
        }
    }

    return roomLeft;
  }

  bool hasQuestions = false;

  void toggleHasQuestions(bool val) {
    hasQuestions = val;
  }

  ActivityQuestions? activityQuestions;

  ActivityQuestions? get getActivityQuestions => activityQuestions;

  set getActivityQuestions(ActivityQuestions? val) {
    activityQuestions = val;
  }

// if(action )
//     if (  i < preNumberPicker) {
//       if (initialPick > 0) {
//         initialPick -= 1;
//       }
//
//     } else if (i > preNumberPicker) {
//       if (initialPick < roomLimit) {
//         initialPick += 1;
//       }
//
//     } else {
//
//     }
//     preNumberPicker = i;
//
//    print(initialPick);
//     return initialPick;
//   }

  PromoPopup? promoPopupData;

  PromoPopup? get promoPopup => promoPopupData;

  set promoPopup(PromoPopup? val) {
    promoPopupData = val;
  }

  int? prePromoPopupId;

  int? get perPromoId => prePromoPopupId;

  set perPromoId(int? val) {
    prePromoPopupId = val;
  }

  PromoList? promoList;

  PromoList? get promotionList => promoList;

  set promotionList(PromoList? val) {
    promoList = val;
  }

  List<Color> color = [];

  List<Color> get promotionColor => color;

  set promotionColor(List<Color> val) {
    color = val;
  }

  Map<String, dynamic> coinPaymentStatus = {};

  Map<String, dynamic> get getCoinPaymentStatus => coinPaymentStatus;

  set getCoinPaymentStatus(Map<String, dynamic> val) {
    coinPaymentStatus = val;
  }

  int switchThePaymentResponse() {
    int status = 0;
    if (getCoinPaymentStatus.containsKey('code')) {
      status = getCoinPaymentStatus['code'];
    }

    return status;
  }
}
