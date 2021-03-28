import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Unwanted page 
class SamplePages extends StatefulWidget {
  SamplePages({this.message});
  final String message;

  SamplePagesState createState() => SamplePagesState();
}

class SamplePagesState extends State<SamplePages> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            widget.message,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
