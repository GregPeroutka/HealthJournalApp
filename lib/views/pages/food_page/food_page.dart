import 'package:flutter/material.dart';
import 'package:my_health_journal/app_style.dart';
import 'package:my_health_journal/view_models/food_page_view_model.dart';
import 'package:my_health_journal/views/pages/food_page/food_page_header.dart';

class FoodPage extends StatefulWidget {
  final FoodPageViewModel foodPageViewModel; 
  
  const FoodPage({
    super.key,
    required this.foodPageViewModel
  });

  @override
  State<StatefulWidget> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppStyle.currentStyle.padding,
          0,
          AppStyle.currentStyle.padding,
          0
        ),
        
        child: Container(
          decoration: BoxDecoration(
            color: AppStyle.currentStyle.backgroundColor2,
            borderRadius: BorderRadius.circular(AppStyle.currentStyle.squareBorderRadius),
          ),

          child: Column(
            children: [
    
              _verticalPadding(8),

              FoodPageHeader(
                foodPageViewModel: widget.foodPageViewModel
              ),
            ],
          )
        )
      )
    );
  }

  Widget _verticalPadding(double space) {
    return Padding(padding: EdgeInsets.only(top: space));
  }
}