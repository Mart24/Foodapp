// this model is used for the SQL Database on the Food page in the application.
// I want to use this SQFLite database for searching the food name with FTS
// I have the productID and the Food name
// Then I want to connect the product ID to the food values in the Firebase database

class FooddataSQL {
  num productid;
  String foodname;

  FooddataSQL({this.productid, this.foodname});

  FooddataSQL.fromMap(dynamic obj) {
    this.productid = obj['productId'];
    this.foodname = obj['productName'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'productid': productid,
      'foodname': foodname,
    };

    return map;
  }
}
