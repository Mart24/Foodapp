import 'package:flutter/material.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/Views/constants.dart';
import 'package:food_app/Views/profile/accounts_settings_view.dart';
import 'package:food_app/Views/profile/app_information_view.dart';
import 'package:food_app/Views/profile/body.dart';
import 'package:food_app/Views/profile/goal_settings_view.dart';
import 'package:food_app/Views/profile/utils.dart';
import 'package:food_app/Views/size_config.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:food_app/Widgets/profile_info.dart';
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class Profiel extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'Darktheme'
        : 'LightTheme';
    //   SizeConfig().init(context);
    // return Scaffold(
    //   body: Body(),
    // );

    return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return displayUserInformation(context, snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget displayUserInformation(context, snapshot) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            buildDarkMode(),
            SettingsGroup(title: 'Goals', children: <Widget>[
              GoalSettingsPage(),
            ]),
            SettingsGroup(title: 'General', children: <Widget>[
              AccountPage(),
              buildLogout(context),
              buildDeleteaccount(),
            ]),
            //  const SizedBox(height: 12),
            SettingsGroup(title: 'Feedback', children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              buildReportBug(),
              //  buildSendFeedback(),
            ]),
            SettingsGroup(title: 'App Information', children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              AppInformationPage(),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildLogout(context) => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: Iconwidget(icon: Icons.logout, color: Colors.greenAccent),
        onTap: () async {
          try {
            AuthService auth = Provider.of(context).auth;
            DairyCubit.instance(context).init();
            // DairyCubit.instance(context).getUsersTripsList();
            await auth.signOut();
            print("Signed Out!");
            AppCubit.instance(context).init();
          } catch (e) {
            print(e);
          }
        },
      );

  Widget buildDeleteaccount() => SimpleSettingsTile(
        title: 'Delete account',
        subtitle: '',
        leading: Iconwidget(icon: Icons.delete, color: Colors.pink),
        onTap: () => Utils.openEmail(
          toEmail: 'example@gmail.com',
          subject: 'Delete account',
          body: 'This works great!',
        ),
      );

  Widget buildReportBug() => SimpleSettingsTile(
        title: 'Report Bug',
        subtitle: '',
        leading: Iconwidget(icon: Icons.report, color: Colors.teal),
        onTap: () => Utils.openEmail(
          toEmail: 'example@gmail.com',
          subject: 'Report Bug',
          body: 'Hi guys...',
        ),
      );

  Widget buildSendFeedback() => SimpleSettingsTile(
        title: 'Send Feedback',
        subtitle: '',
        leading: Iconwidget(icon: Icons.thumb_up, color: Colors.purple),
        onTap: () {},
      );

  Widget buildDarkMode() => SwitchSettingsTile(
      settingKey: keyDarkMode,
      leading: Iconwidget(icon: Icons.dark_mode, color: Colors.black54),
      title: 'Dark Mode',
      enabledLabel: 'Coming soon',
      disabledLabel: 'Coming soon',
      onChange: null);
}
