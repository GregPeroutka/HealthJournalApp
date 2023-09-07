// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide NavigationBar;
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/main_screen_view_model.dart';
import 'package:my_health_journal/views/navigation/navigation_bar.dart';
import 'package:my_health_journal/views/pages/loading_page.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_page.dart';

class MainScreenView extends StatefulWidget {

  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {

  Widget _currentPage = LoadingPage();
  StreamSubscription<PageType>? pageStreamSubscription;

  _MainScreenViewState() {

    MainScreenViewModel.loadWeight();
    
  }

  @override
  void initState() {

    pageStreamSubscription = MainScreenViewModel.pageBroadcastStream.listen((PageType pageType) {
      debugPrint('Test: $pageType');
      setState(() {
        switch (pageType) {
          case PageType.loading:
            _currentPage = LoadingPage();
          case PageType.weight:
            _currentPage = WeightPage();
          case PageType.food:
          case PageType.workout:
          case PageType.settings:
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {

    pageStreamSubscription?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Material(
      color: ColorPalette.currentColorPalette.primaryBackground,

      child: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          NavigationBar(changePage: _changePage),
          Expanded(child: _currentPage)
        ],

      )
    );
  }

  void _changePage(NavigationBarButtonType type) {
    switch(type) {
      case NavigationBarButtonType.weight:
        MainScreenViewModel.loadWeight();
      case NavigationBarButtonType.food:
        MainScreenViewModel.pageStreamSink.add(PageType.loading);
      case NavigationBarButtonType.workout:
        MainScreenViewModel.pageStreamSink.add(PageType.loading);
      case NavigationBarButtonType.settings:
        FirebaseAuth.instance.signOut();
        //MainScreenViewModel.pageStreamController.sink.add(PageType.loading);
    }
  }
}
