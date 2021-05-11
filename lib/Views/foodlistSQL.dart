import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata.dart';
import 'package:food_app/Services/fooddata_service.dart';

class Foodpage extends StatefulWidget {
  @override
  _FoodpageState createState() => _FoodpageState();
}

class _FoodpageState extends State<Foodpage> {
  final dbService = DatabaseService();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FooddataSQL>>(
            future: dbService.getFooddata(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].productid.toString()),
                      trailing: Text(snapshot.data[index].foodname),
                    );
                  });
            }));
  }
}
