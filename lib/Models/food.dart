class FoodSQL {
  final String foodid;
  final String foodname;
  final String foodcategory;
  final num kcal;
  final num co2;

  FoodSQL({this.foodid, this.foodname, this.foodcategory, this.kcal, this.co2});

  factory FoodSQL.fromJson(Map<String, dynamic> json) {
    return FoodSQL(
        foodid: json['food_id'],
        foodname: json['food_name'],
        foodcategory: json['food_category'],
        kcal: json['food_kcal'],
        co2: json['food_co2']);
  }
}
