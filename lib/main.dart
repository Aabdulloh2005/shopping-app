import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/utils/my_them_mode.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:online_shop/views/screens/home_page.dart';

void main() {
  runApp(const MainRunner());
}

class MainRunner extends StatefulWidget {
  const MainRunner({super.key});

  @override
  State<MainRunner> createState() => _MainRunnerState();

  static _MainRunnerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainRunnerState>();
}

class _MainRunnerState extends State<MainRunner> {
  Locale _locale = const Locale('uz');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: MyThemMode.lightheme,
      dark: MyThemMode.nightTheme,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp(
          locale: _locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}
