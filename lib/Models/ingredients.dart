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

  Trip(this.id, this.name, this.eatDate, this.amount, this.travelType);

  Map<String, dynamic> toJson() => {
        'productname': id,
        'name': name,
        //     'startDate': startDate,
        //     'endDate': endDate,
        'eatDate': eatDate,
        'amount': amount,
        'travelType': travelType,
      };
}
