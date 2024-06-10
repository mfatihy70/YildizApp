import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'theme/color_scheme.dart';
import 'theme/theme_notifier.dart';
import 'settings/ip_address_notifier.dart';
import 'navbar.dart';
import 'dart:io' show Platform;

void main() {
  // Set window size and title also ensuring widget initialization for Windows
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Yildiz App');
    setWindowMinSize(const Size(500, 750));
  }
  runApp(
    //Changenotfiers for changes in the theme and ip address inside the app
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => IpAddressNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        return MaterialApp(
          // Get the system theme mode and set the app theme accordingly
          theme: theme.isDarkMode ? customDark : customLight,
          home: NavigationBarApp(),
        );
      },
    );
  }
}
