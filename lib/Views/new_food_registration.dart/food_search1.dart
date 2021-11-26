// import 'package:flutter/material.dart';
// import 'package:food_app/Models/ingredients.dart';
// import 'package:food_app/Views/constants.dart';
// import 'package:food_app/Views/goals/graphs_screen.dart';
// import 'package:food_app/Views/new_food_registration.dart/food_search.dart';
// import 'package:food_app/Views/new_food_registration.dart/food_searchfav.dart';

// class SearchHome extends StatefulWidget {
//   final Trip trip;

//   const SearchHome({Key key, @required this.trip}) : super(key: key);

//   @override
//   _GoalsHomeState createState() => _GoalsHomeState();
// }

// final newTrip = Trip(
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     null,
//     // null,
//     // null,
//     // null,
//     // null,
//     // null,
//     // null,
//     // null,
//     // null,
//     null);

// class _GoalsHomeState extends State<SearchHome>
//     with SingleTickerProviderStateMixin {
//   int currentIndex = 0;
//   List<Widget> screens = [
//     NewFoodIntake(
//       trip: newTrip,
//     ),
//     NewFoodIntakeFav(trip: newTrip),
//   ];
//   TabController tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size(double.infinity, 50),
//           child: Container(
//             height: 50,
//             color: kPrimaryColor,
//             child: TabBar(
//               controller: tabController,
//               indicator: BoxDecoration(
//                 color: Colors.black.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               labelStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//               labelColor: Colors.white,
//               tabs: [
//                 Tab(child: Text('Search all')),
//                 Tab(child: Text('Favorites')),
//               ],
//               onTap: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//             ),
//           ),
//         ),
//         body: TabBarView(
//           controller: tabController,
//           children: screens,
//         ),
//       ),
//     );
//   }
// }
