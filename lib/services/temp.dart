import 'package:flutter/material.dart';
import 'package:ih8clouds/models/json/one_call.dart';
import 'package:ih8clouds/settings/shared_prefs.dart';

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
