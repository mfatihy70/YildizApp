import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

l(String key, BuildContext context) {
  return Localizer.of(context).translate(key);
}

t(String key, BuildContext context) {
  return Text(l(key, context));
}

class Localizer {
  final Locale locale;
  Localizer(this.locale);

  static Localizer of(BuildContext context) {
    return Localizations.of<Localizer>(context, Localizer)!;
  }

  static const LocalizationsDelegate<Localizer> delegate =
      _LocalizerDelegate();

  late Map<String, List<String>> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/locales/translations.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, List<String>.from(value));
    });

    return true;
  }

  String translate(String key) {
    List<String>? translations = _localizedStrings[key];
    if (translations == null) {
      return '';
    }
    switch (locale.languageCode) {
      case 'en':
        return translations[0];
      case 'de':
        return translations[1];
      case 'tr':
        return translations[2];
      default:
        return '';
    }
  }
}

class _LocalizerDelegate extends LocalizationsDelegate<Localizer> {
  const _LocalizerDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<Localizer> load(Locale locale) async {
    Localizer localizations = Localizer(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizerDelegate old) => false;
}

Locale? getLocale(String selectedLanguage) {
  switch (selectedLanguage) {
    case 'English':
      return const Locale('en');
    case 'Deutsch':
      return const Locale('de');
    case 'Türkçe':
      return const Locale('tr');
    default:
      return null;
  }
}

List<Locale> getSupportedLocales() {
  return const [
    Locale('en'),
    Locale('tr'),
    Locale('de'),
  ];
}

List<LocalizationsDelegate<dynamic>> getLocalizationsDelegates() {
  return const [
    Localizer.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
