class FooddataSQL {
  final int productid;
  final String foodname;

  FooddataSQL({this.productid, this.foodname});

  factory FooddataSQL.fromJson(Map<String, dynamic> json) {
    return FooddataSQL(productid: json['productid'], foodname: json['name']);
  }
}
