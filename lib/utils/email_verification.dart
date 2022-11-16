import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../views/pages/auth/signup/dialog/verification_dialog.dart';

void emailVerification(BuildContext context) async {
  final authProvider = context.read<AuthProvider>();
  final userProvider = context.read<UserProvider>();

// verification dialog
  verificationDialog(context);

  await authProvider.emailVerification();

  Timer.periodic(const Duration(seconds: 3), (timer) async {
    bool emailVerified = await authProvider.checkEmailVerification();

    if (emailVerified) {
      timer.cancel();

      await userProvider.updateUser(
        {"email.isVerified": true},
        userProvider.user!.id!,
      );
      Navigator.pop(context);
    }
  });
}
