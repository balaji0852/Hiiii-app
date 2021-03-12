import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'OTP.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  int bike = 0, bicycle = 0, car = 0;
  String gender, verificationId;
  String varName, varEmail, varPhone;
  List<String> formData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Scrollbar(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Paper Work',
                            style: TextStyle(
                              fontSize: 17,
                              color: HexColor('#8FFF29'),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hiiii Team : Yes we do hate paper works...",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      hiiiiAppform(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          HiiiiAppMiniButton2(
                            text: "policies",
                            color: Colors.grey,
                            fontColor: Colors.black,
                            onchange: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'By clicking next, I agree to the terms and condition.',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            HiiiiAppBottomButton(
                text: 'Next',
                onchange: () {
                  try {
                    if (varName.length != 0 &&
                        varEmail.length != 0 &&
                        varPhone.length == 10) {
                      formData.add(name.text);
                      formData.add(phoneNumber.text);
                      formData.add(email.text);
                      formData.add(gender);
                      formData.add(bicycle.toString());
                      formData.add(bike.toString());
                      formData.add(car.toString());
                      accountPresenceChecker();
                    }
                  } on Exception {
                    print(Exception);
                  }

                  print(formData.toString());
                })
          ],
        ),
      ),
    );
  }

  //Reusable component 4, hiiiiAppForm
  Container hiiiiAppform() {
    return Container(
        height: 460,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Material(
            color: HexColor('#262626'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  HiiiiAppMiniButton2(
                    text: "+",
                    color: Colors.white,
                    fontColor: Colors.black,
                    onchange: () {},
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  HiiiiAppTextField(
                      onchange: (value) {
                        varName = value.toString();
                      },
                      height: 62,
                      fontSize: 16,
                      hint: "Full name",
                      tEC: name,
                      type: TextInputType.name,
                      maxLength: 80,
                      textAlign: TextAlign.left),
                  HiiiiAppTextField(
                      onchange: (value) {
                        varPhone = value.toString();
                      },
                      height: 62,
                      fontSize: 16,
                      hint: "Phone number",
                      tEC: phoneNumber,
                      type: TextInputType.number,
                      maxLength: 10,
                      textAlign: TextAlign.left),
                  HiiiiAppTextField(
                      onchange: (value) {
                        varEmail = value.toString();
                      },
                      height: 62,
                      fontSize: 16,
                      hint: "Email",
                      tEC: email,
                      type: TextInputType.emailAddress,
                      maxLength: 80,
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Select your gender (Optional)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HiiiiAppMiniButton2(
                        text: "Male",
                        color: gender == "Male"
                            ? HexColor('#8FFF29')
                            : Colors.white,
                        fontColor: Colors.black,
                        onchange: () {
                          setState(() {
                            gender = "Male";
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      HiiiiAppMiniButton2(
                        text: "Female",
                        color: gender == "Female"
                            ? HexColor('#8FFF29')
                            : Colors.white,
                        fontColor: Colors.black,
                        onchange: () {
                          print('female');
                          setState(() {
                            gender = "Female";
                          });
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      HiiiiAppMiniButton2(
                        text: "Others",
                        color: gender == "Others"
                            ? HexColor('#8FFF29')
                            : Colors.white,
                        fontColor: Colors.black,
                        onchange: () {
                          setState(() {
                            gender = "Others";
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Select the vehicles you own (Optional)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HiiiiAppMiniButton2(
                          text: "Bicycle",
                          fontColor: Colors.black,
                          color:
                              bicycle == 1 ? HexColor('#8FFF29') : Colors.white,
                          onchange: () {
                            setState(() {
                              if (bicycle == 1) {
                                bicycle = 0;
                              } else {
                                bicycle = 1;
                              }
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      HiiiiAppMiniButton2(
                          text: "Bike",
                          fontColor: Colors.black,
                          color: bike == 1 ? HexColor('#8FFF29') : Colors.white,
                          onchange: () {
                            setState(() {
                              if (bike == 1) {
                                bike = 0;
                              } else {
                                bike = 1;
                              }
                            });
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      HiiiiAppMiniButton2(
                          text: "car",
                          fontColor: Colors.black,
                          color: car == 1 ? HexColor('#8FFF29') : Colors.white,
                          onchange: () {
                            setState(() {
                              if (car == 1) {
                                car = 0;
                              } else {
                                car = 1;
                              }
                            });
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
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
                    formData: formData,
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
        phoneNumber: '+91' + phoneNumber.text,
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
                phoneNumber.text));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      print('account exists');
    } else {
      print("Account doesn't exists");
      verifyPhone();
    }
  }
}
