import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'controllers/settings/settings_notifier.dart';
import 'controllers/settings/notifications_helper.dart';
import '/views/navigation/navbar.dart';
import '/localization/localization.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/variables.env");

  if (Platform.isWindows) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(450, 800),
      windowButtonVisibility: true,
      skipTaskbar: false,
      title: 'Yildiz App',
      minimumSize: Size(350, 650),
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    await NotificationHelper.initialize();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SettingsNotifier>(
      future: SettingsNotifier.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              ),
            );
          }

          return ChangeNotifierProvider.value(
            value: snapshot.data!,
            child: Consumer<SettingsNotifier>(
              builder: (context, settingsNotifier, _) {
                Locale? locale = getLocale(settingsNotifier.selectedLanguage);
                return MaterialApp(
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.blue,
                      brightness: settingsNotifier.darkTheme ? Brightness.dark : Brightness.light,
                    ),
                    useMaterial3: true,
                  ),
                  home: NavigationBarApp(),
                  title: 'Yildiz App',
                  locale: locale,
                  supportedLocales: getSupportedLocales(),
                  localizationsDelegates: getLocalizationsDelegates(),
                );
              },
            ),
          );
        }

        // Show a loading spinner while waiting for SettingsNotifier to initialize
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}