import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/home_page/home_page.dart';
import 'package:just_travel/views/pages/signup_page.dart';

import '../views/pages/error/error_page.dart';
import '../views/pages/launcher_page.dart';
import '../views/pages/signin_page.dart';
import '../views/pages/trip_details_page.dart';


class RouteGenerator {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LauncherPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LauncherPage(),
        );

    /*
    * ============= Auth route start ============*/
      case SignInPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );

        case SignUpPage.routeName:
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
        );
    /*
    * ============= Auth route end ============*/

    /*
    * ============= Home page route start ============*/
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

    /*
    * ============= Home page route end ============*/

    /*
    * ============= Trip route end ============*/

      case TripDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => TripDetailsPage(id: args as String),
        );


    /*
    * ============= Trip route end ============*/

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(),
        );
    }
  }
}
