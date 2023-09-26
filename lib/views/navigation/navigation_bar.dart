import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/views/navigation/navigation_bar_button.dart';
import 'package:my_health_journal/types/navigation_types.dart';

class NavigationBar extends StatefulWidget {
  
  final NavigationBarCallBack? changePage;

  const NavigationBar({
    super.key,

    this.changePage
  });

  @override
  State<StatefulWidget> createState() => _NavigationBarState();

}

class _NavigationBarState extends State<NavigationBar> {

  final double _marginPadding = 15;

  int selectedButtonIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: AppStyle.currentStyle.backgroundColor1,
        child: FittedBox(
          child: Container(
    
            margin: EdgeInsets.only(
              top: _marginPadding, 
              right: _marginPadding, 
              left: _marginPadding
            ),
    
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppStyle.currentStyle.completelyRoundRadius)),
              color: AppStyle.currentStyle.backgroundColor2,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(100, 0, 0, 0),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ],
            ),
    
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
    
                NavigationBarButton(
                  isSelected: selectedButtonIndex == 0,
                  index: 0,
                  pos: NavigationBarPosition.first, 
                  buttonType: NavigationBarButtonType.weight,
                  buttonCallBack: _onButtonPressed
                ),
    
                NavigationBarButton(
                  isSelected: selectedButtonIndex == 1, 
                  index: 1,
                  pos: NavigationBarPosition.middle, 
                  buttonType: NavigationBarButtonType.food,
                  buttonCallBack: _onButtonPressed
                ),
    
                NavigationBarButton(
                  isSelected: selectedButtonIndex == 2, 
                  index: 2,
                  pos: NavigationBarPosition.middle, 
                  buttonType: NavigationBarButtonType.workout,
                  buttonCallBack: _onButtonPressed
                ),
    
                NavigationBarButton(
                  isSelected: selectedButtonIndex == 3, 
                  index: 3,
                  pos: NavigationBarPosition.last, 
                  buttonType: NavigationBarButtonType.settings,
                  buttonCallBack: _onButtonPressed
                ),
    
              ],
            )
          )
        )
      ),
    );
  }

  void _onButtonPressed(int index, NavigationBarButtonType type) {

    setState(() {
      selectedButtonIndex = index;
    });
    widget.changePage!(type);
  }
}