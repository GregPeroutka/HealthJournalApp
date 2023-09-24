import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:intl/intl.dart";
import "package:my_health_journal/types/database_types.dart";

class DatabaseModel {

  static final _weightDataCollectionReference = FirebaseFirestore.instance.collection('user_data/weight_data/${FirebaseAuth.instance.currentUser!.uid}');
  static final DateFormat dateToIdFormatter = DateFormat('yyyy-MM-dd');


  static Future<void> writeWeightData(DateTime dateTime, double weight) async {

    return _weightDataCollectionReference.doc(_getId(dateTime)).set({
      'Weight': weight
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

  static String _getId(DateTime dateTime) {
    return dateToIdFormatter.format(dateTime);
  }

  static DateTime _getDateTime(String id) {
    return DateTime.parse(id);
  }
}
