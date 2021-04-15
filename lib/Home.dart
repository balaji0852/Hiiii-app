import 'package:Hiiii/MainPages/PostPage.dart';
import 'package:Hiiii/MainPages/RidePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int body = 0;
  final items = [
    RidePage(),
    Center(
      child: Text(
        "No Rides data available",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
    Center(
      child: Text(
        "No Chat data available",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
    PostPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: items.elementAt(body),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor('#262626'),
        type: BottomNavigationBarType.fixed,
        iconSize: 15.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 26,
              ),
              // ignore: deprecated_member_use
              title: Text(" ", style: TextStyle(fontSize: 1))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: Colors.white,
                size: 26,
              ),
              // ignore: deprecated_member_use
              title: Text(" ", style: TextStyle(fontSize: 1))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
                size: 26,
              ),
              // ignore: deprecated_member_use
              title: Text(
                " ",
                style: TextStyle(fontSize: 1),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 26,
              ),
              // ignore: deprecated_member_use
              title: Text(" ", style: TextStyle(fontSize: 1))),
        ],
        currentIndex: body,
        fixedColor: Colors.red,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      body = index;
    });
  }
}
