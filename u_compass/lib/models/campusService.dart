class CampusService{
  String _name;
  bool _open;
  String _description;
  double _longitude;
  double _latitude;
  int _attente;
  DateTime _openingTime;
  DateTime _closureTime;
  String _affluence;
  String _type;

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
        _affluence = data["affluence"],
        _attente = data["attente"],
        _type = data["type"];


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

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  set open(bool value) {
    _open = value;
  }

  int get attente => _attente;

  set attente(int value) {
    _attente = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }


}