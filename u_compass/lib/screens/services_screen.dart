import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:u_compass/screens/plan_screen.dart';
import 'package:u_compass/models/service.dart';

class Post {
  final String title;
  final String description;

  Post(this.title,  this.description);
}

class ServicesScreen extends StatefulWidget {
  static const String routeName = "/services";


  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  static const platform = const MethodChannel('test');

  BuildContext context;

  String test;

  Future<void> goMap() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test');
      batteryLevel=result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      test = batteryLevel;
    });
  }

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  /// Returns a raised button for a preference service
  RaisedButton serviceButton(Service service){
    return RaisedButton.icon(
        onPressed: goMap,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        icon: Icon(
          Icons.restaurant,
          color: Colors.white,
        ),
        label: Text(
            "Restaurant",
            style : TextStyle(
              color: Colors.white,
            )
        ),
        color: Theme.of(context).primaryColor,
    );
  }

  /// Returns a container for a service
  GestureDetector serviceContainer(Service service){
    return GestureDetector(
      onTap: goMap,
      child: Material(
        color: Colors.white,
        elevation: 14.0,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.restaurant,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        // Service Title
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Service 1",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20.0
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    this.context = context;

    return Scaffold(
      appBar: AppBar(),
      drawer: Menu(),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(),
            ),
          ),
          Container(
            height: 50,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                SizedBox(width: 10),
                serviceButton(null),
                SizedBox(width: 10),
                serviceButton(null),
                SizedBox(width: 10),
                serviceButton(null),
                SizedBox(width: 10),
                serviceButton(null),
                SizedBox(width: 10),
              ],
            ),
          ),
          Container(
            height: 374 ,
            child: StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                staggeredTiles: [
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                ],
                children: <Widget>[
                  serviceContainer(null),
                  serviceContainer(null),
                  serviceContainer(null),
                  serviceContainer(null),
                  serviceContainer(null),
                  serviceContainer(null),
                ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomMenu(2),
    );
  }
}
