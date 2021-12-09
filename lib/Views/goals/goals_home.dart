import 'package:flutter/material.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/goals/graphs_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'goals_screen.dart';

class GoalsHome extends StatefulWidget {
  const GoalsHome({Key key}) : super(key: key);

  @override
  _GoalsHomeState createState() => _GoalsHomeState();
}

class _GoalsHomeState extends State<GoalsHome>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  List<Widget> screens = [
    GoalsScreen(),
    GraphsScreen(),
  ];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Container(
            height: 50,
            color: kPrimaryColor,
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              labelColor: Colors.white,
              tabs: [
                Tab(child: Text(AppLocalizations.of(context).goals)),
                Tab(child: Text(AppLocalizations.of(context).graphs)),
              ],
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: screens,
        ),
      ),
    );
  }
}
