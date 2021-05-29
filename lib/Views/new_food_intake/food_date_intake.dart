import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'dart:async';

import 'Food_amount_intake.view.dart';

class NewTripDateView extends StatefulWidget {
  final Trip trip;

  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {
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
        //   _endDate = picked[1];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7AA573),
        title: Text('Food - Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildSelectedDetails(context, widget.trip),
            Spacer(),
            Text("Food ${widget.trip.name}"),
            // RaisedButton(
            //   child: Text("Select Dates"),
            //   onPressed: () async {
            //     await displayDateRangePicker(context);
            //   },
            // ),
            RaisedButton(
              child: Text("Eat Date"),
              onPressed: () => _selectDate(context),
              // await displayDateRangePicker(context);
              //   },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     Text(
            //         "Start Date: ${DateFormat('MM/dd/yyyy').format(_startDate).toString()}"),
            //     Text(
            //         "End Date: ${DateFormat('MM/dd/yyyy').format(_endDate).toString()}"),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    "Eating data: ${DateFormat('MM/dd/yyyy').format(_eattime).toString()}"),
              ],
            ),
            RaisedButton(
              child: Text("Continue"),
              onPressed: () {
                //  widget.trip.startDate = _startDate;
                // widget.trip.endDate = _endDate;
                widget.trip.eatDate = _eattime;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewTripBudgetView(trip: widget.trip)),
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedDetails(BuildContext context, Trip trip) {
    return Hero(
      tag: "SelectedTrip-${trip.name}",
      transitionOnUserGestures: true,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, bottom: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              AutoSizeText(trip.name,
                                  style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("100 gram "),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Kcal"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Carbs"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Fat"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Protein"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Co2"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Placeholder(
                        fallbackHeight: 100,
                        fallbackWidth: 100,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
