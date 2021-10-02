import 'package:flutter/material.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/services/time.dart';
import 'package:stratos/widgets/components/daily_list.dart';
import 'package:weather_icons/weather_icons.dart';

class DailyCard extends StatefulWidget {
  const DailyCard({Key? key, this.response}) : super(key: key);

  final Onecall? response;

  @override
  State<DailyCard> createState() => _DailyCardState();
}

class _DailyCardState extends State<DailyCard> {
  String refreshTime = "";

  @override
  Widget build(BuildContext context) {
    final timeIcon = TimeIcon.fromDate(TimeHelper.getDateTimeSinceEpoch(
        widget.response!.current!.dt, widget.response!.timezoneOffset));
    return FutureBuilder(
        future: getTimes(),
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.fromLTRB(
              2.5,
              0,
              2.5,
              2.5,
            ),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                children: [/*
                  ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 12.0),
                    leading: BoxedIcon(
                      timeIcon,
                    ),
                    title: Text(
                      "Refreshed at " + refreshTime,
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),*/
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      15,
                      0,
                      20,
                    ),
                    width: double.infinity,
                    child: const Text(
                      "Daily Forecast",
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  DailyList(
                    response: widget.response,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                  )
                ],
              ),
            ),
          );
        });
  }

  getTimes() async {
    refreshTime = await TimeHelper.getReadableTime(
        TimeHelper.getDateTimeSinceEpoch(
            widget.response!.current!.dt, widget.response!.timezoneOffset));
  }
}
