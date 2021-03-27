import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

//reusable component 8, HiiiiAppAppBar
class HiiiiAppAppBar extends StatelessWidget {
  HiiiiAppAppBar({this.onchange, this.title});
  final String title;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor('#8FFF29'),
              size: 25,
            ),
            onPressed: onchange),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: HexColor('#8FFF29'),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
