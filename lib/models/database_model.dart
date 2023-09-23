import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:my_health_journal/types/database_types.dart";

class DatabaseModel {

  static final _weightDataCollectionReference = FirebaseFirestore.instance.collection('user_data/weight_data/${FirebaseAuth.instance.currentUser!.uid}');

  static Future<void> writeWeightData(DateTime dateTime, double weight) async {

    return _weightDataCollectionReference.doc(dateTime.toString()).set({
      'Weight': weight,
      'TimeStamp': DateTime.timestamp()
    });

  }

  static Future<List<WeightData>> getWeightData() async {
    QuerySnapshot<Map<String, dynamic>> weights = await _weightDataCollectionReference.orderBy('TimeStamp').get();

    List<WeightData> weightDataList = List<WeightData>.empty(growable: true);
    for (var element in weights.docs) {
      weightDataList.add(
        WeightData(
          dateTime: (element.data()['TimeStamp'] as Timestamp).toDate(),
          weight: element.data()['Weight'],
          id: element.id
        )
      );
    }

    return weightDataList;
  }

}
