import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension BuildCOntextX on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  Size get getSize => MediaQuery.of(this).size;
  double get height => getSize.height;
  double get width => getSize.width;
  ThemeData get theme => Theme.of(this);
  void removeFocus() => FocusScope.of(this).requestFocus();
  NavigatorState get navigator => Navigator.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension SharedPreferenceExtension on SharedPreferences {
  ThemeMode get currentThemeMode {
    return getBool('darkModeEnabled') ?? true
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<ThemeMode> toggleThemeMode() async {
    await setBool('darkModeEnabled', !(getBool('darkModeEnabled') ?? true));
    return currentThemeMode;
  }

  bool get dataSaverMode {
    return getBool('dataSaverMode') ?? false;
  }

  Future<bool> toggleDataSaverMode() async {
    await setBool('dataSaverMode', !(getBool('dataSaverMode') ?? true));
    return dataSaverMode;
  }

  Future cleanup() async {
    await clear();
  }
}
