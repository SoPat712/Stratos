import 'package:Stratus/settings/shared_prefs.dart';

class TempHelper {
  static bool useF = false;
  static void initialize() async {
    useF = await SharedPrefs.getImperial();
  }

  static String getReadableTemp(String passed) {
    initialize();
    return useF ? passed + "°C" : passed + "°F";
  }
}
