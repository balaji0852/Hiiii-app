import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// Reusable component 1, hiiiiAppBottombutton
class HiiiiAppBottomButton extends StatelessWidget {
  HiiiiAppBottomButton({this.onchange, this.text});

  final Function onchange;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 60,
      child: Material(
        color: HexColor('#262626'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: MaterialButton(
          height: 55,
          minWidth: 80,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: onchange,
        ),
      ),
    );
  }
}
