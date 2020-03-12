import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:u_compass/widgets/homedashboard.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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

    setState(() {
      test = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("U-Compass"),
      ),
      drawer: Menu(),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              height: 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    eventWild(context, "Rentrée des classes", "C'est le premier jour de mamadou"),
                    eventWild(context, "Rentrée des classes", "C'est le premier jour de mamadou"),
                    eventWild(context, "Rentrée des classes", "C'est le premier jour de mamadou"),
                  ]
              ),
            ),
            SizedBox(height: 40),
            HomeDashBord(),
          ]
        )
      ),
      bottomNavigationBar: BottomMenu(0)
    );
  }

  Padding eventWild(BuildContext context, String name, String description){
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100
                ),
              )
            ],
          ),
          SizedBox(width: 15),
          IconButton(
            alignment: Alignment.topCenter,
            icon: Icon(
              Icons.directions_run,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
