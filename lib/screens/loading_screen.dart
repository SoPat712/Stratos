// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stratos/widgets/icons/star.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  bool disposeCalled = false;

  @override
  void dispose() {
    disposeCalled = true;
    animationController!.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          animationController!.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    (!disposeCalled) ? animationController!.forward() : null;
  }

  List<Widget> makeStar(double width, double height) {
    double starsInRow = width / 50;
    double starsInColumn = height / 50;
    double starsNum = starsInRow != 0
        ? starsInRow * (starsInColumn != 0 ? starsInColumn : starsInRow)
        : starsInColumn;

    List<Widget> stars = [];
    var rng = Random();

    for (int i = 0; i < starsNum; i++) {
      stars.add(Star(
        top: rng.nextInt(height.floor()).toDouble(),
        right: rng.nextInt(width.floor()).toDouble(),
        animationController: animationController,
      ));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    if (disposeCalled == false) {
      Timer.periodic(
          const Duration(milliseconds: 500), (Timer t) => setAnimation());
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ...makeStar(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
          stratosLoadScreen(),
        ],
      ),
    );
  }

  Column stratosLoadScreen() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            stratosCloudIcon(),
            stratosLoadingIcon(),
          ],
        );
  }

  Expanded stratosCloudIcon() {
    return Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FlutterIcons.cloud_ant,
                    color: Colors.grey,
                    size: 100.0,
                  ),
                ],
              ),
            );
  }

  Expanded stratosLoadingIcon() {
    return Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SpinKitFoldingCube(
                    color: Colors.blue,
                    size: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                ],
              ),
            );
  }
}
