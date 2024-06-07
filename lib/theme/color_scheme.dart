import 'package:flutter/material.dart';

const Color turquoise = Color.fromARGB(250, 0, 200, 200);
const Color mturquoise = Color.fromARGB(200, 0, 170, 170);
const Color dturquoise = Color.fromARGB(150, 0, 200, 200);
const Color bturquoise = Color.fromARGB(149, 0, 132, 132);
const Color lturquoise = Color.fromARGB(205, 204, 255, 255);

ThemeData customDark = ThemeData.dark().copyWith(
  primaryColor: turquoise,
  scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: turquoise,
        secondary: mturquoise,
        surface: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
  navigationBarTheme: ThemeData.dark().navigationBarTheme.copyWith(
        indicatorColor: dturquoise,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
  navigationRailTheme: ThemeData.dark().navigationRailTheme.copyWith(
        indicatorColor: mturquoise,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        labelType: NavigationRailLabelType.selected,
      ),
  appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
  floatingActionButtonTheme: ThemeData.dark().floatingActionButtonTheme.copyWith(
        backgroundColor: mturquoise,
        foregroundColor: Colors.white,
      ),
  snackBarTheme: ThemeData.dark().snackBarTheme.copyWith(
        actionTextColor: bturquoise,
      ),
    
);

ThemeData customLight = ThemeData.light().copyWith(
  primaryColor: mturquoise,
  scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: mturquoise,
        secondary: turquoise,
        surface: Colors.white,
        onPrimary: Colors.black,
        onSecondary: Colors.white,
        onSurface: Colors.black,
      ),
  navigationBarTheme: ThemeData.light().navigationBarTheme.copyWith(
        indicatorColor: dturquoise,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
  navigationRailTheme: ThemeData.light().navigationRailTheme.copyWith(
        indicatorColor: turquoise,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        labelType: NavigationRailLabelType.selected,
      ),
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
  floatingActionButtonTheme: ThemeData.light().floatingActionButtonTheme.copyWith(
        backgroundColor: mturquoise,
        foregroundColor: Colors.white,
      ),
);