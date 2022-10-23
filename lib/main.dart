import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/hotel_provider.dart';
import 'package:just_travel/providers/message_provider.dart';
import 'package:just_travel/providers/room_provider.dart';
import 'package:just_travel/providers/trip_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/theme/status_bar_theme.dart';
import 'package:provider/provider.dart';

import 'views/just_travel_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          create: (context) => TripProvider()..getAllTrips(),
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
      ],
      child: const JustTravelApp(),
    ),
  );
}
