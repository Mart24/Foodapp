// this model is used for the SQL Database on the Food page in the application.
// I want to use this SQFLite database for searching the food name with FTS
// I have the productID and the Food name
// Then I want to connect the product ID to the food values in the Firebase database

class FooddataSQLJSON {
  int productid;
  String foodname;
  String category;
  String brand;
  int kcal;
  bool isFavorite;

  FooddataSQLJSON(
      {this.productid,
      this.foodname,
      this.category,
      this.brand,
      this.kcal,
      this.isFavorite});

  int get productidm => productid;
  String get foodnamem => foodname;
  String get categorym => category;
  String get brandm => brand;
  int get kcalm => kcal;
  bool get isFavoritem => isFavorite;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['productid'] = productid;
    map['name'] = foodname;
    map['category'] = category;
    map['brand'] = brand;
    map['kcal'] = kcal;
    return map;
  }

  factory FooddataSQLJSON.fromJson(Map<String, dynamic> json) {
    return FooddataSQLJSON(
        productid: json['productid'],
        foodname: json['name'],
        category: json['category'],
        brand: json['brand'],
        kcal: json['kcal'],
        isFavorite: json['isFavorite']);
  }

  FooddataSQLJSON.fromMapObject(Map<String, dynamic> map) {
    this.productid = map['productid'];
    this.foodname = map['name'];
    this.category = map['category'];
    this.brand = map['brand'];
    this.kcal = map['kcal'];
    this.isFavorite = map['isFavorite'];
  }

  set favorite(bool choice) {
    this.isFavorite = choice;
  }
}
