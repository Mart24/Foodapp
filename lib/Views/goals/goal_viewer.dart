import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../constants.dart';

class GoalViewer extends StatefulWidget {
  const GoalViewer({
    Key key,
    this.co2data,
  }) : super(key: key);
  final List<Map<String, dynamic>> co2data;

  @override
  _GoalViewerState createState() => _GoalViewerState();
}

class _GoalViewerState extends State<GoalViewer> {
  @override
  void initState() {
    super.initState();
    AppCubit appCubit = AppCubit.instance(context);
    GoalCubit goalCubit = GoalCubit.instance(context);
    final uid = FirebaseAuth.instance.currentUser.uid;
    goalCubit.getGoalData(
        appCubit.database,
        uid,
        DateTime.parse(widget.co2data[0]['startDate']),
        widget.co2data[0]['co2Goal']);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoalCubit, GoalStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        if (!(state is GoalDataGetDone)) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          GoalCubit goalCubit = GoalCubit.instance(context);
          final List<Map> result = goalCubit.goalQueryResult;
          final int goal = widget.co2data[0]['co2Goal'];
          final saved = goalCubit.overallSavedSum;
          final weekSum = goalCubit.weekCo2Sum;
          final weekSaved = goalCubit.weekSavedSum;
          final toGo = goalCubit.toGo;
          final time = goalCubit.time;

          print('saved: $saved, goal:$goal');
          print('percent');
          print(saved / goal);
          return Container(
            color: const Color(0xFF379A69),
            child: Theme(
              data: Theme.of(context).copyWith(
                accentColor: const Color(0xFF27AA69).withOpacity(0.2),
              ),
              child: Scaffold(
                appBar: _AppBar(),
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _Header(image: widget.co2data[0]['image']),
                      Text(
                        '${widget.co2data[0]['goalName']}',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Table(
                        columnWidths: {
                          0: FractionColumnWidth(0.5),
                          1: FractionColumnWidth(0.5)
                        },
                        children: [
                          TableRow(children: [
                            Text(
                              'Saved ${saved.toStringAsFixed(2)} Kg/Co2',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'Goal ${goal.toStringAsFixed(2)} Kg/Co2',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ])
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Stack(children: [
                        LinearPercentIndicator(
                          animation: true,
                          // width: double.infinity,
                          lineHeight: 25.0,
                          percent: goalCubit.percent,
                          progressColor: kPrimaryColor,
                        ),
                        Center(
                            child: Text(
                          '${(goalCubit.percent * 100).toStringAsFixed(2)} %',
                          style: TextStyle(color: Colors.white),
                        )),
                      ]),
                      SizedBox(
                        height: 5,
                      ),
                      Table(
                        columnWidths: {
                          0: FractionColumnWidth(0.58),
                          1: FractionColumnWidth(0.42)
                        },
                        children: [
                          TableRow(children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Week Sum= '),
                                  TextSpan(
                                    text: '${weekSum.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/co2',
                                      style: TextStyle(fontSize: 14)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'To Go: '),
                                  TextSpan(
                                    text: '${toGo.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/co2',
                                      style: TextStyle(fontSize: 14)),
                                ])),
                          ]),
                          TableRow(children: [Container(), Container()]),
                          TableRow(children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Week Saved= '),
                                  TextSpan(
                                    text: '${weekSaved.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/co2',
                                      style: TextStyle(fontSize: 14)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Time: '),
                                  TextSpan(
                                    text: '${time.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' week',
                                      style: TextStyle(fontSize: 14)),
                                ])),
                          ])
                        ],
                      ),
                      Expanded(
                        child: Card(
                          child: SingleChildScrollView(
                            child: FittedBox(
                              child: DataTable(
                                  headingTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  columns: [
                                    DataColumn(
                                      label: Text('Day'),
                                    ),
                                    DataColumn(
                                      label: Text('Co2 eaten'),
                                    ),
                                    DataColumn(
                                      label: Text('Saved Co2 '),
                                    ),
                                  ],
                                  rows: result.reversed.map((e) {
                                    double sub = 5 - e['co2'];
                                    double cal = e['calories'];
                                    double saved =
                                        (sub < 0 || (sub == 5 && cal == 0))
                                            ? 0
                                            : sub;
                                    return DataRow(cells: [
                                      DataCell(Text(
                                          '${DateFormat.yMMMd().format(DateTime.parse(e['date']))}')),
                                      DataCell(
                                        Text(
                                          '${e['co2'].toStringAsFixed(2)} kg/co2',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          '${(saved).toStringAsFixed(2)} kg/co2',
                                        ),
                                      ),
                                    ]);
                                  }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class _Header extends StatelessWidget {
  final Uint8List image;

  _Header({
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Image.memory(image, fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: const Color(0xFF27AA69),
      // leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Text(
        'Co2',
        // style: GoogleFonts.neuton(
        //     color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Text('Are you sure you want to delete your goal'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            AppCubit cubit = AppCubit.instance(context);
                            cubit.deleteDataFromDatabase(
                                where: 'userId = ?',
                                whereArgs: [
                                  FirebaseAuth.instance.currentUser.uid
                                ],
                                tableName: 'goals');
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.delete_outline_outlined))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}
