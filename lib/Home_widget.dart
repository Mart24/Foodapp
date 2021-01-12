import 'package:flutter/material.dart';
import 'package:food_app/Pages.dart';
import 'package:food_app/home_view.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Voedingsapp"),
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
