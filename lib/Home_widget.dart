import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Pages.dart';
import 'package:food_app/Views/home_view.dart';
import 'package:food_app/Views/new_ingredient/ingredient_input.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Services/auth_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Voeding(),
    Voortgang(),
    Profiel(),
    Lijstje(),
  ];

  @override
  Widget build(BuildContext context) {
    final newIngred = new Ingredient('Mandarijn', 'Fruit', 0, 0, 0, 0, 0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Voedingsapp"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewIngredient(ingredient: newIngred),
                    ));
              }),
          IconButton(
            icon: Icon(Icons.undo),
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print(e);
              }
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Dagboek"),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant), label: "Voeding"),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "Voortgang"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Profiel"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "Lijstje"),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
