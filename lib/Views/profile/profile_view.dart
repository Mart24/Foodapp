import 'package:flutter/material.dart';
import 'package:food_app/Views/profile/body.dart';
import 'package:food_app/Views/size_config.dart';

class Profiel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
