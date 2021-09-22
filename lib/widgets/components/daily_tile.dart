import 'package:flutter/material.dart';
import 'package:ih8clouds/extensions/string_extension.dart';
import 'package:ih8clouds/models/json/one_call.dart';
import 'package:ih8clouds/services/time.dart';
import 'package:ih8clouds/widgets/icons/weather_icon_daily.dart';

var someCapitalizedString = "someString".capitalize();

class DailyTile extends StatelessWidget {
  const DailyTile({Key? key, required this.response, required this.index})
      : super(key: key);

  final int index;
  final Onecall? response;

  @override
  Widget build(BuildContext context) {
    final String pop = (response!.daily![index].pop! * 100).toInt().toString();
    return FittedBox(
      fit: BoxFit.cover,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    response!.daily![index].dt, response!.timezoneOffset)
                .weekday),
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
            child: Align(
                alignment: Alignment.center,
                child: WeatherIconDaily(
                  response: response,
                  index: index,
                )),
          ),
          /*
          Image.network('https://openweathermap.org/img/wn/' +
              response!.daily![index].weather![0].icon! +
              '@2x.png'),*/
          Text(
            response!.daily![index].temp!.max!.round().toString() + "°F",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Text(
            response!.daily![index].temp!.min!.round().toString() + "°F",
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
