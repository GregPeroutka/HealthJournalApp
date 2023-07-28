// This class is the first screen that gets loaded from app startup
// The main purpose of this screen is to handle transitions between screens
// There are not supposed to be many transitions past app initialization, with MainScreenView being the main UI screen

import 'package:flutter/cupertino.dart';
import '../../view_models/ScreenControllerViewModel.dart';
import 'ErrorScreenView.dart';
import 'LoadingScreenView.dart';
import 'MainScreenView.dart';

class ScreenControllerView extends StatefulWidget {
  const ScreenControllerView({super.key});

  @override
  State<ScreenControllerView> createState() => _ScreenControllerViewState();
}

class _ScreenControllerViewState extends State<ScreenControllerView> {
  final PageControllerViewModel vm = PageControllerViewModel();
  String currentScreenView = 'loadingScreen';

  final Map<String, Widget?> screenViews = {
    'loadingScreen': const LoadingScreenView(),
    'errorScreen': const ErrorScreenView(),
    'mainScreen': const MainScreenView()
  };

  _ScreenControllerViewState() {
    vm.initApp().then((bool success) => {
      setState(() => {
        if (success)
          currentScreenView = 'mainScreen'
        else
          currentScreenView = 'errorScreen'
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return screenViews[currentScreenView] ?? const ErrorScreenView();
  }
}
