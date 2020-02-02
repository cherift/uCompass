import 'package:flutter/material.dart';


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
          itemMenu("Accueil",Icons.home),
          itemMenu("Services",Icons.room_service),
          itemMenu("EDT",Icons.search),
          itemMenu("Realité vituel",Icons.card_membership),


        ],
      ),
    );
  }


  Widget itemMenu(String title, IconData icon){
    return Container(
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
    );
  }
}
