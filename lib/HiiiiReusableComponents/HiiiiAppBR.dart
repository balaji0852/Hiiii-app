import 'package:flutter/cupertino.dart';

class HiiiiAppBR extends StatelessWidget{
  final double weight;
  final double height;


  HiiiiAppBR({this.weight,this.height});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: weight,
    )
  }
  
}