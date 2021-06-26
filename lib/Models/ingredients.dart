// I used the database of a tripbudget app to learn about Firebase
// Renaming the objects results in a broken app, so for now I leave it as it is.
// Trip = Foodintake. The new_food_intake folder contains the views how to select a food.

import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  int id;
  String documentId;
  double productid;
  String name;
  DateTime eatDate;
  double amound;
  String categorie;
  double ean;
  bool plantbased;
  double co2;
  double amount;
  String unit;
  String portionsize;
  double sizep1;
  String portionsize2;
  double sizep2;
  String productgroup;
  String brand;
  double kcal;
  double fat;
  double saturatedfat;
  double sugars;
  double protein;
  double carbs;
  double dietaryfiber;
  double salt;
  double alcohol;
  double natrium;
  double kalium;
  double calcium;
  double magnesium;
  double iron;
  double selenium;
  double zink;
  double vitA;
  double vitB;
  double vitC;
  double vitE;
  double vitB1;
  double vitB2;
  double vitB6;
  double vitB12;
  double foliumzuur;
  double niacine;
  double jodium;
  double fosfor;

  Trip(
      this.id,
      this.name,
      this.eatDate,
      this.amount,
      this.kcal,
      this.co2,
      this.carbs,
      this.protein,
      this.fat,
      // this.plantbased,
      // this.categorie,
      // this.ean,
      // this.brand,
      // this.amound,
      // this.portionsize,
      // this.sizep1,
      // this.portionsize2,
      // this.sizep2,
      // this.productgroup,
      // this.productid,
      // this.unit,

      this.alcohol,
      this.calcium,
      this.dietaryfiber,
      this.foliumzuur,
      this.fosfor,
      this.iron,
      this.jodium,
      this.kalium,
      this.magnesium,
      this.natrium,
      this.niacine,
      this.salt,
      this.saturatedfat,
      this.selenium,
      this.sugars,
      this.vitA,
      this.vitB,
      this.vitB1,
      this.vitB12,
      this.vitB2,
      this.vitB6,
      this.vitC,
      this.vitE,
      this.zink);

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
        // 'portionsize2': portionsize2,
        // 'sizep2': sizep2,
        // 'productgroup': productgroup,
        // 'unit': unit,
        // 'plantbased': plantbased,
        // 'categorie': categorie,
        // 'ean': ean,
        // 'brand': brand,
        // 'amound': amound,
        // 'portionsize': portionsize,
        // 'sizep1': sizep1,

        'saturatedfat': saturatedfat,
        'sugars': sugars,
        'dietaryfiber': dietaryfiber,

        // 'salt': salt,
        // 'selenium': selenium,
        // 'vitA': vitA,
        // 'vitB': vitB,
        // 'vitB1': vitB1,
        // 'vitB12': vitB12,
        // 'vitB2': vitB2,
        // 'vitB6': vitB6,
        // 'vitC': vitC,
        // 'vitE': vitE,
        // 'zink': zink,
        // 'alcohol': alcohol,
        // 'calcium': calcium,
        // 'foliumzuur': foliumzuur,
        // 'fosfor': fosfor,
        // 'iron': iron,
        // 'jodium': jodium,
        // 'kalium': kalium,
        // 'magnesium': magnesium,
        // 'natrium': natrium,
        // 'niacine': niacine,
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
        //portionsize2 = snapshot['portionsize2'],
        // sizep2 = snapshot['sizep2'],
        // productgroup = snapshot['productgroup'],
        // plantbased = snapshot['plantbased'],
        // categorie = snapshot['categorie'],
        // ean = snapshot['ean'],
        // brand = snapshot['brand'],
        // amound = snapshot['amound'],
        // portionsize = snapshot['portionsize'],
        // sizep1 = snapshot['sizep1'],

        saturatedfat = snapshot['saturatedfat'],
        sugars = snapshot['sugars'],
        dietaryfiber = snapshot['dietaryfiber'],

        // salt = snapshot['salt'],
        // selenium = snapshot['selenium'],
        // unit = snapshot['unit'],
        // vitA = snapshot['vitA'],
        // vitB = snapshot['vitB'],
        // vitB1 = snapshot['vitB1'],
        // vitB12 = snapshot['vitB12'],
        // vitB2 = snapshot['vitB2'],
        // vitB6 = snapshot['vitB6'],
        // vitC = snapshot['vitC'],
        // vitE = snapshot['vitE'],
        // zink = snapshot['zink'],
        // alcohol = snapshot['alcohol'],
        // calcium = snapshot['calcium'],
        // foliumzuur = snapshot['foliumzuur'],
        // fosfor = snapshot['fosfor'],
        // iron = snapshot['iron'],
        // jodium = snapshot['jodium'],
        // kalium = snapshot['kalium'],
        // magnesium = snapshot['magnesium'],
        // natrium = snapshot['natrium'],
        // niacine = snapshot['niacine'],

        documentId = snapshot.id;
}
