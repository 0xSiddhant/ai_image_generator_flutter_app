import 'package:ai_image_generator_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: Colors.amber.shade500,
        useMaterial3: true,
        brightness: Brightness.dark),
    themeMode: ThemeMode.dark,
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
