// First screen seen by user. Indicates that the app is loading

import 'package:flutter/material.dart';

class LoadingScreenView extends StatelessWidget {
  const LoadingScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Loading")
    );
  }
}
