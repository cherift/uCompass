import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/providers/authentication.dart';
import 'package:u_compass/screens/main_screen.dart';
import 'package:u_compass/screens/plan_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';
import 'package:u_compass/screens/services_screen.dart';




class BottomMenu extends StatelessWidget {


  BuildContext context;
  int current_index;
  AuthenticationProvider authenticationProvider;


  BottomMenu(this.current_index);

  static const platform = const MethodChannel('test');

  Future<void> goMap() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('test');
      batteryLevel=result;
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

  }

  navigate(int item){
    authenticationProvider.connect("admin", "admin");
    switch(item) {
      case 0 :Navigator.pushReplacementNamed(context, MainScreen.routeName);break;
      case 1 :goMap();break;
      case 2 :Navigator.pushReplacementNamed(context, ServicesScreen.routeName);break;
      case 3 :Navigator.pushReplacementNamed(context, SchedulesScreen.routeNampe);break;

    }
  }

  @override
  Widget build(BuildContext context) {
    authenticationProvider = Provider.of<AuthenticationProvider>(context);
    this.context = context;
    return BottomNavigationBar(
      selectedFontSize: 12,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Accueil'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place),
          title: Text('Plan'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Services'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Edt'),
        ),
      ],
      currentIndex: current_index,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black,
      unselectedFontSize: 14,
      showUnselectedLabels: true
      ,
      onTap:navigate,
    );
  }
}
