import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/views/screens/home_page.dart';

void main() {
  runApp(const MainRunner());
}

class MainRunner extends StatelessWidget {
  const MainRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
          foregroundColor: Colors.blue,
        ),
      ),
      dark: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.amber,
          foregroundColor: Colors.blue,
        ),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}
