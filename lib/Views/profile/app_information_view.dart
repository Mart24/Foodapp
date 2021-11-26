import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:food_app/Views/profile/utils.dart';
import 'package:food_app/Widgets/profile_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          SimpleSettingsTile(
            title: AppLocalizations.of(context).appinformation,
            subtitle: 'Privacy, Licenses etc.',
            leading: Iconwidget(
              icon: Icons.smartphone,
              color: Colors.green,
            ),
            child: SettingsScreen(
              children: <Widget>[
                buildPrivacyAgreement(),
                buildLicensesPage(context),
              ],
            ),
          ),
        ],
      );
}

Widget buildPrivacyAgreement() => SimpleSettingsTile(
      title: 'Privacy Policy',
      subtitle: '',
      leading: Iconwidget(icon: Icons.security, color: Colors.purple),
      onTap: () => Utils.openLink(url: 'https://eatmission.app'),
    );
Widget buildLicensesPage(context) => SimpleSettingsTile(
      title: 'Licenses overview',
      subtitle: '',
      leading: Iconwidget(icon: Icons.list, color: Colors.purple),
      onTap: () =>
          showLicensePage(context: context, applicationName: "Eatmission"),
    );
