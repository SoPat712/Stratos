// ignore: unused_import
import 'dart:developer';

// ignore: import_of_legacy_library_into_null_safe
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:Stratus/models/json/one_call.dart';

class WeatherIconHourly extends StatelessWidget {
  const WeatherIconHourly(
      {Key? key, required this.response, required this.index})
      : super(key: key);

  final int index;
  final Onecall? response;

  whichIconImage() {
    if (response!.hourly![index].weather![0].icon == "01d") {
      return Image.asset("assets/weather_icons/clearsky_day.png");
    } else if (response!.hourly![index].weather![0].icon == "02d") {
      return Image.asset("assets/weather_icons/fair_day.png");
    } else if (response!.hourly![index].weather![0].icon == "03d") {
      return Image.asset("assets/weather_icons/partlycloudy_day.png");
    } else if (response!.hourly![index].weather![0].icon == "04d" &&
        response!.hourly![index].weather![0].id.toString() == "803") {
      return Image.asset("assets/weather_icons/partlycloudy_day.png");
    } else if (response!.hourly![index].weather![0].icon == "04d" &&
        response!.hourly![index].weather![0].id.toString() == "804") {
      return Image.asset("assets/weather_icons/cloudy.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "300") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "301") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "302") {
      return Image.asset("assets/weather_icons/heavyrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "310") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "311") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "312") {
      return Image.asset("assets/weather_icons/heavyrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "313") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "314") {
      return Image.asset("assets/weather_icons/heavyrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "321") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "520") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "521") {
      return Image.asset("assets/weather_icons/lightrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "522") {
      return Image.asset("assets/weather_icons/heavyrainshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "09d" &&
        response!.hourly![index].weather![0].id.toString() == "531") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10d" &&
        response!.hourly![index].weather![0].id.toString() == "500") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10d" &&
        response!.hourly![index].weather![0].id.toString() == "501") {
      return Image.asset("assets/weather_icons/rain.png");
    } else if (response!.hourly![index].weather![0].icon == "10d" &&
        response!.hourly![index].weather![0].id.toString() == "502") {
      return Image.asset("assets/weather_icons/heavyrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10d" &&
        response!.hourly![index].weather![0].id.toString() == "503") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10d" &&
        response!.hourly![index].weather![0].id.toString() == "504") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "200") {
      return Image.asset(
          "assets/weather_icons/lightrainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "201") {
      return Image.asset("assets/weather_icons/rainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "202") {
      return Image.asset(
          "assets/weather_icons/heavyrainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "210") {
      return Image.asset("assets/weather_icons/lightrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "211") {
      return Image.asset("assets/weather_icons/rainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "212") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "221") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "230") {
      return Image.asset(
          "assets/weather_icons/lightrainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "231") {
      return Image.asset("assets/weather_icons/rainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "11d" &&
        response!.hourly![index].weather![0].id.toString() == "232") {
      return Image.asset(
          "assets/weather_icons/heavyrainshowersandthunder_day.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "511") {
      return Image.asset("assets/weather_icons/lightsleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "600") {
      return Image.asset("assets/weather_icons/lightsnow.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "601") {
      return Image.asset("assets/weather_icons/snow.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "602") {
      return Image.asset("assets/weather_icons/heavysnow.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "611") {
      return Image.asset("assets/weather_icons/sleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "612") {
      return Image.asset("assets/weather_icons/lightsleetshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "613") {
      return Image.asset("assets/weather_icons/sleetshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "615") {
      return Image.asset("assets/weather_icons/lightsleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "616") {
      return Image.asset("assets/weather_icons/sleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "620") {
      return Image.asset("assets/weather_icons/lightsnowshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "621") {
      return Image.asset("assets/weather_icons/snowshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "13d" &&
        response!.hourly![index].weather![0].id.toString() == "622") {
      return Image.asset("assets/weather_icons/heavysnowshowers_day.png");
    } else if (response!.hourly![index].weather![0].icon == "50d") {
      return Image.asset("assets/weather_icons/fog.png");
    } else if (response!.hourly![index].weather![0].icon == "01n") {
      return Image.asset("assets/weather_icons/clearsky_night.png");
    } else if (response!.hourly![index].weather![0].icon == "02n") {
      return Image.asset("assets/weather_icons/fair_night.png");
    } else if (response!.hourly![index].weather![0].icon == "03n") {
      return Image.asset("assets/weather_icons/partlycloudy_night.png");
    } else if (response!.hourly![index].weather![0].icon == "04n" &&
        response!.hourly![index].weather![0].id.toString() == "803") {
      return Image.asset("assets/weather_icons/partlycloudy_night.png");
    } else if (response!.hourly![index].weather![0].icon == "04n" &&
        response!.hourly![index].weather![0].id.toString() == "804") {
      return Image.asset("assets/weather_icons/cloudy.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "300") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "301") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "302") {
      return Image.asset("assets/weather_icons/heavyrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "310") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "311") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "312") {
      return Image.asset("assets/weather_icons/heavyrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "313") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "314") {
      return Image.asset("assets/weather_icons/heavyrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "321") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "520") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "521") {
      return Image.asset("assets/weather_icons/lightrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "522") {
      return Image.asset("assets/weather_icons/heavyrainshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "09n" &&
        response!.hourly![index].weather![0].id.toString() == "531") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10n" &&
        response!.hourly![index].weather![0].id.toString() == "500") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10n" &&
        response!.hourly![index].weather![0].id.toString() == "501") {
      return Image.asset("assets/weather_icons/rain.png");
    } else if (response!.hourly![index].weather![0].icon == "10n" &&
        response!.hourly![index].weather![0].id.toString() == "502") {
      return Image.asset("assets/weather_icons/heavyrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10n" &&
        response!.hourly![index].weather![0].id.toString() == "503") {
      return Image.asset("assets/weather_icons/lightrain.png");
    } else if (response!.hourly![index].weather![0].icon == "10n" &&
        response!.hourly![index].weather![0].id.toString() == "504") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "200") {
      return Image.asset(
          "assets/weather_icons/lightrainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "201") {
      return Image.asset(
          "assets/weather_icons/rainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "202") {
      return Image.asset(
          "assets/weather_icons/heavyrainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "210") {
      return Image.asset("assets/weather_icons/lightrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "211") {
      return Image.asset("assets/weather_icons/rainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "212") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "221") {
      return Image.asset("assets/weather_icons/heavyrainandthunder.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "230") {
      return Image.asset(
          "assets/weather_icons/lightrainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "231") {
      return Image.asset(
          "assets/weather_icons/rainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "11n" &&
        response!.hourly![index].weather![0].id.toString() == "232") {
      return Image.asset(
          "assets/weather_icons/heavyrainshowersandthunder_night.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "511") {
      return Image.asset("assets/weather_icons/lightsleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "600") {
      return Image.asset("assets/weather_icons/lightsnow.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "601") {
      return Image.asset("assets/weather_icons/snow.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "602") {
      return Image.asset("assets/weather_icons/heavysnow.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "611") {
      return Image.asset("assets/weather_icons/sleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "612") {
      return Image.asset("assets/weather_icons/lightsleetshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "613") {
      return Image.asset("assets/weather_icons/sleetshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "615") {
      return Image.asset("assets/weather_icons/lightsleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "616") {
      return Image.asset("assets/weather_icons/sleet.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "620") {
      return Image.asset("assets/weather_icons/lightsnowshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "621") {
      return Image.asset("assets/weather_icons/snowshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "13n" &&
        response!.hourly![index].weather![0].id.toString() == "622") {
      return Image.asset("assets/weather_icons/heavysnowshowers_night.png");
    } else if (response!.hourly![index].weather![0].icon == "50n") {
      return Image.asset("assets/weather_icons/fog.png");
    }
  }

  String whichIcon() {
    if (response!.hourly![index].weather![0].icon == "01d") {
      return Emoji.byName("Sun").char;
    } else if (response!.hourly![index].weather![0].icon == "02d") {
      return Emoji.byName("Sun behind Cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "03d") {
      return Emoji.byName("Sun behind small cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "04d") {
      return Emoji.byName("Sun behind large cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "09d") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.hourly![index].weather![0].icon == "10d") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.hourly![index].weather![0].icon == "11d") {
      return Emoji.byName("Cloud with Lightning").char;
    } else if (response!.hourly![index].weather![0].icon == "13d") {
      return Emoji.byName("Snowflake").char;
    } else if (response!.hourly![index].weather![0].icon == "50d") {
      return Emoji.byName("Fog").char;
    } else if (response!.hourly![index].weather![0].icon == "01n") {
      return Emoji.byName("Waxing Gibbous Moon").char;
    } else if (response!.hourly![index].weather![0].icon == "02n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "03n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "04n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.hourly![index].weather![0].icon == "09n") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.hourly![index].weather![0].icon == "10n") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.hourly![index].weather![0].icon == "11n") {
      return Emoji.byName("Cloud with Lightning").char;
    } else if (response!.hourly![index].weather![0].icon == "13n") {
      return Emoji.byName("Snowflake").char;
    } else if (response!.hourly![index].weather![0].icon == "50n") {
      return Emoji.byName("Fog").char;
    }
    return Emoji.byName("Warning").char;
  }

  @override
  Widget build(BuildContext context) {
    return //Text(
        whichIconImage();
    //  style: const TextStyle(
    //    fontSize: 35,
    //  ),
    //);
  }
}
