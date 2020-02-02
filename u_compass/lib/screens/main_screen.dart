import 'package:flutter/material.dart';
import 'package:u_compass/widgets/drawer_menu.dart';



class MainScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("U-Compass"),
      ),
      drawer: Menu(),
      body: Center(
        child: Text("App debut !"),
      ),
    );
  }
}
