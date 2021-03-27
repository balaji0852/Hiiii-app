import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Hiiii/Home.dart';
import 'package:Hiiii/Authentication/LoginPage.dart';
import 'Profile.dart';
import 'HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'HiiiiReusableComponents/HiiiiAppTitleBlocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String verificationId, phone;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HiiiiAppTitleBlocks(title: '#share_ride', color: '#8FFF29'),
                  SizedBox(
                    height: 10,
                  ),
                  HiiiiAppTitleBlocks(title: '#socialize', color: '#00DDFF'),
                  SizedBox(
                    height: 10,
                  ),
                  HiiiiAppTitleBlocks(title: '#Shop', color: '#FDF3F4'),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'hiiii app',
                    style: TextStyle(color: Colors.white, fontSize: 27),
                  ),
                ],
              ),
            ),
            HiiiiAppBottomButton(
                text: 'Get started...',
                onchange: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ],
        ),
      ),
    );
  }
}
