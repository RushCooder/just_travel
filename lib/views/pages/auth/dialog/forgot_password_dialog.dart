import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/dialogs/message_dialog.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

forgotPasswordDialog({
  required BuildContext context,
}) {
  final emailController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Forgot Password?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Enter your email tor reset password'),
          const SizedBox(
            height: 15,
          ),
          CustomFormField(
            controller: emailController,
            labelText: 'Email',
            isPrefIcon: true,
            icon: Icons.email_outlined,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            showLoadingDialog(context);
            context
                .read<AuthProvider>()
                .forgotPassword(emailController.text.trim())
                .then(
              (value) {
                Navigator.pop(context);
                if (!value) throw Error();
                messageDialog(
                  context,
                  'Password reset link has been sent to ${emailController.text.trim()}. Check your email inbox or spam',
                ).then((value){
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  throw Error();
                });

              },
            ).onError((error, stackTrace) {
              // Navigator.pop(context);
              messageDialog(
                context,
                '${emailController.text.trim()} has to record on database',
              );

            });
          },
          child: const Text('Reset Password'),
        ),
      ],
    ),
  );
}
