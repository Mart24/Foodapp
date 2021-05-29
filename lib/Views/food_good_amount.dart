import 'package:flutter/material.dart';
import 'package:food_app/Models/fooddata_json.dart';

class Foodamound extends StatelessWidget {
  Foodamound(String foodname);

  // final FooddataSQLJSON food;
  // Foodamound({Key key, @required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    //  _titleController.text = food.foodname;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Food'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('he'),
          ],
        ),
      ),
    );
  }
}
