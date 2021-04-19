import 'package:Hiiii/MainPages/values.dart';

import './Otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTextField.dart';
import './SignUpPage.dart';
import 'package:Hiiii/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String verificationId, phone, toast = '';
  bool flag = false;
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Hey, Pal enter your mobile number...',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  HiiiiAppTextField(
                      maxLines: 1,
                      enabled: true,
                      height: 65,
                      fontSize: 21,
                      tEC: phoneNumber,
                      hint: '+91 XXXXXXXXXX',
                      maxLength: 14,
                      textAlign: TextAlign.center,
                      type: TextInputType.number,
                      onchange: (value) {
                        phone = value;
                      }),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    toast,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  HiiiiAppMiniButton(
                      text: 'Send OTP',
                      onchange: () {
                        try {
                          if (phone.length == 10 && !flag) {
                            print('account');
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            setState(() {
                              flag = true;
                            });
                            accountPresenceChecker();
                          }
                        } on Exception {
                          print(Exception);
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 2,
                    child: Container(
                      color: HexColor('#8FFF29'),
                    ),
                  ),
                  flag
                      ? Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: HexColor('#8FFF29'))
                      : SizedBox(
                          height: 1,
                        ),
                ],
              ),
            ),
            HiiiiAppBottomButton(
                text: 'Create Account',
                onchange: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                }),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      print('otp sent');
      setState(() {
        flag = false;
      });
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp(
                  formData: [],
                  verificationId: verificationId,
                  credential: null)));
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) async {
      await FirebaseAuth.instance
          .signInWithCredential(phoneAuthCredential)
          .then((user) async {
        print('auto verifying successful...');
        print('loggged in successfully....');
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }).catchError((e) {
        print(e);
      });
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 0),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<void> accountPresenceChecker() async {
    var request = http.Request(
        'GET', Uri.parse('${Values.domain}HiiiiAppPhoneCheck/?phone=' + phone));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      print('account exists');

      verifyPhone();
    } else {
      setState(() {
        toast = "Account doesn't exist";
        flag = false;
      });
      print("Account doesn't exists");
    }
  }
}
