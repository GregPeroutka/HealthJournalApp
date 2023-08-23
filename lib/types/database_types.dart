import 'package:cloud_firestore/cloud_firestore.dart';

class WeightData {

  String? note;
  Timestamp timestamp;
  double weight;
  bool isBlank;

  WeightData({required this.note, required this.timestamp, this.weight = 0, this.isBlank = false});
}
