import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTextField.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppToggleSwitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Ride extends StatefulWidget {
  @override
  RideState createState() => RideState();
}

class RideState extends State<Ride> {
  TextEditingController from = new TextEditingController();
  TextEditingController to = new TextEditingController();
  TextEditingController rideDescription = new TextEditingController();
  int vehicle = 0, seat = 0;
  List<String> vehiclesList = ['car', 'bike'];
  List<String> seats = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

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
            onchange: (value) {},
            height: 62,
            fontSize: 16,
            hint: "From",
            tEC: from,
            type: TextInputType.streetAddress,
            maxLength: 255,
            textAlign: TextAlign.left),
        HiiiiAppTextField(
            maxLines: 1,
            enabled: true,
            onchange: (value) {},
            height: 62,
            fontSize: 16,
            hint: "to",
            tEC: to,
            type: TextInputType.streetAddress,
            maxLength: 255,
            textAlign: TextAlign.left),
        Container(
          width: 300,
          height: 100,
          color: HexColor('#262626'),
          child: Text('fawk time picker'),
        ),
        br(15, 0),
        HiiiiAppToggleSwitch(
          onToggle: (index) {
            setState(() {
              vehicle = index;
            });
            print(vehicle);
          },
          initialIndex: vehicle,
          items: vehiclesList,
          title: 'vehicle',
        ),
        br(10, 0),
        if (vehicle == 0) seatSelecter(),
        br(10, 0),
        HiiiiAppTextField(
            maxLines: 5,
            enabled: true,
            onchange: (value) {},
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
          onchange: () {},
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
        children: seats
            .map((ele) => MaterialButton(
                  onPressed: () {
                    setState(() {
                      seat = int.parse(ele);
                    });
                  },
                  height: 10,
                  minWidth: 5,
                  color: ele == seat.toString()
                      ? HexColor('#262626')
                      : Colors.black,
                  child: text(ele.toString(), 14, Colors.white),
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
}
