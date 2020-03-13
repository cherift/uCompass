class PrefEvent {
  String title;
  String place;
  String description;
  DateTime date;
  DateTime begin;
  DateTime end;

  PrefEvent(this.title, this.place, this.description, this.date, this.begin, this.end);
}

class PrefCalendar {
  List<PrefEvent> events;

  PrefCalendar();

  void add(PrefEvent prefEvent) => this.events.add(prefEvent);
}