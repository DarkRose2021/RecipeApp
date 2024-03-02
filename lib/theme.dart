import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black54,
    iconTheme: IconThemeData(color: Colors.teal, size: 30),
    titleTextStyle: TextStyle(fontSize: 32, color: Colors.teal),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.grey,
  ),
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.teal,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.teal, size: 30),
    titleTextStyle: TextStyle(fontSize: 32, color: Colors.teal),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white70,
    selectedItemColor: Colors.teal,
    unselectedItemColor: Colors.grey,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
);
