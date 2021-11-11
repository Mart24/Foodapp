import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

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

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  Widget buildGoalSetting(context) {
    DairyCubit cubit = DairyCubit.instance(context);
    double initialGoal = cubit.calGoal;
    return TextInputSettingsTile(
        settingKey: keyGoal,
        title: 'Calorie Goal',
        initialValue: initialGoal.toString(),
        keyboardType: TextInputType.number,
        validator: numberValidator,
        onChange: (newGoal) async {
          cubit.setCalGoal(double.tryParse(newGoal));
        });
  }
}
