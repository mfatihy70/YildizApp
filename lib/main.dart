import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

void main() {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Yildiz App');
    setWindowMinSize(const Size(500, 750));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBarApp();
  }
}
