import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListviewWidgetType1 extends StatelessWidget {
  final String name;
  final String rating;
  final String rideStart;
  final String rideDescription;
  final String from;
  final String to;
  final String vehicleType;
  final String seats;

  const ListviewWidgetType1(
      {Key key,
      this.name,
      this.rating,
      this.rideStart,
      this.rideDescription,
      this.from,
      this.to,
      this.vehicleType,
      this.seats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
          color: HexColor('#262626'), borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Rating row, containing icons and rating text, aligns top left.
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Values.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      rating,
                      style: TextStyle(
                          fontSize: 13,
                          color: Values.green,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                //Tag row, containing tags widgets and available seats count.
                Row(
                  children: [
                    Icon(Icons.event_seat_rounded, color: Values.green),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      seats,
                      style: TextStyle(
                          fontSize: 13,
                          color: Values.green,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    tags(vehicleType),
                    SizedBox(
                      width: 5,
                    ),
                    tags('ride'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Text(
                        rideStart,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 130,
                        child: Text(
                          from,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    Icon(
                      Icons.directions,
                      size: 40,
                      color: Values.green,
                    ),
                    Container(
                      width: 130,
                      child: Text(
                        to,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (rideDescription.length > 0)
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    rideDescription,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
            HiiiiAppMiniButton2(
              text: 'Request',
              onchange: () {},
              color: Colors.black,
              fontColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Container tags(String text) {
    return Container(
      alignment: Alignment.center,
      height: 25,
      width: 45,
      decoration: BoxDecoration(
          color: Values.green, borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
