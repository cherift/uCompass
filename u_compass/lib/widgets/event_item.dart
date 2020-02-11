import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;

import 'event_bar_advancement.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final DateTime currentDatetime;
  EventWidget(this.event,this.currentDatetime);

  static const platform = const MethodChannel('test');

  String test;

  Future<void> goMap() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test');
      batteryLevel=result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }


  }


  @override
  Widget build(BuildContext context) {
    double todo;
    double done;
    if(currentDatetime.millisecondsSinceEpoch < event.start.dateTime.millisecondsSinceEpoch){
      todo=1;
      done=0;
    }else if(currentDatetime.millisecondsSinceEpoch > event.end.dateTime.millisecondsSinceEpoch){
      todo=0;
      done=1;
    }else{
      int totalTime = (event.end.dateTime.millisecondsSinceEpoch - event.start.dateTime.millisecondsSinceEpoch);
      int timePassed = currentDatetime.millisecondsSinceEpoch- event.start.dateTime.millisecondsSinceEpoch;
      double advancePercent = timePassed / totalTime;
      done=1;
      todo=advancePercent;
    }
    print(this.currentDatetime);

    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (event.start.dateTime.hour + 1).toString() +
                        "H" +
                        event.start.dateTime.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  BarAdvancementWidget(done, todo),
                  Text(
                    (event.end.dateTime.hour + 1).toString() +
                        "H" +
                        event.end.dateTime.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    (event.description != null
                        ? event.description + " - " + event.location
                        : "" + event.location),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(icon: Icon( Icons.navigation), onPressed: goMap),
            )
          ],
        ),
      ),
    );
  }
}
