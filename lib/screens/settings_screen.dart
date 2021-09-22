// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ih8clouds/blocs/application_bloc.dart';
import 'package:ih8clouds/services/data_service.dart';
import 'package:ih8clouds/settings/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool unit = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    var info = await SharedPrefs.getImperial();

    setState(() {
      unit = info;
    });
  }

  Widget buildSettingsList() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return SettingsList(
      sections: [
        /*
        SettingsSection(
          title: 'Common',
          titlePadding: EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile(
              title: 'Environment',
              subtitle: 'Production',
              leading: Icon(Icons.cloud_queue),
            ),
          ],
        ),
        SettingsSection(
          title: 'Account',
          titlePadding: EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile(title: 'Phone number', leading: Icon(Icons.phone)),
            SettingsTile(title: 'Email', leading: Icon(Icons.email)),
            SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app)),
          ],
        ),*/
        SettingsSection(
          title: 'General',
          titlePadding: EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile.switchTile(
              switchValue: unit,
              title: 'Units',
              subtitle: (unit) ? "Imperial" : "Metric",
              leading: Icon(FlutterIcons.tape_measure_mco),
              onToggle: (bool value) async {
                await SharedPrefs.setImperial(value);
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
        /*
        SettingsSection(
          titlePadding: EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          title: 'Misc',
          tiles: [
            SettingsTile(
                title: 'Terms of Service', leading: Icon(Icons.description)),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),*/
        SettingsSection(
          title: 'About',
          titlePadding: EdgeInsets.only(
            top: 20,
            left: 70,
          ),
          tiles: [
            SettingsTile(
              title: 'Github',
              leading: Icon(FlutterIcons.github_ant),
              onPressed: (BuildContext context) {
                launch("https://github.com/SoPat712/ih8clouds");
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings Screen"),
      ),
      body: /*SettingsList(
        sections: [
          SettingsSection(
            title: 'Section',
            tiles: [
              SettingsTile.switchTile(
                title: 'Units',
                leading: Icon(FlutterIcons.tape_measure_mco),
                switchValue: unit,
                onToggle: (bool value) async {
                  await SharedPrefs.setImperial(value);
                  await initialize();
                  await DataService.getWeather(
                      applicationBloc
                          .selectedLocationStatic!.geometry.location.lat,
                      applicationBloc
                          .selectedLocationStatic!.geometry.location.lng);
                  widget.notifyParent();
                },
              ),
            ],
          ),
        ],
      ),
    );*/
          buildSettingsList(),
    );
  }
}
