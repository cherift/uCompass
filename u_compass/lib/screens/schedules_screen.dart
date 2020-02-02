import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/providers/events_to_display.dart';
import 'package:u_compass/widgets/calendar.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:u_compass/widgets/events_item.dart';

class SchedulesScreen extends StatelessWidget {
  static const routeNampe = '/edt';
  EventsToDisplayProvider eventsToDisplayProvider;
  List<Event> eventsToDisplay = [];

  void _onDaySelectedChanged(DateTime dateTime, List<dynamic> events) {
    List<Event> evens = events;
    eventsToDisplayProvider.addNewEventsToDisplay(evens);
  }

  @override
  Widget build(BuildContext context) {
    eventsToDisplayProvider = Provider.of<EventsToDisplayProvider>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("U-Compass"),
        ),
        drawer: Menu(),
        body: Column(
          children: <Widget>[
            CalendarCustom(_onDaySelectedChanged),
            Container(
                height: 400,
                child: EventsListWidget())
          ],
        ));
  }
}
