import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// Moto stack blocks, containing #share_ride,#shop,#socialise blocks
// titleblocks function provides moto stack blocks
class HiiiiAppTitleBlocks extends StatelessWidget {
  HiiiiAppTitleBlocks({this.title, this.color});

  final String title, color;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: HexColor(color),
      child: Container(
        height: 45,
        width: 100,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Broadway',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
