import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppDock.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppDockItems.dart';
import 'package:Hiiii/Authentication/LoginPage.dart';
import 'package:Hiiii/Authentication/OTP.dart';
import 'package:Hiiii/Authentication/SignUpPage.dart';
import 'package:Hiiii/main.dart';
import 'package:Hiiii/SamplePages.dart';
import 'package:Hiiii/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int body = 0;
  final widgetoptions = [
    SamplePages(
      message: 'No rides found near your location...',
    ),
    Profile(
      message: 'No data available',
    ),
    SamplePages(
      message: 'No Chat data available',
    ),
    SamplePages(
      message: 'No Rides data available',
    ),
    SamplePages(
      message: 'Oops, cannot Post ride now',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Center(child: widgetoptions.elementAt(body)),
              ),
            ),
            HiiiiAppDock(
              children: [
                HiiiiAppDockItems(
                  onchange: () {
                    setState(() {
                      body = 1;
                    });
                  },
                  text: 'Profiles',
                  tSize: 12,
                  tColor: Colors.white,
                  borderRadius: 17,
                  color: Colors.black,
                ),
                HiiiiAppDockItems(
                  onchange: () {
                    setState(() {
                      body = 2;
                    });
                  },
                  text: 'chat',
                  tSize: 14,
                  borderRadius: 17,
                  tColor: Colors.white,
                  color: Colors.blueAccent,
                ),
                HiiiiAppDockItems(
                  onchange: () {
                    setState(() {
                      body = 3;
                    });
                  },
                  text: 'Rides',
                  tSize: 14,
                  tColor: Colors.black,
                  borderRadius: 5,
                  color: Colors.white,
                ),
                HiiiiAppDockItems(
                  onchange: () {
                    setState(() {
                      body = 4;
                    });
                  },
                  text: 'Post',
                  tSize: 14,
                  tColor: Colors.white,
                  borderRadius: 30,
                  color: Colors.black,
                ),
              ],
            )
          ],
        ));
  }
}
