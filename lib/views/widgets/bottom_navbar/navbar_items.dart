import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_travel/routes/route_generator.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      routeAndNavigatorSettings: const RouteAndNavigatorSettings(
        initialRoute: LauncherPage.routeName,
        onGenerateRoute: RouteGenerator.onGenerateRoute,

      ),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.notifications),
      title: ("Notifications"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.person),
      title: ("Profile"),
      activeColorPrimary: CupertinoColors.activeBlue,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}