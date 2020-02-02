import 'package:flutter/material.dart';
import 'package:u_compass/widgets/drawer_menu.dart';

class SchedulesScreen extends StatelessWidget {
  static const routeNampe='/edt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("U-Compass"),
      ),
      drawer: Menu(),
      body: Center(child: Text("EDT !!"),),
    );
  }
}
