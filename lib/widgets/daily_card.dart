import 'package:flutter/material.dart';
import 'package:Stratus/models/json/one_call.dart';
import 'package:Stratus/services/time.dart';
import 'package:Stratus/widgets/components/daily_list.dart';
import 'package:weather_icons/weather_icons.dart';

class DailyCard extends StatelessWidget {
  const DailyCard({Key? key, this.response}) : super(key: key);

  final Onecall? response;
  @override
  Widget build(BuildContext context) {
    final timeIcon = TimeIcon.fromDate(TimeHelper.getDateTimeSinceEpoch(
        response!.current!.dt, response!.timezoneOffset));
    return Container(
      padding: const EdgeInsets.fromLTRB(
        2.5,
        0,
        2.5,
        2.5,
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              leading: BoxedIcon(
                timeIcon,
              ),
              title: Text(
                "Refreshed at " +
                    TimeHelper.getReadableTime(TimeHelper.getDateTimeSinceEpoch(
                        response!.current!.dt, response!.timezoneOffset)),
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                18,
                0,
                0,
                25,
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
              response: response,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
            )
          ],
        ),
      ),
    );
  }
}
