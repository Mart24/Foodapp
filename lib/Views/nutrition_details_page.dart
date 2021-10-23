import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';

class NutritionalDetailsPage extends StatelessWidget {
  const NutritionalDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).fooddetailstext),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocConsumer<DairyCubit, DairyStates>(
          listener: (BuildContext context, DairyStates states) {},
          builder: (BuildContext context, DairyStates states) {
            DairyCubit cubit = DairyCubit.instance(context);
            print(cubit.proteinPercent);
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PieChart(
                            chartRadius: 125.0,
                            ringStrokeWidth: 10,
                            chartLegendSpacing: 25,
                            initialAngleInDegree: 270,
                            // legendOptions: LegendOptions(),
                            chartValuesOptions: ChartValuesOptions(
                              decimalPlaces: 2,
                              showChartValues: false,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: true,
                              chartValueBackgroundColor: Colors.transparent,
                            ),
                            colorList: [
                              Colors.green[200],
                              Colors.teal[200],
                              Colors.red[200]
                            ],
                            animationDuration: Duration(seconds: 1),
                            dataMap: {
                              '${cubit.fatPercent.toStringAsFixed(0)}% Vet':
                                  cubit.fatPercent,
                              '${cubit.carbsPercent.toStringAsFixed(0)}% Koolhydraten':
                                  cubit.carbsPercent,
                              '${cubit.proteinPercent.toStringAsFixed(0)}% Eiwitten':
                                  cubit.proteinPercent,
                            },
                            centerText:
                                '${cubit.kCalSum.toStringAsFixed(0)} Calorieën',
                            chartType: ChartType.ring,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              AppLocalizations.of(context).nutritiontext,
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.info), color: kPrimaryColor,
                            // tooltip: 'Increase volume by 10',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                            },
                          ),
                          // onPressed: () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) =>
                          //         _buildPopupDialog(context),
                          //   );
                          // },
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Table(
                                columnWidths: {
                                  0: FractionColumnWidth(0.52),
                                  1: FractionColumnWidth(0.22),
                                  2: FractionColumnWidth(0.12),
                                  3: FractionColumnWidth(0.15)
                                },
                                textBaseline: TextBaseline.alphabetic,
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context).typetext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).howmuchtext,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      AppLocalizations.of(context).advicetext,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),

                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context).energy,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.kCalSum.toStringAsFixed(0)}kcal',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${(100 - ((2000 - cubit.kCalSum) / 2000) * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .totallproteintext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.protein.toStringAsFixed(0)}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.proteinPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .totalfattext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.fats}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.fatPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .dotssaturatedstext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.saturatedFat}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.saturatedFatPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '10%',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .totalcarbstext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.carbs.toStringAsFixed(0)}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.carbsPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .dotsfiberstext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.dietaryFiber}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.dietaryFiberPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '30-40g',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .dotssugarsstext,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      '${cubit.sugars.toStringAsFixed(0)}g',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '${cubit.sugarsPercent.toStringAsFixed(0)}%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '60g',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    )
                                  ]),
                                  // TableRow(children: [
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsets.symmetric(vertical: 10.0),
                                  //     child: Text(
                                  //       '        Suiker',
                                  //       style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  //   Text(
                                  //     '${cubit.sugars.toStringAsFixed(0)}g',
                                  //     style: TextStyle(fontSize: 18),
                                  //   ),
                                  //   Text(
                                  //     '${cubit.sugarsPercent.toStringAsFixed(0)}%',
                                  //     style: TextStyle(fontSize: 16),
                                  //   ),
                                  //   Text(
                                  //     '60g',
                                  //     style:
                                  //         TextStyle(fontSize: 16, color: Colors.red),
                                  //   )
                                  // ]),
                                  // TableRow(children: [
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsets.symmetric(vertical: 10.0),
                                  //     child: Text(
                                  //       '        Suiker',
                                  //       style: TextStyle(
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  //   Text(
                                  //     '${cubit.sugars.toStringAsFixed(0)}g',
                                  //     style: TextStyle(fontSize: 18),
                                  //   ),
                                  //   Text(
                                  //     '${cubit.sugarsPercent.toStringAsFixed(0)}%',
                                  //     style: TextStyle(fontSize: 16),
                                  //   ),
                                  //   Text(
                                  //     '60g',
                                  //     style:
                                  //         TextStyle(fontSize: 16, color: Colors.red),
                                  //   )
                                  // ]),
                                  // TableRow(children: [
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsets.symmetric(vertical: 10.0),
                                  //     child: Text(
                                  //       'Cholesterol',
                                  //       style: TextStyle(
                                  //           fontSize: 18, fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  //   Text(
                                  //     '3g',
                                  //     style: TextStyle(fontSize: 18),
                                  //   ),
                                  //   Text(
                                  //     '3%',
                                  //     style: TextStyle(fontSize: 18),
                                  //   ),
                                  // ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text(
      'Richtlijn Voedingscentrum',
      style: TextStyle(fontSize: 18),
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
            text: TextSpan(
                style: GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                children: <TextSpan>[
              TextSpan(
                  text:
                      'Let op: Dit zijn richtlijnen. Met een gevarieerd dieet krijg je de juiste voedingsstoffen binnen. '),
              TextSpan(
                text: 'Rood',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              TextSpan(
                  text: ' is het maximale en ', style: TextStyle(fontSize: 16)),
              TextSpan(
                text: 'Groen',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              TextSpan(
                  text:
                      ' staat voor de minimale consumptie per dag. Voor meer informatie, kijk op de website voedingscentrum.nl',
                  style: TextStyle(fontSize: 16)),
            ])),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Sluit'),
      ),
    ],
  );
}
