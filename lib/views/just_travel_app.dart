import 'package:flutter/material.dart';
import 'package:just_travel/routes/route_generator.dart';
import 'package:just_travel/views/pages/launcher_page.dart';

class JustTravelApp extends StatelessWidget {
  const JustTravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: LauncherPage.routeName,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      // initialRoute: HomePage.routeName,
      // routes: {
      //   HomePage.routeName : (context) => const HomePage(),
      // },
    );
  }
}
