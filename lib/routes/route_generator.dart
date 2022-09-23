import 'package:flutter/material.dart';
import 'package:just_travel/views/pages/auth/signin/signin_page.dart';
import 'package:just_travel/views/pages/auth/signup/signup_page.dart';
import 'package:just_travel/views/pages/error/error_page.dart';
import 'package:just_travel/views/pages/home-page/home_page.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/pages/trip-details-page/trip_details_page.dart';

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
