import 'package:flutter/material.dart';
import 'package:u_compass/screens/main_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';


class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.only(top: 30),
            child: Image(image: AssetImage('images/logo.png'),),
            decoration: BoxDecoration(
            ),
          ),
          itemMenu("Accueil",Icons.home,context,routeName:MainScreen.routeName),
          itemMenu("Services",Icons.room_service,context,routeName: MainScreen.routeName),
          itemMenu("EDT",Icons.search,context,routeName:SchedulesScreen.routeNampe),
          itemMenu("Realité vituel",Icons.card_membership,context,routeName: MainScreen.routeName),


        ],
      ),
    );
  }


  Widget itemMenu(String title, IconData icon, BuildContext context,{String routeName}){
    return GestureDetector(
      onTap: (){Navigator.of(context).pushReplacementNamed(routeName);},
      child: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromRGBO(179, 34, 114, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:18.0),
              child: Icon(icon),
            ),
            Text(title,style: TextStyle(color:Colors.white,fontSize: 32,fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
