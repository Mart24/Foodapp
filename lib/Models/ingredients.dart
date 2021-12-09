// I used the database of a tripbudget app to learn about Firebase
// Renaming the objects results in a broken app, so for now I leave it as it is.
// Trip = Foodintake. The new_food_intake folder contains the views how to select a food.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Views/constants.dart';

class Trip {
  int id;
  String documentId;
  num productid;
  String name;
  DateTime eatDate;
  num amound;
  String categorie;
  num ean;
  String plantbased;
  num co2;
  num amount;
  String amountUnit;
  String unit;
  String portionsize;
  num sizep1;
  String nutriscore;
  String ecoscore;
  num sizep2;
  String productgroup;
  String brand;
  num kcal;
  num fat;
  num saturatedfat;
  num sugars;
  num protein;
  num carbs;
  num dietaryfiber;
  num salt;
  num alcohol;
  num natrium;
  num kalium;
  num calcium;
  num magnesium;
  num iron;
  num selenium;
  num zink;
  num vitA;
  num vitB;
  num vitC;
  num vitE;
  num vitB1;
  num vitB2;
  num vitB6;
  num vitB12;
  num foliumzuur;
  num niacine;
  num jodium;
  num fosfor;

  Trip(
      this.id,
      this.name,
      this.eatDate,
      this.amount,
      this.amountUnit,
      this.kcal,
      this.co2,
      this.carbs,
      this.protein,
      this.fat,
      this.plantbased,
      this.categorie,
      // this.ean,
      // this.brand,
      // this.amound,
      // this.portionsize,
      // this.sizep1,
      this.nutriscore,
      this.ecoscore,

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

  Trip.empty();

  // formatting for upload to Firbase
  Map<String, dynamic> toJson() => {
        'productid': id,
        'name': name,
        'eatDate': eatDate,
        'amount': amount,
        'amountUnit': amountUnit,

        'kcal': kcal,
        'co2': co2,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
        'nutriscore': nutriscore,
        'ecoscore': ecoscore,

        // 'sizep2': sizep2,
        // 'productgroup': productgroup,
        // 'unit': unit,
        'plantbased': plantbased,
        'categorie': categorie,
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
  Trip.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      String myAmountUnit) {
    final Map<String, dynamic> snapshotAsMap = snapshot.data();
    id = snapshotAsMap['productid'];
    name = snapshotAsMap['name'];
    // if (snapshot.data().containsKey('eatDate'))
    eatDate = snapshotAsMap['eatDate']?.toDate();
    amount = snapshotAsMap['amount'];
    amountUnit = myAmountUnit;
    kcal = snapshotAsMap['kcal'];
    co2 = snapshotAsMap['co2'];
    carbs = snapshotAsMap['carbs'];
    fat = snapshotAsMap['fat'];
    protein = snapshotAsMap['protein'];
    nutriscore = snapshotAsMap['nutriscore'];
    ecoscore = snapshotAsMap['ecoscore'];

    // sizep2 = snapshot['sizep2'];
    // productgroup = snapshot['productgroup'];
    plantbased = snapshotAsMap['plantbased'];
    categorie = snapshotAsMap['categorie'];
    // ean = snapshot['ean'];
    // brand = snapshot['brand'];
    // amound = snapshot['amound'];
    // portionsize = snapshot['portionsize'];
    // sizep1 = snapshot['sizep1'];

    saturatedfat = snapshotAsMap['saturatedfat'];
    sugars = snapshotAsMap['sugars'];
    dietaryfiber = snapshotAsMap['dietaryfiber'];

    // salt = snapshot['salt'];
    // selenium = snapshot['selenium'];
    // unit = snapshot['unit'];
    // vitA = snapshot['vitA'];
    // vitB = snapshot['vitB'];
    // vitB1 = snapshot['vitB1'];
    // vitB12 = snapshot['vitB12'];
    // vitB2 = snapshot['vitB2'];
    // vitB6 = snapshot['vitB6'];
    // vitC = snapshot['vitC'];
    // vitE = snapshot['vitE'];
    // zink = snapshot['zink'];
    // alcohol = snapshot['alcohol'];
    // calcium = snapshot['calcium'];
    // foliumzuur = snapshot['foliumzuur'];
    // fosfor = snapshot['fosfor'];
    // iron = snapshot['iron'];
    // jodium = snapshot['jodium'];
    // kalium = snapshot['kalium'];
    // magnesium = snapshot['magnesium'];
    // natrium = snapshot['natrium'];
    // niacine = snapshot['niacine'];

    documentId = snapshot.id;
  }

  Map<String, ImageIcon> planticon() => {
        "WAAR": ImageIcon(
          AssetImage("assets/icons/leaf_icon.png"),
          color: kPrimaryColor,
        ),
      };

  Map<String, Image> nutriscoreimage() => {
        "A": Image.asset("assets/scores/nutriscore_a.png"),
        "B": Image.asset("assets/scores/nutriscore_b.png"),
        "C": Image.asset("assets/scores/nutriscore_c.png"),
        "D": Image.asset("assets/scores/nutriscore_d.png"),
        "E": Image.asset("assets/scores/nutriscore_e.png"),
        "U": Image.asset("assets/scores/nutriscore_u.png"),
      };

  Map<String, Image> ecoscoreimage() => {
        "A": Image.asset("assets/scores/ecoscore_a.png"),
        "B": Image.asset("assets/scores/ecoscore_b.png"),
        "C": Image.asset("assets/scores/ecoscore_c.png"),
        "D": Image.asset("assets/scores/ecoscore_d.png"),
        "E": Image.asset("assets/scores/ecoscore_e.png"),
        "U": Image.asset("assets/scores/ecoscore_u.png"),
      };
}
