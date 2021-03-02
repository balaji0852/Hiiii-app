import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();

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
                          hiiiiAppMiniButton2("policies", Colors.grey)
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
            hiiiiAppBottomButton()
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
                  hiiiiAppMiniButton2("+", Colors.white),
                  SizedBox(
                    height: 12,
                  ),
                  hiiiiAppTextField("Full name", name, TextInputType.name),
                  SizedBox(
                    height: 6,
                  ),
                  hiiiiAppTextField(
                      "mobile number", phoneNumber, TextInputType.number),
                  SizedBox(
                    height: 6,
                  ),
                  hiiiiAppTextField("Email", email, TextInputType.emailAddress),
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
                        'Select your gender',
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
                      hiiiiAppMiniButton2("Male", Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      hiiiiAppMiniButton2("Female", Colors.pinkAccent),
                      SizedBox(
                        width: 10,
                      ),
                      hiiiiAppMiniButton2("Others", Colors.white),
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
                        'Select the vehicles you own',
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
                      hiiiiAppMiniButton2("Bicycle", Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      hiiiiAppMiniButton2("Bike", Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      hiiiiAppMiniButton2("Car", Colors.white),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // Reusable Component 5,hiiiAppMiniButton
  Container hiiiiAppMiniButton2(String text, Color color) {
    return Container(
      height: 40,
      width: 85,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        color: color,
        onPressed: () {},
      ),
    );
  }

  //Reusable Component 2,hiiiiAppTextField
  Container hiiiiAppTextField(
      String hint, TextEditingController tEC, TextInputType type) {
    return Container(
      width: 280,
      height: 60,
      child: TextField(
        keyboardType: type,
        cursorColor: Colors.black,
        controller: tEC,
        decoration: InputDecoration(
            fillColor: HexColor('#8FFF29'),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            hintText: hint),
        style: TextStyle(
          color: Colors.black,
          fontSize: 19,
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
                'Next',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
            }),
      ),
    );
  }
}
