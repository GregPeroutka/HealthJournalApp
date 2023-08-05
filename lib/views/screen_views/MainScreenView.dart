// Main UI screen

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

enum ListPosition {
  first,
  middle,
  last
}

BuildContext? _context;

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Material(
      color: Theme.of(_context!).colorScheme.primaryContainer,

      child: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          _NavigationBar()
        ],

      )
    );
  }
}

class _NavigationBar extends Material {

  final double _padding = 15;
  final double _borderRadius = 1000;

  @override
  Widget? get child => Material(
    color: Theme.of(_context!).colorScheme.primaryContainer,
    child: FittedBox(
      child: Container(

        margin: EdgeInsets.only(bottom: _padding),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
          color: Theme.of(_context!).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(100, 0, 0, 0),
              blurRadius: 4,
              spreadRadius: 2,
            )
          ]
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            _NavigationBarButton(ListPosition.first),
            _NavigationBarButton(ListPosition.middle),
            _NavigationBarButton(ListPosition.middle),
            _NavigationBarButton(ListPosition.last),

          ],
        )

      ) 
    )
  );
}

class _NavigationBarButton extends Material {

  final double _padding = 12;
  final double _radius = 55;
  ListPosition _pos = ListPosition.middle;

  @override
  Color? get color => Colors.transparent;

  @override
  Widget? get child => Container(
    width: _radius,
    height: _radius,

    margin: EdgeInsets.fromLTRB(
      _pos == ListPosition.first ? _padding : _padding / 2, 
      _padding, 
      _pos == ListPosition.last ? _padding : _padding / 2, 
      _padding
    ),

    decoration: BoxDecoration(
      color: Theme.of(_context!).colorScheme.primary,
      shape: BoxShape.circle
    ),

  );

  _NavigationBarButton(ListPosition pos) {
    _pos = pos;
  }
}
