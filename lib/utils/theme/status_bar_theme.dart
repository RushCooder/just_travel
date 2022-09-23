import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// SystemUiOverlayStyle statusBarTheme = const SystemUiOverlayStyle(
// statusBarBrightness: Brightness.light,
// statusBarIconBrightness: Brightness.dark,
// );

class StatusBarTheme {
  static const SystemUiOverlayStyle statusBarLight = SystemUiOverlayStyle(
    // statusBarBrightness: ,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  static const SystemUiOverlayStyle statusBarDart = SystemUiOverlayStyle(
    // statusBarBrightness: ,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  );
}
