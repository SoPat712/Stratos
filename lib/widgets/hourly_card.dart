import 'package:flutter/material.dart';
import 'package:Stratus/models/json/one_call.dart';
import 'package:Stratus/widgets/components/hourly_list.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard({Key? key, this.response}) : super(key: key);

  final Onecall? response;
  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(
                15,
                15,
                0,
                20,
              ),
              width: double.infinity,
              child: const Text(
                "Hourly Forecast",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            HourlyList(
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
