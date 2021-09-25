// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class TempHelper {
  static bool unit = false;
  static Future<void> initialize() async {
    unit = await Settings.getValue("useMetric", false);
  }

  static Future<String> getReadableTemp(String passed) async{
    await initialize();
    return unit ? passed + "°C" : passed + "°F";
  }
}
