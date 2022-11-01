// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:just_travel/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../pages/auth/signup/components/dialog/verification_dialog.dart';
//
// class EmailVerificationWidget extends StatelessWidget {
//   const EmailVerificationWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: const BoxDecoration(
//         color: Colors.grey,
//       ),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//               'Please verify your email',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//
//                 final authProvider =
//                 context.read<AuthProvider>();
//
//                 // verification dialog
//                 verificationDialog(context);
//
//                 await authProvider.emailVerification();
//
//                 Timer.periodic(const Duration(seconds: 3),
//                         (timer) async {
//                       bool emailVerified = await authProvider
//                           .checkEmailVerification();
//
//                       if (emailVerified) {
//                         timer.cancel();
//
//                         await  userProvider.updateUser(
//                           {"email.isVerified": true},
//                           userProvider.user!.id!,
//                         );
//                         Navigator.pop(context);
//
//                       }
//                     });
//               },
//               child: const Text('Verify'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
