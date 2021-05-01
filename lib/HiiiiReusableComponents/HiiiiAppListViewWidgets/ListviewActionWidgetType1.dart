import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListviewActionWidgetType1 extends StatelessWidget {
  ListviewActionWidgetType1(
      {this.actionDescription, this.buttonText, this.actionButton});
  final String actionDescription;
  final String buttonText;
  final List actionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    actionDescription,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actionButton,
                )
              ],
            ),
          )),
    );
  }
}
