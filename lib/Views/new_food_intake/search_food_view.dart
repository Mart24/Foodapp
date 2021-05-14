import 'package:flutter/material.dart';
import 'package:food_app/Models/food.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Models/suggestion.dart';
import 'package:food_app/Widgets/divider_with_text_widget.dart';
import 'food_date_intake.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class NewTripLocationView extends StatelessWidget {
  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  final List<Foodsuggestion> _foodlist = [
    Foodsuggestion("Banana", 0.07566, 152, 33, 0.3, 1.8),
    Foodsuggestion("Apple", 0.0543, 76, 16.2, 0.3, 0.4),
    Foodsuggestion("Pear", 0.0429, 57, 15, 0.1, 0.4),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = trip.title;
    String barcode = 'Unknown';

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
            Text('Barcode scanner'),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: DividerWithText(
                dividerText: "Suggestions",
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _foodlist.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildFoodCard(context, index)))
          ],
        )));
  }

// return ListTile(
//                       title: Text(snapshot.data[index].productid.toString()),
//                       trailing: Text(snapshot.data[index].foodname),

  Widget buildFoodCard(BuildContext context, int index) {
    return Hero(
      tag: "SelectedTrip-${_foodlist[index].name}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Card(
            child: InkWell(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        //  Text(index.toString()),
                        Row(
                          children: [
                            Text(
                              _foodlist[index].name,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                "Climate impact ${_foodlist[index].co2.toString()}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Placeholder(
                        fallbackHeight: 50,
                        fallbackWidth: 50,
                      ),
                    ],
                  )
                ],
              ),
              onTap: () {
                trip.title = _foodlist[index].name;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTripDateView(trip: trip)),
                );
              },
            ),
          ),
        ),
      ),
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
