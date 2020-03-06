import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:u_compass/providers/schedules.dart';

class CalendarCustom extends StatefulWidget {
  final Function onDaySelectedChanged;

  CalendarCustom(this.onDaySelectedChanged);

  @override
  _CalendarCustomState createState() => _CalendarCustomState();
}

class _CalendarCustomState extends State<CalendarCustom> {
  final textEditingController = new TextEditingController();

  CalendarController _calendarController;
  SchedulesProvider schedulesProvider;

  Future<Events> get eventsData {
    return schedulesProvider.getSchedulesData();
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    schedulesProvider = Provider.of<SchedulesProvider>(context);
    return schedulesProvider.urlCalendarIsDefined()
        ? FutureBuilder<Events>(
            future: eventsData,
            builder: (BuildContext context, AsyncSnapshot<Events> snapshot) {
              if (snapshot.data != null) {
                return TableCalendar(
                  locale: "fr_FR",
                  calendarController: _calendarController,
                  events: schedulesProvider.mapEventsToMap(snapshot.data),
                  onDaySelected: widget.onDaySelectedChanged,
                  calendarStyle: CalendarStyle(
                      selectedColor: Theme.of(context).primaryColor,
                    weekendStyle: TextStyle(color: Theme.of(context).primaryColor)),
                );
              } else {

                return Container(
                    margin: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        : Container(
            height: 200,
            margin: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                    "Veuillez insérer l\'ID de votre emploi du temps :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'ID emploi du temps'),
                    controller: textEditingController,
                  ),
                  RaisedButton(
                    child: Text("Valider"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      schedulesProvider.url_calendar =
                          textEditingController.value.text;
                    },
                  )
                ],
              ),
            ),
          );
  }
}
