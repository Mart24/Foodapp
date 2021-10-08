import 'package:flutter/material.dart';
import 'package:food_app/Views/compare_feature/Search_page.dart';
import 'package:food_app/Views/constants.dart';

class CompareFeature extends StatelessWidget {
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
                builder: (context) => CompareSearch(),
              ));
        },
        label: const Text('Compare'),
        icon: const Icon(Icons.search),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
