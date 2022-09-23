import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/views/pages/auth/signup/signup_page.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  static const String routeName = '/signin';
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  SignInPage({Key? key}) : super(key: key);

  void setAuthentication(BuildContext context) {
    // set email
    context.read<AuthProvider>().setEmail(emailTextEditingController.text);
    //set password
    context
        .read<AuthProvider>()
        .setPassword(passwordTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'Just Travel',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Your Dream Our Efforts',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //  text form fields
                  CustomFormField(
                    controller: emailTextEditingController,
                    icon: Icons.email,
                    labelText: 'Email',
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
                    height: 35,
                  ),

                  /*
                  * Sign In button*/
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      // setting authentication info
                      setAuthentication(context);

                      // authenticating user
                      if (formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        context
                            .read<AuthProvider>()
                            .authenticate(isSignUp: false)
                            .then(
                          (value) {
                            print('Login success');
                            Navigator.pushNamedAndRemoveUntil(context,
                                LauncherPage.routeName, (route) => false);
                          },
                        ).onError(
                          (error, stackTrace) {
                            print('error: $error');
                          },
                        );
                      }
                    },
                    child: Text(
                      'SIGN IN',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white70,
                          ),
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
                        child: Text('Or Sign In With'),
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
                          borderRadius: BorderRadius.circular(50),
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
                      const Text('New User?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpPage.routeName);
                        },
                        child: const Text('SIGN UP'),
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
