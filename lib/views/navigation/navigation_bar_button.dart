import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/types/navigation_types.dart';

class NavigationBarButton extends StatefulWidget {

  const NavigationBarButton({
    super.key, 

    required this.isSelected,
    this.index,
    this.pos,
    this.buttonType,
    this.buttonCallBack
  });
  
  final bool isSelected;
  final int? index;
  final NavigationBarPosition? pos;
  final NavigationBarButtonType? buttonType;
  final NavigationBarButtonCallBack? buttonCallBack;

  @override
  State<StatefulWidget> createState() => _NavigationBarButtonState();

}

class _NavigationBarButtonState extends State<NavigationBarButton>{

  final double _padding = 12;
  final double _radius = 55;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: _radius,
        height: _radius,

        margin: EdgeInsets.fromLTRB(
          widget.pos == NavigationBarPosition.first ? _padding : _padding / 2, 
          _padding, 
          widget.pos == NavigationBarPosition.last ? _padding : _padding / 2, 
          _padding
        ),

        decoration: BoxDecoration(
          color: AppStyle.currentStyle.backgroundColor1,
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: widget.isSelected ? AppStyle.currentStyle.highlightColor1 : AppStyle.currentStyle.backgroundColor1
          )
        ),

        child: IconButton(
          onPressed: () {
            widget.buttonCallBack!(widget.index!, widget.buttonType!);
          },
          icon: Icon(
            _getIcon(), 
            color: AppStyle.currentStyle.textColor1
          )
        ),

      )
    );
  }

  IconData _getIcon() {
    switch(widget.buttonType) {
      case NavigationBarButtonType.weight:
        return Icons.scale;
      case NavigationBarButtonType.food:
        return Icons.food_bank;
      case NavigationBarButtonType.workout:
        return Icons.add_card;
      case NavigationBarButtonType.settings:
        return Icons.settings;
      default:
        return Icons.error;
    }
  }

}