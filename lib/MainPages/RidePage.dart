import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppListViewWidgets/ListviewWidgetType1.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String userName;

  @override
  void initState() {
    super.initState();
    getEvent();
    accountPresenceChecker();
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
                      onChange: () {
                        request(event);
                      },
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
        await convert.jsonDecode(await response.stream.bytesToString());

    setState(() {
      if (jsonResponse['status'] != 200) {
        status = 204;
        toast = " no rides found near you...";
      }
      loading = false;
      eventsData = jsonResponse['events'];
    });
  }

  Future<void> request(var event) async {
    FirebaseUser uid = await FirebaseAuth.instance.currentUser();
    String toast = " ";
    SnackBar snackBar;
    if (event['noSeats'] == 0) {
      toast = "Oops, No seats left out...";
    } else if (uid.uid == event['uid']) {
      toast = "Hey Buddy, you can't make request to your own ride...";
    } else {
      var payload = convert.jsonEncode(<String, String>{
        "requesteeUid": event['uid'],
        "requesterUid": uid.uid,
        "eventId": event['eventId'],
        "requesteeName": "Hoomann",
        "from_": event['from_'],
        "to_": event['to_'],
        "rideStartDate": event['rideStartDate'],
        "actionDate": DateTime.now().toString().substring(0, 16),
        "requesterName": userName
      });

      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST', Uri.parse('${Values.domain}HiiiiAppActionRequestRide'));
      request.body = payload.toString();
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var jsonResponse =
          convert.jsonDecode(await response.stream.bytesToString());
      toast = "Sent request successfully...";
      if (jsonResponse['status'] == 200) {
        toast = "request sent..";
      } else if (jsonResponse['status'] == 400) {
        toast = "you have a request for this ride, already...";
      } else {
        toast = "Oops, try again later";
      }
    }
    snackBar = SnackBar(
      content: Text(
        toast,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Values.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> accountPresenceChecker() async {
    FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var request = http.Request('GET',
        Uri.parse('${Values.domain}HiiiiAppAuthCheck/?authid=' + uid.uid));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      setState(() {
        userName = jsonResponse['name'];
      });
    } else {
      print("Account doesn't exists");
    }
  }
}
