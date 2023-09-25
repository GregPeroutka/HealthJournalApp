import 'package:flutter/material.dart';
import 'package:my_health_journal/views/screen_views/screen_controller_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ScreenControllerView()
      ),
    );
  }
}