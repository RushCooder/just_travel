import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/theme/status_bar_theme.dart';

PreferredSizeWidget appbarLayout({
  required String title,
  Color backgroundColor = Colors.transparent,
  SystemUiOverlayStyle systemOverlayStyle = StatusBarTheme.statusBarLight,
  IconThemeData? iconTheme,
  TextStyle? textStyle,
  Widget? leading,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: leading,
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: iconTheme,
      systemOverlayStyle: systemOverlayStyle,
      titleTextStyle: textStyle,
      title: Text(title),
      actions: actions,
    );
