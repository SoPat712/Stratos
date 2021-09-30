// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stratos/blocs/application_bloc.dart';
import 'package:stratos/services/data_service.dart';
import 'package:stratos/settings/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool unit = false;
  bool twelveHour = false;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    var info = await SharedPrefs.getMetric();
    var info2 = await SharedPrefs.get24();
    setState(() {
      twelveHour = info2;
      unit = info;
    });
  }

  Widget buildSettingsList() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'General',
          titlePadding: const EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile.switchTile(
              switchValue: unit,
              title: 'Units',
              subtitle: (unit) ? "Metric" : "Imperial",
              leading: const Icon(FlutterIcons.tape_measure_mco),
              onToggle: (bool value) async {
                await SharedPrefs.setMetric(value);
                await initialize();
                await DataService.getWeather(
                    applicationBloc
                        .selectedLocationStatic!.geometry.location.lat,
                    applicationBloc
                        .selectedLocationStatic!.geometry.location.lng);
                widget.notifyParent();
                setState(() {});
              },
            ),
            SettingsTile.switchTile(
              switchValue: twelveHour,
              title: 'Time Format',
              subtitle: (twelveHour) ? "24 Hour" : "12 Hour",
              leading: const Icon(FlutterIcons.clock_faw5),
              onToggle: (bool value) async {
                await SharedPrefs.set24(value);
                await initialize();
                await DataService.getWeather(
                    applicationBloc
                        .selectedLocationStatic!.geometry.location.lat,
                    applicationBloc
                        .selectedLocationStatic!.geometry.location.lng);
                widget.notifyParent();
                setState(() {});
              },
            ),
          ],
        ),
        SettingsSection(
          title: 'About',
          titlePadding: const EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile(
              title: 'Github',
              leading: const Icon(FlutterIcons.github_ant),
              onPressed: (BuildContext context) {
                launch("https://github.com/SoPat712/Stratos");
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Screen"),
      ),
      body: buildSettingsList(),
    );
  }
}
