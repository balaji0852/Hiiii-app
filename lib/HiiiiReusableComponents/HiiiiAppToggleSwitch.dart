import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HiiiiAppToggleSwitch extends StatelessWidget {
  final List<String> items;
  final Function onToggle;
  final String title;
  final initialIndex;

  HiiiiAppToggleSwitch(
      {this.items, this.onToggle, this.title, this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(
          width: 20,
        ),
        ToggleSwitch(
          cornerRadius: 15,
          initialLabelIndex: initialIndex,
          labels: items,
          activeBgColor: HexColor('#8FFF29'),
          activeFgColor: Colors.black,
          inactiveBgColor: HexColor('#262626'),
          inactiveFgColor: Colors.white,
          onToggle: onToggle,
        ),
      ],
    );
  }
}
