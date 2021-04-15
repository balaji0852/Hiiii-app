// Moto stack blocks, containing #share_ride,#shop,#socialise blocks
// titleblocks function provides moto stack blocks
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HiiiiAppTitleBlock2 extends StatelessWidget {
  HiiiiAppTitleBlock2({
    this.selected,
    this.title,
    this.color,
    this.onPressed,
    this.description,
  });

  final String title, description, selected;
  final Color color;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        child: Container(
          height: 105,
          width: 100,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    if (selected == title)
                      Icon(
                        Icons.check_box_rounded,
                      )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
