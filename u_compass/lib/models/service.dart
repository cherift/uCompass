import 'package:flutter/cupertino.dart';

class Service {

  String name;
  IconData type;
  String destination;
  double latitude;
  double longitude;

  Service(this.name,
          this.type,
          this.destination,
          this.latitude,
          this.longitude);
}