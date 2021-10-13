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
import 'package:food_app/shared/productOne_cubit.dart';
import 'package:food_app/shared/productTwo_cubit.dart';
import 'package:food_app/shared/search_cubit.dart';

import 'comparison_view.dart';

// Step 1: his is the class for a new Food intake by the user
// The data is clicked on then sended to food_amount.dart and then send to summary.dart
// The item is caled Trip, because I used a trip database in this app. Renames breakes everything, so I let it be trips.
// Trip can be seen as Food.

class CompareSearch1 extends StatefulWidget {
  final Trip trip;

  // final int productNumber;

  CompareSearch1({
    Key key,
    @required this.trip,
    // @required this.productNumber,
  }) : super(key: key);

  @override
  _CompareSearch1State createState() => _CompareSearch1State();
}

class _CompareSearch1State extends State<CompareSearch1> {
  final dbService = DatabaseGService();
  String keyword;

  // Trip trip;
  String scanResult;



  @override
  Widget build(BuildContext context) {
    ProductOneCubit productOneCubit = ProductOneCubit.instance(context);

    // print('Comparison page of Product: ${widget.productNumber}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Search your product 1'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: productOneCubit.scanBarcode)
        ],
      ),
      body: SingleChildScrollView(
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
                      border: OutlineInputBorder(), labelText: 'Type something'),
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
                              Trip t = widget.trip;
                              t.name = snapshot.data[index].foodname;
                              t.id = snapshot.data[index].productid;
                              // push the amount value to the summary page

                              print('product1 tapped: ${t.name} ${t.id}');
                              // (ProductOneCubit.instance(context))
                              //     .deleteChosenItem();
                              (ProductOneCubit.instance(context))
                                  .searchedItemChoose(t);
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompareSearch2 extends StatefulWidget {
  final Trip trip;

  // final int productNumber;

  CompareSearch2({
    Key key,
    @required this.trip,
    // @required this.productNumber,
  }) : super(key: key);

  @override
  _CompareSearch2State createState() => _CompareSearch2State();
}

class _CompareSearch2State extends State<CompareSearch2> {
  final dbService = DatabaseGService();
  String keyword;

  // Trip trip;
  String scanResult;



  @override
  Widget build(BuildContext context) {
    ProductTwoCubit productTwoCubit = ProductTwoCubit.instance(context);

    // print('Comparison page of Product: ${widget.productNumber}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Search your product 2'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              onPressed: productTwoCubit.scanBarcode)
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Type something'),
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
                              Trip t = widget.trip;
                              t.name = snapshot.data[index].foodname;
                              t.id = snapshot.data[index].productid;
                              // push the amount value to the summary page
                              print('product2 tapped: ${t.name} ${t.id}');
                              // (ProductTwoCubit.instance(context))
                              //     .deleteChosenItem();
                              (ProductTwoCubit.instance(context))
                                  .searchedItemChoose(t);
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
