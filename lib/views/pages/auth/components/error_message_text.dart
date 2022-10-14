import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ErrorMessageText extends StatelessWidget {
  const ErrorMessageText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Text(
          authProvider.errorMessage,
          style: TextStyle(
            color: Theme.of(context).errorColor,
          ),
        ),
      ),
    );
  }
}
