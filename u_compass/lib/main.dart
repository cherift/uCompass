import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_compass/providers/authentication.dart';
import 'package:u_compass/providers/events_to_display.dart';
import 'package:u_compass/screens/main_screen.dart';
import 'package:u_compass/screens/plan_screen.dart';
import 'package:u_compass/screens/schedules_screen.dart';
import 'package:u_compass/screens/services_screen.dart';

import 'providers/schedules.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    Map<int, Color> color =
    {
      50:Color.fromRGBO(179,34,114, .1),
      100:Color.fromRGBO(179,34,114, .2),
      200:Color.fromRGBO(179,34,114, .3),
      300:Color.fromRGBO(179,34,114,.4),
      400:Color.fromRGBO(179,34,114,.5),
      500:Color.fromRGBO(179,34,114,.6),
      600:Color.fromRGBO(179,34,114,.7),
      700:Color.fromRGBO(179,34,114,.8),
      800:Color.fromRGBO(179,34,114, .9),
      900:Color.fromRGBO(179,34,114,1),
    };
    MaterialColor customColor = MaterialColor(0xFFB32272,color);


    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SchedulesProvider()),
        ChangeNotifierProvider.value(value: EventsToDisplayProvider()),
        ChangeNotifierProvider.value(value: AuthenticationProvider())
      ],
      child: MaterialApp(
        title: 'U-Compass',
        theme: ThemeData(
          primarySwatch: customColor,
        ),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          SchedulesScreen.routeNampe: (ctx) => SchedulesScreen(),
          ServicesScreen.routeName: (ctx) => ServicesScreen(),
          PlanScreen.routeName: (ctx) => PlanScreen(),
        },
      ),
    );
  }
}
