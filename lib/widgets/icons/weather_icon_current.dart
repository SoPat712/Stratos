// ignore: import_of_legacy_library_into_null_safe
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:ih8clouds/models/json/one_call.dart';

class WeatherIconCurrent extends StatelessWidget {
  const WeatherIconCurrent({
    Key? key,
    required this.response,
  }) : super(key: key);

  final Onecall? response;

  @override
  Widget build(BuildContext context) {
    return Text(
      whichIcon(),
      style: const TextStyle(
        fontSize: 70,
      ),
    );
  }

  String whichIcon() {
    if (response!.current!.weather![0].icon == "01d") {
      return Emoji.byName("Sun").char;
    } else if (response!.current!.weather![0].icon == "02d") {
      return Emoji.byName("Sun behind Cloud").char;
    } else if (response!.current!.weather![0].icon == "03d") {
      return Emoji.byName("Sun behind small cloud").char;
    } else if (response!.current!.weather![0].icon == "04d") {
      return Emoji.byName("Sun behind large cloud").char;
    } else if (response!.current!.weather![0].icon == "09d") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.current!.weather![0].icon == "10d") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.current!.weather![0].icon == "11d") {
      return Emoji.byName("Cloud with Lightning").char;
    } else if (response!.current!.weather![0].icon == "13d") {
      return Emoji.byName("Snowflake").char;
    } else if (response!.current!.weather![0].icon == "50d") {
      return Emoji.byName("Fog").char;
    } else if (response!.current!.weather![0].icon == "01n") {
      return Emoji.byName("Waning Crescent Moon").char;
    } else if (response!.current!.weather![0].icon == "02n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.current!.weather![0].icon == "03n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.current!.weather![0].icon == "04n") {
      return Emoji.byName("Cloud").char;
    } else if (response!.current!.weather![0].icon == "09n") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.current!.weather![0].icon == "10n") {
      return Emoji.byName("Cloud with Rain").char;
    } else if (response!.current!.weather![0].icon == "11n") {
      return Emoji.byName("Cloud with Lightning").char;
    } else if (response!.current!.weather![0].icon == "13n") {
      return Emoji.byName("Snowflake").char;
    } else if (response!.current!.weather![0].icon == "50n") {
      return Emoji.byName("Fog").char;
    }
    return Emoji.byName("Warning").char;
  }
}
