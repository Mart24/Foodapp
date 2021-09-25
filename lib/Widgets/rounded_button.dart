import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/helpers/sizes_helpers.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  final double widthRatio;
  final double heightRatio;
  final double textFont;

  RoundedButton(
      {Key key,
      this.text,
      this.press,
      this.color ,
      this.textColor,
      this.textFont,
      this.widthRatio = 0.5,
      this.heightRatio = 0.08})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    double myTextFont = (textFont==null) ? displayHeight(context) * heightRatio * 0.42: textFont;
    return Container(
      margin: EdgeInsets.symmetric(vertical: displayHeight(context) / 140),
      width: displayWidth(context) * widthRatio,
      height: displayHeight(context) * heightRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(displayHeight(context) / 45),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: displayHeight(context) * heightRatio / 5, horizontal: 5),
          color: color?? Theme.of(context).primaryColor,
          onPressed: press,
          child: Text(
            text??'__',
            style: TextStyle(
                color: textColor??Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: myTextFont),
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
