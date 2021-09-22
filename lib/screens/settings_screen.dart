import 'package:flutter/material.dart';
import 'package:ih8clouds/settings/shared_prefs.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool imperial = false;
  Future<void> getValues() async {
    imperial = await SharedPrefs.getImperial();
  }
  bool _toggleAirplaneMode = false;
  bool _toggleBluetooth = false;
  bool _toggleWiFi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            SwitchListTile(
              title: Text('Airplane Mode'),
              secondary: Icon(Icons.airplanemode_active),
              onChanged: (value) {
                setState(() {
                  _toggleAirplaneMode = value;
                });
              },
              value: _toggleAirplaneMode,
            ),
            Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              title: Text('Wi-Fi'),
              secondary: Icon(Icons.wifi),
              onChanged: (value) {
                setState(() {
                  _toggleWiFi = value;
                });
              },
              value: _toggleWiFi,
            ),
            Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              title: Text('Bluetooth'),
              secondary: Icon(Icons.bluetooth),
              onChanged: (value) {
                setState(() {
                  _toggleBluetooth = value;
                });
              },
              value: _toggleBluetooth,
            ),
          ],
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
