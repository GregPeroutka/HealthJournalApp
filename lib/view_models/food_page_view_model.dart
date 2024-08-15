import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/view_models/page_view_model.dart';

class FoodPageViewModel extends PageViewModel {

  @override
  PageType pageType = PageType.food;

  List<FoodData> _currentData = List<FoodData>.empty();
  List<FoodData> get currentData => _currentData;

  FoodData? _todaysFoodData;
  FoodData? get todaysFoodData => _todaysFoodData;

  final StreamController _onDataUpdatedStreamController = StreamController();
  late final Stream _onDataUpdatedStream = _onDataUpdatedStreamController.stream.asBroadcastStream();
  late final StreamSink _onDataUpdatedSink = _onDataUpdatedStreamController.sink;

  Stream get onDataUpdatedBroadcastStream => _onDataUpdatedStream;

  Future loadData() async {
    DateTime curTime = DateTime.now();

    _currentData = await DatabaseModel.getFoodData();

    try {
      _todaysFoodData = _currentData.firstWhere((element) {
        DateTime elementDateTime = element.dateTime;

        return elementDateTime.year == curTime.year &&
          elementDateTime.month == curTime.month &&
          elementDateTime.day == curTime.day;
      });
    } on StateError catch (e){
      _todaysFoodData = null;
      debugPrint(e.toString());
    }
    
    _onDataUpdatedSink.add(true);
  }

  Future writeTodaysFoodData(int calories, int carbs, int protein, int fat) async {
    await DatabaseModel.writeFoodData(DateTime.now(), calories, carbs, protein, fat);
    await loadData();
  }

  Future writeFoodData(DateTime dateTime, int calories, int carbs, int protein, int fat) async {
    await DatabaseModel.writeFoodData(dateTime, calories, carbs, protein, fat);
    await loadData();
  }

  List<FoodData?> getLastNDaysFoodData(int n) {

    DateTime curTime = DateTime.now();
    List<FoodData?> curFoodData = List<FoodData?>.empty(growable: true);

    for (int i = n; i >= 0; i--) {
      Iterable<FoodData> it = _currentData.where((element) {
        DateTime elementDateTime = element.dateTime;
        DateTime compareDateTime = curTime.subtract(Duration(days: i));

        return elementDateTime.year == compareDateTime.year &&
          elementDateTime.month == compareDateTime.month &&
          elementDateTime.day == compareDateTime.day;
      });

      if (it.isNotEmpty) {
        curFoodData.add(it.first);
      } else {
        curFoodData.add(null);
      }
    }

    return curFoodData;
  }

  FoodData? getFoodData(DateTime dateTime) {

    for(FoodData? element in _currentData) {
      if(element != null) {
        DateTime elementDateTime = element.dateTime;

        if(elementDateTime.day == dateTime.day &&
            elementDateTime.month == dateTime.month &&
            elementDateTime.year == dateTime.year) {

          return element;
        }
      }
    }

    return null;
  }
}