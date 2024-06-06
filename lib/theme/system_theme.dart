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

void setDarkMode() {
  
}
