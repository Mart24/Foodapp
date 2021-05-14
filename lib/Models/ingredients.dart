// I used the database of a tripbudget app to learn about Firebase
// Renaming the objects results in a broken app, so for now I leave it as it is.
// Trip = Foodintake. The new_food_intake folder contains the views how to select a food.

class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  DateTime eatDate;
  double budget;
  String travelType;

  Trip(this.title, this.startDate, this.endDate, this.eatDate, this.budget,
      this.travelType);

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'eatDate': eatDate,
        'budget': budget,
        'travelType': travelType,
      };
}
