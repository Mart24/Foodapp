import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';

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
            buildGoalSetting(),
          ],
        ),
      );
  Widget buildGoalSetting() => TextInputSettingsTile(
      settingKey: keyGoal,
      title: 'Calorie Goal',
      initialValue: '2000',
      onChange: (_) {});
}
