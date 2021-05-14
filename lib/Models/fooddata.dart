// this model is used for the SQL Database on the Food page in the application.
// I want to use this SQFLite database for searching the food name with FTS
// I have the productID and the Food name
// Then I want to connect the product ID to the food values in the Firebase database

class FooddataSQL {
  final int productid;
  final String foodname;

  FooddataSQL({this.productid, this.foodname});

  factory FooddataSQL.fromJson(Map<String, dynamic> json) {
    return FooddataSQL(productid: json['productid'], foodname: json['name']);
  }
}
