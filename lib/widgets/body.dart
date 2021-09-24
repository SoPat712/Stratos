import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:stratus/extensions/string_extension.dart';
import 'package:stratus/models/json/one_call.dart';
import 'package:stratus/widgets/icons/weather_icon_current.dart';

var someCapitalizedString = "someString".capitalize();

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.date,
    required this.response,
  }) : super(key: key);

  final String date;
  final Onecall? response;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 377,
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "High ${response!.daily![0].temp!.max.toString()}°  |  Low ${response!.daily![0].temp!.min.toString()}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "${response!.current!.temp.toString()}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 80,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                width: 120,
                height: 120,
                child: Align(
                  alignment: Alignment.center,
                  child: WeatherIconCurrent(
                    response: response,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Feels like ${response!.current!.feelsLike!.toStringAsFixed(1)}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  response!.current!.weather![0].description
                      .toString()
                      .capitalize(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
