// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:stratos/widgets/icons/star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stratos/blocs/application_bloc.dart';
import 'package:stratos/extensions/time_extension.dart';
import 'package:stratos/models/json/one_call.dart';
import 'package:stratos/screens/settings_screen.dart';
import 'package:stratos/services/data_service.dart';
import 'package:stratos/widgets/body.dart';
import 'package:stratos/widgets/daily_card.dart';
import 'package:stratos/widgets/hourly_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  String cityName = "";
  String currentQuery = "testquery";
  bool disposeCalled = false;
  bool loading = false;
  StreamSubscription? locationSubscription;
  String previousCall = "";
  bool previousCallTypeCur = true;
  bool rendering = false;
  Timer? timer;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _start = 3;
  // ignore: unused_field
  Timer? _timer;

  @override
  void dispose() {
    disposeCalled = true;
    animationController!.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.setCurrentLocation();
    locationSubscription =
        applicationBloc.selectedLocation!.stream.listen((place) async {
      updateVars();
    });
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
    timer =
        Timer.periodic(const Duration(seconds: 600), (Timer t) => updateVars());
  }

  void updateVars() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    log("Latitude: " +
        applicationBloc.selectedLocationStatic!.geometry.location.lat
            .toString());
    log("Longitude: " +
        applicationBloc.selectedLocationStatic!.geometry.location.lng
            .toString());
    await DataService.getWeather(
        applicationBloc.selectedLocationStatic!.geometry.location.lat,
        applicationBloc.selectedLocationStatic!.geometry.location.lng);
    if (previousCallTypeCur) {
      cityName = applicationBloc.cityName;
    }
    log("City name: " + cityName);

    setState(() {});
  }

  void setAnimation() {
    (!disposeCalled) ? animationController!.forward() : null;
  }

  List<Widget> makeStar(double width, double height) {
    double starsInRow = width / 25;
    double starsInColumn = height / 25;
    double starsNum = starsInRow != 0
        ? starsInRow * (starsInColumn != 0 ? starsInColumn : starsInRow)
        : starsInColumn;

    List<Widget> stars = [];
    var rng = math.Random();

    for (int i = 0; i < starsNum; i++) {
      stars.add(Star(
        top: rng.nextInt(height.floor()).toDouble(),
        right: rng.nextInt(width.floor()).toDouble(),
        animationController: animationController,
      ));
    }

    return stars;
  }

  Widget futureWidget() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return FutureBuilder<Onecall?>(
      future: loadOneCall(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FloatingSearchBar(
            progress: rendering,
            clearQueryOnClose: true,
            body: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: FloatingSearchBarScrollNotifier(
                    child: RefreshIndicator(
                      displacement: 90,
                      onRefresh: () {
                        return Future.delayed(
                          const Duration(milliseconds: 1500),
                          () {
                            if (previousCallTypeCur) {
                              setState(() {
                                applicationBloc.setCurrentLocation();
                              });
                            } else {
                              setState(() {
                                applicationBloc
                                    .setSelectedLocation(previousCall);
                              });
                            }
                          },
                        );
                      },
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: Colors.transparent,
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                55,
                                0,
                                0,
                              ),
                            ),
                            Body(
                              date: DateTime.now().curTime(),
                              response: snapshot.data,
                            ),
                            DailyCard(
                              response: snapshot.data,
                            ),
                            HourlyCard(
                              response: snapshot.data,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            hint: cityName,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 46),
            transitionDuration: const Duration(milliseconds: 400),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: 0.0,
            openAxisAlignment: 0.0,
            hintStyle: const TextStyle(
              fontFamily: 'Proxima',
              fontSize: 16,
            ),
            queryStyle: const TextStyle(
              fontFamily: 'Proxima',
              fontSize: 16,
            ),
            //width: 600,
            //debounceDelay: const Duration(milliseconds: 1000),
            onQueryChanged: (query) async {
              loading = true;
              startTimer();
              applicationBloc.searchPlaces(query);
              currentQuery = query;
            },
            transition: SlideFadeFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: Icon(Icons.place, color: Colors.grey.shade800),
                  onPressed: () async {
                    rendering = true;
                    setState(() {});
                    previousCallTypeCur = true;
                    await applicationBloc.setCurrentLocation();
                    cityName = applicationBloc.cityName;
                    rendering = false;
                  },
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  child: (currentQuery.isNotEmpty &&
                          applicationBloc.searchResults != null)
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 0.2,
                              color: Colors.black38,
                              thickness: 0.3,
                              indent: 40,
                              endIndent: 15,
                            );
                          },
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              (applicationBloc.searchResults!.isNotEmpty &&
                                      loading == false)
                                  ? applicationBloc.searchResults!.length
                                  : 1,
                          itemBuilder: (context, index) {
                            return Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              actions: <Widget>[
                                IconSlideAction(
                                  caption: 'Pin',
                                  color: Colors.yellow,
                                  icon: Icons.pin,
                                  onTap: () => log('Pinned'),
                                ),
                              ],
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.white, width: 0),
                                ),
                                leading: (applicationBloc
                                            .searchResults!.isNotEmpty &&
                                        loading == false)
                                    ? Icon(
                                        Icons.place,
                                        color: Colors.grey.shade600,
                                      )
                                    : (loading == false)
                                        ? const Icon(Icons.error)
                                        : SizedBox(
                                            child: CircularProgressIndicator(
                                              color: Colors.blue.shade400,
                                            ),
                                            height: 32,
                                            width: 32,
                                          ),
                                title: (applicationBloc
                                            .searchResults!.isNotEmpty &&
                                        loading == false)
                                    ? Text(
                                        applicationBloc
                                            .searchResults![index].mainText,
                                        style: const TextStyle(
                                            fontFamily: 'Proxima',
                                            color: Colors.black),
                                      )
                                    : (loading == false)
                                        ? Text(
                                            "No results for \"" +
                                                currentQuery +
                                                "\"!",
                                            style: const TextStyle(
                                              fontFamily: 'Proxima',
                                              fontSize: 18,
                                            ),
                                          )
                                        : const Text(
                                            "Loading...",
                                            style: TextStyle(
                                              fontFamily: 'Proxima',
                                              fontSize: 18,
                                            ),
                                          ),
                                subtitle: (applicationBloc
                                            .searchResults!.isNotEmpty &&
                                        loading == false)
                                    ? Text(applicationBloc
                                        .searchResults![index].secondaryText)
                                    : null,
                                onTap: () async {
                                  rendering = true;
                                  setState(() {});
                                  previousCall = applicationBloc
                                      .searchResults![index].placeId;
                                  previousCallTypeCur = false;
                                  (applicationBloc.searchResults!.isNotEmpty)
                                      ? await applicationBloc
                                          .setSelectedLocation(applicationBloc
                                              .searchResults![index].placeId)
                                      : null;
                                  log(applicationBloc
                                      .searchResults![index].description);
                                  cityName = applicationBloc
                                      .searchResults![index].description;
                                  rendering = false;
                                  FloatingSearchBar.of(context)!.close();
                                },
                              ),
                            );
                          })
                      : ListView.builder(
                          padding: const EdgeInsets.all(0.0),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              shape: const ContinuousRectangleBorder(),
                              leading: const Icon(Icons.location_city),
                              title: const Text(
                                "Current Location",
                                style: TextStyle(
                                  fontFamily: 'Proxima',
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () async {
                                previousCallTypeCur = true;
                                //weatherCall();
                                rendering = true;
                                setState(() {});
                                log(rendering.toString());
                                await applicationBloc.setCurrentLocation();
                                cityName = applicationBloc.cityName;
                                rendering = false;
                                FloatingSearchBar.of(context)!.close();
                              },
                            );
                          }),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const LoadingScreen();
      },
    );
  }

  Future<Onecall?> loadOneCall() async {
    //await waitForASecond();
    return await DataService.weatherData;
  }

  //Future<void> waitForASecond() async {
  //  await Future.delayed(const Duration(seconds: 2), () {});
  //}

  void startTimer() {
    const oneSec = Duration(milliseconds: 1500);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            setState(() {
              loading = false;
              rendering = false;
            });
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  Future<void> toggleDrawer() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  Widget buildMap() {
    return Image.asset(
      'assets/sunny.jpg',
      fit: BoxFit.fitHeight,
    );
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => setAnimation());
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade700,
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: Drawer(
          // column holds all the widgets in the drawer
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    ...makeStar(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          FlutterIcons.cloud_ant,
                          color: Colors.grey.shade100,
                          size: 80.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                // ListView contains a group of widgets that scroll inside the drawer
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: const Text(
                        'Current Location',
                        style: TextStyle(
                          fontFamily: 'Proxima',
                        ),
                      ),
                      onTap: () async {
                        //weatherCall();
                        rendering = true;
                        previousCallTypeCur = true;

                        await applicationBloc.setCurrentLocation();
                        cityName = applicationBloc.cityName;

                        startTimer();
                        setState(() {
                          toggleDrawer();
                        });
                      },
                    ),
                  ],
                ),
              ),
              // This container holds the align
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Column(
                    children: <Widget>[
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'Proxima',
                          ),
                        ),
                        onTap: () {
                          toggleDrawer();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(
                                notifyParent: refresh,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
        body: futureWidget(),
      ),
    );
  }
}
