import 'package:flutter/material.dart';
import 'package:u_compass/models/campusService.dart';

class CampusServiceWidget extends StatelessWidget {

  final CampusService campusService;


  CampusServiceWidget(this.campusService);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    color: Colors.grey,
                    shape: BoxShape.circle
                ),
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
                          campusService.description,
                          style: TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                      campusService.open ?
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle
                            ),
                          ),
                          Text("ouvert",style: TextStyle(color: Colors.green),)
                        ],
                      ):
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                          ),
                          Text("fermé",style: TextStyle(color: Colors.red),)
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("A 15 min "),
                      Icon(Icons.directions_run,size: 15,)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("File d'attente "),
                      Text("8 min",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: <Widget>[
                        Text("horaires :"),
                        Text(""+campusService.openingTime.hour.toString()+"H"+campusService.openingTime.minute.toString()),
                        Text(" - "),
                        Text(""+campusService.closureTime.hour.toString()+"H"+campusService.closureTime.minute.toString())
                      ],
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent
                ),
                child: Icon(
                  Icons.arrow_upward,
                  size: 40,
                    color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
