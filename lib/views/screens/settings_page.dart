import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/views/widgets/custom_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text("Light mode"),
            value: toggle,
            onChanged: (value) {
              toggle = value;
              AdaptiveTheme.of(context).toggleThemeMode(useSystem: value);
              setState(() {});
            },
          )
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
