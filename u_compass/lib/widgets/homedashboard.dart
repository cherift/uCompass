import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:u_compass/screens/event_screen.dart';
import 'package:u_compass/screens/plan_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';

class HomeDashBord extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: <Widget>[
          dashBoard(context, "U EDT", "Mon emploi du temps", 0, Icons.perm_contact_calendar, SchedulesScreen()),
          dashBoard(context, "U Calendar", "Mes évèvenements", 2, Icons.event_available, EventScreen()),
          dashBoard(context, "U Events", "Evènements sur le Campus", 5, Icons.event_note, SchedulesScreen()),
      GestureDetector(
          onTap: (){
            goMap();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.map,
                  color: Colors.white,
                  size: 60,
                ),
                SizedBox(height: 14),
                Text(
                  "U Map",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Map U Campus",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "3 à venir",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                )
              ],
            ),
          )
        ),
        ],
      ),
    );
  }

  static const platform = const MethodChannel('test');

  Future<void> goMap() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test',{'placeid': '5e4fb50400c03a0016b79e7b'});
      batteryLevel=result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  GestureDetector dashBoard(BuildContext context, String name, String description, int count, IconData icon, StatefulWidget state) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => state
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: 60,
            ),
            SizedBox(height: 14),
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10
              ),
            ),
            SizedBox(height: 8),
            Text(
              count.toString() + " à venir",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16
              ),
            )
          ],
        ),
      )
    );
  }
}