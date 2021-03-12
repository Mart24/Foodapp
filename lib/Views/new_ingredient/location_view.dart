import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'date_view.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Trip - Location'),
          backgroundColor: Color(0xFF7AA573),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Enter a Location"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () {
                trip.title = _titleController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTripDateView(trip: trip)),
                );
              },
            ),
          ],
        )));
  }
}
