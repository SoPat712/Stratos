import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  //values for imperial

  static const String metricKey = "useMetric";

  static Future<bool> getMetric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(metricKey) ?? false;
    return value;
  }

  static Future<void> setMetric(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(metricKey, newValue);
  }

  //values  for dark mode

  static const String darkKey = "useDarkMode";

  static Future<bool> getDark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if value is none return false
    bool value = prefs.getBool(darkKey) ?? false;
    return value;
  }

  static Future<void> setDark(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkKey, newValue);
  }

  //values for 24h time

  static const String h24key = "use24h";

  static Future<bool> get24() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if value is none return false
    // ignore: unused_local_variable
    bool value = prefs.getBool(h24key) ?? false;
    return value;
  }

  static Future<void> set24(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(h24key, newValue);
  }

  //values for 24h time

  static const String updateDuration = "useUpdateDuration";

  static Future<int> getUpdateDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //if value is none return false
    // ignore: unused_local_variable
    int value = prefs.getInt(updateDuration) ?? 10;
    return value;
  }

  static Future<void> setUpdateDuration(int newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(updateDuration, newValue);
  }

  //values for wind unit

  static const String windKey = "windUnit";

  static Future<WindUnit> getWindUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    WindUnit unit = WindUnit.values[prefs.getInt(windKey) ?? 0];
    return unit;
  }

  static Future<void> setWindUnit(WindUnit unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(windKey, unit.index);
    log(unit.toString());
  }

  //values for language

  static const String langKey = "languageCode";

  static Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(langKey) ?? "en";
    return code;
  }

  static Future<void> setLanguageCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, code);
    log(code.toString());
  }

  //values for custom owm api key

  static const String owmKey = "openWeatherKey";

  static Future<String> getOpenWeatherAPIKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString(owmKey) ?? "";
    return code;
  }

  static Future<void> setOpenWeatherAPIKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(owmKey, key);
    log(key.toString());
  }

  //values for custom owm api key

  static const String disclaimerRead = "discRead";

  static const String defaultLocationKey = "defaultLocationKey";

  static Future<List> getDefaultLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? location = prefs.getStringList(defaultLocationKey);

    if (location != null) {
      return [
        location[0],
        double.parse(location[1]),
        double.parse(location[2])
      ];
    }
    return ["Use a default location on app startup."];
  }

  static Future<void> setDefaultLocation({
    required String text,
    required double lat,
    required double long,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        defaultLocationKey, [text, lat.toString(), long.toString()]);
  }

  static Future<void> setHome(
      {required String myHomeId,
      required String myHomeFullName,
      required String myHomeMainText,
      required String myHomeSecondaryText}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("homeFullName", myHomeFullName);
    await prefs.setString("homeID", myHomeId);
    await prefs.setString("homeMainText", myHomeMainText);
    await prefs.setString("homeSecondaryText", myHomeSecondaryText);
    log("Home set");
  }

  static Future<String> getHomeFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString("homeFullName") ?? "";
    return code;
  }
  static Future<String> getHomeID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString("homeID") ?? "";
    return code;
  }
  static Future<String> getHomeMainText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString("homeMainText") ?? "";
    return code;
  }
  static Future<String> getHomeSecondaryText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String code = prefs.getString("homeSecondaryText") ?? "";
    return code;
  }

  static Future<void> removeDefaultLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(defaultLocationKey);
  }
}

enum WindUnit {
  mS,
  mPH,
  kMPH,
}
