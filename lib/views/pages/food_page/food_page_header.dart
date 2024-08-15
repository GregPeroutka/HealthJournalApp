import 'dart:async';
import 'package:my_health_journal/app_style.dart';
import 'package:flutter/material.dart';
import 'package:my_health_journal/view_models/food_page_view_model.dart';

class FoodPageHeader extends StatefulWidget {

  final FoodPageViewModel foodPageViewModel;
  
  const FoodPageHeader({
    super.key,
    required this.foodPageViewModel
  });

  @override
  State<FoodPageHeader> createState() => _FoodPageHeaderState();
}

class _FoodPageHeaderState extends State<FoodPageHeader> {
  late final StreamSubscription _onDataUpdatedSubscription;

  @override
  void dispose() {
    _onDataUpdatedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        _header(),
      ],
    );
  }

  Center _header() {
    return Center(
      child: Text(
        'Today',
        style: TextStyle(
          color: AppStyle.currentStyle.textColor2,
          fontSize: AppStyle.currentStyle.fontSize4,
          fontWeight: FontWeight.bold,
          fontFamily: AppStyle.currentStyle.fontFamily
        ),
      ),
    );
  }
}