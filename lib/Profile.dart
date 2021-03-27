import 'package:Hiiii/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'HiiiiReusableComponents/HiiiiAppEmailVerification.dart';
import 'HiiiiReusableComponents/HiiiiAppAppBar.dart';
import 'HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Profile extends StatefulWidget {
  Profile({this.message});
  final String message;

  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  int bike = 0, bicycle = 0, car = 0;
  String gender, verificationId;
  String varName, varEmail, varPhone;
  // @override
  // void initState() async {
  //   // TODO: implement initState
  //   super.initState();
  //   // accountPresenceChecker();
  // }

  @override
  Widget build(BuildContext context) {
    name.text = "Balaji Rajkumar";
    phoneNumber.text = "+91 8151033423";
    // accountPresenceChecker();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 25,
            ),
            HiiiiAppAppBar(
              onchange: () {},
              title: 'Profile',
            ),
            CircleAvatar(
              backgroundColor: HexColor('#262626'),
              radius: 45,
            ),
            SizedBox(
              height: 10,
            ),
            HiiiiAppTextField(
                onchange: (value) {},
                enabled: false,
                height: 62,
                fontSize: 16,
                hint: "Your name",
                tEC: name,
                type: TextInputType.name,
                maxLength: 80,
                textAlign: TextAlign.left),
            HiiiiAppTextField(
                onchange: (value) {},
                enabled: false,
                height: 62,
                fontSize: 16,
                hint: "",
                tEC: phoneNumber,
                type: TextInputType.name,
                maxLength: 14,
                textAlign: TextAlign.left),
            HiiiiAppEmailVerification(
              email: "balajikumar189@gmail.com",
              verified: true,
              onchange: (value) {},
              onpress: () {},
            ),
            Row(
              children: [
                Text(
                  'hell world',
                  style: TextStyle(color: HexColor('#262626')),
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  // ignore: missing_return
  Future<void> accountPresenceChecker() async {
    FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var request = http.Request(
        'GET',
        Uri.parse('https://hiiiiapp.azurewebsites.net/api/authreader/?authid=' +
            uid.uid));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      gender = jsonResponse['gender'] == 'None'
          ? 'Others'
          : jsonResponse['gender'].toString();
      bike = jsonResponse['bike'] == 'true' ? 1 : 0;
      bicycle = jsonResponse['bicycle'] == 'true' ? 1 : 0;
      car = jsonResponse['car'] == 'true' ? 1 : 0;
      name.text = jsonResponse['name'];
      phoneNumber.text = jsonResponse['phone'];
      email.text = jsonResponse['email'];
      print(uid.uid);
    } else {
      print("Account doesn't exists");
    }
  }
}
