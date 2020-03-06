import 'package:flutter/cupertino.dart';

class Service {

  String name;
  String placeid;
  IconData type;
  String destination;
  double latitude;
  double longitude;

  Service(this.name,
          this.type,
          this.destination,
          this.latitude,
          this.longitude,
          this.placeid);
}