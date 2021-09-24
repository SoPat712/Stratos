import 'package:flutter/material.dart';
import 'package:stratus/models/json/one_call.dart';
import 'package:stratus/widgets/components/hourly_tile.dart';

class HourlyList extends StatelessWidget {
  const HourlyList({Key? key, required this.response}) : super(key: key);

  final Onecall? response;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView(
        padding: const EdgeInsets.only(left: 5, right: 5),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
          25,
          (index) => HourlyTile(
            response: response,
            index: index,
          ),
        ),
      ),
    );
  }
}
