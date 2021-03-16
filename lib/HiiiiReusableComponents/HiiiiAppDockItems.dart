import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Reusable Component 6,HiiiAppDockItems
class HiiiiAppDockItems extends StatelessWidget {
  HiiiiAppDockItems(
      {this.text,
      this.onchange,
      this.borderRadius,
      this.color,
      this.tColor,
      this.tSize});

  final String text;
  final Function onchange;
  final double borderRadius;
  final Color color;
  final Color tColor;
  final double tSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 60,
      width: 60,
      child: MaterialButton(
          padding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Text(
            text,
            style: TextStyle(color: tColor, fontSize: tSize),
          ),
          color: color,
          onPressed: onchange),
    );
  }
}
