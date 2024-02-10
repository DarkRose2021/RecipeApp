import 'package:flutter/material.dart';

final ThemeData customTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.teal,
      iconTheme: IconThemeData(color: Colors.white, size: 30),
      titleTextStyle: TextStyle(fontSize: 32, color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white70,
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    iconTheme: const IconThemeData(color: Colors.white));
