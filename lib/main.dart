import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/districts_provider.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/join_trip_provider.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/providers/review_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:provider/provider.dart';

import 'views/just_travel_app.dart';

bool shouldUseFirebaseEmulator = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
  }

  if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  await Firebase.initializeApp();
  // status bar theme
  SystemChrome.setSystemUIOverlayStyle(
    StatusBarTheme.statusBarLight,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DistrictsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TripProvider()..onInit(),
        ),
        ChangeNotifierProvider(
          create: (context) => HotelProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => JoinTripProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReviewProvider(),
        ),

      ],
      child: const JustTravelApp(),
    ),
  );
}
