import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart';

class EventsToDisplayProvider with ChangeNotifier{

  List<Event> _events= [];

  EventsToDisplayProvider();

  List<Event> get events => _events;

  void addNewEventsToDisplay(List<Event> events){
    _events = events;
    notifyListeners();
  }

}