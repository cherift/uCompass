class CampusService{
  String _name;
  bool _open;
  String _description;
  int _longitude;
  int _latitude;
  DateTime _openingTime;
  DateTime _closureTime;
  String _affluence;

  CampusService(this._name, this._open, this._description, this._longitude,
      this._latitude, this._openingTime, this._closureTime, this._affluence);

  CampusService.fromJson(Map<String, dynamic> data):
        _name = data["name"],
        _open = data["open"],
        _description = data["description"],
        _longitude = data["longitude"],
        _latitude = data["latitude"],
        _openingTime =DateTime.parse( data["openingTime"].toString()),
        _closureTime =DateTime.parse( data["closureTime"].toString()),
        _affluence = data["affluence"];


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get open => _open;

  get affluence => _affluence;

  set affluence(value) {
    _affluence = value;
  }

  DateTime get closureTime => _closureTime;

  set closureTime(DateTime value) {
    _closureTime = value;
  }

  DateTime get openingTime => _openingTime;

  set openingTime(DateTime value) {
    _openingTime = value;
  }

  int get latitude => _latitude;

  set latitude(int value) {
    _latitude = value;
  }

  int get longitude => _longitude;

  set longitude(int value) {
    _longitude = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set open(bool value) {
    _open = value;
  }


}