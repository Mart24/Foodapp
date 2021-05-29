import 'package:flutter/material.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Pages.dart';
import 'package:food_app/Views/home_view.dart';
import 'package:food_app/Views/new_food_intake/Food_amount_intake.view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/Views/new_food_intake/search_food_view.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'Views/foodlistSQL.dart';
import 'Views/new_food_registration.dart/0000food_search.dart';
import 'Views/progress_view.dart';

const colordarkgreen = const Color(0xFF7AA573);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Foodpage(),
    Progress(),
    Profiel(),
    Lijstje(),
  ];

  @override
  Widget build(BuildContext context) {
    final newTrip = Trip(null, null, null, null, null);

    return Scaffold(
      appBar: AppBar(
        title: Text("Foodapp"),
        backgroundColor: colordarkgreen,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTripLocationView(
                        trip: newTrip,
                      ),
                    ));
              }),
          IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewFoodIntake(
                        trip: newTrip,
                      ),
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
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Diary"),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant), label: "Food"),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "Progress"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "List"),
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTripLocationView(
                  trip: newTrip,
                ),
              ));
        },
        label: const Text('Food'),
        icon: const Icon(Icons.fastfood_outlined),
        backgroundColor: Colors.green,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
