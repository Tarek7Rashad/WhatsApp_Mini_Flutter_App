import 'package:firebase_app/shared/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences2;
  static Future<void> init() async {
    sharedPreferences2 = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {required String key, required bool value}) async {
    return await sharedPreferences2.setBool(key, value);
  }

  static Future<bool> saveData(
      {required String key, required String value}) async {
    return await sharedPreferences2.setString(key, value);
  }

  static bool getData({
    required String key,
  }) {
    return sharedPreferences2.getBool(key) ?? false;
  }

  static String getData2({
    required String key,
  }) {
    return sharedPreferences2.getString(key) ?? '';
  }

  static clearData() async {
    return await sharedPreferences2.setString('uId', '');
  }
}

Future<void> setChangeAppMode(bool isDark) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isClicked', isDarkk);
}

Future<bool> getChangeAppMode() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool('isClicked') ?? false;
}
