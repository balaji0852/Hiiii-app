import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppListViewWidgets/ListviewActionWidgetType1.dart';
import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppMiniButton2.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';

class ActionPage extends StatefulWidget {
  @override
  ActionPageState createState() => ActionPageState();
}

class ActionPageState extends State<ActionPage> {
  var actionData = [];
  bool loading = true;
  String toast = "";
  int status;

  @override
  void initState() {
    super.initState();
    getAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          if (loading)
            HiiiiAppMiniButton2(
              text: 'loading...',
              onchange: () {},
              color: Colors.blue,
              fontColor: Colors.black,
            ),
          Expanded(
            child: actionData != null
                ? ListView(
                    children: actionData
                        .map((action) => ListviewActionWidgetType1(
                            actionDescription: action['name'] +
                                action['actionDescription'] +
                                "...",
                            buttonText: 'cancel',
                            actionButton: action['actionTypeId'] == 1
                                ? <Widget>[
                                    HiiiiAppMiniButton2(
                                        text: 'cancel',
                                        onchange: () {},
                                        color: Colors.blue,
                                        fontColor: Colors.black)
                                  ]
                                : action['actionTypeId'] == 3
                                    ? <Widget>[
                                        HiiiiAppMiniButton2(
                                            text: 'Accept',
                                            onchange: () {
                                              acceptRide(action);
                                            },
                                            color: Colors.blue,
                                            fontColor: Colors.black),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        HiiiiAppMiniButton2(
                                            text: 'Decline',
                                            onchange: () {},
                                            color: Colors.blue,
                                            fontColor: Colors.black)
                                      ]
                                    : <Widget>[]))
                        .toList(),
                  )
                : Center(
                    child: Text(
                      "no history",
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

  Future<void> getAction() async {
    FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var request = http.Request(
        'GET', Uri.parse('${Values.domain}HiiiiAppGetActions/?uid=${uid.uid}'));
    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    setState(() {
      if (jsonResponse['status'] != 200) {
        status = 204;
        toast = " no rides found near you...";
      }
      loading = false;
      actionData = jsonResponse['actions'];
    });
  }

  Future<void> acceptRide(var ride) async {
    String toast = " ";
    SnackBar snackBar;

    FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var payload = convert.jsonEncode(<String, String>{
      "requesteeUid": uid.uid,
      "requesterUid": ride['actioneeAid'],
      "eventId": ride['eventId'],
      "requesterName": ride['name'],
      "requesteeName": " ",
      "rideDescription": ride['actionDescription'].toString().substring(16),
      "actionDate": DateTime.now().toString().substring(0, 16),
      "rideStartDate": ride['actionDescription']
          .toString()
          .substring(ride['actionDescription'].toString().length - 19)
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${Values.domain}HiiiiAppActionAcceptRide'));
    request.body = payload.toString();
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      toast = 'request accepted successfully';
    } else if (jsonResponse['status'] == 400) {
      toast = 'Oops, request accepted already';
    } else if (jsonResponse['status'] == 504) {
      toast = 'Oops, you ran out of seats in the ride...';
    } else if (jsonResponse['status'] == 503) {
      toast = 'Request expired...';
    } else if (jsonResponse['status'] == 500) {
      toast = 'Please try again later...';
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
}
