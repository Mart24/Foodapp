import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
            return Container(
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
                            '${cubit.fatPercent}% Vet': cubit.fatPercent,
                            '${cubit.carbsPercent}% Koolhydraten':
                                cubit.carbsPercent,
                            '${cubit.proteinPercent}% Eiwitten':
                                cubit.proteinPercent,
                          },
                          centerText: '${cubit.kCalSum} Calorieën',
                          chartType: ChartType.ring,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Macronutriënten',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: null,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Table(
                        columnWidths: {
                          0: FractionColumnWidth(0.55),
                          1: FractionColumnWidth(0.28),
                          2: FractionColumnWidth(0.2)
                        },
                        textBaseline: TextBaseline.alphabetic,
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Energie',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.kCalSum} kCal',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${(100 - ((2000 - cubit.kCalSum) / 2000) * 100).toStringAsFixed(1)} %',
                              style: TextStyle(fontSize: 16),
                            ),
                            // Text(
                            //   '100 %',
                            //   style: TextStyle(fontSize: 16),
                            // ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Totaal eiwitten',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.protein}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.proteinPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Totaal vet',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.fats}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.fatPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                '        Verzadigd vet',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.saturatedFat}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.saturatedFatPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Totaal koolhydraten',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.carbs}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.carbsPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                '        Vezels',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.dietaryFiber}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.dietaryFiberPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                '        Suiker',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${cubit.sugars}g',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '${cubit.sugarsPercent}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
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
                  ),
                  TextButton(
                    child: Text(
                      'Micronutriënten',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
