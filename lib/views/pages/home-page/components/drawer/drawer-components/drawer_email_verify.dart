import 'package:flutter/material.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/email_verification.dart';

class DrawerEmailVerify extends StatelessWidget {
  const DrawerEmailVerify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) =>
          userProvider.user!.email!.isVerified == false
              ? Positioned(
                  bottom: 100,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Please verify your email',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              emailVerification(context);
                            },
                            // onPressed: () async {
                            //   final authProvider = context.read<AuthProvider>();
                            //
                            //   // verification dialog
                            //   verificationDialog(context);
                            //
                            //   await authProvider.emailVerification();
                            //
                            //   Timer.periodic(const Duration(seconds: 3),
                            //       (timer) async {
                            //     bool emailVerified =
                            //         await authProvider.checkEmailVerification();
                            //
                            //     if (emailVerified) {
                            //       timer.cancel();
                            //
                            //       await userProvider.updateUser(
                            //         {"email.isVerified": true},
                            //         userProvider.user!.id!,
                            //       );
                            //       Navigator.pop(context);
                            //     }
                            //   });
                            // },
                            child: const Text('Verify'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
    );
  }
}
