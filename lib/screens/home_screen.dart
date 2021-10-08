// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stratos/models/pollution.dart';
import 'package:stratos/services/places_service.dart';
import 'package:stratos/widgets/air_quality_card.dart';
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  AnimationController? animationController;
  String cityName = "";
  SharedPreferences? prefs;
  String currentQuery = "";
  bool disposeCalled = false;
  bool homeSet = true;
  bool loading = false;
  StreamSubscription? locationSubscription;
  String myHomeFullName = "";
  String myHomeId = "";
  String myHomeMainText = "";
  int indexrem = 0;
  String myHomeSecondaryText = "";
  List<String> myPlacesFullName = [];
  List<String> myPlacesIds = [];
  List<String> myPlacesMainText = [];
  List<String> myPlacesSecondaryText = [];
  PlacesService places = PlacesService();
  String previousCall = "";
  bool previousCallTypeCur = false;
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

  Future<void> setPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return;
  }

  @override
  void initState() {
    super.initState();
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    locationSubscription = applicationBloc.selectedLocation!.stream.listen(
      (place) async {
        updateVars();
      },
    );

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    initUpdateVars();
    timer =
        Timer.periodic(const Duration(seconds: 600), (Timer t) => updateVars());
  }

  void initUpdateVars() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await setPrefs();
    _getHome();
    _getList();
    if (myHomeId != "") {
      homeSet = true;
      previousCallTypeCur = false;
      homeLocationCall();
    } else if (previousCallTypeCur) {
      previousCallTypeCur = true;

      currentLocationCall();
    }
    log(
        "Latitude: " +
            applicationBloc.selectedLocationStatic!.geometry.location.lat
                .toString(),
        level: 0);
    log(
        "Longitude: " +
            applicationBloc.selectedLocationStatic!.geometry.location.lng
                .toString(),
        level: 0);
    await DataService.getWeather(
        applicationBloc.selectedLocationStatic!.geometry.location.lat,
        applicationBloc.selectedLocationStatic!.geometry.location.lng);
    await DataService.getAirQuality(
        applicationBloc.selectedLocationStatic!.geometry.location.lat,
        applicationBloc.selectedLocationStatic!.geometry.location.lng);
    log("City name: " + cityName);
    setState(
      () {},
    );
  }

  void updateVars() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    log(
        "Latitude: " +
            applicationBloc.selectedLocationStatic!.geometry.location.lat
                .toString(),
        level: 0);
    log(
        "Longitude: " +
            applicationBloc.selectedLocationStatic!.geometry.location.lng
                .toString(),
        level: 0);
    await DataService.getWeather(
        applicationBloc.selectedLocationStatic!.geometry.location.lat,
        applicationBloc.selectedLocationStatic!.geometry.location.lng);
    await DataService.getAirQuality(
        applicationBloc.selectedLocationStatic!.geometry.location.lat,
        applicationBloc.selectedLocationStatic!.geometry.location.lng);
    log("City name: " + cityName);

    setState(
      () {},
    );
  }

  void currentLocationCall() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    await applicationBloc.setCurrentLocation();
    cityName = applicationBloc.cityName;
  }

  void homeLocationCall() async {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    cityName = myHomeFullName;
    await applicationBloc.setSelectedLocationNoSearch(myHomeId);
  }

  void _saveList() async {
    prefs!.setStringList("placesFullName", myPlacesFullName);
    prefs!.setStringList("placesIds", myPlacesIds);
    prefs!.setStringList("placesMainText", myPlacesMainText);
    prefs!.setStringList("placesSecondaryText", myPlacesSecondaryText);
    log("List Saved");
    return;
  }

  Future<void> _getHome() async {
    myHomeFullName = prefs!.getString("homeFullName")!;
    myHomeId = prefs!.getString("homeID")!;
    myHomeMainText = prefs!.getString("homeMainText")!;
    myHomeSecondaryText = prefs!.getString("homeSecondaryText")!;
    setState(() {});
    return;
  }

  void _saveHome() async {
    prefs!.setString("homeFullName", myHomeFullName);
    prefs!.setString("homeID", myHomeId);
    prefs!.setString("homeMainText", myHomeMainText);
    prefs!.setString("homeSecondaryText", myHomeSecondaryText);
    return;
  }

  Future<void> _getList() async {
    myPlacesFullName = prefs!.getStringList("placesFullName")!;
    myPlacesIds = prefs!.getStringList("placesIds")!;
    myPlacesMainText = prefs!.getStringList("placesMainText")!;
    myPlacesSecondaryText = prefs!.getStringList("placesSecondaryText")!;
    setState(() {});
    return;
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
                              setState(
                                () {
                                  applicationBloc.setCurrentLocation();
                                },
                              );
                            } else if (homeSet) {
                              applicationBloc
                                  .setSelectedLocationNoSearch(myHomeId);
                            } else {
                              setState(
                                () {
                                  applicationBloc.setSelectedLocationNoSearch(
                                      previousCall);
                                },
                              );
                            }
                          },
                        );
                      },
                      child: stratosMainScreen(snapshot),
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
            onQueryChanged: (query) async {
              loading = true;
              currentQuery = query;
              await applicationBloc.searchPlaces(query);
              startTimer();
              setState(() {});
            },
            transition: SlideFadeFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: Icon(Icons.place, color: Colors.grey.shade800),
                  onPressed: () async {
                    rendering = true;
                    setState(
                      () {},
                    );
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
                  child: (currentQuery.isEmpty)
                      ? emptyQueryListView()
                      : (currentQuery.isNotEmpty && loading == true)
                          ? loadingListView()
                          : (currentQuery.isNotEmpty &&
                                  applicationBloc.searchResults!.isNotEmpty)
                              ? placesListView()
                              : noResultsListView(),
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

  Widget noResultsListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
          ),
          leading: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          title: Text(
            "No results for \"" + currentQuery + "\"!",
            style: const TextStyle(
              fontFamily: 'Proxima',
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  Widget emptyQueryListView() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
          ),
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
            rendering = true;
            setState(
              () {},
            );
            log(rendering.toString());
            await applicationBloc.setCurrentLocation();
            cityName = applicationBloc.cityName;
            rendering = false;
            FloatingSearchBar.of(context)!.close();
          },
        );
      },
    );
  }

  Widget placesListView() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return ListView.separated(
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
      itemCount: applicationBloc.searchResults!.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: const SlidableDrawerActionPane(),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Pin',
              color: Colors.yellow,
              icon: Icons.pin,
              onTap: () async {
                if (myPlacesIds
                    .contains(applicationBloc.searchResults![index].placeId)) {
                } else {
                  myPlacesIds
                      .add(applicationBloc.searchResults![index].placeId);
                  myPlacesMainText
                      .add(applicationBloc.searchResults![index].mainText);
                  myPlacesSecondaryText
                      .add(applicationBloc.searchResults![index].secondaryText);
                  myPlacesFullName
                      .add(applicationBloc.searchResults![index].description);
                  _saveList();
                  setState(
                    () {},
                  );
                }
              },
            ),
          ],
          child: ListTile(
            trailing: ((myPlacesIds.contains(
                        applicationBloc.searchResults![index].placeId)) &&
                    (loading == false))
                ? const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : const Icon(
                    Icons.arrow_left,
                    color: Colors.black,
                  ),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 0),
            ),
            leading: Icon(
              Icons.place,
              color: Colors.grey.shade600,
            ),
            title: Text(
              applicationBloc.searchResults![index].mainText,
              style:
                  const TextStyle(fontFamily: 'Proxima', color: Colors.black),
            ),
            subtitle: Text(applicationBloc.searchResults![index].secondaryText),
            onTap: () async {
              rendering = true;
              setState(
                () {},
              );
              previousCall = applicationBloc.searchResults![index].placeId;
              homeSet = false;
              previousCallTypeCur = false;
              (applicationBloc.searchResults!.isNotEmpty)
                  ? await applicationBloc.setSelectedLocation(
                      applicationBloc.searchResults![index].placeId)
                  : null;
              log(applicationBloc.searchResults![index].description);
              cityName = applicationBloc.searchResults![index].description;

              rendering = false;
              FloatingSearchBar.of(context)!.close();
            },
          ),
        );
      },
    );
  }

  Widget stratosMainScreen(AsyncSnapshot<Onecall?> snapshot) {
    return GlowingOverscrollIndicator(
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
          HourlyCard(
            response: snapshot.data,
          ),
          DailyCard(
            response: snapshot.data,
          ),
          FutureBuilder<Pollution>(
              future: loadAirPol(),
              builder: (context, snapshot2) {
                return AirQualityCard(
                  response: snapshot2.data,
                  oneCall: snapshot.data,
                );
              })
        ],
      ),
    );
  }

  Widget loadingListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 0),
          ),
          leading: SizedBox(
            child: CircularProgressIndicator(
              color: Colors.blue.shade400,
            ),
            height: 32,
            width: 32,
          ),
          title: const Text(
            "Loading...",
            style: TextStyle(
              fontFamily: 'Proxima',
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  Future<Onecall?> loadOneCall() async {
    return await DataService.weatherData;
  }

  Future<Pollution> loadAirPol() async {
    return await DataService.airQual;
  }

  Future<void> waitForASecond() async {
    await Future.delayed(
      const Duration(milliseconds: 5000),
      () {},
    );
  }

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            setState(
              () {
                loading = false;
                rendering = false;
              },
            );
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

  void refresh() {
    setState(
      () {},
    );
  }

  Align stratosSettingsTile(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: <Widget>[
          const Divider(
            height: 0,
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(
              14,
              2,
              14,
              2,
            ),
            trailing: const Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Proxima',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    notifyParent: refresh,
                  ),
                ),
              );
              toggleDrawer();
            },
          ),
        ],
      ),
    );
  }

  Container stratosSavedLocationTile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
        child: Text(
          "Pinned Locations",
          style: TextStyle(
            fontFamily: 'Proxima',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Container stratosMoreTile(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
        child: Text(
          "More",
          style: TextStyle(
            fontFamily: 'Proxima',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget stratosHeader(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(0.0),
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
    );
  }

  Widget _buildLocList() {
    return AnimatedList(
      key: _listKey,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      initialItemCount: myPlacesIds.length,
      controller: scrollController,
      itemBuilder: (context, index, animation) {
        if (index < myPlacesMainText.length) {
          return _buildLocTile(context, index, animation);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLocTileOutAnimate(BuildContext context, animation,
      String mainText, String secText, bool isHome) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: ListTile(
        trailing: (isHome) ? const Icon(Icons.home) : null,
        title: Text(
          mainText,
          style: const TextStyle(
            fontFamily: 'Proxima',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          secText,
          style: const TextStyle(
            fontFamily: 'Proxima',
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildLocTile(BuildContext context, int index, animation) {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: ListTile(
        onLongPress: () {
          showSheet(context, index);
        },
        trailing:
            (myPlacesIds[index] == myHomeId) ? const Icon(Icons.home) : null,
        title: Text(
          (index >= myPlacesMainText.length) ? "" : myPlacesMainText[index],
          style: const TextStyle(
            fontFamily: 'Proxima',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          (index >= myPlacesSecondaryText.length)
              ? ""
              : myPlacesSecondaryText[index],
          style: const TextStyle(
            fontFamily: 'Proxima',
            fontSize: 15,
          ),
        ),
        onTap: () async {
          previousCall = myPlacesIds[index];
          previousCallTypeCur = false;
          if (myHomeId == myPlacesIds[index]) {
            homeSet = true;
            previousCallTypeCur = false;
          } else {
            homeSet = false;
            previousCallTypeCur = false;
          }
          rendering = true;
          toggleDrawer();
          setState(
            () {},
          );
          log(rendering.toString());
          await applicationBloc.setSelectedLocationNoSearch(myPlacesIds[index]);
          cityName = myPlacesFullName[index];
          rendering = false;
        },
      ),
    );
  }

  Future<dynamic> showSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    20,
                    0,
                    25,
                  ),
                  width: double.infinity,
                  child: Text(
                    (index < myPlacesMainText.length)
                        ? myPlacesMainText[index]
                        : "",
                    style: const TextStyle(
                      fontFamily: 'Proxima',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    if (myPlacesIds[index] != myHomeId) {
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCirc);
                      myHomeFullName = myPlacesFullName[index];
                      myHomeId = myPlacesIds[index];
                      myHomeMainText = myPlacesMainText[index];
                      myHomeSecondaryText = myPlacesSecondaryText[index];
                      if (index != 0) {
                        myPlacesIds.insert(0, myHomeId);
                        myPlacesFullName.insert(0, myHomeFullName);
                        myPlacesMainText.insert(0, myHomeMainText);
                        myPlacesSecondaryText.insert(0, myHomeSecondaryText);
                        _listKey.currentState!.insertItem(0,
                            duration: const Duration(milliseconds: 200));

                        await Future.delayed(const Duration(milliseconds: 200),
                            () async {
                          myPlacesFullName.removeAt(index + 1);
                          myPlacesMainText.removeAt(index + 1);
                          myPlacesSecondaryText.removeAt(index + 1);
                          myPlacesIds.removeAt(index + 1);
                          _listKey.currentState!.removeItem(
                            index + 1,
                            (context, animation) {
                              return _buildLocTileOutAnimate(
                                  context,
                                  animation,
                                  myPlacesMainText[0],
                                  myPlacesSecondaryText[0],
                                  true);
                            },
                            duration: const Duration(milliseconds: 200),
                          );
                          indexrem = index;
                        });
                      } else {
                        myHomeFullName = myPlacesFullName[index];
                        myHomeId = myPlacesIds[index];
                        myHomeMainText = myPlacesMainText[index];
                        myHomeSecondaryText = myPlacesSecondaryText[index];
                        setState(() {});
                      }
                    } else {
                      myHomeId = "";
                      myHomeFullName = "";
                      myHomeSecondaryText = "";
                      myHomeMainText = "";
                      setState(() {});
                    }
                    _saveHome();
                    _saveList();
                  },
                  title: Text(
                    (myPlacesIds[index] != myHomeId)
                        ? "Set as Home"
                        : "Remove as home",
                    style: const TextStyle(
                      fontFamily: 'Proxima',
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(60),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      bool isHome = false;
                      Navigator.pop(context);
                      if (myPlacesIds[index] == myHomeId) {
                        isHome = true;
                      }
                      var mtext = myPlacesMainText[index];
                      var stext = myPlacesSecondaryText[index];
                      _listKey.currentState!.removeItem(
                        index,
                        (context, animation) => _buildLocTileOutAnimate(
                          context,
                          animation,
                          mtext,
                          stext,
                          isHome,
                        ),
                        duration: const Duration(milliseconds: 200),
                      );
                      myPlacesFullName.removeAt(index);
                      myPlacesMainText.removeAt(index);
                      myPlacesSecondaryText.removeAt(index);
                      myPlacesIds.removeAt(index);
                      await Future.delayed(const Duration(milliseconds: 200),
                          () {
                        if (myPlacesIds[index] == myHomeId) {
                          myHomeId = "";
                          myHomeFullName = "";
                          myHomeSecondaryText = "";
                          myHomeMainText = "";
                          _saveHome();
                        }
                      });
                      _saveList();
                    },
                    title: const Text(
                      "Unpin",
                      style: TextStyle(
                        fontFamily: 'Proxima',
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onReorderFinished(List<String> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(
      () {
        _saveHome();
        _saveList();
      },
    );
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.withAlpha(200),
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        drawer: Drawer(
          elevation: 16,
          child: Column(
            children: <Widget>[
              stratosHeader(context),
              stratosSavedLocationTile(context),
              Expanded(
                flex: 2,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Scrollbar(
                    child: _buildLocList(),
                  ),
                ),
              ),
              stratosSettingsTile(context),
            ],
          ),
        ),
        body: futureWidget(),
      ),
    );
  }
}
