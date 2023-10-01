import 'package:shared_preferences/shared_preferences.dart';

class AssistenData {
  static const userkey = 'user';

  static const isLoginWithMedia = 'media';

  static const promoCodeId = 'promoId';

  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUserdata(String json) async {
    await _preferences.setString(userkey, json);
  }

  static String? getUserData() => _preferences.getString(userkey);

  static removeUserDate() => _preferences.remove(userkey);

  static Future setUserLoginProvider() async => await _preferences.setBool(isLoginWithMedia, true);

  static removeUserMediaLogin() => _preferences.remove(isLoginWithMedia);

  static bool? getUserloginWithMedia() => _preferences.getBool(isLoginWithMedia);

  //=========================>>>  For Search Tuning  <<<===========================//

  static Future setUserPreferredBudget(double val) async =>
      await _preferences.setDouble('uBudget', val);

  static double? getUserPreferredBudget() => _preferences.getDouble('uBudget');

  static removeUserPreferredBudget() => _preferences.remove('uBudget');

  //
  static Future setuserPreferredFlightClass(String val) async =>
      _preferences.setString('Uclass', val);

  static String? getuserPreferredFlightClass() => _preferences.getString('Uclass');

  static removeuserPreferredFlightClass() => _preferences.remove('Uclass');

//

  static Future setUserPreferredStarhotel(int val) async => _preferences.setInt('UHotelStars', val);

  static int? getUserPreferredStarhotel() => _preferences.getInt('UHotelStars');

  static removeUserPreferredStarhotel() => _preferences.remove('UHotelStars');

  ////////// FOR Localization

  static Future setUserLocal(String val) async => _preferences.setString("Ulocal", val);

  static String? getUserLocal() => _preferences.getString("Ulocal");

  static removeUserLocal() => _preferences.remove("Ulocal");

  ///////// FOR PROMO CODE ID

  static Future setPromoCodeID(int val) async => _preferences.setInt(promoCodeId, val);

  static int? getPromoCodeId() => _preferences.getInt(promoCodeId);

  static removePromoCodeId() => _preferences.remove(promoCodeId);
}
