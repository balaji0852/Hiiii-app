import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'LoginPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                  titleBlocks('#share_ride', '#8FFF29'),
                  SizedBox(
                    height: 10,
                  ),
                  titleBlocks('#socialize', '#00DDFF'),
                  SizedBox(
                    height: 10,
                  ),
                  titleBlocks('#Shop', '#FDF3F4'),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'hiiii app',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            hiiiiAppBottomButton(context),
          ],
        ),
      ),
    );
  }
}

// Reusable component 1, hiiiiAppBottombutton
Container hiiiiAppBottomButton(BuildContext context) {
  return Container(
    width: 330,
    height: 60,
    child: Material(
      color: HexColor('#262626'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: MaterialButton(
          height: 55,
          minWidth: 80,
          child: Center(
            child: Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }),
    ),
  );
}

// Moto stack blocks, containing #share_ride,#shop,#socialise blocks
// titleblocks function provides moto stack blocks
Material titleBlocks(String title, String color) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    color: HexColor(color),
    child: Container(
      height: 60,
      width: 130,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Broadway',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
