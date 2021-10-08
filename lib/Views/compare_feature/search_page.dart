import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/fooddata_json.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/new_food_registration.dart/food_amount.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_app/Services/groente_service_json_.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:food_app/Widgets/rounded_button.dart';
import 'package:food_app/shared/search_cubit.dart';

// Step 1: his is the class for a new Food intake by the user
// The data is clicked on then sended to food_amount.dart and then send to summary.dart
// The item is caled Trip, because I used a trip database in this app. Renames breakes everything, so I let it be trips.
// Trip can be seen as Food.

class CompareSearch extends StatefulWidget {
  final Trip trip;

  CompareSearch({Key key, @required this.trip}) : super(key: key);

  @override
  _CompareSearchState createState() => _CompareSearchState();
}

class _CompareSearchState extends State<CompareSearch> {
  final dbService = DatabaseGService();
  String keyword;
  Trip trip;
  String scanResult;

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = SearchCubit.instance(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search your product'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: searchCubit.scanBarcode)
        ],
      ),
      body: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is ScanValidResultReturned) {
            print('SearchValidResultReturned');
            print(searchCubit.scanResult);

            searchCubit.searchOnDb();
          } else if (state is SearchResultFound) {
            print('SearchResultFound');
            print(searchCubit.scanResult);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return FoodDate(
                trip: state.trip,
              );
            }));
          } else if (state is SearchResultNotFound) {
            print('SearchResultNotFound');
            print(searchCubit.scanResult);

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('This Product is not found currently'),
                    content: Text(
                        'we work hard to include all the product in our database, please search for a similar product or send us an email'),
                    actions: [
                      RoundedButton(
                        color: Colors.green,
                        text: 'OK',
                      )
                    ],
                  );
                });
          } else {
            print('___^----^___');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //     Text(scanResult == null ? 'Scan a code!' : 'Scan Result : $scanResult'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type something'),
                      onChanged: (value) {
                        keyword = value;
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    height: 800,
                    child: FutureBuilder<List<FooddataSQLJSON>>(
                      future: dbService.searchGFooddata(keyword),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data[index].foodname),
                                subtitle: Text(snapshot.data[index].brand),
                                // Text(snapshot.data[index].productid.toString()),
                                // trailing: Text(snapshot.data[index].productid.toString()),
                                onTap: () {
                                  widget.trip.name =
                                      snapshot.data[index].foodname;
                                  widget.trip.id =
                                      snapshot.data[index].productid;
                                  // push the amount value to the summary page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FoodDate(trip: widget.trip)),
                                  );
                                },
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
