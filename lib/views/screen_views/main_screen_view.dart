import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide NavigationBar;
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/main_screen_view_model.dart';
import 'package:my_health_journal/view_models/weight_page_view_model.dart';
import 'package:my_health_journal/views/navigation/navigation_bar.dart';
import 'package:my_health_journal/views/pages/loading_page.dart';
import 'package:my_health_journal/view_models/page_view_model.dart';
import 'package:my_health_journal/views/pages/weight_page/weight_page.dart';

class MainScreenView extends StatefulWidget {
  final MainScreenViewModel mainScreenViewModel;

  const MainScreenView({
    super.key,
    required this.mainScreenViewModel
  });

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {

  Widget _currentPage = const LoadingPage();
  StreamSubscription<PageViewModel>? pageStreamSubscription;

  @override
  void initState() {

    pageStreamSubscription = widget.mainScreenViewModel.pageBroadcastStream.listen((PageViewModel pageViewModel) {
      debugPrint('Test: ${pageViewModel.pageType}');
      setState(() {
        switch (pageViewModel.pageType) {
          case PageType.loading:
            _currentPage = const LoadingPage();
          case PageType.weight:
            _currentPage = WeightPage(weightPageViewModel: pageViewModel as WeightPageViewModel);
          case PageType.food:
          case PageType.workout:
          case PageType.settings:
        }
      });
    });

    widget.mainScreenViewModel.loadWeight();

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
      color: AppStyle.currentStyle.backgroundColor1,

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
        widget.mainScreenViewModel.loadWeight();
      case NavigationBarButtonType.food:
        setState(() {
          _currentPage = const LoadingPage();
        });
      case NavigationBarButtonType.workout:
        setState(() {
          _currentPage = const LoadingPage();
        });
      case NavigationBarButtonType.settings:
        FirebaseAuth.instance.signOut();
        //MainScreenViewModel.pageStreamController.sink.add(PageType.loading);
    }
  }
}
