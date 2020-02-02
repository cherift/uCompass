import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:u_compass/widgets/calendar.dart';
import 'package:u_compass/widgets/drawer_menu.dart';

class SchedulesScreen extends StatelessWidget {
  static const routeNampe = '/edt';

  void _onDaySelectedChanged(DateTime dateTime,List<dynamic> events){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("U-Compass"),
        ),
        drawer: Menu(),
        body: Column(
          children: <Widget>[CalendarCustom(_onDaySelectedChanged)],
        ));
  }
}
