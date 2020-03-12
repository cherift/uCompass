import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_compass/screens/add_event_screen.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/drawer_menu.dart';

import 'main_screen.dart';

class EventScreen extends StatefulWidget{
  static const routeName = '/event_screen';

  @override
  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: Icon(
                Icons.backspace,
                color: Colors.white,
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            }
        ),
        title: Text("Mes U Evénements"),
      ),
      body: Center(
        child: Container()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventScreen()
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}