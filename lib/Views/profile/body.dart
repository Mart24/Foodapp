import 'package:flutter/material.dart';
import 'package:food_app/Views/size_config.dart';
import 'package:food_app/Widgets/Provider_Auth.dart';
import 'package:intl/intl.dart';

import 'info.dart';
import 'profile_menu_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: Provider.of(context).auth.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return displayUserInformation(context, snapshot);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    return Column(
      children: <Widget>[
        Info(
          image: "assets/img1.jpg",
          name: "${user.displayName ?? 'Anonymous'}",
          email: "email: ${user.email ?? 'Anonymous'}",
          created:
              "Account gemaakt op: ${DateFormat('dd/MM/yyyy').format(user.metadata.creationTime)}",
        ),

        SizedBox(height: SizeConfig.defaultSize * 2), //20
        ProfileMenuItem(
          iconSrc: "assets/icons/info.svg",
          title: "Change data",
          press: () {},
        ),
        ProfileMenuItem(
          iconSrc: "assets/icons/info.svg",
          title: "Set up goals",
          press: () {},
        ),
        ProfileMenuItem(
          iconSrc: "assets/icons/info.svg",
          title: "Delete account",
          press: () {},
        ),
        ProfileMenuItem(
          iconSrc: "assets/icons/info.svg",
          title: "Help",
          press: () {},
        ),

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     "Name: ${user.displayName ?? 'Anonymous'}",
        //     style: TextStyle(fontSize: 20),
        //   ),
        // ),

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text("Email: ${user.email ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
        // ),

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
        //       user.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
        // ),

        // showSignOut(context, user.isAnonymous),
      ],
    );
  }
}
