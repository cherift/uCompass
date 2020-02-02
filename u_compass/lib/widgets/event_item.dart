import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' hide Colors;

import 'event_bar_advancement.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  EventWidget(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 120,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.start.dateTime.hour.toString() +
                        "H" +
                        event.start.dateTime.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  BarAdvancementWidget(0.5, 0.8),
                  Text(
                    event.end.dateTime.hour.toString() +
                        "H" +
                        event.end.dateTime.minute.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    (event.description != null
                        ? event.description + " - " + event.location
                        : "" + event.location),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text("BUtton"),
            )
          ],
        ),
      ),
    );
  }
}
