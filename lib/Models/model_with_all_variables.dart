// model if necessary I already made it with all the values.
// This model is not used at this moment, but will be used later.
// Or the items can be added to the ingredients.dart model

class FoodDataFirebase {
  final num productid;
  final String name;
  DateTime eatDate;
  double amound;
  final String categorie;
  final num ean;
  final bool plantbased;
  final num co2;
  final num amount;
  final String unit;
  final String portionsize;
  final num sizep1;
  final String portionsize2;
  final num sizep2;
  final String productgroup;
  final String brand;
  final num kcal;
  final num fat;
  final num saturatedfat;
  final num sugars;
  final num proteins;
  final num carbs;
  final num dietaryfiber;
  final num salt;
  final num alcohol;
  final num natrium;
  final num kalium;
  final num calcium;
  final num magnesium;
  final num iron;
  final num selenium;
  final num zink;
  final num vitA;
  final num vitB;
  final num vitC;
  final num vitE;
  final num vitB1;
  final num vitB2;
  final num vitB6;
  final num vitB12;
  final num foliumzuur;
  final num niacine;
  final num jodium;
  final num fosfor;

  FoodDataFirebase(
      {this.productid,
      this.name,
      this.categorie,
      this.ean,
      this.plantbased,
      this.co2,
      this.amount,
      this.unit,
      this.portionsize,
      this.sizep1,
      this.portionsize2,
      this.sizep2,
      this.productgroup,
      this.brand,
      this.kcal,
      this.fat,
      this.saturatedfat,
      this.sugars,
      this.proteins,
      this.carbs,
      this.dietaryfiber,
      this.salt,
      this.alcohol,
      this.natrium,
      this.kalium,
      this.calcium,
      this.magnesium,
      this.iron,
      this.selenium,
      this.zink,
      this.vitA,
      this.vitB,
      this.vitC,
      this.vitB1,
      this.vitB2,
      this.vitB6,
      this.vitB12,
      this.vitE,
      this.foliumzuur,
      this.niacine,
      this.jodium,
      this.fosfor});

  Map<String, dynamic> toJson() => {
        'productname': productid,
        'name': name,
        'eatDate': eatDate,
        'amount': amound,
      };
}
