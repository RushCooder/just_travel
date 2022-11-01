import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

bool shouldUseFirebaseEmulator = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
      //   appId: '1:448618578101:web:0b650370bb29e29cac3efc',
      //   messagingSenderId: '448618578101',
      //   projectId: 'react-native-firebase-testing',
      //   authDomain: 'react-native-firebase-testing.firebaseapp.com',
      //   databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      //   storageBucket: 'react-native-firebase-testing.appspot.com',
      //   measurementId: 'G-F79DJ0VFGS',
      // ),
    );
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
