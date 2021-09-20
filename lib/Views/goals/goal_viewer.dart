import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';
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
                      // Text(
                      //   '${widget.co2data[0]['goalName']}',
                      //   style: TextStyle(
                      //     fontSize: 25,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
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
                              'Saved ${saved.toStringAsFixed(1)} Kg/Co²',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              'Goal ${goal.toStringAsFixed(1)} Kg/Co²',
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
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '${(goalCubit.percent * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      ]),

                      SizedBox(
                        height: 5,
                      ),
                      Table(
                        columnWidths: {
                          0: FractionColumnWidth(0.52),
                          1: FractionColumnWidth(0.50)
                        },
                        children: [
                          TableRow(children: [
                            Text('This week',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            Text('Save goal',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                          ]),

                          TableRow(children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'You have eaten '),
                                  TextSpan(
                                    text: '${weekSum.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/Co²',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Co² to save: '),
                                  TextSpan(
                                    text: '${toGo.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/Co²',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                          ]),
                          //  TableRow(children: [Container(), Container()]),
                          TableRow(children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'You saved '),
                                  TextSpan(
                                    text: '${weekSaved.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/Co2',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: <TextSpan>[
                                  TextSpan(text: 'Goal reached in: '),
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
                                      label: Text('Co² eaten'),
                                    ),
                                    DataColumn(
                                      label: Text('Co² saved'),
                                    ),
                                  ],
                                  rows: result.reversed.map((e) {
                                    double sub = 5 - e['co2'] as double;
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
      height: 250,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Stack(
          children: <Widget>[
            Expanded(
              child: Image.memory(image, fit: BoxFit.fill),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                // This name should be the same as the goal name saved in the sqldatabase, Codeline 75 on this page
                child: Text(
                  'Trainticket Munchen',
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 6
                      ..color = kPrimaryColor,
                  ),
                ),
              ),
            ),
            // Solid text as fill.
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Text(
                  'Trainticket Munchen',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 180.0),
            //     child: Text(
            //       "someText",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
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
        'Co2 saved',
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
