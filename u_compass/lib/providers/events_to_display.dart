import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart';

class EventsToDisplayProvider with ChangeNotifier{

  List<Event> _events= [];
  DateTime _currentDateTime = DateTime.now();

  EventsToDisplayProvider();

  List<Event> get events => _events;


  DateTime get currentDateTime => _currentDateTime;

  set currentDateTime(DateTime value) {
    _currentDateTime = value;
  }

  void addNewEventsToDisplay(List<Event> events){
    _events = events;
    notifyListeners();
  }

}