import 'package:flutter/material.dart';
import 'package:food_app/Models/food.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Models/suggestion.dart';
import 'date_view.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  final List<Foodsuggestion> _foodlist = [
    Foodsuggestion("Banana", 0.07566, 100),
    Foodsuggestion("Apple", 0.0543, 100),
    Foodsuggestion("Pear", 0.0429, 100),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = trip.title;

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Food'),
          backgroundColor: Color(0xFF7AA573),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: DividerWithText(
                dividerText: "Suggestions",
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _foodlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                      child: Column(
                    children: [
                      Text(index.toString()),
                      Text(_foodlist[index].name)
                    ],
                  )),
                );
              },
            ))
          ],
        )));
  }
}

class DividerWithText extends StatelessWidget {
  final String dividerText;
  const DividerWithText({Key key, @required this.dividerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Divider(),
        )),
        Text("Sugggestions"),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Divider(),
        )),
      ],
    );
  }
}

// RaisedButton(
//               child: Text("Continue"),
//               onPressed: () {
//                 trip.title = _titleController.text;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => NewTripDateView(trip: trip)),
//                 );
//               },
//             ),
