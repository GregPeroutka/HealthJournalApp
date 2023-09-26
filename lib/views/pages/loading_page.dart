import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingPage();

}

class _LoadingPage extends State<LoadingPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Loading :D',
        style: TextStyle(
          color: AppStyle.currentStyle.textColor2,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: "Rubik",
        ),
      ),
    );
  }

}