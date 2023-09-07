import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';

class WeightPageViewModel {

  static List<WeightData> _currentData = List<WeightData>.empty();
  static bool _isDataLoaded = false;

  static Future<bool> loadData() async {
    _isDataLoaded = false;
    _currentData = await DatabaseModel.getWeightData();
    _isDataLoaded = true;

    return false;
  }

  static Future writeTodaysWeightData(double weight) async {
    Timestamp curTimestamp = Timestamp.now();
    WeightData todaysWeightData = WeightData(
      note: '', 
      timestamp: curTimestamp,
      weight: weight,
      id: curTimestamp.toDate().toString()
    );

    await DatabaseModel.writeWeightData(todaysWeightData);
    await loadData();
  }

  static Future overwriteWeightData(WeightData weightData, double newWeight) async {
    weightData.weight = newWeight;

    await DatabaseModel.writeWeightData(weightData);
    await loadData();
  }

  static Future writeWeightData(Timestamp timestamp, double weight) async {
    WeightData todaysWeightData = WeightData(
      note: '',
      timestamp: timestamp,
      weight: weight,
      id: timestamp.toDate().toString()
    );

    await DatabaseModel.writeWeightData(todaysWeightData);
    await loadData();
  }

  static List<WeightData?> getLastNDaysWeightData(int n) {

    if(!_isDataLoaded) {
      return List<WeightData?>.filled(n, null);
    }

    DateTime curTime = DateTime.now();
    List<WeightData?> curWeightData = List<WeightData?>.empty(growable: true);

    for (int i = 1; i <= n; i++) {
      // get (today - i days)'s weight data
      Iterable<WeightData> it = _currentData.where((element) {
        DateTime elementDateTime = element.timestamp.toDate();
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

  static WeightData? getTodaysWeightData() {
    DateTime curTime = DateTime.now();

    WeightData? todaysWeightData;
    try {
      todaysWeightData = _currentData.firstWhere((element) {
        DateTime elementDateTime = element.timestamp.toDate();

        return elementDateTime.year == curTime.year &&
              elementDateTime.month == curTime.month &&
              elementDateTime.day == curTime.day;
      });
    } on StateError {
      return null;
    }

    return todaysWeightData;
  }

}