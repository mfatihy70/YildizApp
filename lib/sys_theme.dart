import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/scheduler.dart';
import 'dart:io' show Platform;
import 'dart:ui';

ThemeData getAppTheme() {  
  Brightness brightness;

  if (Platform.isAndroid || Platform.isIOS || kIsWeb) {
    brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  } else {
    brightness = window.platformBrightness;
  }

  bool isDarkMode = brightness == Brightness.dark;

  return isDarkMode
    ? ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
      )
  : ThemeData.light();
}