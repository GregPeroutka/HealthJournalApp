class WeightData {

  DateTime dateTime;
  double weight;

  WeightData({
    required this.dateTime, 
    required this.weight, 
  });
}

class FoodData {

  DateTime dateTime;
  double calories;
  double carbs;
  double protein;
  double fat;

  FoodData({
    required this.dateTime,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat
  });
}
