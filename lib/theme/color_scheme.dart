import 'package:flutter/material.dart';

const Color turquoise = Color.fromARGB(250, 0, 200, 200);
const Color mturquoise = Color.fromARGB(200, 0, 170, 170);
const Color dturquoise = Color.fromARGB(150, 0, 200, 200);
const Color bturquoise = Color.fromARGB(149, 0, 132, 132);
const Color lturquoise = Color.fromARGB(205, 225, 255, 255);
const Color bbturquoise = Color.fromARGB(255, 0, 72, 72);
const Color bbbturquoise = Color.fromARGB(128, 0, 72, 72);
const Color w = Colors.white;
const Color b = Colors.black;

ThemeData customDark = ThemeData.dark().copyWith(
    primaryColor: turquoise,
    scaffoldBackgroundColor: b,
    colorScheme: ColorScheme.dark(
      primary: turquoise,
      secondary: mturquoise,
      surface: b,
      error: Color.fromARGB(255, 255, 157, 150),
      onPrimary: b,
      onSecondary: w,
      onSurface: w,
      onError: w,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: b,
      foregroundColor: w,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: dturquoise,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: mturquoise,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      labelType: NavigationRailLabelType.selected,
      selectedIconTheme: IconThemeData(color: w),
      unselectedIconTheme: IconThemeData(color: w),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mturquoise,
      foregroundColor: w,
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: bturquoise,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: b,
      selectedTileColor: mturquoise,
      iconColor: w,
      textColor: w,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: b,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: turquoise),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: w),
      ),
    ),
    dataTableTheme: DataTableThemeData(
      headingTextStyle: TextStyle(color: w),
      dataTextStyle: TextStyle(color: w),
    ),
    dialogTheme: DialogTheme(
        backgroundColor: b,
        barrierColor: Color.fromARGB(171, 67, 67, 67)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: w),
      bodyMedium: TextStyle(color: w),
      bodySmall: TextStyle(color: w),
      headlineLarge: TextStyle(color: w),
      headlineMedium: TextStyle(color: w),
      headlineSmall: TextStyle(color: w),
      displayLarge: TextStyle(color: w),
      displayMedium: TextStyle(color: w),
      displaySmall: TextStyle(color: w),
      titleLarge: TextStyle(color: w),
      titleMedium: TextStyle(color: w),
      titleSmall: TextStyle(color: w),
      labelLarge: TextStyle(color: w),
      labelMedium: TextStyle(color: w),
      labelSmall: TextStyle(color: w),
    ));

ThemeData customLight = ThemeData.light().copyWith(
    primaryColor: mturquoise,
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.light(
      primary: mturquoise,
      secondary: turquoise,
      surface: w,
      error: Colors.red,
      onPrimary: b,
      onSecondary: b,
      onSurface: b,
      onError: w,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: w,
      foregroundColor: b,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: dturquoise,
      backgroundColor: w,
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: turquoise,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      labelType: NavigationRailLabelType.selected,
      selectedIconTheme: IconThemeData(color: b),
      unselectedIconTheme: IconThemeData(color: b),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mturquoise,
      foregroundColor: w,
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: bturquoise,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: w,
      selectedTileColor: mturquoise,
      iconColor: b,
      textColor: b,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: w,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mturquoise),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: b),
      ),
    ),
    dataTableTheme: DataTableThemeData(
      headingTextStyle: TextStyle(color: b),
      dataTextStyle: TextStyle(color: b),
    ),
    dialogBackgroundColor: w,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: b),
      bodyMedium: TextStyle(color: b),
      bodySmall: TextStyle(color: b),
      headlineLarge: TextStyle(color: b),
      headlineMedium: TextStyle(color: b),
      headlineSmall: TextStyle(color: b),
      displayLarge: TextStyle(color: b),
      displayMedium: TextStyle(color: b),
      displaySmall: TextStyle(color: b),
      titleLarge: TextStyle(color: b),
      titleMedium: TextStyle(color: b),
      titleSmall: TextStyle(color: b),
      labelLarge: TextStyle(color: b),
      labelMedium: TextStyle(color: b),
      labelSmall: TextStyle(color: b),
    ));
