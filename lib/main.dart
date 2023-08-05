import 'package:flutter/material.dart';
import 'package:my_health_journal/views/screen_views/ScreenControllerView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _lightTheme,
      home: ScreenControllerView(),
    );
  }
}

ThemeData _lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 106, 107, 131),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 118, 148, 159), 
    onSecondary: Colors.black, 
    background: Color.fromARGB(255, 247, 243, 227), 
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    surface: Color.fromARGB(255, 95, 80, 107),
    onSurface: Colors.black,
    primaryContainer: Colors.white
  )
);