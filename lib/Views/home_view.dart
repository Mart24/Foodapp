import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart';
import 'package:food_app/Views/constants.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  // final List<Trip> Voedingsmiddelen = [
  //   Trip("New York", DateTime.now(), DateTime.now(), 200.00, "car"),
  //   Trip("Boston", DateTime.now(), DateTime.now(), 450.00, "plane"),
  //   Trip("Washington D.C.", DateTime.now(), DateTime.now(), 900.00, "bus"),
  //   Trip("Austin", DateTime.now(), DateTime.now(), 170.00, "car"),
  //   Trip("Scranton", DateTime.now(), DateTime.now(), 180.00, "car"),
  //];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('.... Gegeten'),
                CircularPercentIndicator(
                  radius: 125.0,
                  lineWidth: 5.0,
                  animation: true,
                  backgroundColor: Colors.white,
                  percent: 0.7,
                  center: Text(
                    "2000 Kcal",
                    style: TextStyle(fontSize: 20),
                  ),
                  progressColor: kPrimaryColor,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Text('... Verbrand')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    new LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: 0.2,
                      progressColor: Colors.red,
                    ),
                    Text('....Koolhydraten'),
                  ],
                ),
                Column(
                  children: [
                    new LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: 0.7,
                      progressColor: Colors.yellow,
                    ),
                    Text('....Eiwitten'),
                  ],
                ),
                Column(
                  children: [
                    new LinearPercentIndicator(
                      width: 100.0,
                      lineHeight: 8.0,
                      percent: 0.3,
                      progressColor: Colors.blue,
                    ),
                    Text('... Vetten'),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Co2 ... kg ', style: TextStyle(fontSize: 20)),
                new LinearPercentIndicator(
                  width: 150.0,
                  lineHeight: 15.0,
                  percent: 0.7,
                  progressColor: kPrimaryColor,
                ),
                Text('max 3.7 kg')
              ],
            ),
          ),
          Divider(),
          Text(
            "Wat heb je gegeten?",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: StreamBuilder(
              stream: getUsersTripsStreamSnapshots(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return new ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.docs[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('food_intake')
        .orderBy("eatDate", descending: true)
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return Container(
      child: InkWell(
        onDoubleTap: () {
          print('hee');
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    AutoSizeText(
                      trip['name'],
                      // style: new TextStyle(fontSize: 20.0),
                    ),
                    Spacer(),
                    Text("${trip['kcal'].toStringAsFixed(0)} Kcal"),
                  ]),
                ),
                Row(children: <Widget>[
                  // Text(
                  //     "${DateFormat('dd/MM/yyyy').format(trip['eatDate'].toDate()).toString()}" ??
                  //         null),
                ]),
                Row(
                  children: <Widget>[
                    Text(
                      "${(trip['amount'] == null) ? "n/a" : trip['amount'].toStringAsFixed(0)} gram",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    Spacer(),
                    //    Icon(Icons.emoji_nature),
                    Text("${trip['co2'].toStringAsFixed(3)} co2"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
