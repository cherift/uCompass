import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:u_compass/models/events.dart';
import 'package:u_compass/providers/schedules.dart';
import 'package:u_compass/screens/add_event_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:u_compass/widgets/prefEvent.dart';

import 'main_screen.dart';

class EventScreen extends StatefulWidget{
  static const routeName = '/event_screen';

  @override
  _EventScreen createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen>{

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CalendarController _calendarController;
  SchedulesProvider schedulesProvider;
  List<PrefEvent> prefEvent = [];

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  void onSelectedDate(DateTime date, List<dynamic> list){
   setState(() {
     prefEvent = list;
   });
  }

  @override
  Widget build(BuildContext context) {

    schedulesProvider = Provider.of<SchedulesProvider>(context);

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
      body:Column(
        children: <Widget>[
          Container(
              child: TableCalendar(
                locale: "fr_FR",
                calendarController: _calendarController,
                events: schedulesProvider.mapPEventsToMap(),
                onDaySelected: onSelectedDate,
                calendarStyle: CalendarStyle(
                    selectedColor: Theme.of(context).primaryColor,
                    weekendStyle: TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          Container(
            height: 350,
            child:prefEvent.length!=0 ? ListView(
              children:
                    prefEvent.map((pe)=> new PrefEventWidget(pe)).toList()
            ) : Text("Choisir une date"),
          )
        ],
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