// This class is the first screen that gets loaded from app startup
// The main purpose of this screen is to handle transitions between screens

import 'package:flutter/cupertino.dart';
import 'package:my_health_journal/views/screen_views/SigninScreenView.dart';
import '../../view_models/ScreenControllerViewModel.dart';
import 'ErrorScreenView.dart';
import 'LoadingScreenView.dart';
import 'MainScreenView.dart';

class ScreenControllerView extends StatefulWidget {
  static final ScreenControllerView _instance = ScreenControllerView._internal();
  factory ScreenControllerView() {
    return _instance;
  }
  ScreenControllerView._internal();

  @override
  State<ScreenControllerView> createState() => _ScreenControllerViewState();
}

class _ScreenControllerViewState extends State<ScreenControllerView> {
  final PageControllerViewModel _vm = PageControllerViewModel();
  String _currentScreenView = 'loadingScreen';

  final Map<String, Widget?> screenViews = {
    'loadingScreen': const LoadingScreenView(),
    'errorScreen': const ErrorScreenView(),
    'mainScreen': const MainScreenView(),
    'loginScreen': const SigninScreenView()
  };

  _ScreenControllerViewState() {
    _vm.initApp().then((bool success) => {
      setState(() => {
        if (success)
          _currentScreenView = 'loginScreen'
        else
          _currentScreenView = 'errorScreen'
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return screenViews[_currentScreenView] ?? const ErrorScreenView();
  }
}
