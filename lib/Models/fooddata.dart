class FooddataSQL {
  final String productid;
  final String foodname;

  FooddataSQL({this.productid, this.foodname});

  factory FooddataSQL.fromJson(Map<String, dynamic> json) {
    return FooddataSQL(
        productid: json['product_id'], foodname: json['food_name']);
  }
}
