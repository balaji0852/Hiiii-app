import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Reusable Component 5,hiiiAppMiniButton
class HiiiiAppMiniButton2 extends StatelessWidget {
  HiiiiAppMiniButton2({this.text, this.onchange, this.color, this.fontColor});
  final String text;
  final Function onchange;
  final Color color;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: TextStyle(color: fontColor, fontSize: 11),
        ),
        color: color,
        onPressed: onchange,
      ),
    );
  }
}
