import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppListViewWidgets/ListviewWidgetType1.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Profile.dart';

//Unwanted page
class RidePage extends StatefulWidget {
  RidePageState createState() => RidePageState();
}

class RidePageState extends State<RidePage> {
  bool loading = true;
  var eventsData = [];
  int status = 200;
  String toast = "finding rides near by you...";

  @override
  void initState() {
    super.initState();
    toast = "finding rides near by you...";
    getEvent();
  }

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
          if (loading)
            HiiiiAppMiniButton2(
              text: 'loading...',
              onchange: () {},
              color: Colors.blue,
              fontColor: Colors.black,
            ),
          Expanded(
            child: status == 200 && !loading
                ? ListView(
                    children: eventsData.map((event) {
                    return ListviewWidgetType1(
                      name: "Unknown",
                      rating: '5.0',
                      rideStart: event['rideStartDate'],
                      rideDescription: event['rideDescription'],
                      from: event['from_'],
                      to: event['to_'],
                      vehicleType: event['vehicleType'],
                      seats: event['noSeats'].toString(),
                    );
                  }).toList())
                : Center(
                    child: Text(
                      "no rides found near you",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Future<void> getEvent() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            '${Values.domain}HiiiiAppGetEvents/?date=${DateTime.now().toString().substring(0, 16)}'));
    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    setState(() {
      if (jsonResponse['status'] != 200) {
        status = 204;
        toast = " no rides found near you...";
      }
      loading = false;
      eventsData = jsonResponse['events'];
    });
  }
}
