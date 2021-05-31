import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Models/suggestion.dart';
import 'package:food_app/Services/fooddata_service_json_.dart';
import 'package:food_app/Views/new_food_registration.dart/0000food_amount.dart';
import 'package:food_app/Widgets/divider_with_text_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// This is the class for a new Food intake by the user
// It will go from NewTripLocationView (Search_food_view)
//// to NewTripDateView (food_location_view)
/// To
class NewFoodIntake extends StatefulWidget {
  final Trip trip;
  NewFoodIntake({Key key, @required this.trip}) : super(key: key);

  @override
  _NewFoodIntakeState createState() => _NewFoodIntakeState();
}

class _NewFoodIntakeState extends State<NewFoodIntake> {
  final List<Foodsuggestion> _foodlist = [
    Foodsuggestion("Banana", 0.07566, 152, 33, 0.3, 1.8),
    Foodsuggestion("Apple", 0.0543, 76, 16.2, 0.3, 0.4),
    Foodsuggestion("Pear", 0.0429, 57, 15, 0.1, 0.4),
  ];

  final dbService = DatabaseService();
  String keyword;
  Trip trip;

  @override
  Widget build(BuildContext context) {
    // TextEditingController _titleController = new TextEditingController();
    // _titleController.text = widget.trip.name;
    String barcode = 'Unknown';
    // final DatabaseService dbService;
    //  String keyword;

    return Scaffold(
      appBar: AppBar(
        title: Text('Zoek jouw product'),
        backgroundColor: Color(0xFF7AA573),
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => NewTripLocationView(
                //         trip: newTrip,
                //       ),
                //     ));
              })
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
                      border: OutlineInputBorder(), labelText: 'Typ hier iets'),
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
