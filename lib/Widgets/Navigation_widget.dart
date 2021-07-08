import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Models/ingredients.dart';
import 'package:food_app/Views/goals_screen.dart';
import 'package:food_app/Views/introduction_screen.dart';
import 'package:food_app/Views/pages.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/dashboard_diary_view.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import '../Views/new_food_registration.dart/food_search.dart';
import '../Views/profile/profile_view.dart';

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
    GoalsScreen(),
    Profiel(),
    //Lijstje(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Food App"),
      //   backgroundColor: kPrimaryColor,
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.add),
      //         onPressed: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => NewFoodIntake(
      //                   trip: newTrip,
      //                 ),
      //               ));
      //         }),
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () async {
      //         try {
      //           AuthService auth = Provider.of(context).auth;
      //           DairyCubit.instance(context).init();
      //           // DairyCubit.instance(context).getUsersTripsList();
      //           await auth.signOut();
      //           print("Signed Out!");
      //         } catch (e) {
      //           print(e);
      //         }
      //       },
      //     )
      //   ],
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Diary"),
            BottomNavigationBarItem(
                icon: Icon(Icons.restaurant), label: "Recipes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "Goals"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "Profile"),
            // BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "List"),
          ]),
    );
  }

  void onTabTapped(int index) {
    if (index == 2) {
      final appCubit = AppCubit.instance(context);
      final uid = FirebaseAuth.instance.currentUser.uid;
      appCubit.getOneWeekData(appCubit.database, uid);
      // DateTime now = DateTime.now();
      // now =DateTime(now.year,now.month,now.day);
      // appCubit.getDataFromDatabase(appCubit.database, uid,
      //     limit: 7,
      //     where:"date > ? and date <= ?",
      //     whereArgs: [now.subtract(Duration(days: 7)).toIso8601String(),now.toIso8601String()]);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
