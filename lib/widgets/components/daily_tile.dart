import 'package:flutter/material.dart';
import 'package:stratos/extensions/string_extension.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/services/temp.dart';
import 'package:stratos/services/time.dart';
import 'package:stratos/widgets/icons/weather_icon_daily.dart';

var someCapitalizedString = "someString".capitalize();

class DailyTile extends StatefulWidget {
  const DailyTile({Key? key, required this.response, required this.index})
      : super(key: key);

  final int index;
  final Onecall? response;

  @override
  State<DailyTile> createState() => _DailyTileState();
}

class _DailyTileState extends State<DailyTile> {
  String max = "";
  String min = "";
  @override
  Widget build(BuildContext context) {
    final String pop =
        (widget.response!.daily![widget.index].pop! * 100).toInt().toString();
    return FutureBuilder(
      future: getTimes(),
      builder: (context, snapshot) {
        return FittedBox(
          fit: BoxFit.cover,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                        widget.response!.daily![widget.index].dt,
                        widget.response!.timezoneOffset)
                    .weekday),
                style: const TextStyle(
                  fontFamily: 'Proxima',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                pop + "%",
                style: TextStyle(
                  fontFamily: 'Proxima',
                  color: Colors.grey.shade700,
                  fontSize: 10,
                ),
              ),
              SizedBox(
                height: 75,
                width: 75,
                child: WeatherIconDaily(
                  response: widget.response,
                  index: widget.index,
                ),
              ),
              Text(
                max,
                style: const TextStyle(
                  fontFamily: 'Proxima',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                min,
                style: const TextStyle(
                  fontFamily: 'Proxima',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getTimes() async {
    max = await TempHelper.getReadableTemp(
        widget.response!.daily![widget.index].temp!.max!.round().toString());
    min = await TempHelper.getReadableTemp(
        widget.response!.daily![widget.index].temp!.min!.round().toString());
  }
}
