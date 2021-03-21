import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// reusable component 2, HiiiiAppTextField
class HiiiiAppTextField extends StatelessWidget {
  HiiiiAppTextField(
      {this.type,
      this.tEC,
      this.hint,
      this.onchange,
      this.maxLength,
      this.textAlign,
      this.height,
      this.enabled,
      this.fontSize});

  final TextInputType type;
  final TextEditingController tEC;
  final String hint;
  final Function onchange;
  final int maxLength;
  final TextAlign textAlign;
  final double height;
  final double fontSize;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 280,
      height: height,
      child: TextField(
        maxLength: maxLength,
        keyboardType: type,
        cursorColor: Colors.black,
        textAlign: textAlign,
        controller: tEC,
        enabled: enabled,
        decoration: InputDecoration(
            fillColor: HexColor('#8FFF29'),
            filled: true,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: hint),
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
        ),
        onChanged: onchange,
      ),
    );
  }
}
