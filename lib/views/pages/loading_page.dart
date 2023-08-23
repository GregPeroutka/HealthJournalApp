import 'package:flutter/material.dart';
import 'package:my_health_journal/color_palette.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loadingPage();

}

class _loadingPage extends State<LoadingPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Loading :D',
        style: TextStyle(
          color: ColorPalette.currentColorPalette.hintText,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: "Rubik",
        ),
      ),
    );
  }

}