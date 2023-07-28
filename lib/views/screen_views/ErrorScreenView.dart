// This screen will only get loaded if there is an error in app initialization
// If this screen gets loaded, the app _should_ crash

import 'package:flutter/material.dart';

class ErrorScreenView extends StatelessWidget {
  const ErrorScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("ERROR");
  }
}
