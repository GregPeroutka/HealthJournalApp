// Main UI screen

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

enum _NavigationBarPosition {
  first,
  middle,
  last
}

enum _NavigationButtonType {
  weight,
  food,
  workout,
  settings
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
          _NavigationBar(),
          Expanded(child: _Content())
        ],

      )
    );
  }
}

class _NavigationBar extends Material {

  final double _marginPadding = 15;
  final double _borderRadius = 1000;

  @override
  Color? get color => Theme.of(_context!).colorScheme.primaryContainer;

  @override
  Widget? get child => FittedBox(
    child: Container(

      margin: EdgeInsets.only(top: _marginPadding,
                              bottom: _marginPadding, 
                              right: _marginPadding, 
                              left: _marginPadding),

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

          _NavigationBarButton(_NavigationBarPosition.first, _NavigationButtonType.weight),
          _NavigationBarButton(_NavigationBarPosition.middle, _NavigationButtonType.food),
          _NavigationBarButton(_NavigationBarPosition.middle, _NavigationButtonType.workout),
          _NavigationBarButton(_NavigationBarPosition.last, _NavigationButtonType.settings),

        ],
      )
    )
  );
}

class _NavigationBarButton extends Material {

  final double _padding = 12;
  final double _radius = 55;

  final _NavigationBarPosition _pos;
  final _NavigationButtonType _type;

  const _NavigationBarButton(this._pos, this._type);

  @override
  Color? get color => Colors.transparent;

  @override
  Widget? get child => Container(
    width: _radius,
    height: _radius,

    margin: EdgeInsets.fromLTRB(
      _pos == _NavigationBarPosition.first ? _padding : _padding / 2, 
      _padding, 
      _pos == _NavigationBarPosition.last ? _padding : _padding / 2, 
      _padding
    ),

    decoration: BoxDecoration(
      color: Theme.of(_context!).colorScheme.primary,
      shape: BoxShape.circle
    ),

    child: IconButton(
      onPressed: () {},
      icon: _getIcon()
    )

  );

  Icon _getIcon() {
    switch(_type) {
      case _NavigationButtonType.weight:
        return Icon(Icons.scale);
      case _NavigationButtonType.food:
        return Icon(Icons.food_bank);
      case _NavigationButtonType.workout:
        return Icon(Icons.running_with_errors);
      case _NavigationButtonType.settings:
        return Icon(Icons.settings);
    }
  }
}

class _Content extends Material {

  @override
  Widget? get child => Container(
    decoration: BoxDecoration(
      color: Theme.of(_context!).colorScheme.primaryContainer,
      border: Border.all(color: Colors.black)
    ),
  );
}
