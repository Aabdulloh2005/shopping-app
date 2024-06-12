import 'package:flutter/material.dart';

class MyThemMode {
  static final lightheme = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.amber),
      bodyMedium: TextStyle(color: Colors.amber),
      displayLarge: TextStyle(color: Colors.amber),
      displayMedium: TextStyle(color: Colors.amber),
      displaySmall: TextStyle(color: Colors.amber),
      headlineMedium: TextStyle(color: Colors.amber),
      headlineSmall: TextStyle(color: Colors.amber),
      titleLarge: TextStyle(color: Colors.amber),
      bodySmall: TextStyle(color: Colors.amber),
      headlineLarge: TextStyle(color: Colors.amber),
      labelLarge: TextStyle(color: Colors.amber),
      labelMedium: TextStyle(color: Colors.amber),
      labelSmall: TextStyle(color: Colors.amber),
      titleMedium: TextStyle(color: Colors.amber),
      titleSmall: TextStyle(color: Colors.amber),
    ),
  );
  static final nightTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.amber,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.amber),
      bodyMedium: TextStyle(color: Colors.amber),
      displayLarge: TextStyle(color: Colors.amber),
      displayMedium: TextStyle(color: Colors.amber),
      displaySmall: TextStyle(color: Colors.amber),
      headlineMedium: TextStyle(color: Colors.amber),
      headlineSmall: TextStyle(color: Colors.amber),
      titleLarge: TextStyle(color: Colors.amber),
      bodySmall: TextStyle(color: Colors.amber),
      headlineLarge: TextStyle(color: Colors.amber),
      labelLarge: TextStyle(color: Colors.amber),
      labelMedium: TextStyle(color: Colors.amber),
      labelSmall: TextStyle(color: Colors.amber),
      titleMedium: TextStyle(color: Colors.amber),
      titleSmall: TextStyle(color: Colors.amber),
    ),
  );
}
