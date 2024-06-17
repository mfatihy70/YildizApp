import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SettingsNotifier extends ChangeNotifier {
  bool darkTheme;
  String selectedLanguage;
  String host = dotenv.env['DB_HOST'] ?? 'localhost';
  String dbName = dotenv.env['DB_NAME'] ?? 'YildizDB';
  String username = dotenv.env['DB_USERNAME'] ?? 'postgres';
  String password = dotenv.env['DB_PASSWORD'] ?? 'admin';
  int port = int.parse(dotenv.env['DB_PORT'] ?? '5432');

  SettingsNotifier({
    required this.darkTheme,
    required this.selectedLanguage,
  });

  factory SettingsNotifier.initialize() {
    final Brightness systemBrightness =
        PlatformDispatcher.instance.platformBrightness;
    final bool isDarkTheme = systemBrightness == Brightness.dark;

    final Locale systemLocale = PlatformDispatcher.instance.locale;
    String defaultLanguage;
    switch (systemLocale.languageCode) {
      case 'de':
        defaultLanguage = 'Deutsch';
      case 'tr':
        defaultLanguage = 'Türkçe';
      default:
        defaultLanguage = 'English';
    }

    return SettingsNotifier(
      darkTheme: isDarkTheme,
      selectedLanguage: defaultLanguage,
    );
  }

  void setDarkTheme(bool value) {
    darkTheme = value;
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }

  void setHost(String host) {
    this.host = host;
    notifyListeners();
  }

  void setDbName(String dbName) {
    this.dbName = dbName;
    notifyListeners();
  }

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
