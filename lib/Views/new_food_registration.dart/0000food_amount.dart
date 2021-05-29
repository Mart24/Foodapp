import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:food_app/Views/new_food_intake/Food_amount_intake.view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class FoodDate extends StatefulWidget {
  final Trip trip;

  FoodDate({Key key, @required this.trip}) : super(key: key);

  @override
  _FoodDateState createState() => _FoodDateState();
}

class _FoodDateState extends State<FoodDate> {
  DateTime _startDate = DateTime.now();
  DateTime _eattime = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _eattime,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != _eattime)
      setState(() {
        _eattime = pickedDate;
      });
  }

  Stream<QuerySnapshot> getFoodDataStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('fdd')
        .doc(uid)
        .collection('food_intake')
        .orderBy("eatDate", descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    DocumentSnapshot fooddata = await FirebaseFirestore.instance
        .collection('fdd')
        .doc(widget.trip.id.toString())
        .get();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _amountcontroller = TextEditingController();
    //  _amountcontroller.text = (trip.amount == null) ? "" : trip.amount.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7AA573),
        title: Text('Food - Date'),
      ),
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('fdd')
                .doc(widget.trip.id.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              var foodDocument = snapshot.data;
              int kcal = foodDocument['kcal'];
              double kcal2 = (kcal.toDouble() / 100) * 300;
              //   int kcal1 = (kcal * int.parse(_amountcontroller.text));
              return Container(
                child: Column(children: <Widget>[
                  Text(
                    "Naam ${foodDocument['name']}",
                    // "${DateFormat('dd/MM/yyyy').format(trip['eatDate'].toDate()).toString()}"
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Calorieen ${kcal.toString()}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Calorieen ${kcal2.toStringAsFixed(0)}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Co2 ${foodDocument['co2'].toString()}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Koolhydraten ${foodDocument['carbs'].toString()}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Eiwitten ${foodDocument['proteins'].toString()}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    "Vetten ${foodDocument['fat'].toString()}",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  TextField(
                    controller: _amountcontroller,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.linear_scale),
                      helperText: "Put in the amount eaten in grams",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                  ),
                  Spacer(),
                ]),
              );
            }),
      ),
    );
  }
}

//               ],
//             ),
//             RaisedButton(
//               child: Text("Continue"),
//               onPressed: () {
//                 widget.trip.eatDate = _eattime;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           NewTripBudgetView(trip: widget.trip)),
//                 );
//               },
//             ),
        // .doc(widget.trip.id.toString())