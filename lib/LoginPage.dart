import 'package:Hiiii/Otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String verificationId, phone;
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
                  HiiiiAppMiniButton(
                      text: 'Send OTP',
                      onchange: () {
                        try {
                          if (phone.length == 10) {
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
                  )
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
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp(
                    formData: [],
                    verificationId: verificationId,
                  )));
    };

    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential phoneAuthCredential) {
      print(phoneAuthCredential);
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phone,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<void> accountPresenceChecker() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://hiiiiapp.azurewebsites.net/api/hiiiiaccountchecker/?phone=' +
                phone));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      print('account exists');
      verifyPhone();
    } else {
      print("Account doesn't exists");
    }
  }
}
