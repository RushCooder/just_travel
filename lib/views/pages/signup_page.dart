import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/services/auth/auth_service.dart';
import 'package:just_travel/views/pages/signin_page.dart';
import 'package:just_travel/views/widgets/dialogs/contact_dialog.dart';
import 'package:just_travel/views/widgets/dialogs/verification_dialog.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/loading_widget.dart';
import 'launcher_page.dart';

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

  void setAuthentication(BuildContext context) {
    if (passwordTextEditingController.text ==
        confirmPasswordTextEditingController.text) {
      // set sign up info
      context.read<AuthProvider>().setSignUpInfo(
            nameTextEditingController.text.trim(),
            emailTextEditingController.text.trim(),
            passwordTextEditingController.text.trim(),
          );
    } else {
      context.read<AuthProvider>().setError('Password not matched');
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      authProvider.setError('');
                      // setting authentication info
                      setAuthentication(context);

                      // authenticating user
                      if (formKey.currentState!.validate()) {
                        // showLoadingDialog(context);
                        verificationDialog(context);
                        authProvider.startTimer();

                        try {
                          bool isSuccess =
                              await authProvider.authenticate(isSignUp: true);

                          if (isSuccess) {
                            print('Sign up success');
                            Timer.periodic(const Duration(seconds: 3),
                                (timer) async {
                              bool emailVerified =
                                  await authProvider.checkEmailVerification();

                              if (authProvider.errorMessage.isNotEmpty){
                                authProvider.stopTimer();
                                authProvider.resetTimerValue();
                                timer.cancel();
                                Navigator.pop(context);
                              }

                              if (emailVerified) {
                                authProvider.stopTimer();
                                timer.cancel();
                                Navigator.pop(context);
                                // context.read<AuthProvider>().storeInDataBase(
                                //       nameTextEditingController.text,
                                //       emailTextEditingController.text,
                                //       emailVerified,
                                //     );
                                // Navigator.pushNamedAndRemoveUntil(context,
                                //     LauncherPage.routeName, (route) => false);
                                authProvider.emailVerified = emailVerified;
                                contactDialog(context);
                              }
                            });
                          }
                        } catch (error) {
                          print('error: $error');
                        }
                      }
                    },
                    child: Text(
                      'SIGN UP',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white70),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // OR bar with divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Divider(
                          height: 10,
                          thickness: 2,
                          indent: 10,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Or Sign Up With'),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Divider(
                          height: 10,
                          thickness: 2,
                          indent: 10,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // google sign in button
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          showLoadingDialog(context);

                          await context.read<AuthProvider>().signInWithGoogle();

                          Navigator.pushNamedAndRemoveUntil(context,
                              LauncherPage.routeName, (route) => false);
                        } catch (error) {
                          context
                              .read<AuthProvider>()
                              .setError(error.toString());
                          Navigator.pop(context);
                        }
                      },
                      // child: const Icon(
                      //   Icons.g_mobiledata,
                      //   size: 50,
                      // ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'images/google_icon.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),

                  // new user and signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('SIGN IN'),
                      ),
                    ],
                  ),

                  // showing error message
                  Center(
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => Text(
                        authProvider.errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
