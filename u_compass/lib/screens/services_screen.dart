import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/models/campusService.dart';
import 'package:u_compass/providers/authentication.dart';
import 'package:flutter/services.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/campus_service_tile.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:u_compass/screens/plan_screen.dart';
import 'package:u_compass/models/service.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class ServicesScreen extends StatefulWidget {
  static const String routeName = "/services";

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  AuthenticationProvider authenticationProvider;
  static const platform = const MethodChannel('test');

  BuildContext context;

  final _origin =
      Location(name: "Vous", latitude: 48.862725, longitude: 3.5000000);
  final _destination =
      Location(name: "Campus lille", latitude: 48.862725, longitude: 2.287592);
  String test;

  MapboxNavigation _directions;
  bool _arrived = false;

  bool displayServiceM5 = true;
  bool displayRestauration = false;
  bool displayAdministration = false;
  double _distanceRemaining, _durationRemaining;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapboxNavigation(onRouteProgress: (arrived) async {
      _distanceRemaining = await _directions.distanceRemaining;
      _durationRemaining = await _directions.durationRemaining;

      setState(() {
        _arrived = arrived;
      });
      if (arrived) await _directions.finishNavigation();
    });
  }

  String platformVersion;

  dispServiceM5() {
    setState(() {
      displayServiceM5 = true;
      displayRestauration = false;
      displayAdministration = false;
    });
  }

  disRestauration() {
    setState(() {
      displayServiceM5 = false;
      displayRestauration = true;
      displayAdministration = false;
    });
  }

  disAdministration() {
    setState(() {
      displayServiceM5 = false;
      displayRestauration = false;
      displayAdministration = true;
    });
  }

  Future<void> goMap() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test');
      batteryLevel = result;
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

  Future<List<CampusService>> get campusServicesRestauration {
    return authenticationProvider.getAllCampusServicesRestauration();
  }

  Future<List<CampusService>> get campusServicesAdministration {
    return authenticationProvider.getAllCampusServicesAdministration();
  }

  /// Returns a raised button for a preference service
  RaisedButton serviceButton(Service service, Function call) {
    return RaisedButton.icon(
      onPressed: call,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      icon: Icon(
        service.type,
        color: Colors.white,
      ),
      label: Text(service.name,
          style: TextStyle(
            color: Colors.white,
          )),
      color: Theme.of(context).primaryColor,
    );
  }

  void goToLocation(Location location) {
    _directions.startNavigation(
        origin: _origin,
        destination: location,
        mode: NavigationMode.walking,
        simulateRoute: false);
  }

  /// Returns a container for a service
  GestureDetector serviceContainer(Service service) {
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
                            service.type,
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
                            service.name,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  displayServices() {
    return Expanded(
      child: FutureBuilder<List<CampusService>>(
          future: displayRestauration
              ? campusServicesRestauration
              : displayAdministration ? campusServicesAdministration : null,
          builder: (BuildContext context,
              AsyncSnapshot<List<CampusService>> snapshot) {
            if (snapshot.hasData) {
              List<CampusService> cs = snapshot.data;
              return ListView.builder(
                  itemCount: cs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CampusServiceWidget(cs[index], goToLocation);
                  });
            } else {
              return Center(child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }

  displayServicesM5() {
    return Expanded(
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
          serviceContainer(Service("Accueil M5", Icons.table_chart, "", 0, 0)),
          serviceContainer(Service("Toilette RDC", Icons.wc, "", 0, 0)),
          serviceContainer(
              Service("M2 E-service", Icons.table_chart, "", 0, 0)),
          serviceContainer(Service("Caffé 1", Icons.local_drink, "", 0, 0)),
          serviceContainer(
              Service("Distributeur", Icons.local_drink, "", 0, 0)),
          serviceContainer(Service("Toilette 1er E", Icons.wc, "", 0, 0)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    authenticationProvider = Provider.of<AuthenticationProvider>(context);

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
                serviceButton(Service("Bât M5", Icons.table_chart, "", 0, 0),
                    dispServiceM5),
                SizedBox(width: 10),
                serviceButton(
                    Service(
                        "Restaurant Universitaire", Icons.restaurant, "", 0, 0),
                    disRestauration),
                SizedBox(width: 10),
                serviceButton(
                    Service("Administration", Icons.table_chart, "", 0, 0),
                    disAdministration),
                SizedBox(width: 10),
                serviceButton(
                    Service("Inscription", Icons.table_chart, "", 0, 0), null),
                SizedBox(width: 10),
              ],
            ),
          ),
          (displayRestauration || displayAdministration) ? displayServices() : Text(""),
          displayServiceM5 ? displayServicesM5() : Text("")
        ],
      ),
      bottomNavigationBar: BottomMenu(2),
    );
  }
}
