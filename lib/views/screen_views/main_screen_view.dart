// Main UI screen

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_health_journal/color_palette.dart';

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

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: ColorPalette.currentColorPalette.primaryBackground,

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
  Color? get color => ColorPalette.currentColorPalette.primaryBackground;

  @override
  Widget? get child => FittedBox(
    child: Container(

      margin: EdgeInsets.only(top: _marginPadding,
                              bottom: _marginPadding, 
                              right: _marginPadding, 
                              left: _marginPadding),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        color: ColorPalette.currentColorPalette.secondaryBackground,
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
      color: ColorPalette.currentColorPalette.primaryBackground,
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
        return Icon(
            Icons.scale, 
            color: ColorPalette.currentColorPalette.text
          );
      case _NavigationButtonType.food:
        return Icon(
            Icons.food_bank, 
            color: ColorPalette.currentColorPalette.text
          );
      case _NavigationButtonType.workout:
        return Icon(
            Icons.running_with_errors, 
            color: ColorPalette.currentColorPalette.text
          );
      case _NavigationButtonType.settings:
        return Icon(
            Icons.settings, 
            color: ColorPalette.currentColorPalette.text
          );
    }
  }
}

class _Content extends Material {

  @override
  Widget? get child => Container(
    decoration: BoxDecoration(
      color: ColorPalette.currentColorPalette.primaryBackground,
      border: Border.all(color: Colors.black)
    ),
  );
}
