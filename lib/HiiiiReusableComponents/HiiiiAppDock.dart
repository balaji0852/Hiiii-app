// Hiiii App reusable component NO. 5

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HiiiiAppDock extends StatelessWidget {
  HiiiiAppDock({this.children});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: HexColor('#262626'),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ));
  }
}
