import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:u_compass/widgets/map.dart';

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
        child: Text("Bienvenue !"),
      ),
      bottomNavigationBar: BottomMenu(0),
      floatingActionButton: FloatingActionButton(
        child: Text("Go Map"),
        onPressed: goMap,
      ),
    );
  }
}
