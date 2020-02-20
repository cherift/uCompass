import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:u_compass/widgets/bottom_navigation_bar_menu.dart';
import 'package:u_compass/widgets/drawer_menu.dart';


class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class ServicesScreen extends StatelessWidget {
  static const String routeName = "/services";

  Future<List<Post>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Post(
        "Title : $search $index",
        "Description :$search $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Menu(),
      body:  Column(
        children: <Widget>[
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(),
            ),

    ),
          Container(
            height: 70,
            child: ListView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.restaurant),
                        Text("Restauration")
                      ],
                    ),
                  ),
                ), Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.account_balance),
                        Text("Inscription")
                      ],
                    ),
                  ),
                ), Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.restaurant),
                        Text("Restauration")
                      ],
                    ),
                  ),
                ), Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.restaurant),
                        Text("Restauration")
                      ],
                    ),
                  ),
                ), Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.restaurant),
                        Text("Restauration")
                      ],
                    ),
                  ),
                ), Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  margin: EdgeInsets.fromLTRB(5,15,5,15),
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        Icon(Icons.restaurant),
                        Text("Restauration")
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
        bottomNavigationBar: BottomMenu(2),
    );
            }
}
