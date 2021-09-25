import 'package:stratos/settings/shared_prefs.dart';

class TempHelper {
  static bool useF = false;
  static void initialize() async {
    useF = await SharedPrefs.getMetric();
  }

  static String getReadableTemp(String passed) {
    initialize();
    return useF ? passed + "°C" : passed + "°F";
  }
}
