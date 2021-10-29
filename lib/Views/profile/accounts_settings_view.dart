import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/profile_buttons.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Account Settings',
        subtitle: 'Settings',
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
