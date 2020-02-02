import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/providers/events_to_display.dart';

import 'event_item.dart';

class EventsListWidget extends StatelessWidget {


  EventsListWidget();


  @override
  Widget build(BuildContext context) {
    final eventsToDisplayProvider = Provider.of<EventsToDisplayProvider>(context);
    return
      (!eventsToDisplayProvider.events.isEmpty) ?
      ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: eventsToDisplayProvider.events.length,
        itemBuilder: (BuildContext context,int index){
          return EventWidget(eventsToDisplayProvider.events[index]);
        },


      ) : Text("RIen aujourdhui");
  }
}
