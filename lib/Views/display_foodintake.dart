import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/sign_up_view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// When user clicks on an item in the listview, the food can be seen and deleted.

class DetailFoodIntakeView extends StatefulWidget {
  final Trip trip;

  DetailFoodIntakeView({Key key, @required this.trip}) : super(key: key);

  @override
  _DetailFoodIntakeViewState createState() => _DetailFoodIntakeViewState();
}

class _DetailFoodIntakeViewState extends State<DetailFoodIntakeView> {
  @override
  Widget build(BuildContext context) {
    // Map<String, double> dataMap = {
    //   "Carbs": (widget.trip.carbs.toDouble() / widget.trip.kcal) * 100,
    //   "Protein": (widget.trip.protein.toDouble() / widget.trip.kcal) * 100,
    //   "fat": (widget.trip.protein.toDouble() / widget.trip.kcal) * 100,
    // };
    final ecoscoreType = widget.trip.ecoscoreimage();
    final nutriscoreType = widget.trip.nutriscoreimage();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip.name),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await deleteFood(context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', (Route<dynamic> route) => false);
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250,
            floating: false,
            elevation: 0,
            backgroundColor: Colors.transparent,

            //   backgroundColor: Colors.white,
            flexibleSpace: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        chartValueBackgroundColor: Colors.white,
                      ),
                      colorList: [
                        Colors.green[200],
                        Colors.teal[200],
                        Colors.red[200]
                      ],
                      animationDuration: Duration(seconds: 1),
                      chartType: ChartType.ring,
                      centerText:
                          '${widget.trip.kcal.toStringAsFixed(0)} Calorieën',
                      dataMap: {
                        '${(((widget.trip.carbs.toDouble() / widget.trip.kcal) * 100) * 4).toStringAsFixed(0)} % Carbs':
                            (((widget.trip.carbs.toDouble() /
                                        widget.trip.kcal) *
                                    100) *
                                4),
                        '${(((widget.trip.protein.toDouble() / widget.trip.kcal) * 100) * 4).toStringAsFixed(0)} % Protein':
                            (((widget.trip.protein.toDouble() /
                                        widget.trip.kcal) *
                                    100) *
                                4),
                        '${(((widget.trip.fat.toDouble() / widget.trip.kcal) * 100) * 9).toStringAsFixed(0)} % Fat':
                            (((widget.trip.fat.toDouble() / widget.trip.kcal) *
                                    100) *
                                9),
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: nutriscoreType[widget.trip.nutriscore],
                            width: 100,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: ecoscoreType[widget.trip.ecoscore],
                            width: 100,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0,
            flexibleSpace: Container(
              alignment: Alignment.center,
              height: kToolbarHeight,
              color: kPrimaryColor,
              child: Text('Macronutriënten', style: TextStyle(fontSize: 20)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Table(
                          columnWidths: {
                            0: FractionColumnWidth(0.50),
                            1: FractionColumnWidth(0.30),
                          },
                          textBaseline: TextBaseline.alphabetic,
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1.0),
                                  child: Text(
                                    AppLocalizations.of(context).howmuchtext,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  '${(widget.trip.amount == null) ? "n/a" : widget.trip.amount.toStringAsFixed(0)} ${widget.trip.amountUnit ?? 'g'}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).energy,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.kcal.toStringAsFixed(0)} kcal',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  'CO₂',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.co2.toStringAsFixed(2)} kg/CO₂',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).proteinfulltext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.protein.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).fatsfulltext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.fat.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .dotssaturatedstext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.saturatedfat.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).carbsfulltext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.carbs.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).dotsfiberstext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.dietaryfiber.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  AppLocalizations.of(context).dotssugarsstext,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${widget.trip.sugars.toStringAsFixed(0)} g',
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // SliverGrid.count(
          //   crossAxisCount: 2,
          //   children: List.generate(5, (index) {
          //     return Card(
          //       color: Colors.white,
          //     );
          //   }),
          // ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            elevation: 0,
            flexibleSpace: Container(
              alignment: Alignment.center,
              height: kToolbarHeight,
              color: kPrimaryColor,
              child: Text(
                'Micronutriënten',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: List.generate(5, (index) {
              return Card(
                color: Colors.white,
              );
            }),
          ),
        ],
      ),
    );
  }

  Future deleteFood(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("food_intake")
        .doc(widget.trip.documentId);

    return await doc.delete();
  }
}
//       body: Center(
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               title: Text(widget.trip.name),
//               backgroundColor: Colors.green,
//               expandedHeight: 150.0,
//               flexibleSpace: FlexibleSpaceBar(
//                   //     background: trip.getLocationImage(),
//                   ),
//               actions: [
//                 Padding(
//                     padding: EdgeInsets.only(right: 20.0),
//                     child: GestureDetector(
//                       onTap: () async {
//                         await deleteFood(context);
//                         Navigator.of(context).pushNamedAndRemoveUntil(
//                             '/home', (Route<dynamic> route) => false);
//                       },
//                       child: Icon(
//                         Icons.delete,
//                         size: 26.0,
//                       ),
//                     )),
//               ],
//             ),
//             SliverFixedExtentList(
//               itemExtent: 60.00,
//               delegate: SliverChildListDelegate([
//                 Column(
//                   //  mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         PieChart(
//                           chartRadius: 125.0,
//                           ringStrokeWidth: 10,
//                           chartLegendSpacing: 25,
//                           initialAngleInDegree: 270,
//                           // legendOptions: LegendOptions(),
//                           chartValuesOptions: ChartValuesOptions(
//                             decimalPlaces: 2,
//                             showChartValues: false,
//                             showChartValuesInPercentage: true,
//                             showChartValuesOutside: true,
//                             chartValueBackgroundColor: Colors.white,
//                           ),
//                           colorList: [
//                             Colors.green[200],
//                             Colors.teal[200],
//                             Colors.red[200]
//                           ],
//                           animationDuration: Duration(seconds: 1),
//                           chartType: ChartType.ring,
//                           centerText:
//                               '${widget.trip.kcal.toStringAsFixed(0)} Calorieën',
//                           dataMap: {
//                             '${(((widget.trip.carbs.toDouble() / widget.trip.kcal) * 100) * 4).toStringAsFixed(0)} % Carbs':
//                                 (widget.trip.carbs.toDouble() /
//                                         widget.trip.kcal) *
//                                     100,
//                             '${(((widget.trip.protein.toDouble() / widget.trip.kcal) * 100) * 4).toStringAsFixed(0)} % Protein':
//                                 (widget.trip.protein.toDouble() /
//                                         widget.trip.kcal) *
//                                     100,
//                             '${(((widget.trip.fat.toDouble() / widget.trip.kcal) * 100) * 9).toStringAsFixed(0)} % Fat':
//                                 (widget.trip.fat.toDouble() /
//                                         widget.trip.kcal) *
//                                     100,
//                           },
//                         ),
//                       ],
//                     ),
//                     Text(
//                       "Hoeveelheid: ${(widget.trip.amount == null) ? "n/a" : widget.trip.amount.toStringAsFixed(0)} ${widget.trip.amountUnit ?? 'gram'}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                     Text(
//                       "Aantal kcal: ${widget.trip.kcal.toString()}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                     Text(
//                       "Aantal koolhy: ${widget.trip.carbs.toString()}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                     Text(
//                       "Aantal vetten: ${widget.trip.fat.toString()}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                     Text(
//                       "Aantal eiwitten: ${widget.trip.protein.toString()}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                     Text(
//                       "Aantal eiwitten: ${widget.trip.saturatedfat.toString()}",
//                       //  style: TextStyle(color: Colors.deepOrange),
//                     ),
//                   ],
//                 ),
//               ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }

 
// }
