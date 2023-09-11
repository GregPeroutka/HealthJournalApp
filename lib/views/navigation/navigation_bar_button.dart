import 'package:flutter/material.dart';
import 'package:my_health_journal/color_palette.dart';
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
          color: ColorPalette.currentColorPalette.primaryBackground,
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: widget.isSelected ? ColorPalette.currentColorPalette.primary : ColorPalette.currentColorPalette.primaryBackground
          )
        ),

        child: IconButton(
          onPressed: () {
            widget.buttonCallBack!(widget.index!, widget.buttonType!);
          },
          icon: Icon(
            _getIcon(), 
            color: ColorPalette.currentColorPalette.text
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