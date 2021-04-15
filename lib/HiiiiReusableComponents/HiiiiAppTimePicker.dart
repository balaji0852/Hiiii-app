import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'date_picker_widget.dart';
import 'package:Hiiii/MainPages/values.dart';

class HiiiiAppTimePicker extends StatelessWidget {
  final Function onDateChange;
  final Function onTimeChange;

  HiiiiAppTimePicker({this.onDateChange, this.onTimeChange, this.selectedTime});

  final String selectedTime;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 160,
              child: DatePicker(DateTime.now(),
                  onDateChange: (value) => onDateChange(value))),
          SizedBox(
            width: 20,
          ),
          Container(
              width: 160,
              height: 75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: Values.time
                    .map((item) => MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color:
                            selectedTime == item ? Values.green : Colors.black,
                        onPressed: () {
                          onTimeChange(item);
                        },
                        height: 75,
                        minWidth: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.substring(0, 3),
                              style: TextStyle(
                                  color: selectedTime == item
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            Text(
                              item.substring(3, 5),
                              style: TextStyle(
                                  color: selectedTime == item
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ],
                        )))
                    .toList(),
              ))
        ],
      ),
    ]);
  }
}
