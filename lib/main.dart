import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yildiz_app/settings/notifiers.dart';
import 'package:yildiz_app/theme/color_scheme.dart';
import 'package:yildiz_app/navigation/navbar.dart';
import 'package:yildiz_app/localization.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/variables.env", mergeWith: {
    'TEST_VAR': '5',
  });

  // Set window size and title, ensuring widget initialization for Windows
  if (Platform.isWindows) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(450, 800),
      windowButtonVisibility: true,
      skipTaskbar: false,
      title: 'Yildiz App',
      minimumSize: Size(300, 600),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsNotifier.initialize()),
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
        Locale? locale = getLocale(settingsNotifier.selectedLanguage);
        return MaterialApp(
          theme: settingsNotifier.darkTheme ? customDark : customLight,
          home: NavigationBarApp(),
          title: 'Yildiz App',
          locale: locale,
          supportedLocales: getSupportedLocales(),
          localizationsDelegates: getLocalizationsDelegates(),
        );
      },
    );
  }
}
