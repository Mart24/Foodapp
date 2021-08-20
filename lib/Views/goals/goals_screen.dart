import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/Views/goals/goals_intro_screen.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/goal_cubit.dart';

import 'goal_viewer.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.instance(context);

    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        print('rebuild goals screen');
        return FutureBuilder(
            future: cubit.getDataFromDatabase2('goals'),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data.length > 0) {
                  print('Choose goal viewer');
                  return GoalViewer(co2data: snapshot.data);
                } else {
                  print('Choose goal Into');

                  return GoalsIntroScreen();
                }
              }
            });
      },
    );
  }
}
