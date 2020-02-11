import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';



class MapBox extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapBox> {

  MapboxNavigation _directions;
  double _distanceRemaining;
  double _durationRemaining;
  bool _arrived;



  @override
  void initState() {
    _directions = MapboxNavigation(onRouteProgress: (arrived) async{

      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });
      if(arrived)
        await _directions.finishNavigation();

    });


  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
