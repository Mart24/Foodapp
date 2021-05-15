import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:path/path.dart';

class NewTripSummaryView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Trip trip;
  NewTripSummaryView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF7AA573),
          title: Text('Food Summary'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Overview of intake",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Text("food ${trip.title}"),
            // Text("Start Date ${trip.startDate}"),
            //Text("End Date ${trip.endDate}"),
            Text(
                "Food intake data ${trip.eatDate.day}-${trip.eatDate.month}-${trip.eatDate.year}"),
            Text("amount ${trip.budget.toStringAsFixed(0)} gram"),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () async {
                // save data to firebase
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db
                    .collection("userData")
                    .doc(uid)
                    .collection("food_intake")
                    .add(trip.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        )));
  }
}
