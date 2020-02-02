import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:u_compass/providers/schedules.dart';

class CalendarCustom extends StatelessWidget {
  final textEditingController = new TextEditingController();

  final Function onDaySelectedChanged;

  CalendarController calendarController = new CalendarController();

  CalendarCustom(this.onDaySelectedChanged);


  @override
  Widget build(BuildContext context) {
    final schedulesProvider = Provider.of<SchedulesProvider>(context);
    return schedulesProvider.urlCalendarIsDefined()
        ? TableCalendar(
          locale: "fr_FR",
          calendarController: calendarController,
          events: schedulesProvider.getFormatedDatForCalendar(),
          onDaySelected: onDaySelectedChanged,
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
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: (){schedulesProvider.url_calendar = textEditingController.value.text;},
                  )
                ],
              ),
            ),
          );
  }
}
