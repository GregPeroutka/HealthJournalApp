import 'dart:async';
import 'package:my_health_journal/app_style.dart';
import 'package:flutter/material.dart';
import 'package:my_health_journal/view_models/food_page_view_model.dart';
import 'package:my_health_journal/views/pages/food_page/food_dialog.dart';

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
  final TextEditingController _caloriesTextController = TextEditingController();
  final TextEditingController _carbsTextController = TextEditingController();
  final TextEditingController _proteinTextController = TextEditingController();
  final TextEditingController _fatTextController = TextEditingController();
  late final StreamSubscription _onDataUpdatedSubscription;

@override
  void initState() {
    _onDataUpdatedSubscription = widget.foodPageViewModel.onDataUpdatedBroadcastStream.listen((event) => setState(() {}));
    super.initState();
  }

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
        _mainBody()
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

  Widget _mainBody() {
    if(widget.foodPageViewModel.todaysFoodData == null) {
      return _addTodaysFoodHeader();
    } else {
      return _displayAndEditTodaysFoodHeader();
    }
  }

  Widget _addTodaysFoodHeader() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppStyle.currentStyle.highlightColor1,
        borderRadius: BorderRadius.circular(AppStyle.currentStyle.completelyRoundRadius)
      ),
      child: TextButton(
        onPressed: () => {

          _caloriesTextController.text = '',
          _addFoodShowDialog()

        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Log Food',
            style: TextStyle(
              color: AppStyle.currentStyle.textColor1,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }

  Future<dynamic> _addFoodShowDialog() {
    return showDialog(
      context: context, 
      builder: (context) {

        return FoodDialog(
          onDone: () {
            try {
              int calories = int.parse(_caloriesTextController.text);
              int carbs = int.parse(_carbsTextController.text);
              int protein = int.parse(_proteinTextController.text);
              int fat = int.parse(_fatTextController.text);
              widget.foodPageViewModel.writeTodaysFoodData(calories, carbs, protein, fat).then((value) => Navigator.of(context).pop());
            } on FormatException catch (e) {
              debugPrint(e.toString());
            }
          },
          textEditingController: _caloriesTextController, 
        ); 
      }
    );
  }

  Widget _displayAndEditTodaysFoodHeader() {
    int todaysFood = (widget.foodPageViewModel.todaysFoodData) != null
      ? widget.foodPageViewModel.todaysFoodData!.calories
      : -1;

    return Stack(
      alignment: Alignment.center,
      children: [
        _currentFoodText(todaysFood),
        _editCurrentFoodButton(todaysFood)
      ],
    );
  }

  Align _editCurrentFoodButton(int todaysFood) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () {

            _caloriesTextController.text = todaysFood.toString();

            _editFoodShowDialog(todaysFood);
          },
          icon: Icon(
            Icons.edit,
            size: 24,
            color: AppStyle.currentStyle.textColor2
          )
        ),
      ),
    );
  }

  Text _currentFoodText(int todaysFood) {
    return Text(
      '$todaysFood cal',
      style: TextStyle(
        color: AppStyle.currentStyle.textColor1,
        fontSize: 50,
        fontWeight: FontWeight.bold,
        fontFamily: "Rubik",
      ),
    );
  }

  Future<dynamic> _editFoodShowDialog(int todaysFood) {
    return showDialog(
      context: context, 
      builder: (context) {

        return FoodDialog(
          onDone: () {
            try {
              int inputFood = int.parse(_caloriesTextController.text);
              if(todaysFood != inputFood) {
                widget.foodPageViewModel.writeTodaysFoodData(inputFood, 0, 0, 0).then((value) => Navigator.of(context).pop());
              } else {
                Navigator.of(context).pop();
              }
              
            } on FormatException catch (e) {
              debugPrint(e.toString());
            }
          },
          textEditingController: _caloriesTextController, 
        );
      }
    );
  }
}