import 'package:Hiiii/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumber = TextEditingController();

//Reusable component 2, hiiiiAppTextField
  Container hiiiiAppTextField() {
    return Container(
      width: 280,
      height: 70,
      child: TextField(
        maxLength: 14,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        controller: phoneNumber,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            fillColor: HexColor('#8FFF29'),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: '+91 XXXXXXXXXX'),
        style: TextStyle(
          color: Colors.black,
          fontSize: 23,
        ),
      ),
    );
  }

// Reusable component 1, hiiiiAppBottombutton
  Container hiiiiAppBottomButton() {
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Hey, Pal enter your mobile number...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  hiiiiAppTextField(),
                  SizedBox(
                    height: 7,
                  ),
                  hiiiiAppMiniButton('Send OTP'),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: HexColor('#8FFF29'),
                    ),
                  )
                ],
              ),
            ),
            hiiiiAppBottomButton(),
          ],
        ),
      ),
    );
  }
}

// Reusable Component 3,hiiiAppMiniButton
Container hiiiiAppMiniButton(String text) {
  return Container(
    height: 60,
    width: 130,
    child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
      color: HexColor('#262626'),
      onPressed: () {},
    ),
  );
}
