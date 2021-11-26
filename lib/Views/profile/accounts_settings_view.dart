import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: AppLocalizations.of(context).accountsettings,
        subtitle: AppLocalizations.of(context).settings,
        leading: Iconwidget(
          icon: Icons.person,
          color: Colors.green,
        ),
        child: SettingsScreen(
          children: <Widget>[
            buildAccountInfo(),
          ],
        ),
      );
}

Widget buildAccountInfo() => SimpleSettingsTile(
      title: 'Account info',
      subtitle: '',
      leading: Iconwidget(icon: Icons.person, color: Colors.purple),
      onTap: () {},
    );
