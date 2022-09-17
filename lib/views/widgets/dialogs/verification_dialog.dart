import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void verificationDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('A verification email has been sent to your email'),
          const SizedBox(
            height: 5,
          ),
          const Text('Please verify your email'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<AuthProvider>(
                  builder: (context, authProvider, child) =>
                      Text('Resend email in ${authProvider.emailResendTime} seconds')),
            ],
          ),
        ],
      ),
      actions: [
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) => ElevatedButton(
            onPressed: authProvider.emailResendTime == 0 ? () async {
              authProvider.resetTimerValue();
              await authProvider.reSendVerificationEmail();
            } : null,
            child: const Text('Resend Email'),
          ),
        )
      ],
    ),
  );
}
