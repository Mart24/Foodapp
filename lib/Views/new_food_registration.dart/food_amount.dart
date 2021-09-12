import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/new_food_registration.dart/summary.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// Step 2: The user chooses the amount he or she have eaten
// The fooddata changes due to the budgetcontroller
// When the users clicks on save, the data goes to the summary view.

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
  int _budgetTotal = 100;
  final db = FirebaseFirestore.instance;
  String categoryChoice = "Breakfast";
  List categoryItem = ["Breakfast", "Lunch", "Diner", "Snacks", "Other"];

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

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    DocumentSnapshot fooddata = await FirebaseFirestore.instance
        .collection('fdd')
        .doc(widget.trip.id.toString())
        .get();
  }

  TextEditingController _budgetController = TextEditingController()
    ..text = '100';

  @override
  void initState() {
    super.initState();
    _budgetController.addListener(_setBudgetTotal);
  }

  _setBudgetTotal() {
    setState(() {
      _budgetTotal = int.parse(_budgetController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Choose amount'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              textStyle: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: () {},
            child: Text('Melden'),
          ),
        ],
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

              //nutriscore
              String nutriscore = foodDocument['nutriscore'];
              // Plantbase string
              String plantbased = foodDocument['plantbased'];
              // Calorieën double
              double kcal = ((foodDocument['kcal'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              // Calorieën CO2
              double co2 = ((foodDocument['co2'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              // Calorieën Koolhydraten
              double koolhy = ((foodDocument['carbs'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              // Calorieën Eiwitten
              double protein = ((foodDocument['proteins'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              // Calorieën Vetten
              double fat = ((foodDocument['fat'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              double saturatedfat = ((foodDocument['saturatedfat'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              double sugars = ((foodDocument['sugars'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              double dietaryfiber = ((foodDocument['dietaryfiber'].toDouble()) *
                  ((double.tryParse(_budgetController.text) ?? 100)) *
                  0.01.toDouble());
              // double salt = ((foodDocument['salt'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double alcohol = ((foodDocument['alcohol'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double natrium = ((foodDocument['natrium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double kalium = ((foodDocument['kalium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double calcium = ((foodDocument['calcium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double magnesium = ((foodDocument['magnesium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double iron = ((foodDocument['iron'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double selenium = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double zink = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitA = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitB = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitC = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitE = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitB1 = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitB2 = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitB6 = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double vitB12 = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double foliumzuur = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double niacine = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double jodium = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());
              // double fosfor = ((foodDocument['selenium'].toDouble()) *
              //     ((double.tryParse(_budgetController.text) ?? 100)) *
              //     0.01.toDouble());

              return Container(
                child: Column(children: <Widget>[
                  FittedBox(
                    child: Text(
                      "Product: ${foodDocument['name']}",
                      style: new TextStyle(fontSize: 24.0),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Inputbar(budgetController: _budgetController),
                  ),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text(
                              "${DateFormat('dd/MM/yyyy').format(_eattime).toString()}"),
                          onPressed: () => _selectDate(context),
                          // await displayDateRangePicker(context);
                          //   },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 8.0),
                        //   child: Text(
                        //       "Datum: ${DateFormat('dd/MM/yyyy').format(_eattime).toString()}"),
                        // ),

                        DropdownButton(
                          hint: Text('Breakfast'),
                          value: categoryChoice,
                          onChanged: (newValue) {
                            setState(() {
                              categoryChoice = newValue;
                            });
                            print(categoryChoice);
                          },
                          items: categoryItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                        RaisedButton(
                          child: Text("Save"),
                          onPressed: () {
                            //  widget.trip.startDate = _startDate;
                            // widget.trip.endDate = _endDate;
                            widget.trip.kcal = kcal;
                            widget.trip.co2 = co2;
                            widget.trip.carbs = koolhy;
                            widget.trip.protein = protein;
                            widget.trip.fat = fat;
                            widget.trip.sugars = sugars;
                            widget.trip.dietaryfiber = dietaryfiber;

                            widget.trip.saturatedfat = saturatedfat;
                            widget.trip.eatDate = _eattime;
                            widget.trip.amount = (_budgetController.text == "")
                                ? 0
                                : double.parse(_budgetController.text);
                            widget.trip.categorie = categoryChoice;
                            widget.trip.plantbased = plantbased;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewFoodSummaryView(trip: widget.trip)),
                            );
                          },
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

                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Table(
                          columnWidths: {
                            0: FractionColumnWidth(0.40),
                            1: FractionColumnWidth(0.45),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${kcal.toStringAsFixed(1)} kcal",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Co²',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${co2.toStringAsFixed(1)} kg/co²",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Koolhydraten',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${koolhy.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Eiwitten',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${protein.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Vetten',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${fat.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Verzadigd vet',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${saturatedfat.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Suikers',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${sugars.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Vezels',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "${dietaryfiber.toStringAsFixed(1)} g",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Plantbased',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "$plantbased",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                            TableRow(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Nutriscore',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "$nutriscore",
                                style: TextStyle(fontSize: 18),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Calories ${kcal.toStringAsFixed(1)}",
                  //       style: new TextStyle(fontSize: 16.0),
                  //     ),
                  //     Text(
                  //       "Co2 ${co2.toStringAsFixed(2)}",
                  //       style: new TextStyle(fontSize: 16.0),
                  //     ),
                  //     Text(
                  //       "Carbs ${koolhy.toStringAsFixed(1)}",
                  //       style: new TextStyle(fontSize: 16.0),
                  //     ),
                  //     Text(
                  //       "Protein ${protein.toStringAsFixed(1)}",
                  //       style: new TextStyle(fontSize: 16.0),
                  //     ),
                  //   ],
                  // ),

                  // Text(
                  //   "Fat ${fat.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "Saturatedfat ${saturatedfat.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "Sugars ${sugars.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "Dietary Fiver ${dietaryfiber.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "plantbased $plantbased",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "nutriscore $nutriscore",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),

                  // VANAFFFF HIERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRBOVEN IS GOED
// ImageIcon(nutriscore.containsKey(trip.plantbased)
//                              ? nutriscoreimage[trip.plantbased]
//                              : nutriscoreimage["n"],)
                  // child: (plantType.containsKey(trip.plantbased))
                  //           ? plantType[trip.plantbased]
                  //           : plantType["n"],

                  // Text(
                  //   "salt ${salt.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "alcohol ${alcohol.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "natrium ${natrium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "kalium ${kalium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "calcium ${calcium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "magnesium ${magnesium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "iron ${iron.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "selenium ${selenium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "zink ${zink.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitA ${vitA.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB ${vitB.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitC ${vitC.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitE ${vitE.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB1 ${vitB1.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB2 ${vitB2.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB6 ${vitB6.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB12 ${vitB12.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "vitB6 ${vitB6.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "foliumzuur ${foliumzuur.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "niacine ${niacine.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "jodium ${jodium.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Text(
                  //   "fosfor ${fosfor.toStringAsFixed(1)}",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                ]),
              );
            }),
      ),
    );
  }
}

class Inputbar extends StatelessWidget {
  const Inputbar({
    Key key,
    @required TextEditingController budgetController,
  })  : _budgetController = budgetController,
        super(key: key);

  final TextEditingController _budgetController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _budgetController,
      maxLines: 1,
      maxLength: 4,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.linear_scale),
        helperText: "How many grams?",
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofocus: true,
    );
  }
}
