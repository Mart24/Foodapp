import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:food_app/ingredients.dart';

class HomePage extends StatelessWidget {
  final List<ingredient> Voedingsmiddelen = [
    ingredient('banaan', 'fruit', 152, 33, 1.8, 0.5, 0.01),
    ingredient('Appel', 'fruit', 152, 33, 1.8, 0.5, 0.01),
    ingredient('Brood', 'Brood', 152, 33, 1.8, 0.5, 0.01),
    ingredient('Hagelslag', 'Broodbeleg', 152, 33, 1.8, 0.5, 0.01),
    ingredient('Ei', 'Eieren', 152, 33, 1.8, 0.5, 0.01),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: Voedingsmiddelen.length,
          itemBuilder: (BuildContext context, int index) =>
              buildVoedingsmiddelenLijst(context, index)),
    );
  }

  Widget buildVoedingsmiddelenLijst(BuildContext context, int index) {
    final ingredient = Voedingsmiddelen[index];
    return Container(
      child: Card(
          child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  ingredient.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                )
              ],
            ),
            Row(
              children: [Text(ingredient.categorie)],
            ),
          ]),
          Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              ingredient.kcal.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            )
          ]),
          SizedBox(width: 30.0),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              ingredient.co2.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ]),
        ],
        //   children: [
        // Row(  Text(ingredient.kcal.toString()),
        // ),],
      )),
    );
  }
}
