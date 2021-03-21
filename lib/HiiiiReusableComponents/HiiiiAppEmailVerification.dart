import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';

class HiiiiAppEmailVerification extends StatelessWidget {
  final Function onchange;
  final Function onpress;
  final bool verified;
  final String email;

  TextEditingController emailTEC = new TextEditingController();

  HiiiiAppEmailVerification(
      {this.onchange, this.onpress, this.verified, this.email});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (verified) {
      emailTEC.text = email;
      return HiiiiAppTextField(
          onchange: (value) {},
          enabled: false,
          height: 62,
          fontSize: 16,
          hint: "",
          tEC: emailTEC,
          type: TextInputType.name,
          maxLength: 80,
          textAlign: TextAlign.left);
    }
    return Container(
      height: 140,
      width: 320,
      child: Material(
        color: HexColor('#262626'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter your email",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          HiiiiAppTextField(
              onchange: onchange,
              enabled: false,
              height: 62,
              fontSize: 16,
              hint: "Email",
              tEC: emailTEC,
              type: TextInputType.name,
              maxLength: 14,
              textAlign: TextAlign.left),
          HiiiiAppMiniButton2(
            text: "Send",
            color: Colors.black,
            fontColor: Colors.white,
            onchange: onpress,
          ),
        ]),
      ),
    );
  }
}
