import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoalSettingsPage extends StatelessWidget {
  static const keyGoal = 'key-goal';
  static const double keySaveGoal = 5.0;

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: AppLocalizations.of(context).goalsettings,
        subtitle: AppLocalizations.of(context).goalsettingssubtitle,
        leading: Iconwidget(
          faIcon: Icons.whatshot,
          color: Colors.green,
        ),
        child: SettingsScreen(
          children: <Widget>[
            buildGoalSetting(context),
            buildSaveGoalSetting(context),
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

  Widget buildSaveGoalSetting(context) {
    DairyCubit cubit = DairyCubit.instance(context);
    double initialSaveGoal = cubit.saveco2Goal;
    return RadioSettingsTile<dynamic>(
        title: 'CO₂ Goal',
        settingKey: initialSaveGoal.toString(),
        values: <double, String>{
          5.0: 'Gemiddelde Nederlander: 5 kg/CO₂',
          2.58: 'Doel voor 2030: 2.58 kg/CO₂',
          2.1: 'Doel voor 2030 (streng): 2.1 kg/CO₂',
          1.1: 'Doel voor 2050: 1.1 kg/CO₂',
        },
        selected: initialSaveGoal,
        onChange: (newco2goal) async {
          cubit.setSaveGoal(newco2goal);
          debugPrint('key-radio-sync-period: $newco2goal days');
        });
  }
}
