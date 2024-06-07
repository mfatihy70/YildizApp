import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/scheduler.dart';
import 'dart:io' show Platform;
import 'dart:ui';
import 'color_scheme.dart';

ThemeData getAppTheme() {
  Brightness brightness;

  if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
    brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
  } else {
    brightness = PlatformDispatcher.instance.platformBrightness;
  }

  bool isDarkMode = brightness == Brightness.dark;

  return isDarkMode ? customDark : customLight;
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

// class ThemeNotifier extends ChangeNotifier {
//   ThemeNotifier(this._isDarkMode);

//   bool _isDarkMode;
//   bool get isDarkMode => _isDarkMode;

//   void setDarkMode(bool value) {
//     _isDarkMode = value;
//     notifyListeners();
//   }
// }
