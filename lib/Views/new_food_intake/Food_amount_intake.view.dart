import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Views/new_food_intake/summary_view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';

class NewTripBudgetView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Trip trip;
  NewTripBudgetView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _amountcontroller = TextEditingController();
    _amountcontroller.text =
        (trip.budget == null) ? "" : trip.budget.toString();

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
                  helperText: "Put in the amount eaten",
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
                trip.budget = (_amountcontroller.text == "")
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
