import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:online_shop/main.dart';
import 'package:online_shop/views/widgets/custom_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool toggle = true;

  // List of supported languages
  final List<Locale> _supportedLocales = [
    const Locale('en'),
    const Locale('ru'),
    const Locale('uz'),
  ];

  // Current locale
  Locale _currentLocale = const Locale('ru');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: toggle
                ? Text(AppLocalizations.of(context)!.lightMode)
                : Text(AppLocalizations.of(context)!.nightMode),
            value: toggle,
            onChanged: (value) {
              setState(() {
                toggle = value;
                AdaptiveTheme.of(context).toggleThemeMode(useSystem: value);
              });
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            onTap: () {
              _showLanguageSelector(context);
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 180,
          child: ListView(
            children: _supportedLocales.map((Locale locale) {
              return ListTile(
                title: Text(_getLanguageName(locale.languageCode)),
                onTap: () {
                  setState(() {
                    _currentLocale = locale;
                  });
                  MainRunner.of(context)?.setLocale(locale);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      case 'uz':
        return 'O‘zbekcha';
      default:
        return 'Unknown';
    }
  }
}
