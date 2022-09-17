import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:just_travel/apis/user_api.dart';
import 'package:just_travel/models/db-models/user_model.dart';

import '../services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isObscure = true;
  bool isVisible = false;
  bool isSignOut = false;
  String? name, email, password, imagePath, mobileNumber, city, division;

  String errorMessage = '';
  Timer? timer;
  int emailResendTime = 59;
  bool emailVerified = false, mobileVerified = false;
  String? vId;

  // change visibility of password
  void changeVisibility() {
    isVisible = !isVisible;
    isObscure = !isObscure;

    print('obscure: $isObscure');
    notifyListeners();
  }

  //set sign up info
  void setSignUpInfo(String name, String email, String password) {
    this.name = name;
    this.email = email;
    this.password = password;
  }

  //set sign up info
  void setContactInfo(
      String imagePath, String mobileNumber, String city, String division) {
    this.imagePath = imagePath;
    this.mobileNumber = mobileNumber;
    this.city = city;
    this.division = division;
  }

  // reset section/*
  // all reset*/
  void resetTimerValue() {
    if (timer != null) {
      timer!.cancel();
    }
    emailResendTime = 59;
    notifyListeners();
  }

  void resetAllData() {
    name = null;
    email = null;
    password = null;
    imagePath = null;
    mobileNumber = null;
    city = null;
    division = null;
  }

  // set email from email field
  void setEmail(String email) {
    this.email = email;
  }

  // set password from password field
  void setPassword(String password) {
    this.password = password;
  }

  void setError(String err) {
    errorMessage = err;
    notifyListeners();
  }

  // start timer
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (emailResendTime > 0) {
        emailResendTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  // stop timer
  void stopTimer() {
    timer!.cancel();
  }

  // checking email is verified or not
  Future<bool> checkEmailVerification() {
    return AuthService.checkIsVerified();
  }

// checking phone number verification. this method will return vId
  verifyPhoneNumber(String phoneNumber, Function(String vId) codeSent) async {
    await AuthService.verifyPhoneNumber(phoneNumber, codeSent);
    // notifyListeners();
    // return vId;
  }

  Future<bool> matchingSmsCode(String vId, String smsCode) async {
    try {
      if (await AuthService.matchingSmsCode(vId, smsCode)) {
        //mobile verification true and store in database
        mobileVerified = true;
        await storeInDataBase();
        return true;
      } else {
        throw 'Wrong OTP';
      }
    } catch (error) {
      print('error at auth provider: $error');
      return false;
    }
  }

  // signing in user
  Future<void> _signIn() async {
    try {
      bool isSuccess = await AuthService.signIn(email!, password!);
      if (isSuccess) {
        return;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  } //

  //resend verification email
  Future<void> reSendVerificationEmail() async {
    await AuthService.emailVerification();
  }

  // authenticating user
  Future<bool> authenticate({required bool isSignUp}) async {
    try {
      bool status = false;
      if (isSignUp) {
        print('signup calling');
        status = await AuthService.signUp(email!, password!);
        if (status) {
          await AuthService.emailVerification();
          // storeInDataBase(name, email, isVerified)
        }
      } else {
        status = await AuthService.signIn(email!, password!);
      }

      if (status) {
        return true;
      } else {
        AuthService.signOut();
        throw 'Credential error';
      }
    } on FirebaseAuthException catch (e) {
      setError(e.message!);
      return false;
    }
  }

  // sign in with google
  Future<bool> signInWithGoogle() async {
    try {
      UserCredential userCredential = await AuthService.signInWithGoogle();
      print('user credential: $userCredential');
      if (userCredential.user != null) {
        UserModel? registeredUser =
            await UserApi.fetchUserByEmail(userCredential.user!.email!);
        print('registered user: ${registeredUser?.name}');

        if (registeredUser == null) {
          print('creating new user');

          UserModel newUser = UserModel(
            name: userCredential.user!.displayName,
            profileImage: userCredential.user!.photoURL,
            email: Email(
              emailId: userCredential.user!.email,
              isVerified: userCredential.user!.emailVerified,
            ),
          );
          await UserApi.createUser(newUser);
        }
        return true;
      } else {
        throw Error();
      }
    } catch (error) {
      print('auth provider sign in with google: $error');
      return false;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await AuthService.signOut();
      isSignOut = true;
      notifyListeners();
    } catch (error) {
      print('error sign out: $error');
    }
  }

  Future<void> storeInDataBase() async {
    UserModel? registeredUser = await UserApi.fetchUserByEmail(email!);
    // print('registered user: ${registeredUser?.name}');
    UserModel? createdUser;
    if (registeredUser == null) {
      print('creating new user');
      UserModel newUser = UserModel(
        name: name,
        email: Email(
          emailId: email,
          isVerified: emailVerified,
        ),
        mobile: Mobile(
          number: mobileNumber,
          isVerified: mobileVerified,
        ),
        city: city,
        division: division,
        profileImage: imagePath,
      );

      print('new user: $newUser');
      createdUser = await UserApi.createUser(newUser);
      await AuthService.signIn(newUser.email!.emailId!, password!);
    }

    // return createdUser;
  }

  // this method will return current user info
  User? getCurrentUser() => AuthService.user;
}
