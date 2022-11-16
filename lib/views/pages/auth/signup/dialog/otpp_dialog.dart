// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/districts_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/pages/launcher_page.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

void otpDialog(BuildContext context, String phoneNumber) async {
  context.read<AuthProvider>().verifyPhoneNumber(phoneNumber, (vId) {
    // stopping loading dialog
    Navigator.pop(context);

    //showing otp dialog
    showOtpDialog(context, vId);
  }, (errorMsg) {
    showMsg(context, errorMsg);
    Navigator.pop(context);
  });
}

void showOtpDialog(BuildContext context, String vId) {
  final codeController = TextEditingController();
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(8),
      content: Consumer<AuthProvider>(
        builder: (context, provider, child) => PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,

          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(30),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          // backgroundColor: Colors.blue.shade50,
          // enableActiveFill: true,
          //errorAnimationController: errorController,
          controller: codeController,
          onCompleted: (v) async {
            print("Completed");
            try {
              showLoadingDialog(context);
              bool otpVerified =
                  await provider.matchingSmsCode(vId, codeController.text);
              print('otp verified: $otpVerified');
              if (otpVerified) {
                // await authProvider.deleteUser();
                bool isAuth = await provider.authenticate(isSignUp: true);
                print('auth: $isAuth');
                if (isAuth) {
                  // if (await provider.emailVerification()){
                  try {
                    await provider.storeInDataBase();
                    context.read<DistrictsProvider>().reset();
                    print('stored db');
                    Navigator.pushNamedAndRemoveUntil(
                        context, LauncherPage.routeName, (route) => false);
                  } catch (e) {
                    showMsg(context, e.toString());
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }

                  // }
                }
              } else {
                Navigator.pop(context);
                showMsg(context, 'Wrong OTP');
              }
            } catch (error) {
              print('otpDialog error: $error');
              Navigator.pop(context);
            }
          },
          onChanged: (value) {
            print('onchanged: $value');
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    ),
  );
}
