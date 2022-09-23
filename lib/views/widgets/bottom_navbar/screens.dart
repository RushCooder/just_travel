import 'package:flutter/cupertino.dart';

import '../../screens/home_screen/home_screen.dart';
import '../../screens/notificaiton_screen/notification_screen.dart';
import '../../screens/profile_screen/profile_screen.dart';

List<Widget> screens() {
  return const [
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
}
