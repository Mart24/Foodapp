import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Views/old_food_intake/summary_view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';

class NewTripBudgetView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Trip trip;
  NewTripBudgetView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _amountcontroller = TextEditingController();
    _amountcontroller.text =
        (trip.amount == null) ? "" : trip.amount.toString();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF7AA573),
          title: Text('Create food - amount'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Enter food amount"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _amountcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  helperText: "Put in the amount eaten in grams",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text("Finish"),
              onPressed: () async {
                // save data to fisebase
                trip.amount = (_amountcontroller.text == "")
                    ? 0
                    : double.parse(_amountcontroller.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTripSummaryView(trip: trip)),
                );
              },
            ),
          ],
        )));
  }
}
