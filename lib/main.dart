import 'package:flutter/material.dart';
import 'package:online_shop/views/screens/home_page.dart';
import 'package:online_shop/views/screens/splash_page.dart';

void main(List<String> args) {
  runApp(const MainRunner());
}

class MainRunner extends StatelessWidget {
  const MainRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
