import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'constants.dart';

class NutritionalDetailsPage extends StatelessWidget {
  const NutritionalDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voedings Details'),
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
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: TextButton(
                                child: Text(
                                  'Voedingswaarden',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: null,
                              ),
                            ),
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
                                        'Soort',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Hoeveel',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      '%',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Grens',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        'Energie',
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
                                        'Totaal eiwitten',
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
                                        'Totaal vet',
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
                                        '        Verzadigd vet',
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
                                        'Totaal koolhydraten',
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
                                        '        Vezels',
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
                                        '        Suiker',
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
