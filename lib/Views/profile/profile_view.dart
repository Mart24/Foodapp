import 'package:flutter/material.dart';
import 'package:food_app/Services/auth_service.dart';
import 'package:food_app/Views/profile/accounts_settings_view.dart';
import 'package:food_app/Views/profile/app_information_view.dart';
import 'package:food_app/Views/profile/goal_settings_view.dart';
import 'package:food_app/Views/profile/utils.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:food_app/Widgets/theme_provider.dart';
import 'package:provider/provider.dart' as provider1;
import 'package:food_app/shared/app_cubit.dart';
import 'package:food_app/shared/dairy_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profiel extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  @override
  Widget build(BuildContext context) {
    // final text = MediaQuery.of(context).platformBrightness == Brightness.dark
    //     ? 'Darktheme'
    //     : 'LightTheme';
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
          padding: EdgeInsets.all(16),
          children: [
            buildDarkMode(context),
            SettingsGroup(title: 'Goals', children: <Widget>[
              GoalSettingsPage(),
            ]),
            SettingsGroup(title: 'General', children: <Widget>[
              AccountPage(),
              buildLogout(context),
              buildDeleteaccount(context),
            ]),
            //  const SizedBox(height: 12),
            SettingsGroup(title: 'Feedback', children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              buildReportBug(context),
              //  buildSendFeedback(),
            ]),
            SettingsGroup(
                title: AppLocalizations.of(context).appinformation,
                children: <Widget>[
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
        title: AppLocalizations.of(context).signout,
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

  Widget buildDeleteaccount(context) => SimpleSettingsTile(
        title: AppLocalizations.of(context).deleteaccount,
        subtitle: '',
        leading: Iconwidget(icon: Icons.delete, color: Colors.pink),
        onTap: () => Utils.openEmail(
          toEmail: 'example@gmail.com',
          subject: 'Delete account',
          body: 'This works great!',
        ),
      );

  Widget buildReportBug(context) => SimpleSettingsTile(
        title: AppLocalizations.of(context).reportbug,
        subtitle: '',
        leading: Iconwidget(icon: Icons.report, color: Colors.teal),
        onTap: () => Utils.openEmail(
          toEmail: 'example@gmail.com',
          subject: 'Report Bug',
          body: 'Hi guys...',
        ),
      );

  Widget buildDarkMode(context) {
    //  DairyCubit cubit = DairyCubit.instance(context);
    final themeProvider = provider1.Provider.of<ThemeProvider>(context);
    // bool isDarkMode = cubit.isDarkMode;
    return SwitchSettingsTile(
      settingKey: keyDarkMode,
      defaultValue: themeProvider.isDarkMode,
      leading: Iconwidget(icon: Icons.dark_mode, color: Colors.black54),
      title: 'Dark Mode',
      enabledLabel: AppLocalizations.of(context).darkmodetext1,
      disabledLabel: AppLocalizations.of(context).darkmodetext2,
      onChange: (newdarkmode) {
        final provider =
            provider1.Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(newdarkmode);
        //  cubit.setDarkMode(newdarkmode);
        debugPrint('Darkmode: $newdarkmode');
      },
    );
  }
}
