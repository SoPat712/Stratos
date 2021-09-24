import 'package:flutter/material.dart';
import 'package:ih8clouds/extensions/string_extension.dart';
import 'package:ih8clouds/models/json/one_call.dart';
import 'package:ih8clouds/services/temp.dart';
import 'package:ih8clouds/services/time.dart';
import 'package:ih8clouds/widgets/icons/weather_icon_hourly.dart';

var someCapitalizedString = "someString".capitalize();

class HourlyTile extends StatelessWidget {
  const HourlyTile({Key? key, required this.response, required this.index})
      : super(key: key);

  final int index;
  final Onecall? response;
  @override
  Widget build(BuildContext context) {
    final String pop = (response!.hourly![index].pop! * 100).toInt().toString();
    return FittedBox(
      fit: BoxFit.cover,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            TimeHelper.getReadableTime(TimeHelper.getDateTimeSinceEpoch(
                response!.hourly![index].dt, response!.timezoneOffset)),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Text(
            pop + "%",
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 10,
            ),
          ),
          SizedBox(
              height: 75,
              width: 75,
              child: WeatherIconHourly(
                response: response,
                index: index,
              ),),
          Text(
            TempHelper.getReadableTemp(
                response!.hourly![index].temp!.round().toString()),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),

          //Text('Jun 28, 2018', style: new TextStyle(color: Colors.black)),
          //Text('18:30', style: new TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
