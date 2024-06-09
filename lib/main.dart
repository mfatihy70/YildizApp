import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'theme/color_scheme.dart';
import 'theme/theme_notifier.dart';
import 'settings/ip_address_notifier.dart';
import 'navbar.dart';
import 'dart:io' show Platform;

void main() {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Yildiz App');
    setWindowMinSize(const Size(500, 750));
  }
  runApp(
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
          theme: theme.isDarkMode ? customDark : customLight,
          home: NavigationBarApp(),
        );
      },
    );
  }
}
