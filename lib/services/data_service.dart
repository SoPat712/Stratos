// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/models/pollution.dart';
import 'package:stratos/services/networking.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class DataService {
  static var weatherData;
  static var airQual;
  static String unit = "metric";
  static Future<void> initialize() async {
    bool useMetric = await Settings.getValue("useMetric", false);
    unit = useMetric ? "metric" : "imperial";
  }

  static Future<void> getAirQuality(double latitude, double longitude) async {
    await initialize();
    final String? appID = dotenv.env['OPENWEATHER_API_KEY'];
    //http://api.openweathermap.org/data/2.5/air_pollution?lat=40.3573&lon=-74.6672&appid=3a3f00a3acea6931dec0c9dff04ebc30
    final String url =
        "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=" +
            latitude.toString() +
            "&lon=" +
            longitude.toString() +
            "&appid=" +
            appID!;

    log('Air pollution url: ' + url);
    NetworkHelper networkHelper = NetworkHelper(url);

    var json = await networkHelper.getData();

    var data = Pollution.fromJson(json);
    log("Air quality parsed: " + data.listpol![0].components!.pm25.toString());
    airQual = data;
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

    log('Url: ' + url);
    NetworkHelper networkHelper = NetworkHelper(url);

    var json = await networkHelper.getData();

    var data = Onecall.fromJson(json);
    log("Temperature parsed: " + data.current!.temp.toString());
    weatherData = data;
  }
}
