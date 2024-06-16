import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 6, 168, 186);

const Color blue = Color.fromARGB(248, 88, 165, 188);
const Color blue2 = Color.fromARGB(197, 45, 181, 223);
const Color blueLight = Color.fromARGB(205, 182, 227, 233);
const Color blueDark = Color.fromARGB(147, 61, 122, 140);
const Color blueDark2 = Color.fromARGB(148, 44, 88, 101);
const Color blueBlack = Color.fromARGB(255, 29, 73, 85);
const Color blueBlack2 = Color.fromARGB(128, 29, 73, 85);
const Color w = Colors.white;
const Color b = Colors.black;

ThemeData customDark = ThemeData.dark().copyWith(
    primaryColor: blue,
    scaffoldBackgroundColor: b,
    colorScheme: ColorScheme.dark(
      primary: blue,
      secondary: blue2,
      surface: b,
      error: Color.fromARGB(255, 255, 157, 150),
      onPrimary: w,
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
      indicatorColor: blue2,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: blue2,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      labelType: NavigationRailLabelType.selected,
      selectedIconTheme: IconThemeData(color: w),
      unselectedIconTheme: IconThemeData(color: w),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blue2,
      foregroundColor: w,
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: blueDark2,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: b,
      selectedTileColor: blue2,
      iconColor: w,
      textColor: w,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: b,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blue),
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
        barrierColor: Color.fromARGB(67, 67, 67, 67)),
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
    primaryColor: blue2,
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    colorScheme: ColorScheme.light(
      primary: blue2,
      secondary: blue,
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
      indicatorColor: blue,
      backgroundColor: w,
    ),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: blue,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      labelType: NavigationRailLabelType.selected,
      selectedIconTheme: IconThemeData(color: b),
      unselectedIconTheme: IconThemeData(color: b),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blue2,
      foregroundColor: w,
    ),
    snackBarTheme: SnackBarThemeData(
      actionTextColor: blueDark2,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: w,
      selectedTileColor: blue2,
      iconColor: b,
      textColor: b,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: w,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: blue2),
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
