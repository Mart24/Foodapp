import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';

class HomePage extends StatelessWidget {
  // final List<Trip> Voedingsmiddelen = [
  //   Trip("New York", DateTime.now(), DateTime.now(), 200.00, "car"),
  //   Trip("Boston", DateTime.now(), DateTime.now(), 450.00, "plane"),
  //   Trip("Washington D.C.", DateTime.now(), DateTime.now(), 900.00, "bus"),
  //   Trip("Austin", DateTime.now(), DateTime.now(), 170.00, "car"),
  //   Trip("Scranton", DateTime.now(), DateTime.now(), 180.00, "car"),
  //];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text('Kcal Eaten: 400'),
          ),
          Text('Carbs Eaten: 59'),
          Text('Fat Eaten: 9'),
          Text('Proteins Eaten: 39'),
          Text('Climate Impact: 1,2kg Co2'),
          Divider(),
          Text("What you have eaten", style: TextStyle(fontSize: 20)),
          Expanded(
            child: StreamBuilder(
                stream: getUsersTripsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildTripCard(context, snapshot.data.docs[index]));
                }),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('food_intake')
        .orderBy("eatDate", descending: true)
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    trip['name'],
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                ]),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
              //   child: Row(children: <Widget>[
              //     Text(
              //         "${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),
              //     Spacer(),
              //   ]),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 15.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('dd/MM/yyyy').format(trip['eatDate'].toDate()).toString()}" ??
                          null),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${(trip['amount'] == null) ? "n/a" : trip['amount'].toStringAsFixed(0)} grams",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    Spacer(),
                    Icon(Icons.emoji_nature),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
