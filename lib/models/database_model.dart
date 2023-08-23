import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:my_health_journal/types/database_types.dart";

class DatabaseModel {

  static final _weightDataCollectionReference = FirebaseFirestore.instance.collection('user_data/weight_data/${FirebaseAuth.instance.currentUser!.uid}');

  static Future<void> writeWeightData(WeightData weightData) async {
    
    return _weightDataCollectionReference.doc().set({
      'Weight': weightData.weight,
      'Note': weightData.note,
      'TimeStamp': weightData.timestamp
    });

  }

  static Future<List<WeightData>> getWeightData() async {
    QuerySnapshot<Map<String, dynamic>> weights = await _weightDataCollectionReference.orderBy('TimeStamp').get();

    List<WeightData> weightDataList = List<WeightData>.empty(growable: true);
    for (var element in weights.docs) {
      weightDataList.add(
        WeightData(
          note: element.data()['Note'],
          timestamp: element.data()['TimeStamp'],
          weight: element.data()['Weight']
        )
      );
    }

    return weightDataList;
  }

}
