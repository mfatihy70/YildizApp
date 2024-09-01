import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends ChangeNotifier {
  late SharedPreferences _prefs;
  bool darkTheme;
  String selectedLanguage;
  String host;
  String dbName;
  String username;
  String password;
  int port;
  bool sslMode;

  SettingsNotifier({
    required this.darkTheme,
    required this.selectedLanguage,
    required this.host,
    required this.dbName,
    required this.username,
    required this.password,
    required this.port,
    required this.sslMode,
  });

  static Future<SettingsNotifier> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final Brightness systemBrightness = PlatformDispatcher.instance.platformBrightness;
    final bool isDarkTheme = prefs.getBool('darkTheme') ?? (systemBrightness == Brightness.dark);

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

    final settings = SettingsNotifier(
      darkTheme: isDarkTheme,
      selectedLanguage: prefs.getString('selectedLanguage') ?? defaultLanguage,
      host: prefs.getString('host') ?? dotenv.env['DB_HOST'] ?? 'localhost',
      dbName: prefs.getString('dbName') ?? dotenv.env['DB_NAME'] ?? 'YildizDB',
      username: prefs.getString('username') ?? dotenv.env['DB_USERNAME'] ?? 'postgres',
      password: prefs.getString('password') ?? dotenv.env['DB_PASSWORD'] ?? 'admin',
      port: prefs.getInt('port') ?? int.parse(dotenv.env['DB_PORT'] ?? '5432'),
      sslMode: prefs.getBool('sslMode') ?? (dotenv.env['DB_SSL_MODE'] == 'true'),
    );
    settings._prefs = prefs;
    return settings;
  }

  void setDarkTheme(bool value) {
    darkTheme = value;
    _prefs.setBool('darkTheme', value);
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    selectedLanguage = language;
    _prefs.setString('selectedLanguage', language);
    notifyListeners();
  }

  void setHost(String value) {
    host = value;
    _prefs.setString('host', value);
    notifyListeners();
  }

  void setPort(int value) {
    port = value;
    _prefs.setInt('port', value);
    notifyListeners();
  }

  void setDbName(String value) {
    dbName = value;
    _prefs.setString('dbName', value);
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    _prefs.setString('username', value);
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    _prefs.setString('password', value);
    notifyListeners();
  }

  void setSslMode(bool value) {
    sslMode = value;
    _prefs.setBool('sslMode', value);
    notifyListeners();
  }
}