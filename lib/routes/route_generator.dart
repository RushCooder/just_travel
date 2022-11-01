import 'package:flutter/material.dart';
import 'package:just_travel/models/db-models/message_group_model.dart';
import 'package:just_travel/models/db-models/room_model.dart';
import 'package:just_travel/models/db-models/trip_model.dart';
import 'package:just_travel/views/pages/auth/signin/signin_page.dart';
import 'package:just_travel/views/pages/auth/signup/signup_page.dart';
import 'package:just_travel/views/pages/chat-page/chat_page.dart';
import 'package:just_travel/views/pages/confirm-page/confirm_page.dart';
import 'package:just_travel/views/pages/error-page/error_page.dart';
import 'package:just_travel/views/pages/error/default_error_page.dart';
import 'package:just_travel/views/pages/home-page/home_page.dart';
import 'package:just_travel/views/pages/inbox-page/inbox_page.dart';
import 'package:just_travel/views/pages/inbox-page/inbox_page.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/pages/my-trips-page/my_trips_page.dart';
import 'package:just_travel/views/pages/profile-page/profile_page.dart';
import 'package:just_travel/views/pages/success-page/success_page.dart';
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
    * ============= Trip route start ============*/
      // Trip details page
      case TripDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => TripDetailsPage(id: args as String),
        );

      //  Trip confirmation page
      case ConfirmPage.routeName:
        {
          List list = args as List;
          TripModel trip = list[0] as TripModel;
          RoomModel room = list[1] as RoomModel;
          num numberOfTravellers = list[2] as num;
          return MaterialPageRoute(
            builder: (context) => ConfirmPage(
              trip: trip,
              room: room,
              numberOfTravellers: numberOfTravellers,
            ),
          );
        }

      //  Trip Join Success page
      case SuccessPage.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => const SuccessPage(),
          );
        }
      //  Trip Join Error page
      case ErrorPage.routeName:
        {
          return MaterialPageRoute(
            builder: (context) => const ErrorPage(),
          );
        }

      /*
    * ============= Trip route end ============*/

      /*
    * ============= My trip route start ============*/
      case MyTripsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => MyTripsPage(),
        );

      /*
    * ============= My trip route start ============*/

      /*
    * ============= Profile route start ============*/
      case ProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );

      /*
    * ============= Profile route start ============*/

      /*
    * ============= Message route start ============*/
      case InboxPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const InboxPage(),
        );

      /*
    * ============= Message route start ============*/

      /*
    * ============= Message route start ============*/
      case ChattingPage.routeName:
        return MaterialPageRoute(
          builder: (context) =>
              ChattingPage(messageGroup: args as MessageGroupModel),
        );

      /*
    * ============= Message route start ============*/

      default:
        return MaterialPageRoute(
          builder: (context) => const DefaultErrorPage(),
        );
    }
  }
}
