import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/models/campusService.dart';
import 'package:u_compass/providers/authentication.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/campus_service_tile.dart';
import 'package:u_compass/widgets/drawer_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }


  Future<List<CampusService>> get campusServices{
    return authenticationProvider.getAllCampusServices();
  }

  @override
  Widget build(BuildContext context) {
    authenticationProvider = Provider.of<AuthenticationProvider>(context);

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
                RaisedButton.icon(
                    onPressed: () {},
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    icon: Icon(
                      Icons.restaurant,
                    ),
                    label: Text("Restaurant"),
                    color: Colors.blue),
                SizedBox(width: 10),
                RaisedButton.icon(
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  icon: Icon(
                    Icons.restaurant,
                    size: 18.0,
                  ),
                  label: Text("Restaurant"),
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                RaisedButton.icon(
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  icon: Icon(
                    Icons.restaurant,
                    size: 18.0,
                  ),
                  label: Text("Restaurant"),
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                RaisedButton.icon(
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  icon: Icon(
                    Icons.restaurant,
                  ),
                  label: Text("Restaurant"),
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Container(
            height: 150,
            child: StaggeredGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              staggeredTiles: [
                StaggeredTile.extent(2, 130.0),
                /*StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),
                  StaggeredTile.extent(1, 150.0),*/
              ],
              children: <Widget>[
                Material(
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
                              Container(
                                child: Icon(
                                  Icons.restaurant,
                                  color: Colors.amber,
                                  size: 30.0,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  // Service Title
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Service 1",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20.0),
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
              ],
            ),
          ),
          Container(
            height: 380,
            child: FutureBuilder<List<CampusService>>(future:campusServices,
                builder: (BuildContext context, AsyncSnapshot<List<CampusService>> snapshot) {
                  if(snapshot.hasData){
                    List<CampusService> cs = snapshot.data;
                    return ListView.builder(
                        itemCount: cs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CampusServiceWidget(cs[index]);
                        });
                  }else{
                    return Text("RRRRR");
                  }
                }),
          )


        ],
      ),
      bottomNavigationBar: BottomMenu(2),
    );
  }
}
