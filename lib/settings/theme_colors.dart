import 'package:flutter/material.dart';
import 'package:ih8clouds/settings/shared_prefs.dart';

class ThemeColors {
  static bool? isDark;

  static void switchTheme(bool value) {
    isDark = value;
    SharedPrefs.setDark(value);
  }

  static Future<void> initialise() async {
    isDark = await SharedPrefs.getDark();
  }

  static Color backgroundColor() =>
      isDark! ? Colors.black : Colors.grey.shade50;
  static Color cardColor() => isDark! ? Colors.grey.shade900 : Colors.white;
  static Color primaryTextColor() => isDark! ? Colors.white : Colors.black87;
  static Color secondaryTextColor() =>
      isDark! ? Colors.grey.shade400 : Colors.black54;
}
