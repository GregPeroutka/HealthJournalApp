import 'package:flutter/material.dart';
import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';
import 'package:my_health_journal/types/navigation_types.dart';
import 'package:my_health_journal/views/pages/weight_page/page_view_model.dart';

class WeightPageViewModel extends PageViewModel {

  @override
  PageType pageType = PageType.weight;

  List<WeightData> _currentData = List<WeightData>.empty();
  List<WeightData> get currentData => _currentData;

  WeightData? _todaysWeightData;
  WeightData? get todaysWeightData => _todaysWeightData;

  Future loadData() async {
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

  Future writeTodaysWeightData(double weight) async {
    await DatabaseModel.writeWeightData(DateTime.now(), weight);
    await loadData();
  }

  Future writeWeightData(DateTime dateTime, double weight) async {
    await DatabaseModel.writeWeightData(dateTime, weight);
    await loadData();
  }

  List<WeightData?> getLastNDaysWeightData(int n) {

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

  WeightData? getWeightData(DateTime dateTime) {

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