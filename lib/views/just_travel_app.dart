import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_travel/views/pages/home_page.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/pages/signin_page.dart';

import '../routes/route_generator.dart';

class JustTravelApp extends StatelessWidget {
  const JustTravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LauncherPage.routeName,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      // initialRoute: HomePage.routeName,
      // routes: {
      //   HomePage.routeName : (context) => const HomePage(),
      // },
    );
  }
}
