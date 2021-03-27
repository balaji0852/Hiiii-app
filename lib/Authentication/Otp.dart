import 'package:Hiiii/Home.dart';
import 'package:Hiiii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Otp extends StatefulWidget {
  String verificationId;
  List<String> formData;
  var credential;

  Otp({this.verificationId, this.formData, this.credential});

  @override
  OtpState createState() => OtpState();
}

class OtpState extends State<Otp> {
  TextEditingController phoneNumber = TextEditingController();
  String smsCode, toast = " ";
  bool flag = false;

  @override
  void initState() {
    super.initState();
    if (widget.credential != null && widget.formData.length != 0) {
      flag = true;
      accountCreation('autologin', context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
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
                    height: 50,
                  ),
                  Text(
                    'Enter the otp sent to your phone...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // hiiiiAppTextField(),
                  HiiiiAppTextField(
                      type: TextInputType.number,
                      tEC: phoneNumber,
                      hint: 'XXXXXX',
                      onchange: (value) {
                        print(value.toString());
                        smsCode = value.toString();
                      },
                      enabled: true,
                      height: 65,
                      fontSize: 21,
                      maxLength: 6,
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    toast,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  flag
                      ? Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: HexColor('#8FFF29'))
                      : SizedBox(
                          height: 1,
                        ),
                  HiiiiAppMiniButton(
                      text: 'login',
                      onchange: () {
                        try {
                          if (smsCode.length == 6) {
                            signIn(smsCode, context);
                          }
                        } on Exception {
                          print(Exception);
                          setState(() {
                            toast = "Try again later.";
                          });
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  signIn(String code, BuildContext context) async {
    var credential = PhoneAuthProvider.getCredential(
        verificationId: widget.verificationId, smsCode: code);
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((user) async {
      if (widget.formData.length == 0) {
        print('successfully logged in....');
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        print('Trying to create account');
        accountCreation(user.user.providerData[0].uid.toString(), context);
      }
    }).catchError((e) {
      setState(() {
        toast = "Wrong OTP.";
      });
    });
  }

  Future<void> accountCreation(String uid, BuildContext context) async {
    if (uid == 'autologin') {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      uid = user.uid;
    }
    var payload = convert.jsonEncode(<String, String>{
      "authid": uid,
      "name": widget.formData.elementAt(0),
      "phone": widget.formData.elementAt(1),
      "email": widget.formData.elementAt(2),
      "gender": widget.formData.elementAt(3),
      "bicycle": widget.formData.elementAt(4),
      "bike": widget.formData.elementAt(5),
      "car": widget.formData.elementAt(6),
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://hiiiiapp.azurewebsites.net/api/hiiiiappAuthentication'));
    request.body = payload.toString();
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
}
