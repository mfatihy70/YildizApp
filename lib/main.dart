import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:yildiz_app/settings/notifiers.dart';
import 'theme/color_scheme.dart';
import 'navigation/navbar.dart';
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
        return MaterialApp(
          // Get the system theme mode and set the app theme accordingly
          theme: settingsNotifier.darkTheme ? customDark : customLight,
          home: NavigationBarApp(),
        );
      },
    );
  }
}
