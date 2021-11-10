import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalSettingsPage extends StatelessWidget {
  static const keyGoal = 'key-goal';

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Goal Settings',
        subtitle: 'Calorie goal',
        leading: Iconwidget(
          icon: Icons.whatshot,
          color: Colors.green,
        ),
        child: SettingsScreen(
          children: <Widget>[
            buildGoalSetting(context),
          ],
        ),
      );

  Widget buildGoalSetting(context) {
    DairyCubit cubit = DairyCubit.instance(context);
    double initialGoal = cubit.calGoal;
    return TextInputSettingsTile(
        settingKey: keyGoal,
        title: 'Calorie Goal',
        initialValue: initialGoal.toString(),
        onChange: (newGoal) async {
          cubit.setCalGoal(double.tryParse(newGoal));
        });
  }

}
