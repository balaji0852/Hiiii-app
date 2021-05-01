import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppToggleSwitch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTimePicker.dart';
import 'package:Hiiii/MainPages/values.dart';

class Ride extends StatefulWidget {
  @override
  RideState createState() => RideState();
}

class RideState extends State<Ride> {
  TextEditingController from = new TextEditingController();
  TextEditingController to = new TextEditingController();
  TextEditingController rideDescription = new TextEditingController();
  String selectedTime,
      time,
      date,
      fromLocation,
      toLocation,
      rideDescriptionString;
  int vehicle = 1, seat = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text('Fill the ride details', 15, Colors.white),
        br(5, 0),
        HiiiiAppTextField(
            maxLines: 1,
            enabled: true,
            onchange: (value) {
              fromLocation = value;
            },
            height: 80,
            fontSize: 16,
            hint: "From",
            tEC: from,
            type: TextInputType.streetAddress,
            maxLength: 255,
            textAlign: TextAlign.left),
        HiiiiAppTextField(
            maxLines: 1,
            enabled: true,
            onchange: (value) {
              toLocation = value;
            },
            height: 80,
            fontSize: 16,
            hint: "to",
            tEC: to,
            type: TextInputType.streetAddress,
            maxLength: 255,
            textAlign: TextAlign.left),
        HiiiiAppTimePicker(
          onDateChange: (value) {
            date = value.toString();
          },
          onTimeChange: (value) {
            setState(() {
              selectedTime = value;
              time = value.toString();
            });
          },
          selectedTime: selectedTime,
        ),
        br(15, 0),
        HiiiiAppToggleSwitch(
          onToggle: (index) {
            setState(() {
              vehicle = index;
            });
          },
          initialIndex: vehicle,
          items: ['car', 'bike'],
          title: 'vehicle',
        ),
        br(10, 0),
        if (vehicle == 0) seatSelecter(),
        br(10, 0),
        HiiiiAppTextField(
            maxLines: 5,
            enabled: true,
            onchange: (value) {
              rideDescriptionString = value;
            },
            height: 100,
            fontSize: 16,
            hint: "Ride Description",
            tEC: rideDescription,
            type: TextInputType.streetAddress,
            maxLength: 255,
            textAlign: TextAlign.left),
        br(10, 0),
        HiiiiAppMiniButton(
          text: "Post",
          onchange: () {
            postRide();
          },
        )
      ],
    );
  }

  SizedBox br(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Container seatSelecter() {
    return Container(
      height: 30,
      width: 330,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: Values.seats
            .map((ele) => MaterialButton(
                  onPressed: () {
                    setState(() {
                      seat = int.parse(ele);
                    });
                  },
                  height: 10,
                  minWidth: 5,
                  color: ele == seat.toString()
                      ? HexColor('#8FFF29')
                      : Colors.black,
                  child: text(ele.toString(), 14,
                      ele == seat.toString() ? Colors.black : Colors.white),
                ))
            .toList(),
      ),
    );
  }

  Text text(String text, double size, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }

  Future<void> postRide() async {
    if (from.text.length > 0 &&
        to.text.length > 0 &&
        time.length > 0 &&
        date.length > 0) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      var payload = convert.jsonEncode(<String, String>{
        "eventTypeId": "1",
        "eventTypeTag": "ride",
        "vehicleType": vehicle == 0 ? 'car' : 'bike',
        "from_": from.text,
        "to_": to.text,
        "noSeats": seat.toString(),
        "rideDescription": rideDescription.text,
        "uid": user.uid.toString(),
        "rideStartDate": date.substring(0, 10) + " " + time,
        "actionDate": DateTime.now().toString().substring(0, 16)
      });

      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse('${Values.domain}HiiiiAppRidePost'));
      request.body = payload.toString();
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var jsonResponse =
          convert.jsonDecode(await response.stream.bytesToString());
      String toast;
      if (jsonResponse['status'] == 200) {
        from.text = "";
        to.text = "";
        rideDescription.text = "";
        print('ride posted sucessfully');
        toast = 'Your ride is posted succesfully...';
      } else {
        toast = 'please try again later';
      }
      final snackBar = SnackBar(content: Text(toast));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
