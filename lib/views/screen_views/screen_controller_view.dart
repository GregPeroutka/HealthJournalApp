// This class is the first screen that gets loaded from app startup
// The main purpose of this screen is to handle transitions between screens

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/views/screen_views/signin_screen_view.dart';
import '../../view_models/screen_controller_view_model.dart';
import 'error_screen_view.dart';
import 'loading_screen_view.dart';
import 'main_screen_view.dart';

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

  ScreenType _currentScreenType = ScreenType.loading;

  final LoadingScreenView _loadingScreenView = const LoadingScreenView();
  final ErrorScreenView _errorScreenView = const ErrorScreenView();
  final SigninScreenView _signinScreenView = const SigninScreenView();
  final MainScreenView _mainScreenView = const MainScreenView();

  StreamSubscription<ScreenType>? screenStreamSubscription;

  Map<ScreenType, Widget?> _screenViews = {};

  @override
  void initState() {

    _screenViews = {
      ScreenType.loading: _loadingScreenView,
      ScreenType.error: _errorScreenView,
      ScreenType.main: _mainScreenView,
      ScreenType.signin: _signinScreenView
    };

    ScreenControllerViewModel.initApp().then((value) => {
      screenStreamSubscription = ScreenControllerViewModel.screenBroadcastStream.listen((ScreenType screenType) => 

        setState(() {
          _currentScreenType = screenType;
          debugPrint('Screen Stream event received: ${screenType.toString()}');
        })

      )
    });

    super.initState();
  }

  @override
  void dispose() {

    screenStreamSubscription?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return _screenViews[_currentScreenType] ?? const ErrorScreenView();
  }
}
