import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Services/fooddata_service_json_.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/new_food_registration.dart/food_amount.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Step 1: his is the class for a new Food intake by the user
// The data is clicked on then sended to food_amount.dart and then send to summary.dart
// The item is caled Trip, because I used a trip database in this app. Renames breakes everything, so I let it be trips.
// Trip can be seen as Food.

class NewFoodIntake extends StatefulWidget {
  final Trip trip;
  NewFoodIntake({Key key, @required this.trip}) : super(key: key);

  @override
  _NewFoodIntakeState createState() => _NewFoodIntakeState();
}

class _NewFoodIntakeState extends State<NewFoodIntake> {
  final dbService = DatabaseService();
  String keyword;
  Trip trip;

  @override
  Widget build(BuildContext context) {
    String barcode = 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Search your product'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type something'),
                  onChanged: (value) {
                    keyword = value;
                    setState(() {});
                  },
                ),
              ),
              Container(
                height: 800,
                child: FutureBuilder<List<FooddataSQLJSON>>(
                  future: dbService.searchFooddata(keyword),
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
                            // trailing: Text(snapshot.data[index].productid.toString()),
                            onTap: () {
                              widget.trip.name = snapshot.data[index].foodname;
                              widget.trip.id = snapshot.data[index].productid;
                              // push the amount value to the summary page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FoodDate(trip: widget.trip)),
                              );
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
