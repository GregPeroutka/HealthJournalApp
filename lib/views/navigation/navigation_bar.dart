import 'package:flutter/material.dart';
import 'package:my_health_journal/color_palette.dart';
import 'package:my_health_journal/views/navigation/navigation_bar_button.dart';
import 'package:my_health_journal/views/navigation/navigation_types.dart';

class NavigationBar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NavigationBarState();

}

class _NavigationBarState extends State<NavigationBar> {

  final double _marginPadding = 15;
  final double _borderRadius = 1000;

  int selectedButtonIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorPalette.currentColorPalette.primaryBackground,
      child: FittedBox(
        child: Container(

          margin: EdgeInsets.only(top: _marginPadding,
                                  bottom: _marginPadding, 
                                  right: _marginPadding, 
                                  left: _marginPadding),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
            color: ColorPalette.currentColorPalette.secondaryBackground,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(100, 0, 0, 0),
                blurRadius: 4,
                spreadRadius: 2,
              )
            ]
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              NavigationBarButton(
                isSelected: selectedButtonIndex == 0,
                index: 0,
                pos: NavigationBarPosition.first, 
                buttonType: NavigationBarType.weight,
                buttonCallBack: _onButtonPressed
              ),

              NavigationBarButton(
                isSelected: selectedButtonIndex == 1, 
                index: 1,
                pos: NavigationBarPosition.middle, 
                buttonType: NavigationBarType.food,
                buttonCallBack: _onButtonPressed
              ),

              NavigationBarButton(
                isSelected: selectedButtonIndex == 2, 
                index: 2,
                pos: NavigationBarPosition.middle, 
                buttonType: NavigationBarType.workout,
                buttonCallBack: _onButtonPressed
              ),

              NavigationBarButton(
                isSelected: selectedButtonIndex == 3, 
                index: 3,
                pos: NavigationBarPosition.last, 
                buttonType: NavigationBarType.settings,
                buttonCallBack: _onButtonPressed
              ),

            ],
          )
        )
      )
    );
  }

  void _onButtonPressed(int index, NavigationBarType type) {
    debugPrint('Call Back Test');

    setState(() {
      selectedButtonIndex = index;
    });

    debugPrint('enabledButtonIndex: $index');
    debugPrint('enabledButtonIndex: $type');

  }
}