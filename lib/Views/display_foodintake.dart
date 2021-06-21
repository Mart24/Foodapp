import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';

// When user clicks on an item in the listview, the food can be seen and deleted.

class DetailFoodIntakeView extends StatefulWidget {
  final Trip trip;

  DetailFoodIntakeView({Key key, @required this.trip}) : super(key: key);

  @override
  _DetailFoodIntakeViewState createState() => _DetailFoodIntakeViewState();
}

class _DetailFoodIntakeViewState extends State<DetailFoodIntakeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Voeding'),
              backgroundColor: Colors.green,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                  //     background: trip.getLocationImage(),
                  ),
            ),
            SliverFixedExtentList(
              itemExtent: 60.00,
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.trip.name,
                    style: TextStyle(fontSize: 40, color: Colors.green[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Aantal gram: ${widget.trip.amount.toString()}",
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Verwijder'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        await deleteFood(context);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home', (Route<dynamic> route) => false);
                      },
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future deleteFood(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("food_intake")
        .doc(widget.trip.documentId);

    return await doc.delete();
  }
}
