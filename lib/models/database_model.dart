import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:intl/intl.dart";
import "package:my_health_journal/types/database_types.dart";

class DatabaseModel {

  static final _weightDataCollectionReference = FirebaseFirestore.instance.collection('user_data/weight_data/${FirebaseAuth.instance.currentUser!.uid}');
  static final _foodDataCollectionReference = FirebaseFirestore.instance.collection('user_data/food_data/${FirebaseAuth.instance.currentUser!.uid}');
  static final DateFormat dateToIdFormatter = DateFormat('yyyy-MM-dd');


  static Future<void> writeWeightData(DateTime dateTime, double weight) async {

    return _weightDataCollectionReference.doc(_getId(dateTime)).set({
      'Weight': weight
    });

  }

  static Future<void> writeFoodData(DateTime dateTime, int calories, int carbs, int protein, int fat) async {

    return _foodDataCollectionReference.doc(_getId(dateTime)).set({
      'Calories': calories,
      'Carbs': carbs,
      'Protein': protein,
      'Fat': fat
    });

  }

  static Future<List<WeightData>> getWeightData() async {
    QuerySnapshot<Map<String, dynamic>> weights = await _weightDataCollectionReference.get();

    List<WeightData> weightDataList = List<WeightData>.empty(growable: true);
    for (var element in weights.docs) {
      weightDataList.add(
        WeightData(
          dateTime: _getDateTime(element.id),
          weight: element.data()['Weight']
        )
      );
    }

    return weightDataList;
  }

  static Future<List<FoodData>> getFoodData() async {
    QuerySnapshot<Map<String, dynamic>> foods = await _foodDataCollectionReference.get();

    List<FoodData> foodDataList = List<FoodData>.empty(growable: true);
    for (var element in foods.docs) {
      foodDataList.add(
        FoodData(
          dateTime: _getDateTime(element.id),
          calories: element.data()['Calories'],
          carbs: element.data()['Carbs'],
          protein: element.data()['Protein'],
          fat: element.data()['Fat']
        )
      );
    }

    return foodDataList;
  }
  

  static String _getId(DateTime dateTime) {
    return dateToIdFormatter.format(dateTime);
  }

  static DateTime _getDateTime(String id) {
    return DateTime.parse(id);
  }
}
