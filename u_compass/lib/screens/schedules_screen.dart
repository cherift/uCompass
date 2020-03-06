import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:provider/provider.dart';
import 'package:u_compass/providers/authentication.dart';
import 'package:u_compass/providers/events_to_display.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/calendar.dart' ;
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:u_compass/widgets/events_item.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class SchedulesScreen extends StatefulWidget {
  static const routeNampe = '/edt';


  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  EventsToDisplayProvider eventsToDisplayProvider;
  AuthenticationProvider authenticationProvider;

  List<Event> eventsToDisplay = [];

  DateTime selectedDateTime=DateTime.now();


  void _onDaySelectedChanged(DateTime dateTime, List<dynamic> events) {
    List<Event> evens = events;
    eventsToDisplayProvider.addNewEventsToDisplay(evens);
  }

  @override
  Widget build(BuildContext context) {
    eventsToDisplayProvider = Provider.of<EventsToDisplayProvider>(context,listen: false);
    authenticationProvider = Provider.of<AuthenticationProvider>(context,listen: false);
    authenticationProvider.connect("admin", "admin");
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
                child: EventsListWidget(selectedDateTime))
          ],
        ),
    bottomNavigationBar: BottomMenu(3),
    floatingActionButton: FlatButton(
        onPressed: () {
      DatePicker.showDateTimePicker(context,
          showTitleActions: true,
          minTime: DateTime(2019, 1, 1),
          maxTime: DateTime(2020, 12, 12), onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
           setState(() {
             eventsToDisplayProvider.currentDateTime = date;
           });
          }, currentTime: eventsToDisplayProvider.currentDateTime, locale: LocaleType.fr);
    },
    child: Text(
    'show date time picker (Chinese)',
    style: TextStyle(color: Theme.of(context).primaryColor),
    )),);

  }
}
