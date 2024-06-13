import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CalendarPage extends StatelessWidget {
  final Function(Locale) onLocaleChange;

  const CalendarPage({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.helloWorld),
        actions: [
          DropdownButton<Locale>(
            style: const TextStyle(color: Colors.blue),
            value: Localizations.localeOf(context),
            icon: const Icon(Icons.language, color: Colors.white),
            onChanged: (Locale? locale) {
              if (locale != null) {
                onLocaleChange(locale);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('ru'),
                child: Text('Русский'),
              ),
              DropdownMenuItem(
                value: Locale('uz'),
                child: Text('Oʻzbekcha'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.hello("Mardon")),
            Text(AppLocalizations.of(context)!.nApples(1)),
            Localizations.override(
              context: context,
              child: Builder(
                builder: (context) {
                  return CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onDateChanged: (value) {},
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
