import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  @override
  Widget build(BuildContext context) {
    print('rebuild dashboard');
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          BlocConsumer<DairyCubit, DairyStates>(
              listener: (BuildContext context, DairyStates states) {
            if (states is CurrentDateUpdated) {
              print('current date updated');
            } else if (states is GetUserTripsListState) {
              DairyCubit.instance(context).sumAll();
            }
          }, builder: (BuildContext context, DairyStates states) {
            DairyCubit cubit = DairyCubit.instance(context);
            double diff = cubit.kCalSum;
            double circularPercent = diff / 2000.0;
            if (circularPercent > 1) {
              circularPercent = 1;
            }
            double diff2 = cubit.co2Sum;
            double barPercent = diff2 / 3.7;
            if (barPercent > 1) {
              barPercent = 1;
            }
            return Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.updateCurrentDate(
                          cubit.currentDate.subtract(Duration(days: 1)));
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp),
                    splashRadius: 28,
                    iconSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                  TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          theme: DatePickerTheme(),
                          currentTime: cubit.currentDate ?? DateTime.now(),
                          minTime: DateTime(DateTime.now().year - 20),
                          maxTime: DateTime(DateTime.now().year + 20),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            print('confirm $date');
                            cubit.updateCurrentDate(date);
                          },
                          locale: LocaleType.en,
                        );
                      },
                      child: Text(
                        '${DateFormat.yMMMMd().format(cubit.currentDate)}',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  IconButton(
                    onPressed: () {
                      cubit.updateCurrentDate(
                          cubit.currentDate.add(Duration(days: 1)));
                    },
                    icon: Icon(Icons.arrow_forward_ios_sharp),
                    splashRadius: 28,
                    iconSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
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
                        percent: circularPercent,
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
                            color: Colors.green, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0),
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
                        Text('${cubit.carbs}g Carbs'),
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
                        Text('${cubit.protein}g Protein'),
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
                        Text('${cubit.fats}g Fat'),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Text('Co2 ${cubit.co2Sum.toStringAsFixed(1)} kg ',
                    //     style: TextStyle(fontSize: 20)),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(text: 'Co2 '),
                          TextSpan(
                            text: '${cubit.co2Sum.toStringAsFixed(1)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          TextSpan(text: 'kg', style: TextStyle(fontSize: 12)),
                        ])),
                    new LinearPercentIndicator(
                      animation: true,
                      width: 150.0,
                      lineHeight: 15.0,
                      percent: barPercent,
                      progressColor: kPrimaryColor,
                    ),
                    Text('max 3.7 kg')
                  ],
                ),
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
              // Expanded(
              //   child: Builder(
              //     builder: (context) {
              //       if (cubit.tripsList.isNotEmpty) {
              //         return ListView.builder(
              //           itemCount: cubit.tripsList.length,
              //           itemBuilder: (BuildContext context, int index) =>
              //               buildTripCard(context, cubit.tripsList[index]),
              //         );
              //       }
              //       return const Text("No items entered...");
              //     },
              //   ),
              // ),
            ]);
          }),
          BlocConsumer<DairyCubit, DairyStates>(
            listener: (context, states) {},
            builder: (context, states) {
              return Expanded(
                child: StreamBuilder(
                  stream: DairyCubit.instance(context).myStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildTripCard(context, snapshot.data.docs[index]),
                      );
                    } else {
                      return const Text("No items entered...");
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // getUsersTripsStreamSnapshots(context);
    DairyCubit.instance(context).getUsersTripsStreamSnapshots();
    super.initState();
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    final uid = FirebaseAuth.instance.currentUser.uid;

    // var now =cubit.currentDate;
    var now = (DairyCubit.instance(context) == null)
        ? DateTime.now()
        : DairyCubit.instance(context).currentDate;
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
                    Text("${trip.co2.toStringAsFixed(1)} co2"),
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

// Expanded(
//   child: StreamBuilder(
//     stream: getUsersTripsStreamSnapshots(context ),
//     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasData) {
//         foods = [];
//         foods = snapshot.data.docs;
//         print(foods);
//         DairyCubit.instance(context).sumAll();
//         final allData = snapshot.data.docs.map((doc) {
//           return doc.data();
//         }).toList();
//         print(allData);
//         //print('EatDate: ${foods[0].data()['eatDate'].toDate()}');
//
//         return ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (BuildContext context, int index) =>
//               buildTripCard(context, snapshot.data.docs[index]),
//         );
//       }
//       return const Text("Loading...");
//     },
//   ),
// ),
