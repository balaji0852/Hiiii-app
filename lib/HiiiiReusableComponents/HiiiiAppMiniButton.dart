import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// Reusable Component 3,HiiiAppMiniButton
class HiiiiAppMiniButton extends StatelessWidget {
  HiiiiAppMiniButton({this.text, this.onchange});

  final String text;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 110,
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          color: HexColor('#262626'),
          onPressed: onchange),
    );
  }
}
