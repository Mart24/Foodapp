// I used the database of a tripbudget app to learn about Firebase
// Renaming the objects results in a broken app, so for now I leave it as it is.
// Trip = Foodintake. The new_food_intake folder contains the views how to select a food.

class Trip {
  int id;
  String name;
  //  DateTime startDate;
//  DateTime endDate;
  DateTime eatDate;
  double amount;
  String travelType;
  double kcal;
  double co2;
  double carbs;
  double protein;
  double fat;

  Trip(this.id, this.name, this.eatDate, this.amount, this.travelType,
      this.kcal, this.co2, this.carbs, this.protein, this.fat);

  Map<String, dynamic> toJson() => {
        'productid': id,
        'name': name,
        //     'startDate': startDate,
        //     'endDate': endDate,
        'eatDate': eatDate,
        'amount': amount,
        'travelType': travelType,
        'kcal': kcal,
        'co2': co2,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
      };
}
