import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppListViewWidgets/ListviewWidgetType1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Profile.dart';

//Unwanted page
class RidePage extends StatefulWidget {
  RidePageState createState() => RidePageState();
}

class RidePageState extends State<RidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 33,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    }),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Expanded(
                child: ListView(
              children: [
                ListviewWidgetType1(
                  name: 'Balaji R',
                  rating: '4.5',
                  rideStart: '2021-04-21 08:00',
                  rideDescription: 'Its wonderful ride to wonderla',
                  from: 'R.T.Nagar',
                  to: 'Wonderla bangalore',
                  vehicleType: 'Car',
                  seats: '10',
                ),
                ListviewWidgetType1(
                  name: 'Balaji R',
                  rating: '4.5',
                  rideStart: '2021-04-21 08:00',
                  rideDescription: 'Its wonderful ride to wonderla',
                  from: 'R.T.Nagar',
                  to: 'Wonderla bangalore',
                  vehicleType: 'Car',
                  seats: '10',
                ),
                ListviewWidgetType1(
                  name: 'Balaji R',
                  rating: '4.5',
                  rideStart: '2021-04-21 08:00',
                  rideDescription: 'Its wonderful ride to wonderla',
                  from: 'R.T.Nagar',
                  to: 'Wonderla bangalore',
                  vehicleType: 'Car',
                  seats: '10',
                ),
              ],
            ))
          ],
        ));
  }
}
