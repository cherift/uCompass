import 'package:flutter/material.dart';



class MainScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("U-Compass"),
      ),
      body: Center(
        child: Text("App debut !"),
      ),
    );
  }
}
