import 'package:flutter/material.dart';
import 'package:weather_app/WheaterScreen.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: const AppBarTheme(),
  );

  static ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: const AppBarTheme(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.lightTheme,
      darkTheme: ThemeManager.darkTheme,
      themeMode:
          ThemeMode.system, // Automatically switch based on system setting
      home: const WheaterScreen(),
    );
  }
}

void main() {
  runApp(const MyApp());
}
