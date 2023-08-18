// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart' hide NavigationBar;
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/views/navigation/navigation_bar.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {

  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: ColorPalette.currentColorPalette.primaryBackground,

      child: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          NavigationBar(),
          Expanded(child: _Content())
        ],

      )
    );
  }
}

class _Content extends Material {

  @override
  Widget? get child => Container(
    decoration: BoxDecoration(
      color: ColorPalette.currentColorPalette.primaryBackground,
      border: Border.all(color: Colors.black)
    ),
  );
}
