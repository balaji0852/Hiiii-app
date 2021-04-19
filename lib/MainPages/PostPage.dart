import 'package:Hiiii/HiiiiReusableComponents/HiiiiAppTitleBlock2.dart';
import 'package:Hiiii/MainPages/PostPages/Ride.dart';
import 'package:Hiiii/MainPages/values.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PostPage extends StatefulWidget {
  @override
  PostPageState createState() {
    return PostPageState();
  }
}

class PostPageState extends State<PostPage> {
  String category = "Share ride";
  var serviceListResponse = [];
  bool loading = true;

  SizedBox br(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
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

  @override
  void initState() {
    super.initState();
    serviceListGetter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Scrollbar(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  br(40, 0),
                  text("Post", 17, HexColor('#8FFF29')),
                  br(20, 0),
                  text("Pick a category", 15, Colors.white),
                  br(5, 0),
                  loading
                      ? Loading(
                          indicator: BallPulseIndicator(),
                          size: 100.0,
                          color: HexColor('#8FFF29'))
                      : Center(
                          child: Container(
                            height: 80,
                            width: 360,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: serviceListResponse
                                    .map((elements) => HiiiiAppTitleBlock2(
                                          selected: category,
                                          title: elements['title'],
                                          description: elements['description'],
                                          onPressed: () {
                                            setState(() {
                                              category = elements['title'];
                                            });
                                          },
                                          color: HexColor(elements['color']),
                                        ))
                                    .toList()),
                          ),
                        ),
                  br(20, 0),
                  if (category == "Share ride" && !loading)
                    Ride()
                  else if (category != "Share ride" && !loading)
                    text("oops, service isn't available currently", 15,
                        Colors.white)
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> serviceListGetter() async {
    // FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    var request =
        http.Request('GET', Uri.parse('${Values.domain}HiiiiAppServiceList'));

    http.StreamedResponse response = await request.send();

    var jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

    if (jsonResponse['status'] == 200) {
      print('hell');
      setState(() {
        loading = false;
        serviceListResponse = jsonResponse['ServiceList'];
      });
    } else {
      print("500");
    }
  }
}


// br(20, 0),
//                 Center(
//                   child: HiiiiAppTextField(
//                       enabled: true,
//                       onchange: (value) {},
//                       height: 62,
//                       fontSize: 16,
//                       hint: "From",
//                       tEC: name,
//                       type: TextInputType.name,
//                       maxLength: 80,
//                       textAlign: TextAlign.left),
//                 ),
//                 Center(
//                   child: HiiiiAppTextField(
//                       enabled: true,
//                       onchange: (value) {},
//                       height: 62,
//                       fontSize: 16,
//                       hint: "To",
//                       tEC: name,
//                       type: TextInputType.name,
//                       maxLength: 80,
//                       textAlign: TextAlign.left),
//                 ),
//                 HiiiiAppToggleSwitch(
//                   onToggle: (index) {},
//                   title: "Vehicle",
//                   items: ['car', 'bike'],
//                 ),
//                 if (vehicle == 0)
//                   Center(
//                     child: Container(
//                       height: 10,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           Container(),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           Text(
//                             "1",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )