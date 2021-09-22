import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ih8clouds/models/json/one_call.dart';
import 'package:ih8clouds/services/networking.dart';
import 'package:ih8clouds/settings/shared_prefs.dart';

bool imperial = true;
String unit = "";

class DataService {
  // ignore: prefer_typing_uninitialized_variables
  static var weatherData;

  static Future<void> getWeather(double latitude, double longitude) async {
    final String? appID = dotenv.env['OPENWEATHER_API_KEY'];
    imperial = await SharedPrefs.getImperial();
    if (imperial) {
      unit = "imperial";
    } else {
      unit = "metric";
    }
    final String url = "https://api.openweathermap.org/data/2.5/onecall?lat=" +
        latitude.toString() +
        "&lon=" +
        longitude.toString() +
        "&units=" +
        unit +
        "&exclude=minutely&appid=" +
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
