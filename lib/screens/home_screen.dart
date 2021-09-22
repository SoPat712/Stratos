import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ih8clouds/blocs/application_bloc.dart';
import 'package:ih8clouds/extensions/time_extension.dart';
import 'package:ih8clouds/models/json/one_call.dart';
import 'package:ih8clouds/models/location/place.dart';
import 'package:ih8clouds/screens/settings_screen.dart';
import 'package:ih8clouds/services/data_service.dart';
import 'package:ih8clouds/widgets/body.dart';
import 'package:ih8clouds/widgets/daily_card.dart';
import 'package:ih8clouds/widgets/hourly_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Placemark>? cityName;
  String currentQuery = "testquery";
  bool loading = false;
  StreamSubscription? locationSubscription;
  Place? placeSet;
  bool populated = false;
  String previousCall = "";
  bool previousCallTypeCur = true;
  bool rendering = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _start = 3;
  // ignore: unused_field
  Timer? _timer;

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    locationSubscription =
        applicationBloc.selectedLocation!.stream.listen((place) async {
      log("Latitude: " + place.geometry.location.lat.toString());
      log("Longitude: " + place.geometry.location.lng.toString());
      cityName = await placemarkFromCoordinates(
          place.geometry.location.lat, place.geometry.location.lng);
      await DataService.getWeather(
          applicationBloc.selectedLocationStatic!.geometry.location.lat,
          applicationBloc.selectedLocationStatic!.geometry.location.lng);
      setState(() {});
    });
    super.initState();
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
                buildMap(),
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
                            /*
                Padding(
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
                      children: const <Widget>[
                        SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Text(
                              "asdf",
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
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
                      children: const <Widget>[
                        SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Text(
                              "asdf",
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
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
                      children: const <Widget>[
                        SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: Text(
                              "asdf",
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                  ),
                ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            hint: applicationBloc.cityName,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 46),
            transitionDuration: const Duration(milliseconds: 400),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: 0.0,
            openAxisAlignment: 0.0,
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
                  onPressed: () {
                    //weatherCall();
                    rendering = true;
                    applicationBloc.setCurrentLocation();
                    setState(() {
                      startTimer();
                    });
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
                                            color: Colors.black),
                                      )
                                    : (loading == false)
                                        ? Text("No results for \"" +
                                            currentQuery +
                                            "\"!")
                                        : const Text("Loading..."),
                                subtitle: (applicationBloc
                                            .searchResults!.isNotEmpty &&
                                        loading == false)
                                    ? Text(applicationBloc
                                        .searchResults![index].secondaryText)
                                    : null,
                                onTap: () {
                                  rendering = true;
                                  startTimer();
                                  setState(() {});
                                  previousCall = applicationBloc
                                      .searchResults![index].placeId;
                                  previousCallTypeCur = false;
                                  (applicationBloc.searchResults!.isNotEmpty)
                                      ? applicationBloc.setSelectedLocation(
                                          applicationBloc
                                              .searchResults![index].placeId)
                                      : null;
                                  log(applicationBloc
                                      .searchResults![index].description);

                                  Future.delayed(
                                      const Duration(milliseconds: 1500), () {
                                    FloatingSearchBar.of(context)!.close();
                                  });
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
                              title: const Text("Current Location"),
                              onTap: () {
                                previousCallTypeCur = true;
                                //weatherCall();
                                rendering = true;
                                startTimer();
                                setState(() {});
                                log(rendering.toString());
                                applicationBloc.setCurrentLocation();

                                Future.delayed(
                                    const Duration(milliseconds: 1500), () {
                                  FloatingSearchBar.of(context)!.close();
                                });
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
      'assets/cloudy.jpg',
      fit: BoxFit.fitHeight,
    );
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: const <Widget>[
                    Text('IH8Clouds'),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('Current Location'),
                onTap: () {
                  //weatherCall();
                  rendering = true;
                  applicationBloc.setCurrentLocation();
                  startTimer();
                  setState(() {
                    toggleDrawer();
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
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
          ),
        ),
        body: futureWidget(),
      ),
    );
  }
}
