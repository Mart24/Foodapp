import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/constants.dart';

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
      body: const Center(
        child: Text('Press the button to start searching for products!'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompareSearch(
                  trip: newTrip,
                ),
              ));
        },
        label: const Text('Compare'),
        icon: const Icon(Icons.search),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
