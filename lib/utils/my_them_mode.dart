import 'package:flutter/material.dart';

class MyThemMode {
  static final lightheme = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
      foregroundColor: Colors.white,
    ),
  );
  static final nightTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
      foregroundColor: Colors.white,
    ),
  );
}
