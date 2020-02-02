import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/providers/events_to_display.dart';
import 'package:u_compass/screens/main_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';

import 'providers/schedules.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SchedulesProvider()),
        ChangeNotifierProvider.value(value: EventsToDisplayProvider())
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
