import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';

class SchedulesProvider with ChangeNotifier {
  Events _events;
  String _url_calendar;
  CalendarService calendarService;

  SchedulesProvider() {
    calendarService = new CalendarService();
  }

  String get url_calendar => _url_calendar;

  set url_calendar(String value) {
    _url_calendar = value;
    calendarService._url_calendar = _url_calendar;
    getSchedulesData();
  }

  bool urlCalendarIsDefined() {
    return url_calendar != null && url_calendar != "";
  }

  void getSchedulesData() {
    calendarService.getCurrentSchoolYearEvents().then((events) {
      _events = events;
      notifyListeners();
    });
  }

  Map<DateTime, List<Event>> getFormatedDatForCalendar(){
    return _mapEventsToMap(_events);
  }

  Map<DateTime, List<Event>> _mapEventsToMap(Events events) {
    List<Event> eventList = events.items;
    List<DateTime> dates =
    eventList.map((e) => e.start.dateTime).toSet().toList();

    Map<DateTime,List<Event>> map = Map.fromIterable(dates,
        key: (date) => date,
        value: (date) =>
            eventList.where((event) => _isSameDay(date, event.start.dateTime)).toList());

    return map;
  }

  bool _isSameDay(DateTime date_1, DateTime date_2){
    return (date_1.day==date_2.day) && (date_1.month==date_2.month) && (date_1.year==date_2.year) ;
  }

}

class CalendarService {
  final accountCredentials = new ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "platine-1567754733767",
    "private_key_id": "412903b828dc6e793339e6efff4e8303dc3cdb3e",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDHfOJdIcMumkUE\nho+m8VTUHIXwMsOC5SZ34qJ3suMS4rCJ4jmDWgUl4ND0ao4vw2cXKC+6eGoiuP/i\nvHUczRLzdDyU9mcmy/QpgwX0c+sBF3eD/I7f2Rn++t2W4BrzdfyZhcu1tix8EtWo\n7utNOI5DC7GZC/PYNDSUrQ8pUHGCB9lfY2YdQxU5dun/tjGic4H+bKsOKtxHComV\ny/FoFfsvXN7u/1A4OFsI8un1BEb3A2Sw8HD0Iu8GRxNuYa9BhXG7nFy6r93H0O5z\nw6JLcaIF4TDwWMZcrtptkqNRNXJ+B8ALqfidECzu4lQ4TzBA2aN57MY0xKVvUoeP\nRbJNjK6BAgMBAAECggEADkMd9fWbfEH4TD4ImDFp1K5jXwxqEPosGWchIXivJmMB\npyH+5aaydoZPuiHCH6UTQkMTwnuobuoWFVJO9yusPq6hRC8nqczsHGmrK9J7yzyv\nxUZxuoxNgP7Th91m3+AgGqPHsCqhnI9GKklGlmNEPIPiAySpHtyAo96JlnUTYG3p\n6gzkRSqmZZVPAfY1se3j5LbiSwsZPuM6cRhAGULawwsahxh8lqdACU8e6VG9hnKu\nmXGs8UlgtKMiCGG9Im5BSDArq1EkdkcOJMIBxsLyOZGpYFxEPdNUTOt76H9V2uQ0\nV4hPYe8h6Y9CGN48/19os2IEmz2Ff+mA57VWoz8RoQKBgQDlIL8AhbH5dBFMKlYm\ntw6cAzc5P161cgS2WBFBkICqyW/ho1MTd1UtdKb+VFjVftIKPdijLdJpfXywRGh5\n/fdp9ade8r0yiFcFROqPxtniuGMQ8QyaTOOEUhVFDqURW3xrJTMX5vav6ogUVboq\nojP86U9YXzTOgAd3IpyRFrs2OQKBgQDe4jwh8t54cwxc1BROxUfJZo37mvsDnpso\nC//Yp7JhJl0EmyQZnUzqumWkaXp4UOzPHoca13ryiJuw6T3UrzHtvfSP4U9DR17J\nv/Rjh4fuQxcxSd5myoLanW1sd3Be0+s7yCH6IZ+oMl/lWGNBW9vfne8xgFJcOXZY\nq3rAa7H6iQKBgE2JsVlZ5QqHzrq5sQHU/Oqq4+tJmKFKfnG+h8hqQECLfoMbJCf4\nQCjryv9SR+WnzyiMGV3PSd9NCf8Uh06RNUL0ULl+56vMG7a6xa32GxHwWAYJrLwi\nvPOwW2ZNOGsRTJ9trUavcFfDxF0tTZzT20gBJErBnTssdFpKqjUnPh9xAoGBAJFf\nyozyFn1FvRiHE7/VGV+Zzp3/lh3kQ5s5SGUN7GFFXoJ0lnVGjjbD4Sv9yG3VisAF\nT2YIih7LT5FycGva4ZwJvAxkjwh48rBwzXxlmBmmFOiHH9K33+WrrQWEWfzgCJxz\niwXVDIfuY3H51rN4sM8H+k21PwL8T97B6ky7cdjRAoGAYt4keP6Xb1HfUhNm7WgE\nBMQlGNzZZ9XHTriqGdVv//kqPyPGGjEZUnoQR8vQVkzU/qRhgSfpz+eXIkGUcUe1\n347v1vZQVFZVVNh/qQSSaO0wPqVDnEDox40OrDmkEiYNFiNVxRhryfRxw86CSxnp\nLFvESKtvaEzfEo6qh/w555A=\n-----END PRIVATE KEY-----\n",
    "client_email":
        "events-service@platine-1567754733767.iam.gserviceaccount.com",
    "client_id": "109337736235355835944",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/events-service%40platine-1567754733767.iam.gserviceaccount.com"
  });
  var _scopes = [
    CalendarApi.CalendarScope
  ]; //defines the scopes for the calendar api

  CalendarApi _calendar;
  bool connected = false;
  String _url_calendar;

  Future<void> initConection() async {
    return clientViaServiceAccount(accountCredentials, _scopes).then((client) {
      _calendar = new CalendarApi(client);
      connected = true;
    });
  }

  Future getCurrentSchoolYearEvents() async {
    int currentYear = DateTime.now().year;
    DateTime timeMin = new DateTime(currentYear - 1, 1, 1);
    DateTime timeMax = new DateTime(currentYear + 1, 12, 31);

    if (!connected) {
      await initConection();
    }

    return _calendar.events.list(
        "kmgohivkaknf9cvbgcso55f4eo@group.calendar.google.com",
        timeMin: timeMin,
        timeMax: timeMax,
        maxAttendees: 1000);
  }

  String get url_calendar => _url_calendar;

  set url_calendar(String value) {
    _url_calendar = value;
  }
}
