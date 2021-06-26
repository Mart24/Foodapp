import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/display_foodintake.dart';
import 'package:food_app/Views/nutrition_details_page.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DocumentSnapshot> foods = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Text(
            "<     19-06-2021     > ",
            style: TextStyle(fontSize: 20),
          ),
          BlocConsumer<DairyCubit, DairyStates>(
              listener: (BuildContext context, DairyStates states) {},
              builder: (BuildContext context, DairyStates states) {
                DairyCubit cubit = DairyCubit.instance(context);
                double diff = 2000 - cubit.kCalSum;
                return Column(children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '${cubit.kCalSum.toStringAsFixed(0)} Eaten',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: CircularPercentIndicator(
                            radius: 125.0,
                            lineWidth: 5.0,
                            animation: true,
                            backgroundColor: Colors.grey[350],
                            percent: diff / 2000.0,
                            center: Text(
                              "${diff.toStringAsFixed(0)} Kcal",
                              style: TextStyle(fontSize: 20),
                            ),
                            progressColor: kPrimaryColor,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '.......... Burned',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        )
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
                            // new LinearPercentIndicator(
                            //   width: 100.0,
                            //   lineHeight: 8.0,
                            //   percent: 0.2,
                            //   progressColor: Colors.red,
                            // ),
                            Text('${cubit.carbs} Carbs'),
                          ],
                        ),
                        Column(
                          children: [
                            // new LinearPercentIndicator(
                            //   width: 100.0,
                            //   lineHeight: 8.0,
                            //   percent: 0.7,
                            //   progressColor: Colors.yellow,
                            // ),
                            Text('${cubit.protein} Protein'),
                          ],
                        ),
                        Column(
                          children: [
                            // new LinearPercentIndicator(
                            //   width: 100.0,
                            //   lineHeight: 8.0,
                            //   percent: 0.3,
                            //   progressColor: Colors.blue,
                            // ),
                            Text('${cubit.fats} Fat'),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      DairyCubit.instance(context).calcPercents();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NutritionalDetailsPage()));
                    },
                    child: Text(
                      "Get extended overview",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ]);
              }),

          // Padding(
          //   padding: const EdgeInsets.only(top: 15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text('Co2 ... kg ', style: TextStyle(fontSize: 20)),
          //       new LinearPercentIndicator(
          //         width: 150.0,
          //         lineHeight: 15.0,
          //         percent: 0.7,
          //         progressColor: kPrimaryColor,
          //       ),
          //       Text('max 3.7 kg')
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Get extended overview",
          //         style: TextStyle(fontSize: 20),
          //       ),
          //       Icon(Icons.arrow_drop_down)
          //     ],
          //   ),
          // ),

          Expanded(
            child: StreamBuilder(
              stream: getUsersTripsStreamSnapshots(context),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  foods = [];
                  foods = snapshot.data.docs;
                  print(foods);
                  DairyCubit.instance(context).sumAll(foods);
                  final allData = snapshot.data.docs.map((doc) {
                    return doc.data();
                  }).toList();
                  print(allData);
                  //print('EatDate: ${foods[0].data()['eatDate'].toDate()}');

                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildTripCard(context, snapshot.data.docs[index]),
                  );
                }
                return const Text("Loading...");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getUsersTripsStreamSnapshots(context);
    super.initState();
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    var now = DateTime.now();
    var start = Timestamp.fromDate(DateTime(now.year, now.month, now.day));
    var end =
        Timestamp.fromDate(DateTime(now.year, now.month, now.day, 23, 59, 59));
    print('Now: $now');
    print('Start: ${start.toDate()}');
    print('End: ${end.toDate()}');
    Stream<QuerySnapshot> myStream = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('food_intake')
        .where('eatDate', isGreaterThanOrEqualTo: start)
        .where('eatDate', isLessThanOrEqualTo: end)
        .orderBy("eatDate", descending: true)
        .snapshots();

    // double sum=0;
    // myStream.first.then((value) {
    //   value.docs.forEach((element) {
    //    sum += element.data()['kcal'];
    //
    //   });
    // }).then((value) => print(sum));
    yield* myStream;
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot document) {
    final trip = Trip.fromSnapshot(document);
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailFoodIntakeView(trip: trip)),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(
                    children: <Widget>[
                      AutoSizeText(
                        trip.name,
                        // style: new TextStyle(fontSize: 20.0),
                      ),
                      Spacer(),
                      Text("${trip.kcal.toStringAsFixed(0)} Kcal"),
                    ],
                  ),
                ),
                // Row(children: <Widget>[
                //   // Text(
                //   //     "${DateFormat('dd/MM/yyyy').format(trip['eatDate'].toDate()).toString()}" ??
                //   //         null),
                // ]),
                Row(
                  children: <Widget>[
                    Text(
                      "${(trip.amount == null) ? "n/a" : trip.amount.toStringAsFixed(0)} gram",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                    Spacer(),
                    //Icon(Icons.emoji_nature),
                    // Text("${trip.co2.toStringAsFixed(3)} co2"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
