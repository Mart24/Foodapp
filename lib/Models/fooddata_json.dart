// this model is used for the SQL Database on the Food page in the application.
// I want to use this SQFLite database for searching the food name with FTS
// I have the productID and the Food name
// Then I want to connect the product ID to the food values in the Firebase database

class FooddataSQLJSON {
  int productid;
  String foodname;
  String category;
  String brand;

  FooddataSQLJSON({this.productid, this.foodname, this.category, this.brand});

  factory FooddataSQLJSON.fromJson(Map<String, dynamic> json) {
    return FooddataSQLJSON(
        productid: json['productid'],
        foodname: json['name'],
        category: json['category'],
        brand: json['brand']);
  }
}
