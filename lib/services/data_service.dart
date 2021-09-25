import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Stratus/models/json/one_call.dart';
import 'package:Stratus/services/networking.dart';
import 'package:Stratus/settings/shared_prefs.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class DataService {
  // ignore: prefer_typing_uninitialized_variables

  static var weatherData;
  static String unit = "";
  static Future<void> initialize() async {
    bool useImperial = await Settings.getValue("useImperial", true);
    unit = useImperial ? "metric" : "imperial";
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

    log("Temperature: " + json['current']['temp'].toString());
    var data = Onecall.fromJson(json);
    log("Temperature parsed: " + data.current!.temp.toString());
    weatherData = data;
  }
}
