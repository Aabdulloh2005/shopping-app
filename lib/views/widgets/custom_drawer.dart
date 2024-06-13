import 'package:flutter/material.dart';
import 'package:online_shop/views/screens/home_page.dart';
import 'package:online_shop/views/screens/settings_page.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.appHome),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.settings ),
            ),
          ],
        ),
      ),
    );
  }
}
