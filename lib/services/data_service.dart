// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/services/networking.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class DataService {
  static var weatherData;
  static String unit = "metric";
  static Future<void> initialize() async {
    bool useMetric = await Settings.getValue("useMetric", false);
    unit = useMetric ? "metric" : "imperial";
  }

  static Future<void> getWeather(double latitude, double longitude) async {
    await initialize();
    final String? appID = dotenv.env['OPENWEATHER_API_KEY'];
    final String url = "https://api.openweathermap.org/data/2.5/onecall?lat=" +
        latitude.toString() +
        "&lon=" +
        longitude.toString() +
        "&units=$unit&exclude=minutely&appid=" +
        appID!;

    log("Url: " + url);
    NetworkHelper networkHelper = NetworkHelper(url);

    var json = await networkHelper.getData();

    var data = Onecall.fromJson(json);
    log("Temperature parsed: " + data.current!.temp.toString());
    weatherData = data;
  }
}
