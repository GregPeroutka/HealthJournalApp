import 'package:my_health_journal/models/database_model.dart';
import 'package:my_health_journal/types/database_types.dart';

class WeightPageViewModel {

  static List<WeightData?>? _currentData = null;
  static bool get _isDataLoaded => _currentData != null;

  static Future<bool> LoadData() async {
    _currentData = await DatabaseModel.getWeightData();

    return false;
  }

  static Future<List<WeightData?>> getLastNDaysWeightData(int n) async {

    DateTime curTime = DateTime.now();
    List<WeightData> allWeightData = await DatabaseModel.getWeightData();
    List<WeightData?> curWeightData = List<WeightData?>.empty(growable: true);

    for (int i = 1; i <= n; i++) {
      // get (today - i days)'s weight data
      Iterable<WeightData> it = allWeightData.where((element) {
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

}