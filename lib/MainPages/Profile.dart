import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppToggleSwitch.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:Hiiii/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../HiiiiReusableComponents/HiiiiAppEmailVerification.dart';
import '../HiiiiReusableComponents/HiiiiAppAppBar.dart';
import '../HiiiiReusableComponents/HiiiiAppTextField.dart';
import '../HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';

import '../Home.dart';

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
  int theme = 0;
  @override
  void initState() {
    super.initState();
    theme = 0;
    accountPresenceChecker();
  }

  @override
  Widget build(BuildContext context) {
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
                onchange: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                title: 'Profile',
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=6&m=1223671392&s=612x612&w=0&h=NGxdexflb9EyQchqjQP0m6wYucJBYLfu46KCLNMHZYM="),
                backgroundColor: HexColor('#262626'),
                radius: 45,
              ),
              SizedBox(
                height: 25,
              ),
              HiiiiAppTextField(
                  maxLines: 1,
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
                  maxLines: 1,
                  onchange: (value) {},
                  enabled: false,
                  height: 62,
                  fontSize: 16,
                  hint: "your phone",
                  tEC: phoneNumber,
                  type: TextInputType.name,
                  maxLength: 14,
                  textAlign: TextAlign.left),
              HiiiiAppEmailVerification(
                email: "",
                verified: false,
                onchange: (value) {},
                onpress: () {},
                emailTEC: email,
              ),
              SizedBox(
                height: 15,
              ),
              HiiiiAppToggleSwitch(
                onToggle: (index) {
                  setState(() {
                    theme = index;
                  });
                },
                title: "theme",
                items: ['dark', 'light'],
                initialIndex: theme,
              ),
              SizedBox(
                height: 50,
              ),
              HiiiiAppMiniButton2(
                text: "logout",
                onchange: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                fontColor: Colors.white,
                color: HexColor('#262626'),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<void> accountPresenceChecker() async {
    FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var request = http.Request('GET',
        Uri.parse('${Values.domain}HiiiiAppAuthCheck/?authid=' + uid.uid));

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
