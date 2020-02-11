import 'package:flutter/material.dart';
import 'package:u_compass/widgets/drawer_menu.dart';

class ServicesScreen extends StatelessWidget {
  static const String routeName = "/services";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Menu(),
      body: Container(
          margin: EdgeInsets.all(20),
          child: GridView(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              Container(
                child: Text(
                  "Testing 1",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Text(
                    "Testing 1",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Container(
                  child: Text(
                    "Testing 1",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              Container(
                  child: Text(
                    "Testing 1",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ))
            ],
          ))
      ,
    );






  }
}
