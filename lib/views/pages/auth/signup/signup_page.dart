import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/views/pages/auth/components/auth_button.dart';
import 'package:just_travel/views/pages/auth/components/error_message_text.dart';
import 'package:just_travel/views/pages/auth/components/google_signin_button.dart';
import 'package:just_travel/views/pages/auth/components/or_bar_divider.dart';
import 'package:just_travel/views/pages/auth/signup/components/already_user.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/dialogs/contact_dialog.dart';
import 'package:just_travel/views/widgets/dialogs/verification_dialog.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static const String routeName = '/signup';
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignUpPage({Key? key}) : super(key: key);

  bool setAuthentication(BuildContext context) {
    if (passwordTextEditingController.text ==
        confirmPasswordTextEditingController.text) {
      // set sign up info
      context.read<AuthProvider>().setSignUpInfo(
            nameTextEditingController.text.trim(),
            emailTextEditingController.text.trim(),
            passwordTextEditingController.text.trim(),
          );

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Text(
                  //   'Just Travel',
                  //   style: Theme.of(context).textTheme.headline3,
                  // ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'to get started now!',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //  text form fields
                  CustomFormField(
                    controller: nameTextEditingController,
                    icon: Icons.person,
                    labelText: 'Full Name',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    controller: emailTextEditingController,
                    icon: Icons.email,
                    labelText: 'Email Address',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    controller: passwordTextEditingController,
                    icon: Icons.lock,
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    controller: confirmPasswordTextEditingController,
                    icon: Icons.lock,
                    labelText: 'Confirm Password',
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  /*
                  * Sign up button*/
                  AuthButton(
                    buttonName: 'SIGN UP',
                    onPressed: () async {
                      authProvider.setError('');
                      // setting authentication info
                      // setAuthentication(context);

                      // authenticating user
                      if (formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        // verificationDialog(context);
                        // authProvider.startTimer();

                        try {
                          if (setAuthentication(context)) {
                            bool isSuccess =
                                await authProvider.authenticate(isSignUp: true);
                            if (isSuccess) {
                              await authProvider.deleteUser();
                              Navigator.pop(context);
                              contactDialog(context);
                            }
                          } else {
                            context
                                .read<AuthProvider>()
                                .setError('Password not matched');
                            Navigator.pop(context);
                          }
                        } catch (error) {
                          print('error: $error');
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // OR bar with divider
                  const OrBarDivider(barText: 'Or Sign Up With'),

                  // google sign in button
                  const GoogleSignInButton(),

                  // already user and sign in
                  const AlreadyUser(),

                  // showing error message
                  const ErrorMessageText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
