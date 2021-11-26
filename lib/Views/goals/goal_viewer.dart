import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Views/sign_up_view.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          final String name = widget.co2data[0]['goalName'];
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
                //   backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _Header(
                          image: widget.co2data[0]['image'], goalname: name),
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
                            Text.rich(TextSpan(
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    //     color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context).saved),
                                  TextSpan(
                                    text: '${saved.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  TextSpan(
                                    text: ' kg/CO₂',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ])),

                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    //   color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context).goal),
                                  TextSpan(
                                    text: '${goal.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  ),
                                  TextSpan(
                                    text: ' kg/CO₂',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.end,
                            ),

                            // Text(
                            //   'Goal ${goal.toStringAsFixed(1)} Kg/Co²',
                            //   style: TextStyle(
                            //       color: Theme.of(context).primaryColor,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold),
                            //   textAlign: TextAlign.end,
                            // ),
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
                          padding: const EdgeInsets.only(top: 5.0, bottom: 10),
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
                            Text(AppLocalizations.of(context).thisweek,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                            Text(AppLocalizations.of(context).savegoal,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start),
                          ]),

                          TableRow(children: [
                            Text.rich(TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .youhaveeaten),
                                  TextSpan(
                                    text: '${weekSum.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/CO₂',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                            Text.rich(TextSpan(
                                style: TextStyle(fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .co2tosave),
                                  TextSpan(
                                    text: '${toGo.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/CO₂',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                          ]),
                          //  TableRow(children: [Container(), Container()]),
                          TableRow(children: [
                            Text.rich(TextSpan(
                                style: TextStyle(fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .yousaved),
                                  TextSpan(
                                    text: '${weekSaved.toStringAsFixed(1)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  TextSpan(
                                      text: ' kg/CO₂',
                                      style: TextStyle(fontSize: 10)),
                                ])),
                            Text.rich(TextSpan(
                                style: TextStyle(fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: AppLocalizations.of(context)
                                          .goalreachedin),
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
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Card(
                          child: SingleChildScrollView(
                            child: FittedBox(
                              child: DataTable(
                                  headingTextStyle: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                          AppLocalizations.of(context).day),
                                    ),
                                    DataColumn(
                                      label: Text(AppLocalizations.of(context)
                                          .co2eaten),
                                    ),
                                    DataColumn(
                                      label: Text(AppLocalizations.of(context)
                                          .co2saved),
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
                                          '${DateFormat.yMMMd().format(DateTime.parse(e['date']))}',
                                          style: TextStyle(fontSize: 16))),
                                      DataCell(
                                        Text(
                                            '${e['co2'].toStringAsFixed(2)} kg/CO₂',
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                      DataCell(
                                        Text(
                                            '${(saved).toStringAsFixed(2)} kg/CO₂',
                                            style: TextStyle(fontSize: 16)),
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
  final String goalname;

  _Header({this.image, this.goalname});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          //  color: Color(0xFFF9F9F9),
          // border: Border(
          //   bottom: BorderSide(
          //     color: Color(0xFFE9E9E9),
          //     // width: 1,
          //   ),
          // ),
          ),
      child: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: Image.memory(image, fit: BoxFit.fill),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                // This name should be the same as the goal name saved in the sqldatabase, Codeline 75 on this page
                child: Text(
                  goalname,
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
                  goalname,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Solid text as fill.
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Text(
                  goalname,
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
      backgroundColor: kPrimaryColor,
      // leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context).yourco2goal,
        style: GoogleFonts.alata(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(AppLocalizations.of(context).questiongoal),
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
                        child: Text(AppLocalizations.of(context).yes),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context).no),
                      )
                    ],
                  );
                });
          },
          icon: Icon(Icons.delete_outline_outlined),
          color: Colors.white,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}
