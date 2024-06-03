import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:window_size/window_size.dart';
import 'dart:io' show Platform;

void main() {
  //Check if this line is necessary:
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle('Yildiz App');
    setWindowMinSize(const Size(420, 700));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBarApp();
  }
}
