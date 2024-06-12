import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:yildiz_app/settings/notifiers.dart';
import 'theme/color_scheme.dart';
import 'navigation/navbar.dart';
import 'localization.dart';
import 'dart:io' show Platform;

void main() {
  // Set window size and title also ensuring widget initialization for Windows
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Yildiz App');
    setWindowMinSize(const Size(500, 750));
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, settingsNotifier, _) {
        Locale? locale;
        switch (settingsNotifier.selectedLanguage) {
          case 'English':
            locale = const Locale('en');
          case 'Deutsch':
            locale = const Locale('de');
          case 'Türkçe':
            locale = const Locale('tr');
        }
        return MaterialApp(
          theme: settingsNotifier.darkTheme ? customDark : customLight,
          home: NavigationBarApp(),
          title: 'Yildiz App',
          locale: locale,
          supportedLocales: [
            const Locale('en'),
            const Locale('tr'),
            const Locale('de'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
