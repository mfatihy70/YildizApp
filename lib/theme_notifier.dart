import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier(this._isDarkMode);

  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
