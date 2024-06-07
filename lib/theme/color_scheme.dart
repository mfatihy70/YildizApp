import 'package:flutter/material.dart';

const Color turquoise = Color.fromARGB(250, 0, 200, 200);
const Color mturquoise = Color.fromARGB(200, 0, 170, 170);
const Color dturquoise = Color.fromARGB(150, 0, 200, 200);
const Color bturquoise = Color.fromARGB(149, 0, 132, 132);

ThemeData customDark = ThemeData.dark().copyWith(
  primaryColor: turquoise,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: turquoise,
      ),
  navigationBarTheme: ThemeData.dark().navigationBarTheme.copyWith(
        indicatorColor: dturquoise,
      ),
  navigationRailTheme: ThemeData.dark().navigationRailTheme.copyWith(
        indicatorColor: mturquoise,
        labelType: NavigationRailLabelType.selected,
      ),
  floatingActionButtonTheme: ThemeData.dark()
      .floatingActionButtonTheme
      .copyWith(backgroundColor: mturquoise, foregroundColor: Colors.white),
);

ThemeData customLight = ThemeData.light().copyWith(
  primaryColor: mturquoise,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: mturquoise,
      ),
  navigationBarTheme: ThemeData.light().navigationBarTheme.copyWith(
        indicatorColor: dturquoise,
      ),
  floatingActionButtonTheme: ThemeData.light()
      .floatingActionButtonTheme
      .copyWith(backgroundColor: mturquoise, foregroundColor: Colors.white),
);
