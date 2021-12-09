import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Iconwidget extends StatelessWidget {
  final IconData faIcon;
  final Color color;

  const Iconwidget({
    Key key,
    this.faIcon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(faIcon, color: Colors.white),
      );
}
