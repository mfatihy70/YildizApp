import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class SettingsNotifier extends ChangeNotifier {
  bool _darkTheme = true;
  String _selectedLanguage = 'English';
  String _ipAddress = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  String _dbName = 'YildizDB';
  String _username = 'postgres';
  String _password = 'admin';

  String get selectedLanguage => _selectedLanguage;
  String get ipAddress => _ipAddress;
  String get dbName => _dbName;
  String get username => _username;
  String get password => _password;
  bool get darkTheme => _darkTheme;

  void setDarkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void setIpAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }

  void setDbName(String dbName) {
    _dbName = dbName;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
