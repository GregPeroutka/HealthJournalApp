// This class is the first screen that gets loaded from app startup
// The main purpose of this screen is to handle transitions between screens

import 'package:flutter/material.dart';
import 'package:my_health_journal/views/screen_views/signin_screen_view.dart';
import '../../view_models/screen_controller_view_model.dart';
import 'error_screen_view.dart';
import 'loading_screen_view.dart';
import 'main_screen_view.dart';

String _currentScreenView = 'loadingScreen';

class ScreenControllerView extends StatefulWidget {
  static const ScreenControllerView _instance = ScreenControllerView._internal();
  factory ScreenControllerView() {
    return _instance;
  }
  const ScreenControllerView._internal();

  @override
  State<ScreenControllerView> createState() => _ScreenControllerViewState();
}

class _ScreenControllerViewState extends State<ScreenControllerView> {
  final ScreenControllerViewModel _vm = ScreenControllerViewModel();

  final Map<String, Widget?> screenViews = {
    'loadingScreen': const LoadingScreenView(),
    'errorScreen': const ErrorScreenView(),
    'mainScreen': const MainScreenView(),
    'loginScreen': const SigninScreenView()
  };

  _ScreenControllerViewState() {
    _currentScreenView = 'loadingScreen';

    final screenStreamSubscription = _vm.screenStreamController.stream.asBroadcastStream().listen((String event) => 
      setState(() {
        _currentScreenView = event.toString();
        print('Screen Stream event received: ${event.toString()}');
      })
    );
    screenStreamSubscription.pause();

    _init().then((value) => {
      screenStreamSubscription.resume()
    });

  }

  Future<void> _init() async {
    await _vm.initApp();
  }

  @override
  Widget build(BuildContext context) {
    return screenViews[_currentScreenView] ?? const ErrorScreenView();
  }
}
