import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:u_compass/models/campusService.dart';

class CampusServiceWidget extends StatelessWidget {
  final CampusService campusService;
  Function mapboxNavigation;

  CampusServiceWidget(this.campusService, this.mapboxNavigation);

  Icon getIconByType() {
    if (campusService.type.toLowerCase() == "restauration")
      return Icon(
        Icons.restaurant,
        color: Colors.white,
        size: 20.0,
      );
    else if (campusService.type.toLowerCase() == "administration")
      return Icon(
        Icons.library_books,
        color: Colors.white,
        size: 20.0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      child: Material(
        color: Colors.white,
        elevation: 10.0,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    shape: BoxShape.circle),
                child: getIconByType()
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        // Service Title
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          campusService.name,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                      campusService.open
                          ? Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle),
                          ),
                          Text(
                            "ouvert",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      )
                          : Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle),
                          ),
                          Text(
                            "fermé",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("A 15 min "),
                      Icon(
                        Icons.directions_run,
                        size: 15,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("File d'attente "),
                      Text(
                        "" + (campusService.attente / 60).round().toString()+" min",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text("horaires :"),
                        Text("" +
                            campusService.openingTime.hour.toString() +
                            "H" +
                            campusService.openingTime.minute.toString()),
                        Text(" - "),
                        Text("" +
                            campusService.closureTime.hour.toString() +
                            "H" +
                            campusService.closureTime.minute.toString())
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              RaisedButton(
                color: Theme
                    .of(context)
                    .primaryColor,
                onPressed: () =>
                {
                  mapboxNavigation(Location(name: this.campusService.name,
                      latitude: this.campusService.latitude,
                      longitude: this.campusService.longitude))
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Icon(
                  Icons.directions_run,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
