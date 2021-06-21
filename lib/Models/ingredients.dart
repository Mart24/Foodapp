// I used the database of a tripbudget app to learn about Firebase
// Renaming the objects results in a broken app, so for now I leave it as it is.
// Trip = Foodintake. The new_food_intake folder contains the views how to select a food.

import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  int id;
  String name;
  //  DateTime startDate;
//  DateTime endDate;
  DateTime eatDate;
  double amount;
  double kcal;
  double co2;
  double carbs;
  double protein;
  double fat;
  String documentId;

  Trip(this.id, this.name, this.eatDate, this.amount, this.kcal, this.co2,
      this.carbs, this.protein, this.fat);

  // formatting for upload to Firbase
  Map<String, dynamic> toJson() => {
        'productid': id,
        'name': name,
        'eatDate': eatDate,
        'amount': amount,
        'kcal': kcal,
        'co2': co2,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
      };

  // creating a Food object from a firebase snapshot
  Trip.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot['productid'],
        name = snapshot['name'],
        eatDate = snapshot['eatDate'].toDate(),
        amount = snapshot['amount'],
        kcal = snapshot['kcal'],
        co2 = snapshot['co2'],
        carbs = snapshot['carbs'],
        protein = snapshot['protein'],
        fat = snapshot['fat'],
        documentId = snapshot.id;
}
