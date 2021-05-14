import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';

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
            Text("Finish"),
            Text("food ${trip.title}"),
            // Text("Start Date ${trip.startDate}"),
            //Text("End Date ${trip.endDate}"),
            Text("Intake data ${trip.eatDate}"),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () async {
                // save data to fisebase
                final uid = await Provider.of(context).auth.getCurrentUID();
                await db
                    .collection("userData")
                    .doc(uid)
                    .collection("trips")
                    .add(trip.toJson());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        )));
  }
}

// import 'package:flutter/material.dart';
// import 'package:food_app/Models/ingredients.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:food_app/Widgets/Provider_Auth.dart';

// class NewIngredient extends StatelessWidget {
//   final db = FirebaseFirestore.instance;

//   final Ingredient ingredient;
//   NewIngredient({Key key = const Key("any_key"), @required this.ingredient})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _nameController = new TextEditingController();
//     //   _nameController.text = ingredient.name;
//     TextEditingController _categoryController = new TextEditingController();
//     //  _categoryController.text = ingredient.categorie;

//     ingredient.name = _nameController.text;
//     ingredient.categorie = _categoryController.text;

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Create Ingredient'),
//         ),
//         body: Center(
//             child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Text("Enter a Name"),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: TextField(
//                 controller: _nameController,
//                 autofocus: true,
//               ),
//             ),
//             Text("Enter a Category"),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//               child: TextField(
//                 controller: _categoryController,
//                 autofocus: true,
//               ),
//             ),
//             RaisedButton(
//               child: Text("Continue"),
//               onPressed: () async {
//                 //save to firebase
//                 final uid = await Provider.of(context).auth.getCurrentUID();
//                 await db
//                     .collection("userData")
//                     .doc(uid)
//                     .collection("ingredient")
//                     .add({
//                   'name': ingredient.name,
//                   'category': ingredient.categorie
//                 });

//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//             ),
//           ],
//         )));
//   }
// }
