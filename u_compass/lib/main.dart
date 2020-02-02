import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/screens/main_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';

import 'providers/schedules.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SchedulesProvider())
      ],
      child: MaterialApp(
        title: 'U-Compass',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          SchedulesScreen.routeNampe: (ctx) => SchedulesScreen()
        },
      ),
    );
  }
}
