import 'package:Hiiii/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'HiiiiReusableComponents/HiiiiAppBottomButton.dart';
import 'HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';

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
    accountPresenceChecker();
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Account details',
                  style: TextStyle(
                    fontSize: 17,
                    color: HexColor('#8FFF29'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hiiiiAppform(),
                HiiiiAppMiniButton2(
                  color: HexColor('#262626'),
                  fontColor: Colors.white,
                  text: 'save',
                  onchange: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                HiiiiAppMiniButton2(
                  color: HexColor('#262626'),
                  fontColor: Colors.white,
                  text: 'logout',
                  onchange: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    });
                  },
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

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
