import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/scheduler.dart';
import 'dart:ui';
import 'dart:io' show Platform;

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode;

  ThemeNotifier() : _isDarkMode = _getSystemTheme();

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  static bool _getSystemTheme() {
    Brightness brightness;

    if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
      brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
    } else {
      brightness = PlatformDispatcher.instance.platformBrightness;
    }

    return brightness == Brightness.dark;
  }
}
