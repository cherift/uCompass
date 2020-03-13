import 'package:flutter/material.dart';
import 'package:u_compass/models/events.dart';
import 'package:flutter/services.dart';

class PrefEventWidget extends StatelessWidget {

  PrefEvent prefEvent;
  PrefEventWidget(this.prefEvent);

  final platform = const MethodChannel('test');

  String test;

  Future<void> goMap(String place) async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test', {'placeid' : place});
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Map<String, String> map = {
    'M5 - IAGL' : '5e62745ca81f7d00162683a6',
    'M5 - EService':  '5e4fb50400c03a0016b79e7b',
    'M5 - Admin' : '5e4fb50400c03a0016b79e7b',
    'M5 - Café' : '5e4fb815a5a4b70016bbd248'
  };

  @override
  Widget build(BuildContext context) {
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
                    (prefEvent.begin.hour + 1).toString() +
                        "H" +
                        prefEvent.begin.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (prefEvent.end.hour + 1).toString() +
                        "H" +
                        prefEvent.end.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    (prefEvent.description != null
                        ? prefEvent.description + " - " + prefEvent.place
                        : "" + prefEvent.place),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon( Icons.navigation),
                  onPressed: () {
                    goMap(map[prefEvent.place]);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }



}
