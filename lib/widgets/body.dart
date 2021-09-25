import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:Stratus/extensions/string_extension.dart';
import 'package:Stratus/models/json/one_call.dart';
import 'package:Stratus/widgets/icons/weather_icon_current.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                child: Text(
                  "High ${response!.daily![0].temp!.max.toString()}°  |  Low ${response!.daily![0].temp!.min.toString()}°",
                  style: const TextStyle(
                    fontFamily: 'Proxima',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
              Container(
                child: Text(
                  "${response!.current!.temp.toString()}°",
                  style: const TextStyle(
                    fontFamily: 'Proxima',
                    color: Colors.white,
                    fontSize: 80,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
              Container(
                child: Text(
                  "Feels like ${response!.current!.feelsLike!.toStringAsFixed(1)}°",
                  style: const TextStyle(
                    fontFamily: 'Proxima',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontFamily: 'Proxima',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 35, 0, 0)),
              Container(
                width: 130,
                height: 130,
                child: Align(
                  alignment: Alignment.center,
                  child: WeatherIconCurrent(
                    response: response,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
              Container(
                child: Text(
                  response!.current!.weather![0].description
                      .toString()
                      .capitalize(),
                  style: const TextStyle(
                    fontFamily: 'Proxima',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
