import 'package:cloud_firestore/cloud_firestore.dart';

class WeightData {

  String? note;
  Timestamp timestamp;
  double weight;
  bool isBlank;
  String id;

  WeightData({required this.note, required this.timestamp, required this.weight, required this.id, this.isBlank = false});
}
