import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/compare_feature/comparison_view.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/shared/productOne_cubit.dart';
import 'package:food_app/shared/productTwo_cubit.dart';

import 'comparison_search_page.dart';

class CompareFeature extends StatelessWidget {
  final newTrip = Trip(
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      // null,
      // null,
      // null,
      // null,
      // null,
      // null,
      // null,
      // null,
      null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare products'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(2),
        height: double.infinity,
        // color: Colors.black,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  height: double.infinity,
                  child: BlocConsumer<ProductOneCubit, ProductOneStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is SearchResultFound1) {
                          return ComparisonView(trip: state.trip, productNumber: 1,);
                        } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                  heroTag:'product1',

                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CompareSearch(
                                            trip: newTrip,
                                            productNumber: 1,
                                          ),
                                        ));
                                  },
                                  label: const Text('1st product'),
                                  icon: const Icon(Icons.search),
                                  backgroundColor: kPrimaryColor,
                                ),
                              ]);
                        }
                      }),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  color: Colors.green,
                  child: BlocConsumer<ProductTwoCubit, ProductTwoStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is SearchResultFound2) {
                          return ComparisonView(trip: state.trip, productNumber: 2,);
                        } else {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton.extended(
                                  heroTag:'product2',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CompareSearch(
                                            trip: newTrip,
                                            productNumber: 2,
                                          ),
                                        ));
                                  },
                                  label: const Text('2nd product'),
                                  icon: const Icon(Icons.search),
                                  backgroundColor: kPrimaryColor,
                                ),
                              ]);
                        }
                      }),
                ),
              ),
            ]),
      ),
    );
  }
}
