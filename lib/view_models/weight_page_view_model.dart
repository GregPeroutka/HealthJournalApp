import 'package:flutter/material.dart';
import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';

class WeightPageViewModel {

  static List<WeightData> _currentData = List<WeightData>.empty();
  static List<WeightData> get currentData => _currentData;

  static WeightData? _todaysWeightData;
  static WeightData? get todaysWeightData => _todaysWeightData;

  static Future loadData() async {
    DateTime curTime = DateTime.now();

    _currentData = await DatabaseModel.getWeightData();

    try {
      _todaysWeightData = _currentData.firstWhere((element) {
        DateTime elementDateTime = element.dateTime;

        return elementDateTime.year == curTime.year &&
          elementDateTime.month == curTime.month &&
          elementDateTime.day == curTime.day;
      });
    } on StateError catch (e){
      _todaysWeightData = null;
      debugPrint(e.toString());
    }
  }

  static Future writeTodaysWeightData(double weight) async {
    await DatabaseModel.writeWeightData(DateTime.now(), weight);
    await loadData();
  }

  static Future writeWeightData(DateTime dateTime, double weight) async {
    await DatabaseModel.writeWeightData(dateTime, weight);
    await loadData();
  }

  static List<WeightData?> getLastNDaysWeightData(int n) {

    DateTime curTime = DateTime.now();
    List<WeightData?> curWeightData = List<WeightData?>.empty(growable: true);

    for (int i = n; i >= 0; i--) {
      Iterable<WeightData> it = _currentData.where((element) {
        DateTime elementDateTime = element.dateTime;
        DateTime compareDateTime = curTime.subtract(Duration(days: i));

        return elementDateTime.year == compareDateTime.year &&
          elementDateTime.month == compareDateTime.month &&
          elementDateTime.day == compareDateTime.day;
      });

      if (it.isNotEmpty) {
        curWeightData.add(it.first);
      } else {
        curWeightData.add(null);
      }
    }

    return curWeightData;
  }

  static WeightData? getWeightData(DateTime dateTime) {

    for(WeightData? element in _currentData) {
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