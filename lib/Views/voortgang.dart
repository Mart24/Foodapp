import 'package:flutter/material.dart';
import 'package:food_app/Models/food.dart';
import 'package:food_app/Services/food_service.dart';
//import 'package:food_app/Models/trail.dart';
//import 'package:food_app/Services/trail_service.dart';

class Voortgang extends StatefulWidget {
  @override
  _VoortgangState createState() => _VoortgangState();
}

class _VoortgangState extends State<Voortgang> {
  final dbService = DatabaseService();

  @override
  void dispose() {
    dbService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FoodSQL>>(
            future: dbService.getFoods(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].foodname),
                      subtitle: Text(snapshot.data[index].foodcategory),
                      trailing: Text(snapshot.data[index].co2.toString()),
                    );
                  });
            }));
  }
}
