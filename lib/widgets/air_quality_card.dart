import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/models/pollution.dart';
import 'package:stratos/services/time.dart';

class AirQualityCard extends StatefulWidget {
  AirQualityCard({Key? key, this.response, this.oneCall}) : super(key: key);

  Pollution? response;
  Onecall? oneCall;
  @override
  State<StatefulWidget> createState() => AirQualityCardState();
}

class AirQualityCardState extends State<AirQualityCard> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 5;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 =
        makeGroupData(0, widget.response!.listpol![0].components!.pm25!, 12);
    final barGroup2 =
        makeGroupData(1, widget.response!.listpol![1].components!.pm25!, 12);
    final barGroup3 =
        makeGroupData(2, widget.response!.listpol![2].components!.pm25!, 5);
    final barGroup4 =
        makeGroupData(3, widget.response!.listpol![3].components!.pm25!, 16);
    final barGroup5 =
        makeGroupData(4, widget.response!.listpol![4].components!.pm25!, 6);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Transactions',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'state',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: barTouchData,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: titleGetter,
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 8,
                        reservedSize: 28,
                        interval: 1,
                        getTitles: (value) {
                          if (value == 0) {
                            return '0';
                          } else if (value == 10) {
                            return '5';
                          } else if (value == 20) {
                            return '10';
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
  String titleGetter(double value) {
    switch (value.toInt()) {
      case 0:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 1:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 2:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 3:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 4:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 5:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      case 6:
        return TimeHelper.getWeekdayAsString(TimeHelper.getDateTimeSinceEpoch(
                    widget.oneCall!.daily![value.toInt()].dt,
                    widget.oneCall!.timezoneOffset)
                .weekday)
            .substring(0, 3);
      default:
        return '';
    }
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          y: y1,
          colors: [leftBarColor],
          width: width,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
