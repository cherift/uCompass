import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/models/events.dart';
import 'package:u_compass/providers/schedules.dart';

const kGoogleApiKey = "API_KEY";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class AddEventScreen extends StatefulWidget {
  static const routeName = '/add_eventscreen';

  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen>{

  String dropdownValue = 'M5 - IAGL';
  SchedulesProvider schedulesProvider;
  PrefEvent event = PrefEvent("","","",DateTime.now(),DateTime.now(),DateTime.now());

  @override
  Widget build(BuildContext context) {
    schedulesProvider = Provider.of<SchedulesProvider>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ajouter un événement"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Container(
                alignment: Alignment.center,
                height: 60.0,
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.title,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: "Entrer le titre de l'événment"
                  ),
                  onChanged: (value) {
                    setState(() {
                      event.title = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Text(
                    "Choisir le lieu",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    underline: Container(
                        color: Theme.of(context).primaryColor,
                        height:1.0
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        event.place = newValue;
                      });
                    },
                    items: <String>['M5 - IAGL', 'M5 - EService', 'M5 - Admin', 'M5 - Café']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Container(
                alignment: Alignment.center,
                height: 60.0,
                child: DateTimeField(
                  format: DateFormat("dd/MM/yyyy"),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: "Date"
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  onChanged: (value) {
                    setState(() {
                      event.date = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: DateTimeField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.timer,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Debut"
                        ),
                        format: DateFormat("HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                        onChanged: (value) {
                          setState(() {
                            event.begin = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                      child: DateTimeField(
                        format: DateFormat("HH:mm"),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          contentPadding: EdgeInsets.only(top: 14),
                          prefixIcon: Icon(
                            Icons.timer_off,
                            color: Theme.of(context).primaryColor,
                          ),
                          hintText: "Fin"
                        ),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                        onChanged: (value) {
                          setState(() {
                            event.end = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Container(
                alignment: Alignment.center,
                height: 160.0,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 30,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor
                  ),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.description,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: "Description"
                  ),
                  onChanged: (value) {
                    setState(() {
                      event.description = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25),
              width: 200,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: (){
                  // Save here
                  schedulesProvider.prefCalendar.events.add(event);
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Enregister",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);
    }
  }
}